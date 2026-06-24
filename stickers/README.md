# Matrica képek

Ide tedd a matrica képeket almappákba szervezve.

## Struktúra

```
stickers/
├── Markak/           ← mappa neve = kategória neve a menüben
│   ├── BMW.png
│   ├── Audi.webp
│   └── Mercedes.png
├── JDM/
│   ├── Initial D.png
│   └── Turbo.webp
└── Egyeb/
    ├── Koponya.png
    └── Lang.webp
```

## Szabályok

- **Támogatott formátumok**: PNG, WebP, JPG
- **Mappa neve** = kategória neve a játék menüjében
- **Fájl neve** (kiterjesztés nélkül) = matrica neve a menüben
- Nem kell kézzel hozzáadni a config.lua-hoz!
- Az ár automatikusan `Config.DefaultStickerPrice` (alapértelmezetten 500 Ft)
- A meglévő YTD-alapú matricák továbbra is működnek mellette
