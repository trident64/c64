 BasicUpstart2(start)
start:

    lda #$7f
    sta $dc0d
    sta $dd0d

    lda #$01
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
