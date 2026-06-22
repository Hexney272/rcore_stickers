// ============================================================
// STICKERS NUI - Premium Interface Logic
// ============================================================

(function() {
    'use strict';

    // ========== State ==========
    let menuData = null;
    let activeCategory = 0;
    let currentTab = 'shop';

    // ========== Resource Name ==========
    const RESOURCE = (typeof GetParentResourceName !== 'undefined')
        ? GetParentResourceName()
        : 'rcore_stickers';

    // ========== DOM References ==========
    const $ = (sel) => document.querySelector(sel);
    const $$ = (sel) => document.querySelectorAll(sel);

    const app = $('#app');
    const catList = $('#cat-list');
    const productGrid = $('#product-grid');
    const contentTitle = $('#content-title');
    const contentCount = $('#content-count');
    const editGrid = $('#edit-grid');
    const editCount = $('#edit-count');
    const editEmpty = $('#edit-empty');
    const editError = $('#edit-error');
    const editErrorText = $('#edit-error-text');
    const shopError = $('#shop-error');
    const shopErrorText = $('#shop-error-text');
    const previewBadge = $('#preview-badge');
    const btnClose = $('#btn-close');

    // ========== NUI Post ==========
    function post(endpoint, data) {
        return fetch(`https://${RESOURCE}/${endpoint}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data || {})
        });
    }

    // ========== Event Listeners ==========
    // Tab switching
    $$('.nav-tab').forEach(tab => {
        tab.addEventListener('click', () => {
            const name = tab.dataset.tab;
            switchTab(name);
        });
    });

    // Close button
    btnClose.addEventListener('click', closeMenu);

    // Escape key
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
            closeMenu();
        }
    });

    // NUI Messages from client.lua
    window.addEventListener('message', (e) => {
        const msg = e.data;
        if (!msg || !msg.action) return;

        switch (msg.action) {
            case 'open':
                openMenu(msg);
                break;
            case 'close':
                hide();
                break;
        }
    });

    // ========== Menu Open ==========
    function openMenu(data) {
        menuData = data;
        activeCategory = 0;
        currentTab = 'shop';

        // Show
        app.classList.remove('hidden');

        // Reset tabs
        switchTab('shop');

        // Categories
        renderCategories(data.categories || []);

        // Select first category
        if (data.categories && data.categories.length > 0) {
            selectCategory(0);
        } else {
            productGrid.innerHTML = '';
            contentTitle.textContent = 'Nincs kategoria';
            contentCount.textContent = '';
        }

        // Error handling for shop
        if (data.errorAdd && data.errorAdd.length > 0) {
            shopErrorText.textContent = data.errorAdd;
            shopError.classList.remove('hidden');
            productGrid.classList.add('hidden');
        } else {
            shopError.classList.add('hidden');
            productGrid.classList.remove('hidden');
        }

        // Edit list
        renderEditList(data.activeStickers || []);

        // Error handling for edit
        if (data.errorEdit && data.errorEdit.length > 0) {
            editErrorText.textContent = data.errorEdit;
            editError.classList.remove('hidden');
            editGrid.classList.add('hidden');
            editEmpty.classList.add('hidden');
        } else {
            editError.classList.add('hidden');
            editGrid.classList.remove('hidden');
        }
    }

    // ========== Menu Close ==========
    function closeMenu() {
        hide();
        post('closeMenu');
    }

    function hide() {
        app.classList.add('hidden');
        previewBadge.classList.add('hidden');
    }

    // ========== Tab Switch ==========
    function switchTab(name) {
        currentTab = name;

        $$('.nav-tab').forEach(t => {
            t.classList.toggle('active', t.dataset.tab === name);
        });

        $$('.tab-view').forEach(v => {
            v.classList.toggle('active', v.id === `view-${name}`);
        });

        // Clear preview when switching
        previewBadge.classList.add('hidden');
        post('clearPreview');
    }

    // ========== Categories ==========
    function renderCategories(categories) {
        catList.innerHTML = '';

        categories.forEach((cat, i) => {
            const el = document.createElement('div');
            el.className = 'cat-item' + (i === 0 ? ' active' : '');
            el.textContent = cat.category;
            el.addEventListener('click', () => selectCategory(i));
            catList.appendChild(el);
        });
    }

    function selectCategory(index) {
        activeCategory = index;

        // Update active state
        $$('.cat-item').forEach((el, i) => {
            el.classList.toggle('active', i === index);
        });

        // Render products
        const cat = menuData.categories[index];
        if (cat) {
            contentTitle.textContent = cat.category;
            contentCount.textContent = cat.stickers.length + ' db';
            renderProducts(cat.stickers);
        }

        // Hide preview
        previewBadge.classList.add('hidden');
        post('clearPreview');
    }

    // ========== Products ==========
    function renderProducts(stickers) {
        productGrid.innerHTML = '';

        stickers.forEach(sticker => {
            const card = document.createElement('div');
            card.className = 'product-card';

            const priceText = (menuData.noFramework || sticker.price === 0)
                ? 'INGYENES'
                : '$' + sticker.price;
            const priceClass = (menuData.noFramework || sticker.price === 0)
                ? 'card-price free'
                : 'card-price';

            card.innerHTML = `
                <div class="card-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/>
                    </svg>
                </div>
                <div class="card-name">${sticker.name}</div>
                <div class="${priceClass}">${priceText}</div>
            `;

            // Hover = preview
            card.addEventListener('mouseenter', () => {
                previewBadge.classList.remove('hidden');
                post('previewSticker', { name: sticker.name, dict: sticker.dict });
            });

            card.addEventListener('mouseleave', () => {
                previewBadge.classList.add('hidden');
                post('clearPreview');
            });

            // Click = select for placement
            card.addEventListener('click', () => {
                hide();
                post('selectSticker', {
                    name: sticker.name,
                    dict: sticker.dict,
                    price: sticker.price
                });
            });

            productGrid.appendChild(card);
        });
    }

    // ========== Edit List ==========
    function renderEditList(stickers) {
        editGrid.innerHTML = '';
        editCount.textContent = stickers.length + ' db';

        if (stickers.length === 0) {
            editEmpty.classList.remove('hidden');
            return;
        }

        editEmpty.classList.add('hidden');

        stickers.forEach(sticker => {
            const item = document.createElement('div');
            item.className = 'edit-item';

            item.innerHTML = `
                <div class="edit-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/>
                    </svg>
                </div>
                <div class="edit-info">
                    <div class="edit-name">${sticker.name}</div>
                    <div class="edit-id">ID: ${sticker.id}</div>
                </div>
                <div class="edit-actions">
                    <button class="btn-edit">Szerkesztes</button>
                </div>
            `;

            // Hover = highlight on vehicle
            item.addEventListener('mouseenter', () => {
                post('highlightSticker', { id: sticker.id });
            });

            item.addEventListener('mouseleave', () => {
                post('unhighlightSticker', { id: sticker.id });
            });

            // Edit button click
            item.querySelector('.btn-edit').addEventListener('click', (e) => {
                e.stopPropagation();
                hide();
                post('editSticker', { id: sticker.id, name: sticker.name });
            });

            editGrid.appendChild(item);
        });
    }

})();
