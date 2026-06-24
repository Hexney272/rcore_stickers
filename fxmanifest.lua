fx_version 'cerulean'
game 'gta5'

lua54 'yes'

version "1.0.2"

escrow_ignore {
    'config.lua',
    'client/menu.lua',
    'client/framework/*.lua',
    'server/framework/*.lua',
    'server/db/bridge.lua',
    'server/db/api.lua',
    'stream/*',
}

shared_scripts {
    'config.lua',
    'object.lua',
    'debug.lua',
}

client_scripts {
    'client/framework/*.lua',
    'client/utils.lua',
    'client/sticker.lua',
    'client/image_loader.lua',
    'client/menu.lua',
    'client/tooltip.lua',
    'client/editor.lua',
    'client/client.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/db/bridge.lua',
    'server/db/api.lua',
    'server/framework/*.lua',
    'server/utils.lua',
    'server/image_scanner.lua',
    'server/server.lua',
}

files {
    'stickers/**/*.png',
    'stickers/**/*.webp',
    'stickers/**/*.jpg',
    'stickers/**/*.jpeg',
}

dependencies {
    '/server:4752',
    '/onesync',
}
-- dependency '/assetpacks' -- Removed: Tebex escrow-only dependency
