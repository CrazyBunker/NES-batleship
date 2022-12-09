.segment "HEADER"
.byte $4e, $45, $53, $1a  ;Magic string thet always begins an iNES header (Заголовок файлов iNES)
.byte $02                 ; 16KB PRG-ROM (память программ)
.byte $01                 ; 8KB CHR-ROM  (память символов)
.byte %00000001           ; Vertical mirroring, no save RAM, no mapper
.byte %00000000           ; No special-case flags set, no mapper
.byte $00                 ; No PRG-RAM present
.byte $00                 ; NTSC format
