.segment "CODE"
; Use variables:
; phaze - текущая фаза игры
; player_y_map - положение на поле y (0-9)
; player_x_map - положение на поле x (0-9)
; запускаемые процедуры:
; phaze_init - Фаза инициализации, расстановка кораблей
; phaze_select_target - фаза выбора цели для выстрела
; get_ship_from_map - процедура полуучения объекта на карте противника
; update_tile - установить тайл на месте выстрела
; up_indicator, down_indicator - установить индикатор или убрать
.proc phaze_selector
    lda phaze
    cmp #0
    bne :+
      jsr phaze_init
      jmp @exit
    :
    lda phaze
    cmp #1
    bne :+
      lda #0
      sta player_y_map
      sta player_x_map
      jsr phaze_select_target
      jsr load_ship
      inc phaze
      jmp @exit
    :   
    lda phaze
    cmp #2
    bne @exit
      jsr get_ship_from_map
      ; x - 6 попал, 7 мимо; 5 - повтор
      cpx #$05
      bne :+
         jsr up_indicator
         jmp @exit
      :
      lda player1_scoope
      bne @next
        jsr up_indicator
        jmp @exit
      @next:
      jsr down_indicator
      jsr update_tile

      jsr next_step_player
      @iter:
      jsr get_ship_from_table1_player
      ; x - 6 попал, 7 мимо; 5 - повтор
      cpx #$07
      beq :+
        jmp @1
      : 
        txa 
        pha
        jsr update_tile_player
        pla
        tax
      @1:
      cpx #$06
      beq :+
        jmp @2
      : 
        txa 
        pha
        jsr update_sprite_player
        jsr next_step_player
        pla
        tax
        jmp @iter
      @2:
      lda #0

      sta update_ready
    @exit:
    rts
.endproc

.proc phaze_init
    jsr get_ship_from_table1
    txa 
    bne @no_load_ship
    inc ship_current
    lda #09
    cmp ship_current
    bne :+
       inc phaze
    :
    jsr load_to_table1
    jsr load_ship
    jsr down_indicator
    jmp @exit_load
    @no_load_ship:
      jsr up_indicator
    @exit_load:
  rts
.endproc

.proc phaze_select_target
  ldy #4
  :
    dey
    lda x_min_table2,y
    sta x_min,y
    tya
  bne :-
  lda #10
  sta ship_current
  lda #5
  sta type_sprite
  lda #1
  sta pallete_sprite
  rts
.endproc