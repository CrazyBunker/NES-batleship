.segment "ZEROPAGE"
nmi_ready: .res 1
image: .res 4
jpad: .res 1
player_x: .res 1
player_y: .res 1
player_x_map: .res 1
player_y_map: .res 1
player_x_map_player: .res 1
player_y_map_player: .res 1
keys1_is_down:  .byte 0
keys2_is_down:  .byte 0
tmp_addr: .res 2
type_sprite: .res 1
pallete_sprite: .res 1
map_count: .res 1
ship_fire: .res 1
ship_fire_player: .res 1
player1_scoope: .res 1
player2_scoope: .res 1
frame_count: .res 1
update_ready: .res 1

high_tile_player: .res 1
low_tile_player: .res 1
high_tile: .res 1
low_tile: .res 1