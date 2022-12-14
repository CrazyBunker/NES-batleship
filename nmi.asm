.segment "CODE"
nmi:
  php
  pha
  txa
  pha
  tya
  pha
  lda nmi_ready
  bne :+
; обновление тайлов попаданий или  промахов (вынесено в первую  очередь, так как тайлы должны успеть обновиться в первую очередь)
  lda update_ready
  bne @exit_update
  ; Загрузка тайла попаданий по проивнику
  ldy PPUSTATUS
  lda high_tile
  sta PPUADDR
  lda low_tile
  sta PPUADDR
  lda ship_fire
  sta PPUDATA

  ; Загрузка тайла попаданий по своим кораблям
  ldy PPUSTATUS
  lda high_tile_player
  sta PPUADDR
  lda low_tile_player
  sta PPUADDR
  lda #7
  sta PPUDATA
  ; Сбросить значения установки адреса и стролла, так как при загрузке в таблицы тайлов срабатывает скролл.
  lda PPUSTATUS
  lda #$20
  sta PPUADDR
  lda #$00
  sta PPUADDR

  lda #0
  sta PPUSCROLL
  sta PPUSCROLL

  inc update_ready

  @exit_update:

  LDX #$00
  STX OAMADDR
  INX 
  INX
  STX OAMDMA
  inc frame_count
  lda #1
  sta nmi_ready
  :
  pla
  tay
  pla
  tax
  pla
  plp
  rti