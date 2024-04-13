	output DVD.COM

	org 100h
	
	map 4100h
	
	
include bios.asm

PATTBL = 0x3800
ATTTBL = 0x1B00

_STROUT = 09h
		
	ld a,6
	ld (color),a
	
	//backup old colors
	ld a,(BAKCLR)
	ld (c_bakclr),a
	ld a,(FORCLR)
	ld (c_bdrclr),a
	
	xor a
	ld (BAKCLR),a
	ld (BDRCLR),a
	
	ld a, 60 //initial wait
	ld (wait),a
		
	ld ix, CHGMOD
	ld a,2
	call CALL_BIOS
	
	ld ix, WRTVDP
	ld c, 1
	ld b, 01100010b
	call CALL_BIOS
	
	
	//load sprites
	//move sprite data to 0x4000
	ld hl, DVD_SPRITE
	ld de, 0x4000
	ld bc, 8*32
	LDIR
	//move sprite data to vram	
	ld ix, LDIRVM
	ld hl, 0x4000
	ld de, PATTBL
	ld bc, 8 * 32
	call CALL_BIOS
	
	//center logo
	ld a, (256/2) - (64/2)
	ld (pos_x),a
	ld a, (192/2) - (32/2)
	ld (pos_y),a
	
	//initial direction
	ld a,1
	ld (dir_x),a
	ld (dir_y),a
	
	call set_attrib_pattern_and_color
		
LOOP:
	halt
		
	ld a,(wait)
	cp 0
	jp z, .move
	
	//wait a bit
	dec a
	ld (wait),a
[4]	sra a
[2]	inc a
	ld (color),a
	
	call position_sprites
	call set_attrib_pattern_and_color
	jp .test_keyboard
	
.move
	//x
	ld a,(pos_x)
	ld hl, dir_x
	add a, (hl)
	ld (pos_x),a
	cp 0
	call z, bounce_h
	cp 256 - 64
	call z, bounce_h
	
	//y
	ld a,(pos_y)
	ld hl, dir_y
	add a, (hl)
	ld (pos_y),a
	cp 0
	call z, bounce_v
	cp 192 - 32
	call z, bounce_v
			
	call position_sprites
	
.test_keyboard
	//check for key
	ld ix, CHSNS
	call CALL_BIOS
	jp z, LOOP
	
	ld ix, KILBUF
	call CALL_BIOS
	
	
	ld a,(c_bakclr)
	ld (BAKCLR),a
	ld a,(c_bdrclr)
	ld (BDRCLR),a	
	ld ix, CHGMOD
	ld a,0
	call CALL_BIOS
		
	ret

bounce_h
	ld a,(dir_x)
	call reverse_a
	ld (dir_x),a
	call change_color
	ret
	
bounce_v
	ld a,(dir_y)
	call reverse_a
	ld (dir_y),a
	call change_color
	ret
	
change_color:
	ld a,(color)
	inc a
	cp 16
	jp nz, .cont
	ld a,2
.cont
	ld (color),a
	jp set_attrib_pattern_and_color
	

reverse_a
	cp -1
	jp z, .set1
	ld a, -1
	ret
.set1
	ld a,1
	ret


position_sprites
	
	ld hl, attrib
	ld b,4
	ld a,(pos_x)
	ld d,a
	ld a,(pos_y)
	ld e,a
.loop1
	ld (hl),e
	inc hl
	ld (hl),d
	
[3] inc hl
[16] inc d
	djnz .loop1
	
	ld a,(pos_x)
	ld d,a
[16] inc e
	ld b,4
.loop2
	ld (hl),e
	inc hl
	ld (hl),d
	
[3] inc hl
[16] inc d
	djnz .loop2
	
	//copy to VRAM
	ld ix, LDIRVM
	ld hl, attrib
	ld de, ATTTBL
	ld bc, 8 * 4
	call CALL_BIOS
	ret

	
set_attrib_pattern_and_color
	ld a,(color)
	ld c,a
	ld hl, attrib + 2
	xor a
	ld b, 8
.loop
	ld (hl),a
	add a,4
	
	inc hl
	ld (hl),c
	
[3]	inc hl
	djnz .loop
	ret
	
CALL_BIOS
	ld iy, 0
	jp CALSLT
	

pos_x 	#1
pos_y 	#1
dir_x 	#1
dir_y 	#1
attrib  #4*8 //8 sprites
color	#1
wait	#1

c_bakclr	#1
c_bdrclr	#1

DVD_SPRITE:		
        DB $1F,$1F,$1F,$1F,$00,$3F,$3F,$3F,$3F,$7F,$7F,$7E,$7E,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$81,$00,$00,$00,$00,$01,$03,$0F,$FF,$FF,$FE
        DB $FF,$FF,$FF,$FF,$FF,$FF,$FE,$FE,$FE,$FE,$FC,$F8,$F0,$E0,$80,$00,$F0,$F8,$F8,$F8,$FC,$FC,$FC,$FE,$FE,$7E,$7F,$7F,$3F,$3F,$3F,$1F
        DB $00,$00,$01,$03,$07,$0F,$1F,$3F,$7F,$FE,$FC,$F8,$F0,$E0,$C0,$80,$7F,$FF,$FF,$FF,$F0,$EF,$CF,$8F,$0F,$1F,$1F,$1F,$1F,$3F,$3F,$3F
        DB $FE,$FF,$FF,$FF,$03,$E0,$C0,$C0,$C0,$C0,$C0,$80,$83,$FF,$FF,$FF,$00,$E0,$FC,$FE,$FF,$7F,$3F,$3F,$3F,$3F,$7F,$FE,$FC,$F8,$E0,$80
        DB $FF,$00,$00,$00,$00,$03,$3F,$7F,$7F,$3F,$03,$00,$00,$00,$00,$00,$E0,$00,$00,$00,$0F,$FF,$FE,$FE,$FE,$FF,$FF,$0F,$00,$00,$00,$00
        DB $00,$00,$00,$00,$FF,$FF,$EE,$EE,$EE,$5E,$BE,$FF,$00,$00,$00,$00,$1F,$1E,$0C,$00,$FF,$FF,$F0,$F7,$F7,$F7,$F0,$FF,$00,$00,$00,$00
        DB $00,$00,$00,$00,$FF,$FF,$F8,$7B,$78,$7B,$F8,$FF,$00,$00,$00,$00,$3F,$00,$00,$00,$FF,$FF,$78,$F7,$77,$F7,$78,$FF,$00,$00,$00,$00
        DB $F8,$00,$00,$00,$F0,$FF,$7F,$BF,$BF,$BF,$7F,$F0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$C0,$FC,$FE,$FE,$FC,$C0,$00,$00,$00,$00,$00