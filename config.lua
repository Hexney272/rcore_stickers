Config = {}

-- if you see some errors enable this option
Config.ErrorDebug = false

-- classic debug
Config.EnableDebug = false

Config.Language = 'EN' -- [ 'EN' ] Custom locales can be added to locale.lua
Config.Database = 'oxmysql' --[ 'mysql-async' / 'oxmysql' / 'ghmattimysql' ] Choose your sql driver (leave empty for standalone)
Config.Framework = 'esx' --[ 'esx' / 'qbcore' / 'other' ] Choose your framework (leave empty for standalone)

Config.FrameworkTriggers = {
    notify = 'esx:showNotification', -- [ ESX = 'esx:showNotification'    QBCore = 'QBCore:Notify' ] Set the notification event, if left blank, default will be used
    object = 'esx:getSharedObject', --[ ESX = 'esx:getSharedObject'    QBCore = 'QBCore:GetObject' ] Set the shared object event, if left blank, default will be used (deprecated for QBCore)
    resourceName = 'es_extended', -- [ ESX = 'es_extended'    QBCore = 'qb-core' ] Set the resource name, if left blank, automatic detection will be performed
}

Config.FrameworkSQLTables = {
    table = 'owned_vehicles', --[ ESX = 'owned_vehicles'    QBCore = 'player_vehicles' ] Set the name of the table where you store player vehicles, if left blank, default will be used
    identifier = 'owner', --[ ESX = 'owner'    QBCore = 'citizenid' ] Set the identifier used in that table, if left blank, default will be used
}

Config.Accessibility = {
    event = false, -- Enable this if you want to open the menu by triggering event (rcore_stickers:openMenu)

    restricted = false, -- Enable to restrict the whole script for certain players (IsPlayerAllowedScript function in framework/your_framework.lua)

    anyone = true, -- Everyone can use place and edit stickers
    owner = false, -- Only the owner of the vehicle can place and edit stickers
    jobs = false, -- Only players with certain job can place and edit stickers
}

-- Related to settings above
Config.AllowedJobs = {
    -- Example:
    mechanic = true,

    -- OR if you want it limited to a certain grade. The example below means players with the job mechanic that is above the grade 2 can use it.
    -- mechanic = 2, 
}

Config.EditorOptions = {
    loadDistance = 50.0, -- The distance at which the stickers will start displaying
    maxDistance = 10.0, -- The maximum distance the player can go away from the vehicle when in editor mode
    maxStickers = 6, -- The maximum amount of stickers on a single vehicle, please do note that there cannot be more than 56 stickers rendered at the same time
    maxScale = 6.0, -- The maximum scale of the sticker in editor
    minScale = 0.1, -- The minimum scale of the sticker in editor
}

-- ===== KÉPES MATRICÁK (PNG/WebP automatikus felismerés) =====
-- A stickers/ mappába tett PNG/WebP/JPG fájlok automatikusan megjelennek a menüben!
-- Mappastruktúra:
--   stickers/
--   ├── Markak/           ← mappa neve = kategória neve a menüben
--   │   ├── BMW.png
--   │   ├── Audi.webp
--   │   └── Mercedes.png
--   ├── JDM/
--   │   ├── Initial D.png
--   │   └── Turbo.webp
--   └── Egyeb/
--       ├── Koponya.png
--       └── Lang.webp
--
-- A fájl neve (kiterjesztés nélkül) = matrica neve a menüben
-- Nem kell kézzel hozzáadni a Config.Stickers táblához!

Config.DefaultStickerPrice = 500 -- Alapértelmezett ár (Ft) ha nincs külön megadva
Config.StickerCurrency = 'Ft' -- Pénznem megjelenítés
Config.MaxStickerPhysicalSize = 0.8 -- Max matrica méret méterben (scale 1.0-nál) - megakadályozza hogy az egész autót eltakarja
Config.MaxTextureResolution = 512 -- Bedobott képek ennél a felbontásnál lesznek renderelve (VRAM optimalizáció)

-- ===== MATRICA PONTOK (real_markers integráció) =====
-- Ha a real_markers resource fut, ezeken a pontokon jelenik meg egy marker
-- ahol a játékos megnyithatja a matrica menüt (a járműre nézve)
-- Adj hozzá annyi pontot amennyit szeretnél!
Config.StickerPoints = {
    {
        id = 'sticker_point_1',
        coords = vec3(-337.39, -136.87, 39.01), -- Példa: Burton LSC
        title = 'Matrica',
        helpText = '~INPUT_CONTEXT~ Matrica',
        drawDistance = 8.0,
        interactDistance = 2.0,
    },
    {
        id = 'sticker_point_2',
        coords = vec3(732.23, -1088.79, 22.17), -- Példa: La Mesa LSC
        title = 'Matrica',
        helpText = '~INPUT_CONTEXT~ Matrica',
        drawDistance = 8.0,
        interactDistance = 2.0,
    },
    -- Adj hozzá több pontot:
    -- {
    --     id = 'sticker_point_3',
    --     coords = vec3(x, y, z),
    --     title = 'Matrica',
    --     helpText = '~INPUT_CONTEXT~ Matrica',
    -- },
}

Config.Controls = {}

-- Controls used in the sticker editor, you can find the controls codes here https://docs.fivem.net/docs/game-references/controls/
Config.Controls['EDITOR_CONFIRM']      = 176 -- Enter
Config.Controls['EDITOR_CANCEL']       = 177 -- Backspace
Config.Controls['EDITOR_REMOVE']       = 178 -- Delete
Config.Controls['EDITOR_SPEED']        = 155 -- Left Shift
Config.Controls['EDITOR_LOCK']         = 171 -- Capslock
Config.Controls['EDITOR_MIRROR']       = 132 -- Left Ctrl
Config.Controls['EDITOR_SCALE_UP']     = 181 -- Scrollwheel Up
Config.Controls['EDITOR_SCALE_DOWN']   = 180 -- Scrollwheel Down
Config.Controls['EDITOR_ROTATE_LEFT']  = 174 -- Arrow Left
Config.Controls['EDITOR_ROTATE_RIGHT'] = 175 -- Arrow Right

Config.Text = {}

-- All text labels used in this script
Config.Text['EDITOR_PLACE']      = 'Felrakás (%s Ft)'
Config.Text['EDITOR_SCALE']      = 'Méret (%sx)'
Config.Text['EDITOR_ROTATE']     = 'Forgatás (%s°)'
Config.Text['EDITOR_SPEED']      = 'Gyorsítás (Tartsd)'
Config.Text['EDITOR_LOCK_ON']    = 'Pozíció zárolva'
Config.Text['EDITOR_LOCK_OFF']   = 'Pozíció szabad'
Config.Text['EDITOR_MIRROR_ON']  = 'Tükrözés (Be)'
Config.Text['EDITOR_MIRROR_OFF'] = 'Tükrözés (Ki)'
Config.Text['EDITOR_REMOVE']     = 'Eltávolítás'
Config.Text['EDITOR_CANCEL']     = 'Mégse'

Config.Text['ERROR_WRONG_ENTITY']    = 'Matricát csak járműre rakhatsz.'
Config.Text['ERROR_NO_ACCESS_PLACE'] = 'Nincs jogosultságod matricát rakni erre a járműre.'
Config.Text['ERROR_NO_ACCESS_EDIT']  = 'Nincs jogosultságod szerkeszteni ennek a járműnek a matricáit.'
Config.Text['ERROR_NO_ENTITY']       = 'Nincs jármű a közeledben.'
Config.Text['ERROR_OUT_OF_RANGE']    = 'Túl messzire mentél a járműtől.'
Config.Text['ERROR_MAX_STICKERS']    = 'Ez a jármű elérte a maximális matricaszámot.'
Config.Text['ERROR_NO_STICKERS']     = 'Ezen a járművön nincs matrica.'
Config.Text['ERROR_NO_MONEY']        = 'Nincs elég pénzed ehhez a matricához.'
Config.Text['ERROR_NOT_ALLOWED']     = 'Nincs jogosultságod ehhez a matricához.'

Config.Text['SUCCESS_PLACED']  = 'Matrica sikeresen felrakva!'
Config.Text['SUCCESS_EDITED']  = 'Matrica sikeresen szerkesztve!'
Config.Text['SUCCESS_REMOVED'] = 'Matrica sikeresen eltávolítva!'

Config.Text['MENU_BUTTON_ADD']   = 'Hozzáadás'
Config.Text['MENU_BUTTON_EDIT']  = 'Szerkesztés'
Config.Text['MENU_BUTTON_PRICE'] = '~g~%s Ft'
Config.Text['MENU_BUTTON_FREE']  = '~g~INGYENES'

Config.Text['MENU_MAIN_TITLE']        = 'MATRICÁK'
Config.Text['MENU_MAIN_SUBTITLE']     = 'Válassz műveletet'
Config.Text['MENU_EDIT_SUBTITLE']     = 'Meglévő matricák'
Config.Text['MENU_CATEGORY_SUBTITLE'] = 'Kategóriák' 

-- All available stickers
--[[
    You can add your own stickers, all you need is OpenIV and the stickers, let's look how to do that
        Stickers are sorted in categories which you can rename, add or remove
            category - name of the category
            stickers - list of all stickers in this category
        Stickers come with 2 different variants, either stickers that need to be flipped horizontally or text stickers which can stay as they are
        You can upload your own stickers to .ytd file (texture dictionary) using OpenIV
        A sticker needs these properties:
            name - name of the sticker in the .ytd file
            price - price of the sticker (can be set to 0)
            flip - whether or not the sticker has a horizontally flipped equivalent
            dict - name of the texture dictionary where the sticker is located at (without .ytd extension)
        There are two optional properties:
            name2 - name of the horizontally flipped equivalent in the .ytd file (is set only if flip is true)
            premium - this sticker is meant only for premium players, IsPlayerAllowed (located in framework folder) has to return true
]]
Config.Stickers = {
    {
        category = 'In-game Brands',
        stickers = {
            {
                name = 'Bean Machine Coffee',
                price = 80,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Burger Shot',
                price = 200,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Cherenkov Vodka',
                price = 50,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Cluckin\' Bell',
                name2 = 'Cluckin\' Bell Flipped',
                price = 50,
                flip = true,
                dict = 'in_game_brands'
            },
            {
                name = 'E-Cola',
                price = 160,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Globe Oil',
                price = 120,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Meteorite',
                price = 60,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Pisswasser',
                price = 90,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Sprunk',
                price = 75,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Stronzo Beer',
                price = 50,
                flip = false,
                dict = 'in_game_brands'
            },
        }
    },
    {
        category = 'Real-life Brands',
        stickers = {
            {
                name = '3M',
                price = 30,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Audi',
                price = 150,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'BMW',
                price = 150,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Budweiser',
                price = 90,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Burger King',
                price = 75,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Castrol',
                price = 60,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Caterpillar',
                price = 50,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Chevrolet',
                price = 150,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Coca Cola',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'FedEx',
                price = 95,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Ferrari',
                price = 250,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Ford',
                price = 150,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Haas',
                price = 40,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Lamborghini',
                price = 250,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'McDonald\'s',
                price = 85,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Mercedes-Benz',
                price = 150,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Monster Energy',
                price = 70,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Mountain Dew',
                price = 70,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Pepsi',
                price = 180,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Porsche',
                price = 250,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Red Bull',
                price = 110,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Shell',
                price = 40,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Target',
                price = 30,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'UPS',
                price = 55,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Volkswagen',
                price = 150,
                flip = false,
                dict = 'real_life_brands'
            },
        }
    },
    {
        category = 'Japanese',
        stickers = {
            {
                name = 'Akina Speed Stars',
                price = 130,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'Fujiwara Tofu',
                price = 110,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'Initial D',
                price = 100,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'JDM Legends',
                price = 90,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'JDM Turbo',
                price = 85,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'Night Kids',
                price = 130,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'Red Suns',
                price = 130,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'Top Tier Japan',
                price = 90,
                flip = false,
                dict = 'japanese'
            }, 
        }
    },
    {
        category = 'NASCAR',
        stickers = {
            {
                name = 'NASCAR Logo',
                price = 100,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Aric Almirola',
                price = 50,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Christopher Bell',
                price = 50,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Denny Hamlin',
                price = 50,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Erik Jones',
                price = 50,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Justin Haley',
                price = 50,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Kurt Busch',
                price = 50,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Kyle Busch',
                price = 50,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Martin Truex Jr',
                price = 50,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'William Byron',
                price = 50,
                flip = false,
                dict = 'nascar'
            },
        }
    },
    {
        category = 'Others',
        stickers = {
            {
                name = 'Burning Horse',
                name2 = 'Burning Horse Flipped',
                price = 120,
                flip = true,
                dict = 'others'
            },
            {
                name = 'Burning Skull',
                name2 = 'Burning Skull Flipped',
                price = 110,
                flip = true,
                dict = 'others'
            },
            {
                name = 'Cowboy Skull',
                name2 = 'Cowboy Skull Flipped',
                price = 90,
                flip = true,
                dict = 'others'
            },
            {
                name = 'Drift',
                price = 60,
                flip = false,
                dict = 'others'
            },
            {
                name = 'HOONIGAN',
                price = 40,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Jesus',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Mechanic Skull',
                price = 75,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Piston Skull',
                price = 85,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Pistons',
                price = 85,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Red Flame',
                name2 = 'Red Flame Flipped',
                price = 20,
                flip = true,
                dict = 'others'
            },
            {
                name = 'Textured Skull',
                price = 65,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Turbo Slug',
                name2 = 'Turbo Slug Flipped',
                price = 55,
                flip = true,
                dict = 'others'
            },
            {
                name = 'Umbrella Corporation',
                price = 95,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Yellow Flame',
                name2 = 'Yellow Flame Flipped',
                price = 30,
                flip = true,
                dict = 'others'
            }
        }
    }
}