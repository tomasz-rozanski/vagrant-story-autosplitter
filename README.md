# Vagrant Story auto splitter
### Scriptable Auto Splitter for Vagrant Story game (PSOne)

Supported SKUs: 
 - `SLUS-01040 (NTSC-U)`

Supported emulators:
 - Duckstation
 - Mednafen
 - PCSX_Redux
 - Retroarch
 - Xebra
 - ePSXe
 - pSX


Supported actions:
 - splits when BossHP == 0 (including some mini-bosses)
 - starts the timer when the game starts (New Game, New Game+)
 - resets the timer when you get back to the title screen 
 - handles multi-enemy fights in any kill order (Duane, Grissom, Tieger and Neesa)

Requirements:
 - [Live Split](https://github.com/LiveSplit/LiveSplit) with [emu-help](https://github.com/Jujstme/emu-help) component installed

