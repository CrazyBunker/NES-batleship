.segment "CODE"
.proc up_ships
    lda player_y
    cmp y_min
    beq :+
    bcc :+
    sbc #$08
    sta player_y
    dec player_y_map
    :
    rts
.endproc
.proc down_ships
    jsr calculate_max
    lda player_y
    cmp max_y
    beq :+
    bcs :+
    clc
    adc #$08
    sta player_y
    inc player_y_map
    :
    rts
.endproc
.proc left_ships
    lda player_x
    cmp x_min
    beq :+
    bcc :+
    sbc #$08
    sta player_x
    dec player_x_map
    :
    rts
.endproc
.proc right_ships
    jsr calculate_max
    lda player_x
    cmp max_x
    beq :+
    bcs :+
    clc
    adc #$08
    sta player_x
    inc player_x_map
    :
    rts
.endproc