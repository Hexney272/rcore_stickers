# rcore_stickers

Jármű matrica rendszer FiveM-hez. Matricákat lehet elhelyezni, szerkeszteni és törölni járműveken egy interaktív szerkesztővel.

## Funkciók

- Interaktív 3D szerkesztő: pozícionálás, méretezés, forgatás, tükrözés
- Kategorizált matrica rendszer (egyedi matricák hozzáadhatók)
- Automatikus tükrözés (flip) támogatás
- Jogosultság rendszer: bárki / tulajdonos / job alapú / restricted
- Premium matricák támogatása
- Automatikus szinkronizálás minden játékos között
- Perzisztens tárolás MySQL adatbázisban
- Framework támogatás: ESX, QBCore, standalone, egyéb

## Követelmények

- FiveM szerver (build 4752+)
- OneSync engedélyezve
- SQL driver (valamelyik):
  - [oxmysql](https://github.com/overextended/oxmysql) (ajánlott)
  - mysql-async
  - ghmattimysql
- Framework (opcionális):
  - ESX
  - QBCore
  - Egyéb (custom)

## Telepítés

1. Másold a `rcore_stickers` mappát a szervered `resources` könyvtárába

2. Futtasd le a `database.sql` fájlt az adatbázisodban:
   ```sql
   CREATE TABLE IF NOT EXISTS stickers (
       id            INT          NOT NULL AUTO_INCREMENT,
       name          VARCHAR(255) NOT NULL,
       vehicle_hash  VARCHAR(50)  NOT NULL,
       vehicle_plate VARCHAR(50)  NOT NULL,
       scale         FLOAT        NOT NULL,
       rotation      FLOAT        NOT NULL,
       ray_from_x    FLOAT        NOT NULL,
       ray_from_y    FLOAT        NOT NULL,
       ray_from_z    FLOAT        NOT NULL,
       ray_to_x      FLOAT        NOT NULL,
       ray_to_y      FLOAT        NOT NULL,
       ray_to_z      FLOAT        NOT NULL,
       CONSTRAINT stickers_pk_id PRIMARY KEY (id)
   ) COLLATE utf8mb4_general_ci;
   ```

3. Add hozzá a `server.cfg`-hez:
   ```
   ensure rcore_stickers
   ```

4. Konfiguráld a `config.lua` fájlt (lásd lentebb)

## Konfiguráció

### Framework beállítás

```lua
Config.Database = 'oxmysql'  -- 'mysql-async' / 'oxmysql' / 'ghmattimysql'
Config.Framework = 'esx'     -- 'esx' / 'qbcore' / 'other' / nil (standalone)
```

### Hozzáférés

```lua
Config.Accessibility = {
    event = false,       -- true: event-tel nyitható (rcore_stickers:openMenu)
    restricted = false,  -- true: IsPlayerAllowedScript() alapján korlátoz
    anyone = true,       -- true: bárki használhatja
    owner = false,       -- true: csak a jármű tulajdonosa
    jobs = false,        -- true: csak bizonyos job-ok
}
```

### Szerkesztő beállítások

```lua
Config.EditorOptions = {
    loadDistance = 50.0,  -- Matricák megjelenítési távolsága
    maxDistance = 10.0,   -- Max távolság a járműtől szerkesztés közben
    maxStickers = 6,      -- Max matricák száma járművenként
    maxScale = 6.0,       -- Maximális méret
    minScale = 0.1,       -- Minimális méret
}
```

## Használat

### Parancs
```
/stickers
```
Nézz egy járműre és írd be a parancsot.

### Event (ha `Config.Accessibility.event = true`)
```lua
TriggerEvent('rcore_stickers:openMenu')
```

### Szerkesztő vezérlők

| Gomb | Funkció |
|------|---------|
| Enter | Matrica elhelyezése |
| Backspace | Mégse |
| Delete | Matrica törlése (szerkesztés módban) |
| Scrollwheel | Méretezés |
| Nyíl balra/jobbra | Forgatás |
| Left Shift (tartva) | Precíziós mód (kisebb lépések) |
| Capslock | Pozíció zárolás be/ki |
| Left Ctrl | Tükrözés be/ki (új matrica módban) |

## Egyéni matricák hozzáadása

1. Készíts egy `.ytd` textúra fájlt OpenIV-vel
2. Helyezd a `stream/` mappába
3. Add hozzá a `config.lua`-ban:

```lua
Config.Stickers = {
    {
        category = 'Egyéni Kategória',
        stickers = {
            {
                name = 'Matrica Neve',       -- Textúra neve a .ytd-ben
                price = 100,                  -- Ár (0 = ingyenes)
                flip = false,                 -- Van-e tükrözött verzió
                dict = 'ytd_fajl_neve',      -- .ytd fájl neve (kiterjesztés nélkül)
                -- name2 = 'Tükrözött Neve', -- Csak ha flip = true
                -- premium = true,           -- Csak premium játékosok (opcionális)
            },
        }
    },
}
```

## Job-alapú hozzáférés

```lua
Config.AllowedJobs = {
    mechanic = true,    -- Bármely grade
    mechanic = 2,       -- Csak grade 2 felett
}
```

## Premium / Restricted testreszabás

A `server/framework/` mappában az adott framework fájljában szerkeszd:

```lua
-- Script szintű hozzáférés
IsPlayerAllowedScript = function(source)
    -- Igaz = hozzáférhet, Hamis = nem
    return true
end

-- Matrica szintű hozzáférés
IsPlayerAllowedSticker = function(source, stickerName)
    -- Igaz = megveheti, Hamis = nem
    return true
end
```

## Fájl struktúra

```
rcore_stickers/
├── config.lua                    -- Konfiguráció
├── object.lua                    -- Framework objektum betöltő
├── debug.lua                     -- Debug rendszer
├── fxmanifest.lua                -- Resource manifest
├── database.sql                  -- SQL tábla létrehozás
├── client/
│   ├── client.lua                -- Fő kliens logika, menük
│   ├── editor.lua                -- Interaktív szerkesztő
│   ├── sticker.lua               -- Matrica renderelés (AddDecal)
│   ├── utils.lua                 -- Segédfüggvények, raycast
│   ├── menu.lua                  -- WarMenu menü rendszer
│   ├── tooltip.lua               -- Scaleform tooltip
│   └── framework/
│       ├── esx.lua               -- ESX kliens integráció
│       ├── qbcore.lua            -- QBCore kliens integráció
│       ├── no_framework.lua      -- Standalone mód
│       └── other.lua             -- Egyéni framework
├── server/
│   ├── server.lua                -- Fő szerver logika, sync
│   ├── utils.lua                 -- Szerver segédfüggvények
│   ├── db/
│   │   ├── bridge.lua            -- SQL driver absztrakció
│   │   └── api.lua               -- Adatbázis lekérdezések
│   └── framework/
│       ├── esx.lua               -- ESX szerver integráció
│       ├── qbcore.lua            -- QBCore szerver integráció
│       ├── no_framework.lua      -- Standalone mód
│       └── other.lua             -- Egyéni framework
└── stream/
    ├── in_game_brands.ytd        -- GTA brand matricák
    ├── japanese.ytd              -- Japán stílusú matricák
    ├── nascar.ytd                -- NASCAR matricák
    ├── others.ytd                -- Egyéb matricák
    └── real_life_brands.ytd      -- Valós márka matricák
```

## Hibaelhárítás

| Probléma | Megoldás |
|----------|----------|
| Matricák nem jelennek meg | Ellenőrizd hogy a `stream/` mappa .ytd fájljai betöltődnek-e |
| "Choose your framework" warning | Állítsd be a `Config.Framework`-öt helyesen |
| "Choose your database" warning | Állítsd be a `Config.Database`-t és legyen elindítva az SQL resource |
| Nem nyílik a menü | Nézz egy járműre közelről, majd `/stickers` |
| Permission denied | Ellenőrizd a `Config.Accessibility` beállításokat |
| QBCore job check crash | Győződj meg róla hogy a qb-core resource fut |

## Debug mód

```lua
Config.ErrorDebug = true   -- Részletes hibaüzenetek (xpcall wrapper-ek)
Config.EnableDebug = true  -- Vizuális debug (decal ID-k, raycast vonalak)
```

Debug módban elérhető a `/clearalldecals` parancs az összes decal eltávolításához.
