;-----------------------------------------------------------------------------;
; File        : msx-bios.asm
; Description : Functions and system variable declarations for MSX BIOS
;
; Copyright (C) 2015 Alvaro Polo
;
; This Source Code Form is subject to the terms of the Mozilla Public
; License, v. 2.0. If a copy of the MPL was not distributed with this
; file, You can obtain one at http://mozilla.org/MPL/2.0/.
;
;-----------------------------------------------------------------------------;

;
; MSX-1 BIOS subroutines
;

CHKRAM      equ 0x0000
SYNCHR      equ 0x0008
RDSLT       equ 0x000c
CHRGTR      equ 0x0010
WRSLT       equ 0x0014
OUTDO       equ 0x0018
CALSLT      equ 0x001c
DCOMPR      equ 0x0020
ENASLT      equ 0x0024
GETYPR      equ 0x0028
CALLF       equ 0x0030
KEYINT      equ 0x0038

INITIO      equ 0x003b
INIFNK      equ 0x003e

DISSCR      equ 0x0041
ENASCR      equ 0x0044
WRTVDP      equ 0x0047
RDVRM       equ 0x004a
WRTVRM      equ 0x004d
SETRD       equ 0x0050
SETWRT      equ 0x0053
FILVRM      equ 0x0056
LDIRMV      equ 0x0059
LDIRVM      equ 0x005c
CHGMOD      equ 0x005f
CHGCLR      equ 0x0062
NMI         equ 0x0066
CLRSPR      equ 0x0069
INITXT      equ 0x006C
INIT32      equ 0x006f
INIGRP      equ 0x0072
INIMLT      equ 0x0075
SETTXT      equ 0x0078
SETT32      equ 0x007b
SETGRP      equ 0x007e
SETMLT      equ 0x0081
CALPAT      equ 0x0084
CALATR      equ 0x0087
GSPSIZ      equ 0x008a
GRPPRT      equ 0x008d

GICINI      equ 0x0090
WRTPSG      equ 0x0093
RDPSG       equ 0x0096
STRTMS      equ 0x0099

CHSNS       equ 0x009c
CHGET       equ 0x009f
CHPUT       equ 0x00a2
LPTOUT      equ 0x00a5
LPTSTT      equ 0x00a8
CNVCHR      equ 0x00ab
PINLIN      equ 0x00ae
INLIN       equ 0x00b1
QINLIN      equ 0x00b4
BREAKX      equ 0x00b7
ISCNTC      equ 0x00ba
CKCNTC      equ 0x00bd
BEEP        equ 0x00c0
CLS         equ 0x00c3
POSIT       equ 0x00c6
FNKSB       equ 0x00c9
ERAFNK      equ 0x00cc
DSPFNK      equ 0x00cf
TOTEXT      equ 0x00d2

GTSTCK      equ 0x00d5
GTTRIG      equ 0x00d8
GTPAD       equ 0x00db
GTPDL       equ 0x00de

TAPION      equ 0x00e1
TAPIN       equ 0x00e4
TAPIOF      equ 0x00e7
TAPOON      equ 0x00ea
TAPOUT      equ 0x00ed
TAPOOF      equ 0x00f0
STMOTR      equ 0x00f3

LFTQ        equ 0x00f6
PUTQ        equ 0x00f9

RIGHTC      equ 0x00fc
LEFTC       equ 0x00ff
UPC         equ 0x0102
TUPC        equ 0x0105
DOWNC       equ 0x0108
TDOWNC      equ 0x010b
SCALXY      equ 0x010e
MAPXY       equ 0x0111
FETCHC      equ 0x0114
STOREC      equ 0x0117
SETATR      equ 0x011a
READC       equ 0x011e
SETC        equ 0x0120
NSETCX      equ 0x0123
GTASPC      equ 0x0126
PNTINI      equ 0x0129
SCANR       equ 0x012c
SCANL       equ 0x012f

CHGCAP      equ 0x0132
CHGSND      equ 0x0135
RSLREG      equ 0x0138
WSLREG      equ 0x013b
RDVDP       equ 0x013e
SNSMAT      equ 0x0141
PHYDIO      equ 0x0144
FORMAT      equ 0x0147
ISFLIO      equ 0x014a
OUTDLP      equ 0x014e
GETVCP      equ 0x0150
GETVC2      equ 0x0153
KILBUF      equ 0x0156
CALBAS      equ 0x0159


//MSX2. 2+, TR

SUBROM		equ 0x015C
EXTROM		equ 0x015F
CHKSLZ		equ 0x0162
CHKNEW		equ 0x0165
EOL			equ 0x0168
BIGFIL		equ 0x016B
NSETRD		equ 0x016E
NSTWRT		equ 0x0171
NRDVRM		equ 0x0174
NWRVRM		equ 0x0177
RDRES		equ 0x017A
WRRES		equ 0x017D
CHGCPU		equ 0x0180
GETCPU		equ 0x0183
PCMPLY		equ 0x0186
PCMREC		equ 0x0189


;
; MSX-1 system variables
;

CLIKSW		equ 0xf3db
FORCLR      equ 0xf3e9
BAKCLR      equ 0xf3ea
BDRCLR      equ 0xf3eb






;
; MSX-1 VRAM addresses
;
CHRTBL		equ 0x0000
NAMTBL		equ 0x1800
CLRTBL		equ 0x2000
SPRATR		equ 0x1b00
SPRTBL		equ 0x3800

JIFFY		equ	0xFC9E


;
; MSX-2 VRAM addresses
;
ACPAGE 		equ 0xFAF6
DPPAGE		equ 0xFAF5

RG0SAV		equ 0xF3DF
RG1SAV		equ 0xF3E0
RG2SAV		equ 0xF3E1
RG3SAV		equ 0xF3E2
RG4SAV		equ 0xF3E3
RG5SAV		equ 0xF3E4
RG6SAV		equ 0xF3E5
RG7SAV		equ 0xF3E6

RG8SAV		equ	0xFFE7	;	Mirror of VDP register 8 (Basic:VDP(9), note: +1)			
RG9SAV		equ	0xFFE8	;	Mirror of VDP register 9 (Basic:VDP(10), note: +1)			
RG10SA		equ	0xFFE9	;	Mirror of VDP register 10 (Basic:VDP(11), note: +1)			
RG11SA		equ	0xFFEA	;	Mirror of VDP register 11 (Basic:VDP(12), note: +1)			
RG12SA		equ	0xFFEB	;	Mirror of VDP register 12 (Basic:VDP(13), note: +1)			
RG13SA		equ	0xFFEC	;	Mirror of VDP register 13 (Basic:VDP(14), note: +1)			
RG14SA		equ	0xFFED	;	Mirror of VDP register 14 (Basic:VDP(15), note: +1)			
RG15SA		equ	0xFFEE	;	Mirror of VDP register 15 (Basic:VDP(16), note: +1)			
RG16SA		equ	0xFFEF	;	Mirror of VDP register 16 (Basic:VDP(17), note: +1)			
RG17SA		equ	0xFFF0	;	Mirror of VDP register 17 (Basic:VDP(18), note: +1)			
RG18SA		equ	0xFFF1	;	Mirror of VDP register 18 (Basic:VDP(19), note: +1)			
RG19SA		equ	0xFFF2	;	Mirror of VDP register 19 (Basic:VDP(20), note: +1)			
RG20SA		equ	0xFFF3	;	Mirror of VDP register 20 (Basic:VDP(21), note: +1)			
RG21SA		equ	0xFFF4	;	Mirror of VDP register 21 (Basic:VDP(22), note: +1)			
RG22SA		equ	0xFFF5	;	Mirror of VDP register 22 (Basic:VDP(23), note: +1)			
RG23SA		equ	0xFFF6	;	Mirror of VDP register 23 (Basic:VDP(24), note: +1)			
ROMSLT		equ	0xFFF7	;	Main BIOS slot ID. (MSX2 and up only)			
RG25SA		equ	0xFFFA	;	Mirror of VDP register 25 (Basic:VDP(26), note: +1)			
RG26SA		equ	0xFFFB	;	Mirror of VDP register 26 (Basic:VDP(27), note: +1)			
RG27SA		equ	0xFFFC	;	Mirror of VDP register 27 (Basic:VDP(28), note: +1)			


EXPTBL0     equ 0xFCC1  ;   Slot 0: #80 = expanded, 0 = not expanded. Also main BIOS-ROM slot address.
EXPTBL1     equ 0xFCC2  ;   Slot 1: #80 = expanded, 0 = not expanded. 
EXPTBL2     equ 0xFCC3  ;   Slot 2: #80 = expanded, 0 = not expanded. 
EXPTBL3     equ 0xFCC4  ;   Slot 3: #80 = expanded, 0 = not expanded. 

SLTTBL0	    equ 0xFCC5	;	Mirror of slot 0 secondary slot selection register.
SLTTBL1	    equ 0xFCC6	;	Mirror of slot 1 secondary slot selection register.
SLTTBL2	    equ 0xFCC7	;	Mirror of slot 2 secondary slot selection register.
SLTTBL3	    equ 0xFCC8	;	Mirror of slot 3 secondary slot selection register.



H_KEYI      equ 0xFD9A  ;  
H_TIMI      equ 0xFD9F  ;  vdp interrupt.
