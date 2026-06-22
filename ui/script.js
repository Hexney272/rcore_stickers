// ============================================================
// NUI Script - Sticker Menu
// ============================================================

let currentTab = 'add';
let selectedCategory = 0;
let selectedSticker = null;
let menuData = null;

// ========== DOM Elements ==========
const app = document.getElementById('app');
const categoriesList = document.getElementById('categories-list');
const stickersGrid = document.getElementById('stickers-grid');
const editList = document.getElementById('edit-list');
const editEmpty = document.getElementById('edit-empty');
const errorAdd = document.getElementById('error-add');
const errorEdit = document.getElementById('error-edit');
const previewIndicator = document.getElementById('preview-indicator');
const tabs = document.querySelectorAll('.tab');
const tabContents = document.querySelectorAll('.tab-content');

// ========== Event Listeners ==========
tabs.forEach(tab => {
    tab.addEventListener('click', () => {
        const tabName = tab.dataset.tab;
        switchTab(tabName);
    });
});

document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
        closeMenu();
    }
});

// ========== NUI Message Handler ==========
window.addEventListener('message', (event) => {
    const data = event.data;

    switch (data.action) {
        case 'open':
            openMenu(data);
            break;
        case 'close':
            hideMenu();
            break;
    }
});

// ========== Menu Functions ==========
function openMenu(data) {
    menuData = data;
    selectedCategory = 0;
    selectedSticker = null;

    app.classList.remove('hidden');

    // Reset to add tab
    switchTab('add');

    // Populate categories
    renderCategories(data.categories);

    // Select first category
    if (data.categories.length > 0) {
        selectCategory(0);
    }

    // Handle errors
    if (data.errorAdd && data.errorAdd !== '') {
        errorAdd.textContent = data.errorAdd;
        errorAdd.classList.remove('hidden');
    } else {
        errorAdd.classList.add('hidden');
    }

    if (data.errorEdit && data.errorEdit !== '') {
        errorEdit.textContent = data.errorEdit;
        errorEdit.classList.remove('hidden');
    } else {
        errorEdit.classList.add('hidden');
    }

    // Populate edit list
    renderEditList(data.activeStickers || []);
}

function hideMenu() {
    app.classList.add('hidden');
    previewIndicator.classList.add('hidden');
    selectedSticker = null;
}

function closeMenu() {
    hideMenu();
    fetch(`https://${GetParentResourceName()}/closeMenu`, {
        method: 'POST',
        body: JSON.stringify({})
    });
}

function switchTab(tabName) {
    currentTab = tabName;

    tabs.forEach(t => t.classList.toggle('active', t.dataset.tab === tabName));
    tabContents.forEach(tc => tc.classList.toggle('active', tc.id === `tab-${tabName}`));

    // Clear preview when switching tabs
    if (tabName === 'edit') {
        clearPreview();
    }
}

// ========== Categories ==========
function renderCategories(categories) {
    categoriesList.innerHTML = '';

    categories.forEach((cat, index) => {
        const el = document.createElement('div');
        el.className = 'category-item' + (index === 0 ? ' active' : '');
        el.textContent = cat.category;
        el.addEventListener('click', () => selectCategory(index));
        categoriesList.appendChild(el);
    });
}

function selectCategory(index) {
    selectedCategory = index;

    // Update active state
    document.querySelectorAll('.category-item').forEach((el, i) => {
        el.classList.toggle('active', i === index);
    });

    // Render stickers
    if (menuData && menuData.categories[index]) {
        renderStickers(menuData.categories[index].stickers);
    }

    // Clear preview
    clearPreview();
}

// ========== Stickers Grid ==========
function renderStickers(stickers) {
    stickersGrid.innerHTML = '';

    stickers.forEach((sticker, index) => {
        const card = document.createElement('div');
        card.className = 'sticker-card';

        const priceText = sticker.price > 0 ? `$${sticker.price}` : 'INGYENES';
        const priceClass = sticker.price > 0 ? '' : ' free';

        card.innerHTML = `
            <div class="sticker-icon">&#9733;</div>
            <div class="sticker-name">${sticker.name}</div>
            <div class="sticker-price${priceClass}">${priceText}</div>
        `;

        card.addEventListener('mouseenter', () => {
            hoverSticker(sticker);
        });

        card.addEventListener('mouseleave', () => {
            clearPreview();
        });

        card.addEventListener('click', () => {
            selectStickerForPlacement(sticker);
        });

        stickersGrid.appendChild(card);
    });
}

// ========== Edit List ==========
function renderEditList(stickers) {
    editList.innerHTML = '';

    if (stickers.length === 0) {
        editEmpty.classList.remove('hidden');
        return;
    }

    editEmpty.classList.add('hidden');

    stickers.forEach((sticker) => {
        const item = document.createElement('div');
        item.className = 'edit-item';

        item.innerHTML = `
            <div class="edit-item-info">
                <div class="edit-item-icon">&#9733;</div>
                <div class="edit-item-name">${sticker.name}</div>
            </div>
            <button class="edit-btn">Szerkesztes</button>
        `;

        item.querySelector('.edit-btn').addEventListener('click', (e) => {
            e.stopPropagation();
            editExistingSticker(sticker);
        });

        item.addEventListener('mouseenter', () => {
            hoverEditSticker(sticker);
        });

        item.addEventListener('mouseleave', () => {
            clearEditPreview(sticker);
        });

        editList.appendChild(item);
    });
}

// ========== Preview / Hover ==========
function hoverSticker(sticker) {
    selectedSticker = sticker;
    previewIndicator.classList.remove('hidden');

    fetch(`https://${GetParentResourceName()}/previewSticker`, {
        method: 'POST',
        body: JSON.stringify({
            name: sticker.name,
            dict: sticker.dict
        })
    });
}

function clearPreview() {
    selectedSticker = null;
    previewIndicator.classList.add('hidden');

    fetch(`https://${GetParentResourceName()}/clearPreview`, {
        method: 'POST',
        body: JSON.stringify({})
    });
}

function hoverEditSticker(sticker) {
    fetch(`https://${GetParentResourceName()}/highlightSticker`, {
        method: 'POST',
        body: JSON.stringify({ id: sticker.id })
    });
}

function clearEditPreview(sticker) {
    fetch(`https://${GetParentResourceName()}/unhighlightSticker`, {
        method: 'POST',
        body: JSON.stringify({ id: sticker.id })
    });
}

// ========== Actions ==========
function selectStickerForPlacement(sticker) {
    hideMenu();

    fetch(`https://${GetParentResourceName()}/selectSticker`, {
        method: 'POST',
        body: JSON.stringify({
            name: sticker.name,
            dict: sticker.dict,
            price: sticker.price,
            categoryIndex: selectedCategory
        })
    });
}

function editExistingSticker(sticker) {
    hideMenu();

    fetch(`https://${GetParentResourceName()}/editSticker`, {
        method: 'POST',
        body: JSON.stringify({
            id: sticker.id,
            name: sticker.name
        })
    });
}

// ========== Utility ==========
function GetParentResourceName() {
    return window.GetParentResourceName ? window.GetParentResourceName() : 'rcore_stickers';
}
