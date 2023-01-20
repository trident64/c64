 BasicUpstart2(start)
start:

    lda #$7f
    sta $dc0d
    sta $dd0d


    lda #$ff
    sta $d015
    sta $d01d

    .for (var i = 0; i < 8; i++) {
        lda #$24
        sta $07f8 + i
        lda #$f8 + i * $30
        sta $d000 + i*2
        lda #$ff
        sta $d001 + i*2
    }

    lda #$f0
    sta $d000

    lda #8
    sta $d027 + 5
    lda #$c1
    sta $d010

    lda #$00
    sta $3fff

openborder:
    lda #$f8
!:
    cmp $d012
    bne !-
    lda #$13
    sta $d011

    lda #$02
!:
    cmp $d012
    bne !-
    lda #$1b
    sta $d011
    jmp openborder

* = $0900

.byte 0,127,0,1,255,192,3,255,224,3,231,224
.byte 7,217,240,7,223,240,7,217,240,3,231,224
.byte 3,255,224,3,255,224,2,255,160,1,127,64
.byte 1,62,64,0,156,128,0,156,128,0,73,0,0,73,0
.byte 0,62,0,0,62,0,0,62,0,0,28,0,0