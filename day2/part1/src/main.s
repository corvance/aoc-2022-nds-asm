.include "../../../topscreen.s"
.include "../../../common.s"

.global main
main:
	push {r4, lr}
	bl setup

    ldr r0, =data   @ Data address.
    eor r3, r3      @ Running total.

.loop:
    eor r1, r1
    eor r2, r2
    ldrb r1, [r0]       @ Get character.
    cmp r1, #0       @ Check if end of data.

    beq .finished

    ldrb r1, [r0], #2   @ Get opponent's character and advance address to player's.
    sub r1, r1, #64    @ Convert to 1, 2 or 3.
    ldrb r2, [r0], #2   @ Get player's character and advance address to next line or null terminator.
    sub r2, r2, #87    @ Convert to 1, 2 or 3

    add r3, r3, r2      @ Add choice score to running total.
    @ Determine outcome.

    @ Draw
    cmp r1, r2
    addeq r3, r3, #3    @ 3 points for a draw.
    beq .loop

    @ Win conditions.

    @ Can't use > or < for scissors and rock as they are 3 and 1 respectively.
    cmp r1, #3
    bne .notScissorsRock
    cmp r2, #1
    bne .notScissorsRock
    add r3, r3, #6      @ 6 points for a win.
    b .loop
.notScissorsRock:
    cmp r1, #1
    bne .notRockScissors
    cmp r2, #3
    bne .notRockScissors
    b .loop

.notRockScissors:
    cmp r1, r2
    @ All other combos are wins if player > opponent.
    addlt r3, r3, #6    @ 6 points for a win.
    @ Nothing for as loss so just loop here.
    b .loop

.finished:
    ldr r0, =output
    mov r1, r3
    bl printf

@ DS Software must loop infinitely.
.infloop:
	b .infloop

.section .rodata

@ Initial output.
intro: .ascii "AOC 2022 - Day 2 - Part 1\n\000"
@ Output upon finishing.
output:	.ascii	"\nThe total Rock, Paper, Scissors score is %i!\n\0"


data: .ascii "A Y\nB Y\nB Z\nB Z\nA Y\nC Y\nA Y\nC Y\nA Y\nB X\nB Y\nB Z\nA Y\nA Y\nC Y\nC Y\nA Y\nC Y\nB Y\nA Y\nA Y\nC Y\nC X\nA Y\nB Z\nC Y\nA Y\nC Y\nA Y\nC Y\nA Z\nA Y\nC Y\nB Y\nA Y\nC Y\nB X\nB Z\nC X\nB Z\nB X\nC Y\nB Z\nA Y\nC Y\nB X\nA Y\nA Z\nB Y\nC Y\nA X\nC X\nC Y\nC Y\nA Y\nC X\nA Y\nC X\nC Y\nC Y\nA Y\nC Y\nA Z\nA Y\nB Z\nA Y\nA Y\nB X\nA Y\nB Y\nA Y\nB X\nB Y\nC Y\nA Y\nB X\nA Y\nC X\nB Y\nA Y\nB Z\nC Y\nC Y\nB Y\nB Z\nB Z\nB Y\nB Y\nA Y\nA Y\nA Z\nC Y\nB X\nA Y\nB Y\nA Y\nB X\nC Y\nA Z\nC Y\nC Y\nA Y\nA Y\nC Y\nC Y\nB X\nA Y\nA Y\nB X\nA Y\nC Y\nB Z\nA Y\nB Z\nC Y\nC X\nC Y\nB Z\nC Y\nA Y\nA Y\nB Y\nC X\nA X\nB X\nA Y\nC Y\nC Y\nA Y\nA Y\nC Y\nC Y\nA Z\nB X\nC Y\nB X\nA Y\nC Y\nA Y\nA Z\nC Y\nA Y\nA Y\nA Y\nC Y\nB X\nC Y\nA Y\nA X\nC Y\nA Y\nB X\nC Y\nA Y\nA Y\nB Y\nA Y\nA Y\nC Y\nB Y\nB X\nA Y\nA Y\nB X\nA Y\nC Y\nA X\nC Y\nC Y\nA Y\nB Z\nA Y\nA Y\nC Y\nA Y\nA Y\nC Y\nA Z\nB Z\nA Y\nC Y\nB X\nB X\nA Y\nA Y\nC Y\nA Y\nA Y\nC Y\nB Z\nB Z\nB Y\nB Y\nA Y\nA Y\nA Y\nA Y\nA Y\nC X\nA Y\nA Y\nA Y\nB Z\nC Y\nA Y\nB Z\nA Y\nA Y\nA Y\nB Z\nA Z\nC X\nB X\nB Z\nB Y\nB Y\nC Y\nC Y\nB Y\nA Y\nC Y\nA Y\nA Y\nC Y\nB X\nA Y\nA X\nA Y\nA Y\nB Z\nC Z\nA Y\nB X\nC Y\nC Y\nA Y\nA Z\nA Y\nC Y\nC Y\nC Y\nA Y\nA Y\nC Y\nC Y\nA Y\nA Y\nA X\nA Y\nC Y\nB X\nB Z\nC Y\nA Y\nA X\nA Y\nC X\nC Y\nB Z\nB Y\nA Y\nC X\nC Y\nC Y\nC X\nC Y\nB X\nA Y\nA Y\nA Y\nA Z\nC Y\nA Y\nC Y\nA Y\nB Y\nC X\nA Y\nA Y\nA Y\nC Y\nB Z\nA Y\nC X\nB Y\nA Y\nB Z\nA Y\nC Y\nC Y\nA Y\nB Z\nC Y\nA Z\nC Y\nA Y\nB X\nA Y\nA Z\nA Z\nA Z\nC Y\nC Y\nA Z\nB Y\nA Z\nA Y\nC X\nC Y\nA Y\nA Y\nB Y\nA Y\nA Y\nA Y\nB Y\nC Y\nA Y\nC Y\nA Y\nC X\nA Y\nA Z\nA Y\nA Y\nA Y\nC Y\nA Y\nC Y\nA Y\nA Y\nC X\nA Y\nC Y\nB Z\nC Y\nA Y\nB Y\nA Z\nC Y\nB Y\nA Y\nA Y\nA Y\nA Y\nA Y\nB Z\nB Z\nB Z\nA X\nA Y\nB Z\nA Y\nA Y\nC Y\nC Y\nB Z\nA Y\nB X\nC Y\nA Y\nA Y\nB Y\nC Y\nB Z\nA Y\nA Y\nA Y\nB X\nB Y\nC Y\nA Y\nA Y\nB X\nA Y\nB Z\nC X\nC X\nA Y\nC Z\nC Y\nC Y\nA Z\nB Z\nC Y\nA Y\nA Y\nC Y\nC Y\nC Y\nA Y\nA X\nB Z\nA Y\nA Y\nB Y\nB Y\nC Y\nB Y\nB Y\nB Z\nC Y\nC Y\nB Y\nA Y\nC Y\nA Y\nA Y\nB Y\nA Y\nA X\nA Y\nB Y\nA Y\nB Y\nC Y\nA Y\nB Z\nA Y\nB Y\nA Y\nA Y\nC X\nC Y\nC X\nA Z\nC Z\nB Y\nB Y\nC Y\nB Y\nA Y\nA Y\nB Y\nC Y\nC Y\nC Y\nA Y\nB Z\nB X\nC Y\nC Y\nA Z\nA Z\nA Y\nA Y\nA Y\nB Y\nA Y\nB Y\nA Y\nB Z\nA Z\nB Y\nC Y\nC Y\nC Z\nB Z\nB Y\nB X\nA Y\nB X\nB X\nB Y\nC Y\nB Z\nA Y\nC Y\nA Y\nC Z\nB Y\nA Y\nA Y\nC Y\nB Y\nC Y\nB Y\nB Y\nA Y\nA Y\nA Z\nC X\nA Y\nA Y\nC Y\nA Y\nB Z\nA Y\nA Y\nA Y\nC Z\nC Y\nB Z\nC Y\nB Z\nA Y\nB Z\nB Y\nA Y\nB Y\nA Y\nA Y\nA Y\nA Y\nC Y\nC Y\nC Z\nB Y\nC Y\nC Y\nA Y\nA Z\nA Y\nB Z\nA Y\nC Y\nC Y\nA Y\nA Y\nA Y\nB Z\nA Z\nA Y\nA Y\nA Y\nA Y\nA Y\nB Z\nB Z\nA Y\nA Y\nB Z\nA Z\nA Z\nA Y\nB Y\nB Y\nB Z\nA Y\nB Z\nC Y\nB Z\nB Y\nA Y\nA Y\nC Y\nC Y\nC Y\nA Y\nA Y\nC Y\nC X\nC Y\nA Y\nB Z\nA Y\nB X\nB Y\nB Y\nB X\nA Y\nA Z\nC Y\nB Z\nC Y\nA Z\nA Y\nA Y\nA Y\nC Y\nC X\nA Y\nC Y\nA Y\nB Z\nC Y\nA Y\nB Z\nA Y\nC Y\nA Y\nC Y\nB Y\nC Y\nB X\nA Y\nA Z\nC Y\nA Y\nC X\nC Y\nA Y\nC Y\nA Y\nC Y\nA Z\nB Y\nA Y\nB Z\nC Y\nC Z\nA Y\nA Y\nA Z\nA Y\nA Y\nC Y\nB Y\nC Z\nA Y\nB Y\nC X\nB Z\nC Y\nC Y\nB Z\nB Z\nA Y\nB Y\nC Y\nB Y\nC Y\nB Y\nA Z\nC Y\nB Z\nA Y\nA Y\nC Y\nA Y\nB Z\nA Y\nA Y\nC Y\nC Y\nA Z\nA Y\nA X\nC Y\nB Y\nB Y\nB Z\nB Y\nB Y\nC Y\nA Y\nC Y\nA Y\nA Y\nB X\nC Y\nB X\nA Y\nA Y\nB Y\nB Z\nC Y\nA Y\nC Y\nA Y\nA Y\nC Y\nB Y\nC Y\nB Y\nB X\nC Y\nA Y\nA Y\nB Z\nB Y\nB Y\nA Y\nA Y\nA Y\nA Y\nA Y\nC Y\nA Y\nA Y\nC Y\nA Y\nB Y\nC Y\nA Y\nA Y\nA Y\nC Y\nA Y\nB Y\nB Y\nA Z\nA Y\nC Y\nB Y\nC Y\nA Z\nB Z\nA X\nB Y\nB Z\nA Y\nA Y\nC Y\nB Y\nA Y\nB Z\nA Z\nC Y\nC Y\nA Y\nB X\nC Y\nA Y\nC Y\nC Y\nB Z\nA Y\nA Y\nA Y\nC Y\nA Y\nC Y\nB Y\nB Y\nB Y\nA Z\nC X\nB X\nC Y\nA Y\nA Y\nA Y\nA Y\nC Y\nA Y\nB Y\nA Y\nC Z\nC Y\nA Z\nB Y\nA Y\nC Z\nC X\nB Y\nC X\nA Y\nB Z\nA X\nB Y\nB Y\nB X\nC X\nA Z\nC Y\nB Y\nC Y\nA Z\nC Y\nC Y\nC Y\nA Y\nA Y\nA Y\nC Y\nA Y\nA Y\nC X\nB Z\nC Y\nC Y\nB Z\nC Y\nB Y\nB Z\nA Y\nB X\nA Y\nC Y\nA Y\nA Y\nA Y\nA Y\nB Z\nC Y\nC Y\nB Z\nB Y\nC Y\nC Z\nC Y\nC Y\nB Y\nA Y\nA Y\nA Y\nA Z\nC Y\nA Y\nA Y\nC Y\nA Y\nA Y\nB Y\nA Y\nA X\nA Y\nA Z\nB Y\nC Y\nA Y\nA Y\nC Y\nA Y\nB Z\nB Z\nC Y\nC Y\nA Y\nA Y\nB Z\nB Z\nA Y\nB Y\nC Y\nA Y\nB Y\nC Y\nA Y\nC Y\nB X\nA Y\nA Y\nA Y\nA Y\nA Y\nB X\nC Y\nC Y\nB Y\nA Y\nC Y\nB Y\nC Z\nC Y\nB X\nC Y\nA Y\nC Y\nC Y\nC Y\nC Y\nB X\nA Y\nC Y\nA X\nA Y\nC X\nA X\nC X\nC Y\nA X\nC Y\nC Z\nC Y\nA Y\nA Y\nA Z\nC Y\nC Y\nB Z\nA Y\nC Y\nA Y\nA Y\nB Z\nC Z\nA Y\nA Y\nC Y\nA Y\nA Y\nB Y\nA X\nA Y\nB Z\nA X\nC Y\nB X\nA Y\nA Z\nC Y\nB Z\nB Y\nB Y\nA X\nA Z\nB Z\nC X\nC Y\nB X\nB Z\nC Y\nC Y\nC Y\nA Y\nC Y\nB X\nC Y\nA Y\nA Y\nA X\nC Z\nB Z\nC Z\nC Y\nB Y\nC Y\nA Y\nA Y\nC Y\nC Y\nB Y\nC Y\nC Y\nC Y\nA Y\nB X\nA Y\nB Y\nC Y\nB X\nC Y\nC Y\nB Y\nA Y\nB Y\nB Y\nC Y\nA Y\nB X\nC X\nC Y\nB X\nA Y\nA Y\nB Z\nB Y\nA Y\nB Y\nB Y\nA Z\nB X\nB Z\nC Y\nB Y\nC Y\nA Y\nA Y\nB X\nA Y\nC X\nB Y\nB Z\nB X\nC X\nC Y\nC X\nA Y\nC Y\nB Y\nB Y\nA Y\nB X\nC Y\nC Y\nB X\nB X\nC Y\nB Z\nB Y\nA Y\nC Y\nB X\nC Y\nA Y\nA Z\nA Y\nA Y\nC Y\nA Z\nA Y\nB Z\nA Y\nB Y\nB X\nB Z\nB Y\nC Y\nA Y\nA Y\nC X\nB Y\nA Y\nB Y\nA Y\nC Y\nC Y\nA Y\nB Y\nB Y\nB Y\nC Y\nA Y\nB Y\nB X\nB X\nA Y\nC Y\nC Y\nA Y\nA Y\nA Y\nA Z\nC Y\nA Y\nC Y\nA Y\nB Z\nC Y\nC X\nC Y\nA Y\nC X\nB Z\nC X\nA Y\nB X\nA Y\nC Z\nC X\nA X\nA Y\nC Y\nB X\nA X\nB Y\nA Y\nA Y\nA Y\nC X\nA Z\nB Z\nC Y\nA Y\nC Y\nC Y\nC X\nC Y\nB Y\nC Y\nB Z\nB Z\nC Y\nB Y\nA Y\nA Y\nA Y\nB Y\nC Y\nA Y\nA Y\nC Y\nB Y\nB Y\nC Y\nA X\nA Y\nA Y\nA Z\nA Y\nB Y\nC Y\nA Y\nA Y\nA Y\nC Y\nA Y\nB X\nA Y\nC Y\nA Y\nA Y\nB Z\nB Y\nB Z\nC Y\nA Y\nA Z\nA Y\nA Y\nB Y\nA Y\nC Y\nC Y\nA Y\nB Y\nC X\nB Z\nA Y\nC Y\nB X\nB Y\nC Y\nB Y\nC Z\nA Z\nA Y\nC Y\nA Y\nC Y\nC X\nA Y\nC Y\nB X\nC Y\nA Y\nA Y\nC Y\nA Z\nB X\nB Z\nA Y\nB Z\nB Y\nA Z\nB Y\nA Y\nC Y\nA Y\nC Y\nC Y\nA Y\nB Y\nC Y\nA Y\nA Y\nB X\nA Y\nA Y\nA Y\nC Y\nA Z\nB Y\nB X\nA Y\nB Y\nC Y\nA Y\nC Y\nA Z\nB X\nA Y\nA Y\nA Y\nA Z\nA Y\nB Y\nB Z\nB Z\nA Y\nA Z\nA Y\nB X\nA Y\nA Y\nA Y\nC Y\nA Y\nA Y\nA Z\nC Y\nA Y\nA Y\nB X\nB Y\nC Y\nB X\nC Y\nA Y\nB Y\nA Y\nC Y\nC Y\nC Y\nC Y\nA Y\nC Y\nC Y\nB Y\nA Y\nC Y\nA Y\nA Y\nB Y\nA Y\nB Y\nC X\nA Y\nA Y\nA Y\nC Y\nB Z\nC Y\nA X\nA Y\nA Z\nA Y\nB X\nC X\nA Y\nB Y\nA Y\nA Y\nB Y\nA Y\nC Y\nA Y\nA Y\nB Z\nC Y\nA Y\nA X\nB Z\nA Y\nA Y\nA Z\nC Y\nA Z\nC Y\nB Y\nA Y\nC X\nB X\nA Y\nC X\nC X\nA Y\nA Y\nA X\nA Y\nA Y\nA Y\nB Y\nC X\nA Y\nC Y\nC Y\nA Y\nB Z\nA Y\nC Y\nB Z\nA Y\nC Y\nC Y\nB X\nB Y\nB Z\nA Y\nC Z\nC Y\nA Y\nC X\nA Y\nC X\nB Z\nA Y\nB Y\nA Y\nC Y\nB Y\nA Y\nB Y\nB X\nA Y\nB Y\nC Y\nA Y\nC Y\nC Y\nA X\nC Y\nC X\nA X\nA Y\nC Y\nC Y\nC X\nC X\nC Y\nC Y\nC Y\nA Z\nA Y\nB Z\nC Y\nC Y\nA Z\nA Y\nA Y\nC X\nA Y\nA Y\nA Y\nC Y\nA Y\nC Y\nA Y\nA Y\nA Y\nC Y\nC Y\nA Y\nB Y\nB Y\nA Z\nB X\nB X\nB Y\nC Y\nA Y\nA X\nA Y\nB X\nC Y\nB X\nC X\nC Y\nA Y\nA Y\nC Y\nA Y\nC Y\nA Y\nB Z\nC Y\nA Y\nB Y\nA Y\nA Y\nA Y\nA Y\nA Z\nC Y\nA Y\nB Y\nC Y\nC Y\nA Y\nC X\nA Y\nA Y\nC Y\nC Y\nC X\nB Y\nA Y\nA Y\nA Y\nA Y\nC Y\nA Y\nB X\nA Z\nA Y\nC Y\nB X\nA Y\nC Y\nA Y\nA Y\nA Y\nC Y\nB Y\nA Y\nA Y\nB Z\nC Y\nC X\nA Y\nA Y\nC Y\nA Y\nC X\nC Y\nC Y\nA Y\nC Y\nC Y\nC Y\nC X\nA Y\nA Y\nA Y\nA Y\nC Y\nB Y\nC Y\nA Y\nA Z\nB Z\nA Y\nB Y\nB Z\nC Y\nA X\nB Y\nC Y\nA Y\nA Y\nC Y\nA Y\nA Y\nA Z\nB Z\nC X\nB Y\nB Y\nC Y\nC Y\nC Y\nA Y\nA Y\nA Y\nA Y\nC Z\nB Y\nB Z\nC Y\nC Y\nA Y\nB Y\nC Y\nA Y\nA X\nB X\nC Y\nA Y\nC Y\nC X\nC Y\nA Y\nA Y\nB Y\nB X\nA Y\nC Y\nA Z\nB X\nC Y\nB X\nA Y\nB Z\nA Y\nA Y\nB Y\nB Z\nB X\nA Y\nB X\nB Z\nA Y\nC Y\nA Y\nA Y\nA Z\nB X\nA Y\nA Y\nB Y\nA Y\nB Z\nB X\nC Y\nC X\nC X\nC X\nA X\nA Y\nA Y\nA Y\nB Y\nA Y\nA Y\nA Y\nC Y\nB Y\nB X\nB Y\nC Y\nA Z\nA Y\nB Z\nA Y\nC Y\nA Y\nA Z\nB Z\nC Y\nB Z\nA Y\nC Y\nB Y\nC Y\nA Y\nC Y\nB Z\nB Y\nB X\nC X\nA Y\nA X\nB X\nC Y\nC Y\nA Y\nC Y\nB Y\nA Y\nB Z\nA Y\nB X\nA Y\nC Y\nA Y\nC Y\nC Y\nA Y\nA Y\nA Y\nC X\nB Y\nB Z\nB Y\nA Y\nA Y\nA Z\nB X\nA Y\nA Z\nC Y\nB Z\nB X\nA Y\nC Y\nA Y\nB Z\nA Y\nA Z\nB Y\nC X\nA Y\nC Y\nC Y\nC Y\nC Y\nA Y\nA Y\nB Y\nA Y\nC Y\nA Y\nB Z\nC Y\nA Z\nC Y\nA Y\nA Z\nC Y\nB X\nC Y\nC Y\nA Y\nA Y\nB Z\nB Y\nB X\nA Y\nA Y\nB Y\nA Y\nA Y\nB X\nB Y\nA Y\nC Y\nA Y\nC Y\nC Y\nB Y\nB Y\nC Y\nA Y\nA Z\nA Y\nA Y\nA Y\nC Y\nC X\nB Z\nC Y\nA Y\nA Y\nC Y\nA Y\nA Y\nA Z\nC X\nC Y\nA Y\nA Y\nC Y\nC Y\nA Y\nA Y\nC Y\nC X\nA Y\nA Y\nB Y\nA Z\nB Y\nA Y\nB Z\nC Y\nC Y\nA Y\nB Y\nA Y\nC Y\nB Z\nA Y\nA Y\nC X\nC Y\nC X\nA Y\nA Y\nA Y\nB Y\nC X\nA Y\nB X\nB Y\nC Y\nA Y\nC Y\nA Y\nA Y\nC Y\nA Z\nA Y\nC X\nA Y\nA Y\nC Y\nC Y\nC X\nA Y\nA Y\nC Y\nB Y\nA Y\nC Y\nA Y\nB Z\nA Y\nC Y\nA Y\nA Y\nA Z\nA Y\nB Z\nA Y\nA Y\nA Y\nA Y\nA Y\nC Z\nC X\nA Y\nA Z\nC Y\nC Y\nB Z\nA Y\nB X\nA Y\nA Y\nA Z\nB Z\nA Y\nA Y\nC Y\nA Y\nC Y\nB Z\nB X\nC X\nA Y\nB Y\nC Y\nC X\nB Y\nC Y\nA Y\nA Y\nA Y\nA Z\nB Y\nA Y\nC Y\nA Y\nA Y\nA Y\nA Y\nC Y\nC Y\nA Y\nA Z\nC Y\nB Y\nC Y\nC Y\nB Y\nA Y\nC Y\nB Z\nA Y\nA Y\nB Z\nC Y\nB Z\nC Y\nC Y\nB Z\nB Y\nA Y\nC X\nC Y\nB Y\nA Y\nA Y\nA Y\nB Z\nA Y\nB Y\nA Y\nC Y\nA Y\nA Y\nC Y\nA Z\nA Y\nC Y\nB Y\nA Y\nB Z\nC Y\nA Y\nA Y\nC Y\nB Z\nB Z\nA Y\nA Y\nA Y\nA Y\nA Y\nC Y\nA Y\nA Y\nA Y\nA Y\nC Y\nA Y\nC Y\nB X\nB Y\nA Y\nC Z\nB Y\nC Y\nC Y\nA Y\nC Y\nC Y\nA Y\nA Y\nA Y\nA Y\nB X\nB Z\nC Y\nB X\nB Y\nB Y\nB Z\nB X\nA Y\nA Y\nB Y\nB X\nA Y\nA Y\nC Y\nC X\nA Y\nB Y\nA Y\nB Y\nB Y\nB Y\nC Y\nA Y\nA X\nA Y\nC Y\nB X\nB Y\nA Y\nA X\nC Y\nC X\nA Y\nA Y\nA Y\nB Y\nC X\nA Z\nB Z\nA Y\nB Z\nA Y\nA Y\nA Y\nA Y\nB X\nA Y\nC Z\nC Y\nC Y\nC Y\nB Z\nA Y\nA Y\nB Z\nB Y\nA Z\nA Y\nA Y\nB Z\nC Y\nA Y\nC Y\nC Y\nC Y\nB X\nB Y\nA Y\nA Y\nA Y\nA Y\nB Y\nA Y\nB Z\nB Z\nA Y\nC Y\nC Y\nC Y\nA Y\nC Y\nB Y\nC Y\nA Y\nB Y\nB Y\nB X\nC X\nA Y\nA Y\nA Y\nB Y\nC Y\nB Y\nC X\nB Y\nB Y\nA Z\nC Z\nC X\nB Y\nC Y\nB Y\nC Y\nB Z\nA Y\nC Y\nA Y\nB Y\nC Y\nA Y\nA Y\nC Z\nB X\nA Z\nC Y\nC Y\nA Y\nB Z\nB Y\nC X\nA Y\nB Z\nA Y\nA Y\nA X\nA Y\nB Y\nC Y\nB Y\nA Y\nA Y\nB Y\nC Y\nB Y\nA Y\nA Y\nB Y\nC Y\nB Y\nC Y\nB Y\nB Y\nB X\nA Y\nA Y\nC X\nA Y\nC Y\nB Z\nA Y\nB Y\nA Z\nA Y\nA Y\nB Y\nC Y\nB Z\nA Z\nA Y\nB Z\nC Y\nA Y\nA Y\nA Y\nC X\nC Y\nA Y\nC Y\nA Y\nA Y\nB Z\nA Y\nA Z\nC Y\nC Y\nA X\nC X\nA Y\nB Z\nA Y\nA Y\nB Y\nA Y\nA Y\nB Z\nA Y\nB Y\nB Z\nA Y\nA Z\nA Y\nA Z\nC Y\nB Y\nA Y\nA Y\nB Z\nC X\nC Y\nA Y\nA Y\nA Y\nA Y\nA Y\nA Z\nC Y\nB X\nA Z\nB Y\nA Y\nA Z\nA Y\nC X\nA Y\nA Y\nC Z\nB Y\nC Y\nC Y\nB Y\nC X\nA Y\nA Y\nB Y\nA Y\nA Y\nA Y\nB Y\nB Y\nC Y\nA Y\nA Y\nB Y\nB X\nA Y\nA Y\nC Y\nB Y\nC Y\nB Z\nA Z\nC X\nB X\nA Y\nA Y\nA Y\nC Z\nA Y\nC Y\nB Y\nA Y\nB X\nA Y\nC Y\nA Y\nB Y\nA Y\nB X\nB Y\nA Y\nC Y\nC Y\nA Y\nA Y\nA Y\nA Y\nC Y\nC Y\nA Y\nA Y\nB Y\nC Y\nB Z\nC Y\nC Y\nC Z\nA Z\nB X\nC Y\nA Y\nB Y\nB Y\nA Y\nB X\nA Y\nB Y\nB X\nC Y\nB X\nB Y\nB Y\nB Z\nA Y\nA Z\nB Z\nA X\nC Y\nB X\nC X\nA Y\nB Z\nA Y\nA Y\nA Z\nC X\nA Y\nB Y\nB Y\nA Y\nA Z\nA Y\nB X\nB X\nA Y\nB Y\nC Y\nA Y\nB X\nB Z\nB Z\nB Z\nC X\nA Y\nC Y\nA Z\nB Y\nB Y\nA Y\nB Y\nC Y\nA Y\nA Z\nB X\nC Y\nC Y\nA X\nC Y\nC Y\nB Y\nB X\nC X\nA Y\nC X\nC Y\nA Y\nB Y\nA Y\nA Y\nB Z\nC Y\nB X\nA X\nC Y\nB X\nC Y\nC Y\nA Y\nC Y\nC Y\nC X\nA Y\nA Y\nB Y\nC Y\nC Y\nA Y\nC Y\nA Z\nA Y\nA Y\nB X\nA Y\nA Y\nA Y\nA Y\nA Y\nC Y\nB Y\nB Y\nA Y\nA Y\nB Y\nC Y\nB Y\nA Y\nA Y\nB Z\nC X\nA Y\nC Y\nB Y\nB X\nA X\nA Y\nB Y\nB X\nB Y\nA Y\nC Y\nA Z\nB Y\nC Y\nC Y\nB Z\nC Y\nC Y\nC Y\nC Y\nC Y\nA Y\nB Z\nC Y\nC Y\nA Z\nA Y\nB Z\nA Y\nB X\nC Y\nC X\nA Y\nA Y\nB Y\nA Z\nA Y\nC Z\nA Y\nB Y\nA Y\nB X\nA Y\nB Z\nC Y\nA Y\nA Z\nA Y\nB Y\nA Y\nB Z\nA Y\nA Y\nA Y\nA Y\nC X\nA Y\nB Z\nA Y\nB Z\nB X\nA Y\nB Y\nC Y\nB Z\nB Z\nC Y\nB Z\nA Z\nA Z\nB Z\nA Y\nC Y\nC Y\nA Y\nC Y\nB X\nC Y\nC Y\nB Z\nA Y\nA Y\nC Y\nB Y\nA Y\nC Y\nC Y\nA Y\nB Y\nA Y\nB Y\nA Y\nA Y\nA Y\nC Y\nB X\nB X\nC Y\nC Y\nB X\nA Y\nC Y\nA Y\nB Z\nA Z\nA Y\nC Y\nA Y\nC Y\nA Y\nC Y\nC Y\nC Y\nA Z\nA Y\nC Y\nB Y\nA Y\nA Y\nC Y\nC Y\nA Y\nB X\nB Y\nC Y\nB Y\nB Z\nC Y\nA Y\nC Y\nC Y\nC Y\nA X\nA Y\nC X\nA Z\nC Y\nC Y\nA Y\nC Y\nA Y\nC Y\nA Y\nA Y\nC Y\nB Y\nA Y\nA Y\nA Y\nC Y\nC Z\nA Z\nA Y\nC Y\nA Y\nA Z\nC Y\nA Y\nC Y\nB Y\nA Y\nB Y\nC Y\nB Y\nA Y\nA Z\nA Y\nB X\nC X\nC Y\nB Z\nC Y\nC Y\nA Y\nB X\nB Z\nA Y\nB Z\nB X\nA Y\nA Y\nA Y\nB X\nC Y\nC Y\nC Y\nC Y\nB Z\nA Y\nB Y\nB Z\nA Y\nA Z\nA Y\nA Y\nA Y\nB Z\nC Y\nA Y\nA Y\nB Y\nC Y\nC X\nA Y\nC Y\nA Y\nA Y\nA Y\nC Z\nA Z\nB Y\nA Z\nB X\nB Y\nA X\nA Y\nA Y\nC Y\nC Y\nB X\nA Z\nC Y\nB Y\nC X\nA Y\nA Y\nB Y\nC Y\nC Y\nA Y\nC X\nA Y\nA Y\nA Y\nA Y\nC Y\nC Y\nA Y\nC Y\nA Z\nA Y\nC Y\nA Y\nB X\nC Y\nC Y\nC Y\nB X\nB Y\nA Y\nA Y\nA Y\nC Y\nA Y\nA Y\nB Y\nA Y\nA Y\nC Y\nC Y\nA Y\nC Y\nC Y\nC Y\nC Y\nC Y\nB Z\nC Z\nC Y\nB X\nB Y\nC Y\nA Y\nA Y\nA Y\nA Y\nB Z\nA Y\nA Z\nC X\nA X\nA Y\nA Y\nC X\nC Y\nB Y\nA Y\nC Z\nB Y\nB Y\nC Z\nC Z\nA Y\nA Y\nA Y\nC X\nB Y\nB Z\nA Y\nA Y\nB Y\nC X\nB Y\nA Y\nC Y\nB Y\nA Y\n\000"