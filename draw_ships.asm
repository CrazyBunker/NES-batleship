.segment "CODE"
.proc draw_ships
  jsr calculate_max
  lda ship_current
  asl a
  tay
  lda #<ship_number
  sta image
  lda #>ship_number
  sta image+1
  lda (image),y
  sta tmp_addr
  iny
  lda (image),y
  sta tmp_addr+1
  ; Рисуем первый спрайт
  ldx #0
  ldy #0
  @loop:

    lda ship_orient
    cmp #0
    beq :+
    txa
    clc
    adc player_y
    jmp @exit_loop1
    :
    lda player_y
    @exit_loop1:
    sta (tmp_addr),y
    iny
    lda type_sprite
    sta (tmp_addr),y
    iny
    lda pallete_sprite
    sta (tmp_addr),y
    iny
    lda ship_orient
    cmp #1
    beq :+
    txa
    clc
    adc player_x
    jmp @exit_loop2
    :
    lda player_x
    @exit_loop2:
    sta (tmp_addr),y
    txa
    cmp count_max
    beq @exit
    iny
    txa
    adc #8
    tax
  jmp @loop
  @exit:

  rts
.endproc