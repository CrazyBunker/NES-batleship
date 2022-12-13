.segment "CODE"
.proc down_indicator
  lda #255
  sta indicator
  lda #1
  sta indicator+1
  lda #0
  sta indicator+2
  lda #255
  sta indicator+3
  rts
.endproc
; Установка индикатора
.proc up_indicator
  lda #15
  sta indicator
  lda #1
  sta indicator+1
  lda #0
  sta indicator+2
  lda #24
  sta indicator+3
  rts
.endproc

.segment "CODE"
.proc down_indicator_kill
  ldy #0
  :
  lda #255
  sta indicator_kill,y
  lda #0
  sta indicator_kill+1,y
  lda #0
  sta indicator_kill+2,y
  lda #255
  sta indicator_kill+3,y
  iny
  iny
  iny
  iny
  cpy #16
  bne :-
  rts
.endproc
; Установка индикатора
.proc up_indicator_kill
  ldy #0
  sty tmp_addr
  :
  lda #103
  sta indicator_kill,y
  lda tmp_addr
  clc
  adc #$10
  sta indicator_kill+1,y
  lda #2
  sta indicator_kill+2,y
  lda tmp_addr
  asl a
  asl a
  asl a
  adc  #156
  sta indicator_kill+3,y
  inc tmp_addr
  iny
  iny
  iny
  iny
  cpy #16
  bne :-
  rts
.endproc