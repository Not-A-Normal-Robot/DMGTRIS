IF !DEF(GLOBALS_ASM)
DEF GLOBALS_ASM EQU 1


INCLUDE "hardware.inc"
INCLUDE "structs.asm"


; PPU modes:
; - 0: HBlank
; - 1: VBlank
; - 2: OAM Scan
; - 3: Drawing


; Waits for PPU mode to be 0 or 1.
; We don't wait for 2 because it's super short and impractical to do much of anything in.
MACRO wait_vram
    ld hl, rSTAT
.wvr\@
    bit 1, [hl]
    jr nz, .wvr\@
ENDM


; Waits for PPU mode to be at the start of mode 1.
; We do this by checking for scanline 144.
MACRO wait_vblank
    ld b, 144
.wvb\@
    ldh a, [rLY]
    cp a, b
    jr nz, .wvb\@
ENDM


; Waits for PPU mode to be at the end of mode 1.
; We do this by checking for scanline 0.
MACRO wait_vblank_end
    ld b, 0
.wvbe\@
    ldh a, [rLY]
    cp a, b
    jr nz, .wvbe\@
ENDM


; Sets the background palette to A.
MACRO set_bg_palette
    ldh [rBGP], a
ENDM


; Sets the object0 palette to A.
MACRO set_obj0_palette
    ldh [rOBP0], a
ENDM


; Sets the object1 palette to A.
MACRO set_obj1_palette
    ldh [rOBP1], a
ENDM


; Sets all palettes to A.
MACRO set_all_palettes
    set_bg_palette
    set_obj0_palette
    set_obj1_palette
ENDM


; Writes two bytes to a register pair.
MACRO lb
    ld \1, (LOW(\2) << 8) | LOW(\3)
ENDM


DEF PALETTE_REGULAR     EQU %11100100
DEF PALETTE_INVERTED    EQU %00011011
DEF PALETTE_MONO_0      EQU %11111111
DEF PALETTE_MONO_1      EQU %10101010
DEF PALETTE_MONO_2      EQU %01010101
DEF PALETTE_MONO_3      EQU %00000000
DEF PALETTE_DARKER_0    EQU %11100100
DEF PALETTE_DARKER_1    EQU %11111001
DEF PALETTE_DARKER_2    EQU %11111110
DEF PALETTE_DARKER_3    EQU %11111111
DEF PALETTE_LIGHTER_0   EQU %11100100
DEF PALETTE_LIGHTER_1   EQU %10010000
DEF PALETTE_LIGHTER_2   EQU %01000000
DEF PALETTE_LIGHTER_3   EQU %00000000
DEF TITLE_A             EQU $99ED
DEF TITLE_B             EQU $99EF
DEF FIELD_TOP_LEFT      EQU $9800+1
DEF TILE_FIELD_EMPTY    EQU 4
DEF TILE_PIECE_0        EQU 10
DEF TILE_0              EQU 66
DEF TILE_CLEARING       EQU 124
DEF TILE_GHOST          EQU 125
DEF TILE_A              EQU 76
DEF TILE_B              EQU 77
DEF NEXT_BASE_X         EQU 120
DEF NEXT_BASE_Y         EQU 40
DEF HOLD_BASE_X         EQU 120
DEF HOLD_BASE_Y         EQU 80
DEF SCORE_BASE_X        EQU 112
DEF SCORE_BASE_Y        EQU 115
DEF LEVEL_BASE_X        EQU 120
DEF CLEVEL_BASE_Y       EQU 136
DEF NLEVEL_BASE_Y       EQU 148
DEF SCURVE_N_ENTRIES    EQU 32
DEF SCURVE_ENTRY_SIZE   EQU 8
DEF PIECE_I             EQU 0
DEF PIECE_Z             EQU 1
DEF PIECE_S             EQU 2
DEF PIECE_J             EQU 3
DEF PIECE_L             EQU 4
DEF PIECE_O             EQU 5
DEF PIECE_T             EQU 6
DEF PIECE_NONE          EQU 255
DEF SFX_IRS             EQU 7
DEF SFX_DROP            EQU 8
DEF SFX_LOCK            EQU 9
DEF SFX_BELL            EQU 10
DEF SFX_MOVE            EQU 11
DEF SFX_RANK_UP         EQU 12
DEF SFX_LEVEL_UP        EQU 13
DEF SFX_IHS             EQU 14
DEF STACK_SIZE          EQU 64


ENDC
