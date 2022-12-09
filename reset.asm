.segment "CODE"
reset:
  SEI
  CLD
  lda #0
  sta PPUCTRL  ; disable NMI
  sta PPUMASK  ; disable rendering
;  STX APUSOUND ; disable APU sound
;  STX DMCIRQ   ; disable DMC IRQ
          
;  LDA #$40
;  STA $4017 ; disable APU IRQ
;  LDX #$FF
;  TXS
  ; clear all RAM to 0
  ldx #0
  :
    sta $0000, X
    sta $0100, X
    sta $0200, X
    sta $0300, X
    sta $0400, X
    sta $0500, X
    sta $0600, X
    sta $0700, X
    inx
    bne :-
  ; place all sprites offscreen at Y=255
  lda #255
  ldx #0
  :
    sta null_sprite, X
    inx
    inx
    inx
    inx
    bne :-
  jsr scroll_reset
  jmp main