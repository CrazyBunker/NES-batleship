.segment "CHR"
.incbin "main.chr"
.segment "VECTORS"
.addr nmi, reset, irq


.segment "BSS"

;joypad              
keys1_prev:     .byte 0
keys2_prev:     .byte 0
keys1_was_pressed:      .byte 0
keys2_was_pressed:      .byte 0
ship_orient:     .byte 0
ship_count:      .byte 0
max_x:           .byte 0
max_y:           .byte 0
x_min: .byte 0
x_max: .byte 0
y_min: .byte 0
y_max: .byte 0
count_max:       .byte 0
ship_current: .byte 0
phaze: .byte 0
table_1: .res 100  ; Таблица расстановки игрока 1 (1) Player
table_2: .res 100  ; Таблица расстановки игрока 2 (2) PC
table_player: .res 100 ; Таблица поля боя игрока 2 (2) PC


.segment "OAM"
null_sprite: .res 4
ship1: .res 16
ship2: .res 12
ship3: .res 12
ship4: .res 8
ship5: .res 8
ship6: .res 8
ship7: .res 4
ship8: .res 4
ship9: .res 4
ship10: .res 4
ship_cursor: .res 4
indicator: .res 4