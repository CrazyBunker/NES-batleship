.segment "RODATA"
example_palette:
.byte $0F,$15,$26,$37 ; bg0 purple/pink
.byte $0F,$15,$37,$21 ; bg2 blue
.byte $0F,$09,$19,$29 ; bg1 green
.byte $0F,$00,$10,$30 ; bg3 greyscale

.byte $0F,$18,$28,$38 ; sp0 yellow
.byte $0F,$14,$24,$34 ; sp1 purple
.byte $0F,$1B,$2B,$3B ; sp2 teal
.byte $0F,$12,$22,$32 ; sp3 marine

ship_number:     .addr ship1, ship2, ship3, ship4, ship5, ship6, ship7, ship8, ship9, ship10, ship_cursor
ship_number_count: .addr ship_count_1,ship_count_2,ship_count_3,ship_count_4,ship_count_5,ship_count_6,ship_count_7,ship_count_8,ship_count_9,ship_count_10,ship_count_11
ships:
ship_count_1:  .byte 23,32,$03
ship_count_2:  .byte 23,32,$02
ship_count_3:  .byte 23,32,$02
ship_count_4:  .byte 23,32,$01
ship_count_5:  .byte 23,32,$01
ship_count_6:  .byte 23,32,$01
ship_count_7:  .byte 23,32,$00
ship_count_8:  .byte 23,32,$00
ship_count_9:  .byte 23,32,$00
ship_count_10: .byte 23,32,$00
ship_count_11: .byte $6f,$88,$00

x_min_table1: .byte 32
x_max_table1: .byte 104
y_min_table1: .byte 24
y_max_table1: .byte 94

x_min_table2: .byte $88
x_max_table2: .byte $D0
y_min_table2: .byte $6F
y_max_table2: .byte $B7


table_1_background: .addr $2064
table_2_background: .addr $21d1

tables: .addr table_1, table_2

background:
.incbin  "ns.bin"