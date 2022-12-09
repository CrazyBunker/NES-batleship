.segment "CODE"
.proc update_tile
  ; a - старший адрес таблицы
  ; x - младший адрес таблицы
  lda table_2_background ; младший адрес таблицы
  ldx table_2_background+1 ; старший адрес таблицы
  ldy player_y_map
  beq :++
  @loop:
    clc
    adc #$20
    bcc :+
      inx
  :
  dey
  :
  bne @loop
  clc
  adc player_x_map
  ; a - младший адрес
  ; x - старший адрес
  stx high_tile
  sta low_tile
  rts
.endproc

.proc update_tile_player
  ; a - старший адрес таблицы
  ; x - младший адрес таблицы
  lda table_1_background ; младший адрес таблицы
  ldx table_1_background+1 ; старший адрес таблицы
  ldy player_y_map_player
  beq :++
  @loop:
    clc
    adc #$20
    bcc :+
      inx
  :
  dey
  :
  bne @loop
  clc
  adc player_x_map_player
  ; a - младший адрес
  ; x - старший адрес
  stx high_tile_player
  sta low_tile_player
  rts
.endproc

.proc update_sprite_player
  ; a - старший адрес таблицы
  ; x - младший адрес таблицы
  lda #<ship1 ; загрузить старший адрес первого корабля
  sta tmp_addr
  lda #>ship1 ; загрузить младший адрес первого корабля
  sta tmp_addr+1
  ldy #0
  @loop:
    cpy #$58
    beq @exit_table
    lda #0
    ldx player_y_map_player
    @1:
    beq :+
      clc
      adc #$08
      dex
      jmp @1
    :
    clc
    adc y_min_table1
    sec
    sbc #1
    cmp (tmp_addr),y
    beq :+
      iny
      iny
      iny
      iny
      jmp @loop
    :
  iny
  iny
  iny
  lda #0
  ldx player_x_map_player
  @2:
  beq :+
    clc
    adc #$08
    dex
    jmp @2
  :
  clc
  adc x_min_table1
  cmp (tmp_addr),y
  beq @hit
    iny
    jmp @loop
  @hit:
     dey
     dey
     lda #6
     sta (tmp_addr),y
  @exit_table:
 rts
.endproc