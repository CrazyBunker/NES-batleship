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