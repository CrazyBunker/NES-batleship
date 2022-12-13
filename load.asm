.segment "CODE"
.proc load_tiles
  ; Загрузка тайлов фона
  lda PPUSTATUS
  lda #$20
  sta PPUADDR
  lda #$00
  sta PPUADDR
  ; загружаем адреса начала блока с таблицей
  lda  #<background
  sta <image
  lda  #>background
  sta <image+1
  lda #$00
  sta <image+2
  lda #$04
  sta <image+3
  ldy #0
  @1:
    lda (image),y
    sta PPUDATA
    inc image
  bne @2
  inc image+1
  @2:
    lda <image+2
    bne @3
    dec <image+3
  @3:
    dec <image+2
    lda <image+2
    ora <image+3
    bne @1
  rts
.endproc
; Загрузка карты
; Получаем количество палуб на корабле, просталяем в таблицу корабль как номер корабля
.proc load_to_table1
  ldx ship_count
  inx
  @loop:
      lda player_x_map
      pha
      lda player_y_map
      pha

      lda ship_orient
      beq @1
        txa
        clc
        adc player_y_map
        sec
        sbc #$1 
        sta player_y_map
        jmp @2
      @1:
        txa
        clc
        adc player_x_map
        sec
        sbc #$1
        sta player_x_map
      @2:

      jsr get_address
      lda ship_current
      sta table_1,y
      jsr set_zone
      pla
      sta player_y_map
      pla
      sta player_x_map
      dex
  beq :+
    jmp @loop
  :

  lda #0
  sta player_y_map
  sta player_x_map
  rts
.endproc

.proc set_zone
  ; уменьшаем значение y на поле и проверяем не вышли ли за границы, если вышли, то возвращаем значение обратно и пропускаем шаг

  dec player_y_map  ; уменьшаем y и проверяем не вышли ли мы за границы, если вышли, то верхей части поля нет
  ;  ^
  ;  X
  bmi @exit_up_zone
  ; если сверху есть место для зоны, то ставим 20
  jsr write_zone
  ; уменьшаем x и проверяем не вышли ли мы за границы 
  ;    < ^
  ;      X
  dec player_x_map
  bmi :+
     ; Если не вышли за границы, то записываем 2-ки
     jsr write_zone
  :
  ;  ^
  ;  X
  inc player_x_map
  ;  ^ >
  ;  X
  inc player_x_map
  lda #10
  cmp player_x_map
  beq :+
    ; Если не вышли за границы, то записываем 2-ки
    jsr write_zone
  :
  ; ^ |
  ; X |
  dec player_x_map
  @exit_up_zone:
  ;   |
  ; X |      
  inc player_y_map
  ; Выгружаем обратно, то что загрузили в стек
  ; < X ;
  dec player_x_map
  bmi :+
    jsr write_zone
  :  
  ; X ;
  inc player_x_map
  ; X >;
  inc player_x_map
  lda #10
  cmp player_x_map
  beq :+
     jsr write_zone
  :
  ; X ;
  dec player_x_map
  ; X ;
  ; ↓ ;
  inc player_y_map
  lda #10
  cmp player_y_map
  beq @exit_down_zone
  jsr write_zone
  ;  X ;
  ;← ↓ ;  
  dec player_x_map
  bmi :+
    jsr write_zone
  :  
  ; X ;
  ; ↓ ;
  inc player_x_map
  ; X  ;
  ; ↓ →;
  inc player_x_map
  lda #10
  cmp player_x_map
  beq :+
    jsr write_zone
  :  
  ; X ;
  ; ↓ ;
  dec player_x_map
  ; X ;
  dec player_y_map
  @exit_down_zone:
  rts
.endproc
.proc write_zone
  jsr get_address
  lda table_1,y
  bne :+
    lda #20
    sta table_1,y
  :
  rts
.endproc

.proc load_ship
  lda ship_current
  asl a
  tay
  lda #<ship_number_count
  sta image
  lda #>ship_number_count
  sta image+1
  lda (image),y
  sta tmp_addr
  iny
  lda (image),y
  sta tmp_addr+1
  ldy #0
  lda (tmp_addr),y
  sta player_y
  iny 
  lda (tmp_addr),y
  sta player_x
  iny 
  lda (tmp_addr),y
  sta ship_count
  rts
.endproc