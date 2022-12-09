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
.proc load_to_table1
  ldx ship_count
  inx
  @loop:
      jsr get_address
      lda #1
      sta table_1,y
      dex
  beq :+
    jmp @loop
  :
  lda #0
  sta player_y_map
  sta player_x_map
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