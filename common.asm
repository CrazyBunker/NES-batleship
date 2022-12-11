.segment "CODE"

.proc scroll_reset
  bit PPUSTATUS
  lda #0
  sta PPUSCROLL
  sta PPUSCROLL
  rts
.endproc

; Получить смещение корабля на карте (0-100)
; player_y_map
; player_x_map
.proc get_address
  lda #0
  ldy player_y_map
  beq @exit
    : 
      clc
      adc #10
      dey
    bne :-
  @exit: 
    clc
    adc player_x_map
    tay
    rts
.endproc

; Получить смещение корабля на карте (0-100) - Y
; Параметры, X - длина корабля (1-4) (смещение от начальных координат)
; player_y_map_player
; player_x_map_player
; tmp_addr - буфер
.proc get_address_player
  ldy player_y_map_player
  dey
  beq @exit
    lda #0
    : 
      clc
      adc #10
      dey
    bne :-
    ;y = номер строки
  @exit:  
    clc
    adc player_x_map_player
    rts
.endproc


; Загрузка карты в таблицу table_2 (Статическая загрузка предустановленной карты, будет заменена на генерацию, в будущем)
.proc load_map
  lda map_count
  asl a
  tay
  lda #<maps
  sta image
  lda #>maps
  sta image+1
  lda (image),y
  sta tmp_addr
  iny
  lda (image),y  
  sta tmp_addr+1
  ldy #0
  :
  lda (tmp_addr),y
  sta table_2,y
  iny
  tya
  cmp #100
  bne :-
  rts 
.endproc

; Получить статус объекта на карте противника
; Процедуры: get_address - получить смещение на карте, в зависимости от координат прицела
; Переменные: player1_scoope - количество неподбитых единиц кораблей на карте противника
; ship_fire - стаатус последнего выстрела: 6 попал, 7 мимо (номер совпадает с номером тайла, который отображается )

.proc get_ship_from_map
  ldx #1
  jsr get_address

  lda #0
  cmp table_2,y
  beq :+
    jmp @1
  :
    ldx #7
  @1:
  lda #1
  cmp table_2,y
  beq :+
  bcc @repeat
    jmp @2
  :
    ldx #6
    dec player1_scoope
  @2:
  txa
  sta ship_fire
  sta table_2,y
  jmp @exit
  @repeat:
    ldx #5
  @exit:
  rts
.endproc

; Вычисление границ поля (в зависимости от длины корабля)
.proc calculate_max
  lda #0
  ldy ship_count
  @loop:
    beq @exit
    clc
    adc #8
    dey
    jmp @loop
  @exit:
  sta count_max

  lda ship_orient
  beq @horintal
    lda y_max
    clc
    sbc count_max
    sta max_y
    lda x_max
    sta max_x
    jmp @exit3
  @horintal:
    lda x_max
    sbc count_max
    sta max_x
    lda y_max
    sta max_y
    @exit3:
    rts
.endproc   

; Процедура для порота корабля (проверка условия возможности поворота на границах)
.proc orient_proc
  lda player_y
  clc
  adc count_max
  sbc #7
  cmp y_max
  beq @exit
  bcs @exit

  lda player_x
  clc
  adc count_max
  clc
  sbc #7
  cmp x_max
  beq @exit
  bcs @exit

  lda ship_orient
  beq :+
  dec ship_orient
  beq @exit
  :
  inc ship_orient
  @exit:
  rts
.endproc

; Проверка корабля, возвращает 1 в X если есть пересечение (Перессечение определяется из таблицы table_1 - если получено значение - не ноль, то X = 1 )
.proc get_ship_from_table1
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

      pla
      sta player_y_map
      pla
      sta player_x_map

      lda #0
      cmp table_1,y
      bne @exit_bad
      dex
  beq @exit_good
    jmp @loop
  @exit_bad:
    ldx #1
  @exit_good:
  rts
.endproc

; Проверка поадания противника, результат записывается в table_player
.proc get_ship_from_table1_player
  jsr get_address_player
  lda #0
  cmp table_1,y
  beq :+
    jmp @1
  :
    ldx #7
  @1:
  lda #1
  cmp table_1,y
  beq :+
    jmp @2
  :
    ldx #6
    dec player2_scoope
  @2:
  txa
  sta ship_fire_player
  sta table_player,y
  jmp @exit
  @exit:
  rts
.endproc


