.include "includes.asm"


.segment "CODE"
main:
  ; загрузка палитры в PPU
  ldx PPUSTATUS
  ldx #$3f
  stx PPUADDR
  ldx #0
  stx PPUADDR
  ldx #0
  :
    lda example_palette,X
    sta PPUDATA
    inx
    cpx #32
    bcc :-
  
  ; Загрузка тайлов фона
  jsr load_tiles

  ; Загрузка лимитов первой таблицы
  ldy #4
  :
    dey
    lda x_min_table1,y
    sta x_min,y
    tya
  bne :-
  lda #4
  sta type_sprite
  lda #2
  sta pallete_sprite
  lda #0
  sta table_active
  ; Включаем графику
  lda PPUSTATUS
  lda #$20
  sta PPUADDR
  lda #$00
  sta PPUADDR
  ; Выбираем первый корабль
  lda ship_current
  jsr load_ship
  ;Заполнили координатами 
  jsr scroll_reset
  lda #%10010000
  sta PPUCTRL
  lda #%00011110
  sta PPUMASK
;  lda #1
;  sta phaze
  lda #0
  sta map_count
  jsr load_map
  lda #20
  sta player1_scoope
  sta player2_scoope
  lda #2
  sta update_ready
  lda #1
  sta player_y_map_player
  lda #3
  sta player_x_map_player

@loop:

  jsr update_keys

  lda keys1_is_down
  eor keys1_prev
  beq @exit
  ; Рисуем спарйты
  jsr draw_ships

  lda keys1_was_pressed
  AND #KEY_UP
  BEQ :+
  jsr up_ships
  :
  lda keys1_was_pressed
  AND #KEY_DOWN
  BEQ :+
  jsr down_ships
  :
  lda keys1_was_pressed
  AND #KEY_LEFT 
  BEQ :+
  jsr left_ships
  :
  lda keys1_was_pressed
  AND #KEY_RIGHT
  BEQ :+
  jsr right_ships
  :
  lda keys1_was_pressed
  AND #KEY_B
  BEQ :+
  jsr orient_proc
  :
  lda keys1_was_pressed
  AND #KEY_A
  BEQ @exit
  jsr phaze_selector
  @exit:

  lda nmi_ready
  cmp #1
  beq :+
    jmp @loop
  :


  lda #0
  sta nmi_ready
  jmp @loop






