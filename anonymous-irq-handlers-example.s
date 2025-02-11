.macro irq_set(name, rasterline) {
    lda #<name
    sta $fffe
    lda #>name
    sta $ffff
    lda #rasterline
    sta $d012
    lda $d011
    and #$7f
    ora #(rasterline & $100) >> 1
    sta $d011

}

.macro irq_wait(rasterline) {
    irq_set(next, rasterline)
    inc $d019
    rti
next:
}

.macro pt_wait_ticks(pt, ticks) {
    lda #0
    sta count + 1
    lda #<again
    sta pt
    lda #>again
    sta pt + 1
again:
count: lda #0
    cmp #ticks
    beq done
    inc count + 1
    rts
done:
}

    * = $0801 "Basic Upstart"
    BasicUpstart(start)

    * = $0810 "Program"
start:
{
    sei
    lda #$7f
    sta $dc0d
    bit $dc0d

    lda #$01
    sta $d01a

    lda #$35
    sta $01

    irq_set(irq, 0)
    cli

    jmp *
}


irq:
{
    lda #$e
    sta $d020

    irq_wait($40)
    lda #2
    sta $d020

    irq_wait($80)
    lda #3
    sta $d020

    irq_wait($f8)
    lda #4
    sta $d020

    jsr sequence

    irq_set(irq, 0)
    inc $d019
    rti
}

sequence:
{
    jmp (pt)

again:
    pt_wait_ticks(pt, 2 * 50)
    lda #5
    sta $d021

    pt_wait_ticks(pt, 2 * 50)
    lda #6
    sta $d021

    jmp again

pt: .word again
}
