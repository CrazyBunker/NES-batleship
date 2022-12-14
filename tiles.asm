.segment "CODE"
.proc update_tile
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

.proc update_around_ship
  lda player_x_map
  pha
  lda player_y_map
  pha
  lda ship_fire
  pha
  lda #1
  sta table_active
    ldx #0
    ldy #0
  @loop:
    lda table_ships_player,x
    cmp #1
    bne @loop_1
      ; X - номер корабля который убит
      ; Ищем все координаты кораблей, которые убиты
         txa
         clc
         adc #21
         @loop_2:
           pha ; Сохраняем код убитого корабля в стек
           cmp table_2,y
           bne @loop_3
              lda #0
              sta player_x_map
              sta player_y_map           
              ;Получили Y  - смещение в табице - адрес корабля
              tya
              : 
                inc player_y_map
                sec
                sbc #10
              bpl :-
                dec player_y_map
                clc
                adc #10
                sta player_x_map
              txa
              pha
              tya
              pha
              jsr set_zone ; Портит Y
              pla
              tay
              pla
              tax
              
         @loop_3:
         pla ; выгружаем номер корабля из стека
         iny
         cpy #100
         bne @loop_2
    @loop_1:
  inx
  txa
  cmp #10
  bne @loop
  ; Перебрали все корабли в таблице убитых
  
  pla
  sta ship_fire
  pla
  sta player_y_map
  pla
  sta player_x_map

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