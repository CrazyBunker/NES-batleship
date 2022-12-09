.proc next_step_player
  inc player_y_map_player
  lda player_y_map_player
  cmp #10
  beq :++
    dec player_y_map_player
    inc player_x_map_player
    lda player_x_map_player
    cmp #10
    beq :+
      dec player_x_map_player
      dec player_x_map_player
    :
  :
  @iter:
  jsr get_address_player
  ; y - смещение
  lda table_player,y
  ; Получить значение в таблице противника (0, 6 , 7)
  cmp #0
  ; если клетка пустая, то
  beq :+
     jmp @exit   
  :
  cmp #6
  ; если получил клетку с попаданием
  beq :+++
     dec player_x_map_player
     lda player_x_map_player
     cmp #$FF
     beq :++
       inc player_x_map_player
       dec player_y_map_player
       lda player_y_map_player
       cmp #$FF
       beq :+
           inc player_y_map_player
           inc player_x_map_player
       :
     :
     jmp @iter
  :
  cmp #7
  ; если ппоал на клетку с промахом
  beq @exit
     dec player_x_map_player
     lda player_x_map_player
     cmp #$FF
     beq :++
       inc player_x_map_player
       dec player_y_map_player
       lda player_y_map_player
       cmp #$FF
       beq :+
           inc player_y_map_player
           inc player_x_map_player
       :
     :
  jmp @iter
  @exit:
  rts
.endproc