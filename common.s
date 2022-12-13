.arch armv5te
.fpu softvfp

.text

setup:
	// Push return address.
	push	{lr}

	@ REG_DISPCNT = MODE_5_2D
	ldr r2, =65541
	ldr r3, =0x04000000
	str r2, [r3]

	@ VRAM Bank A = 0x04000240
	@ VRAM_ENABLE = 128, VRAM_A_MAIN_BG = 1
	ldr r2, =129
	ldr r3, =0x04000240
	str r2, [r3]

	@ Set up console for printing.
	bl	consoleDemoInit

	@ bgInit() arguments.
	@ 5 arguments, so last (tileBase) must be on the stack.
    @ Both tileBase and mapBase are 0, so load 0 into r3 and also store
	@ r3 on the stack.
	ldr r3, =0
	push {r3}
	@ BgSize_B16_256x256 = 278660
	ldr r2, =278660
	@ BgType_Bmp16 = 5
	ldr r1, =5
	@ Background 3.
	ldr r0, =3
	bl bgInit_call
	@ Don't need pushed r3 back, so just adjust SP instead of popping.
	add	sp, sp, #4

	@ decompress() arguments.
	@ LZ77Vram = 1
	ldr r2, =1
	@ BG_GFX Address = 0x6000000
	ldr r1, =0x6000000
	@ Source = topscreenBitmap
	ldr r0, =topscreenBitmap
	bl	decompress

	@ Pop return address to PC.
	pop	{pc}
