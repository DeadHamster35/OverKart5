	.file	1 "OKMenu.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.globl	loadPosition
	.set	nomips16
	.set	nomicromips
	.ent	loadPosition
	.type	loadPosition, @function
loadPosition:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(g_playerCount)
	lw	$2,%lo(g_playerCount)($2)
	li	$3,3			# 0x3
	beq	$2,$3,$L2
	slt	$3,$2,4

	beq	$3,$0,$L3
	li	$3,1			# 0x1

	beq	$2,$3,$L4
	li	$3,2			# 0x2

	bne	$2,$3,$L10
	lui	$2,%hi(MenuPosition)

	li	$3,90			# 0x5a
	sh	$3,%lo(MenuPosition)($2)
	addiu	$2,$2,%lo(MenuPosition)
	li	$3,97			# 0x61
	jr	$31
	sh	$3,2($2)

$L3:
	li	$3,4			# 0x4
	bne	$2,$3,$L10
	lui	$2,%hi(MenuPosition)

	li	$3,90			# 0x5a
	sh	$3,%lo(MenuPosition)($2)
	addiu	$2,$2,%lo(MenuPosition)
	li	$3,97			# 0x61
	jr	$31
	sh	$3,2($2)

$L10:
	jr	$31
	nop

$L4:
	lui	$2,%hi(MenuPosition)
	li	$3,5			# 0x5
	sh	$3,%lo(MenuPosition)($2)
	addiu	$2,$2,%lo(MenuPosition)
	li	$3,15			# 0xf
	jr	$31
	sh	$3,2($2)

$L2:
	lui	$2,%hi(MenuPosition)
	li	$3,170			# 0xaa
	sh	$3,%lo(MenuPosition)($2)
	addiu	$2,$2,%lo(MenuPosition)
	li	$3,200			# 0xc8
	jr	$31
	sh	$3,2($2)

	.set	macro
	.set	reorder
	.end	loadPosition
	.size	loadPosition, .-loadPosition
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
$LC0:
	.ascii	"X:\000"
	.align	2
$LC1:
	.ascii	"Y:\000"
	.align	2
$LC2:
	.ascii	"Z:\000"
	.align	2
$LC3:
	.ascii	"A:\000"
	.align	2
$LC4:
	.ascii	" SX:\000"
	.align	2
$LC5:
	.ascii	" SY:\000"
	.align	2
$LC6:
	.ascii	" SZ:\000"
	.align	2
$LC7:
	.ascii	" LA:\000"
	.align	2
$LC8:
	.ascii	" LS:\000"
	.align	2
$LC9:
	.ascii	" PG:\000"
	.align	2
$LC10:
	.ascii	" SA:\000"
	.align	2
$LC14:
	.ascii	"\000"
	.align	2
$LC15:
	.ascii	".\000"
	.text
	.align	2
	.globl	printDetails
	.set	nomips16
	.set	nomicromips
	.ent	printDetails
	.type	printDetails, @function
printDetails:
	.frame	$sp,80,$31		# vars= 0, regs= 10/0, args= 40, gp= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(g_playerCount)
	lw	$3,%lo(g_playerCount)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L57
	li	$2,58			# 0x3a

	jr	$31
	nop

$L57:
	addiu	$sp,$sp,-80
	sw	$31,76($sp)
	sw	$fp,72($sp)
	sw	$23,68($sp)
	sw	$22,64($sp)
	sw	$21,60($sp)
	sw	$20,56($sp)
	sw	$19,52($sp)
	sw	$18,48($sp)
	sw	$17,44($sp)
	sw	$16,40($sp)
	lui	$16,%hi(MenuPosition)
	sh	$2,%lo(MenuPosition)($16)
	addiu	$17,$16,%lo(MenuPosition)
	li	$2,175			# 0xaf
	sh	$2,2($17)
	lui	$18,%hi(GraphPtr)
	li	$2,175			# 0xaf
	sw	$2,32($sp)
	sw	$0,28($sp)
	sw	$0,24($sp)
	sw	$0,20($sp)
	li	$2,233			# 0xe9
	sw	$2,16($sp)
	li	$7,243			# 0xf3
	li	$6,193			# 0xc1
	li	$5,76			# 0x4c
	jal	FillRect1ColorF
	lw	$4,%lo(GraphPtr)($18)

	jal	loadFont
	sw	$2,%lo(GraphPtr)($18)

	lui	$6,%hi($LC0)
	addiu	$6,$6,%lo($LC0)
	lh	$5,2($17)
	jal	printString
	lh	$4,%lo(MenuPosition)($16)

	lh	$5,2($17)
	lui	$6,%hi($LC1)
	addiu	$6,$6,%lo($LC1)
	addiu	$5,$5,10
	jal	printString
	lh	$4,%lo(MenuPosition)($16)

	lh	$5,2($17)
	lui	$6,%hi($LC2)
	addiu	$6,$6,%lo($LC2)
	addiu	$5,$5,20
	jal	printString
	lh	$4,%lo(MenuPosition)($16)

	lh	$5,2($17)
	lui	$6,%hi($LC3)
	addiu	$6,$6,%lo($LC3)
	addiu	$5,$5,30
	jal	printString
	lh	$4,%lo(MenuPosition)($16)

	lui	$2,%hi(SaveGame+17)
	lb	$3,%lo(SaveGame+17)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L58
	lui	$6,%hi($LC7)

	lui	$16,%hi(MenuPosition)
	addiu	$17,$16,%lo(MenuPosition)
	lh	$4,%lo(MenuPosition)($16)
	addiu	$6,$6,%lo($LC7)
	lh	$5,2($17)
	jal	printString
	addiu	$4,$4,87

	lh	$5,2($17)
	lh	$4,%lo(MenuPosition)($16)
	lui	$6,%hi($LC8)
	addiu	$6,$6,%lo($LC8)
	addiu	$5,$5,10
	jal	printString
	addiu	$4,$4,87

	lh	$5,2($17)
	lh	$4,%lo(MenuPosition)($16)
	lui	$6,%hi($LC9)
	addiu	$6,$6,%lo($LC9)
	addiu	$5,$5,20
	jal	printString
	addiu	$4,$4,87

	lui	$2,%hi(MenuPosition)
$L69:
	addiu	$3,$2,%lo(MenuPosition)
	lh	$5,2($3)
	lh	$4,%lo(MenuPosition)($2)
	lui	$6,%hi($LC10)
	addiu	$6,$6,%lo($LC10)
	addiu	$5,$5,30
	jal	printString
	addiu	$4,$4,87

	move	$16,$0
	lui	$23,%hi(wholeNumber)
	lui	$18,%hi(decimalNumber)
	lui	$20,%hi(printOffsetB)
	lui	$21,%hi(printOffsetA)
	li	$fp,56			# 0x38
	lui	$19,%hi(MenuPosition)
	addiu	$17,$19,%lo(MenuPosition)
	lui	$22,%hi($LC14)
	b	$L29
	addiu	$22,$22,%lo($LC14)

$L58:
	lh	$4,%lo(MenuPosition)($16)
	lui	$6,%hi($LC4)
	addiu	$6,$6,%lo($LC4)
	lh	$5,2($17)
	jal	printString
	addiu	$4,$4,87

	lh	$5,2($17)
	lh	$4,%lo(MenuPosition)($16)
	lui	$6,%hi($LC5)
	addiu	$6,$6,%lo($LC5)
	addiu	$5,$5,10
	jal	printString
	addiu	$4,$4,87

	lh	$5,2($17)
	lh	$4,%lo(MenuPosition)($16)
	lui	$6,%hi($LC6)
	addiu	$6,$6,%lo($LC6)
	addiu	$5,$5,20
	jal	printString
	addiu	$4,$4,87

	b	$L69
	lui	$2,%hi(MenuPosition)

$L16:
	bne	$16,$2,$L19
	lui	$2,%hi(g_player1LocationA)

	lw	$2,%lo(g_player1LocationA)($2)
	mtc1	$2,$f0
	nop
	cvt.s.w	$f0,$f0
	lui	$2,%hi($LC12)
	lwc1	$f2,%lo($LC12)($2)
	mul.s	$f0,$f0,$f2
	lui	$2,%hi($LC13)
	lwc1	$f2,%lo($LC13)($2)
	mul.s	$f0,$f0,$f2
	trunc.w.s $f2,$f0
	swc1	$f2,%lo(wholeNumber)($23)
	cvt.s.w	$f2,$f2
	sub.s	$f0,$f0,$f2
	lui	$2,%hi($LC11)
	lwc1	$f2,%lo($LC11)($2)
	mul.s	$f0,$f0,$f2
	trunc.w.s $f0,$f0
	b	$L19
	swc1	$f0,%lo(decimalNumber)($18)

$L17:
	lui	$2,%hi(g_player1LocationX)
	lwc1	$f0,%lo(g_player1LocationX)($2)
	trunc.w.s $f2,$f0
	swc1	$f2,%lo(wholeNumber)($23)
	cvt.s.w	$f2,$f2
	sub.s	$f0,$f0,$f2
	lui	$2,%hi($LC11)
	lwc1	$f2,%lo($LC11)($2)
	mul.s	$f0,$f0,$f2
	trunc.w.s $f0,$f0
	swc1	$f0,%lo(decimalNumber)($18)
$L19:
	lw	$2,%lo(decimalNumber)($18)
	bltz	$2,$L59
	subu	$2,$0,$2

$L21:
	lw	$3,%lo(wholeNumber)($23)
	sra	$4,$3,31
	xor	$2,$4,$3
	subu	$2,$2,$4
	lui	$4,%hi(printOffsetD)
	sw	$2,%lo(printOffsetD)($4)
	slt	$4,$2,10
	bnel	$4,$0,$L22
	li	$2,32			# 0x20

	slt	$4,$2,100
	bnel	$4,$0,$L23
	li	$2,24			# 0x18

	slt	$2,$2,1000
	bne	$2,$0,$L24
	li	$2,16			# 0x10

	li	$2,8			# 0x8
	b	$L25
	sw	$2,%lo(printOffsetB)($20)

$L15:
	lui	$2,%hi(g_player1LocationZ)
	lwc1	$f0,%lo(g_player1LocationZ)($2)
	trunc.w.s $f2,$f0
	swc1	$f2,%lo(wholeNumber)($23)
	cvt.s.w	$f2,$f2
	sub.s	$f0,$f0,$f2
	lui	$2,%hi($LC11)
	lwc1	$f2,%lo($LC11)($2)
	mul.s	$f0,$f0,$f2
	trunc.w.s $f0,$f0
	b	$L19
	swc1	$f0,%lo(decimalNumber)($18)

$L59:
	b	$L21
	sw	$2,%lo(decimalNumber)($18)

$L24:
	b	$L25
	sw	$2,%lo(printOffsetB)($20)

$L23:
	b	$L25
	sw	$2,%lo(printOffsetB)($20)

$L22:
	sw	$2,%lo(printOffsetB)($20)
$L25:
	bltz	$3,$L26
	lw	$2,%lo(printOffsetB)($20)

	addiu	$2,$2,8
	sw	$2,%lo(printOffsetB)($20)
$L26:
	sw	$fp,%lo(printOffsetA)($21)
	lw	$2,%lo(decimalNumber)($18)
	slt	$2,$2,100
	bne	$2,$0,$L60
	lui	$2,%hi(printOffsetC)

	sw	$0,%lo(printOffsetC)($2)
$L28:
	lh	$4,%lo(MenuPosition)($19)
	lw	$2,%lo(printOffsetB)($20)
	lw	$7,%lo(wholeNumber)($23)
	move	$6,$22
	lh	$5,2($17)
	jal	printStringNumber
	addu	$4,$4,$2

	lh	$4,%lo(MenuPosition)($19)
	lw	$2,%lo(printOffsetA)($21)
	lui	$6,%hi($LC15)
	addiu	$6,$6,%lo($LC15)
	lh	$5,2($17)
	jal	printString
	addu	$4,$4,$2

	lh	$2,%lo(MenuPosition)($19)
	lw	$4,%lo(printOffsetA)($21)
	addu	$2,$2,$4
	addiu	$2,$2,-4
	lui	$3,%hi(printOffsetC)
	lw	$4,%lo(printOffsetC)($3)
	lw	$7,%lo(decimalNumber)($18)
	move	$6,$22
	lh	$5,2($17)
	jal	printStringNumber
	addu	$4,$2,$4

	lhu	$2,2($17)
	addiu	$2,$2,10
	sh	$2,2($17)
	addiu	$16,$16,1
	li	$2,4			# 0x4
	beq	$16,$2,$L61
	lui	$2,%hi(MenuPosition)

$L29:
	li	$2,2			# 0x2
	beq	$16,$2,$L15
	slt	$2,$16,3

	beq	$2,$0,$L16
	li	$2,3			# 0x3

	beq	$16,$0,$L17
	li	$2,1			# 0x1

	bne	$16,$2,$L19
	lui	$2,%hi(g_player1LocationY)

	lwc1	$f0,%lo(g_player1LocationY)($2)
	trunc.w.s $f2,$f0
	swc1	$f2,%lo(wholeNumber)($23)
	cvt.s.w	$f2,$f2
	sub.s	$f0,$f0,$f2
	lui	$2,%hi($LC11)
	lwc1	$f2,%lo($LC11)($2)
	mul.s	$f0,$f0,$f2
	trunc.w.s $f0,$f0
	b	$L19
	swc1	$f0,%lo(decimalNumber)($18)

$L60:
	lh	$4,%lo(MenuPosition)($19)
	move	$7,$0
	move	$6,$22
	lh	$5,2($17)
	jal	printStringNumber
	addiu	$4,$4,52

	lui	$2,%hi(printOffsetC)
	li	$3,8			# 0x8
	b	$L28
	sw	$3,%lo(printOffsetC)($2)

$L61:
	lhu	$3,%lo(MenuPosition)($2)
	addiu	$3,$3,87
	sh	$3,%lo(MenuPosition)($2)
	addiu	$2,$2,%lo(MenuPosition)
	li	$3,175			# 0xaf
	sh	$3,2($2)
	move	$16,$0
	lui	$19,%hi(SaveGame)
	addiu	$19,$19,%lo(SaveGame)
	lui	$20,%hi(wholeNumber)
	lui	$21,%hi(decimalNumber)
	lui	$22,%hi(MenuPosition)
	move	$18,$2
	lui	$23,%hi($LC14)
	b	$L49
	addiu	$23,$23,%lo($LC14)

$L31:
	bne	$16,$2,$L34
	lui	$2,%hi(g_player1SpeedA)

	lwc1	$f0,%lo(g_player1SpeedA)($2)
	trunc.w.s $f2,$f0
	swc1	$f2,%lo(wholeNumber)($20)
	cvt.s.w	$f2,$f2
	sub.s	$f0,$f0,$f2
	lui	$2,%hi($LC11)
	lwc1	$f2,%lo($LC11)($2)
	mul.s	$f0,$f0,$f2
	trunc.w.s $f0,$f0
	swc1	$f0,%lo(decimalNumber)($21)
$L34:
	lw	$2,%lo(decimalNumber)($21)
$L72:
	bltz	$2,$L62
	subu	$2,$0,$2

$L39:
	lw	$3,%lo(wholeNumber)($20)
	sra	$4,$3,31
	xor	$2,$4,$3
	subu	$2,$2,$4
	lui	$4,%hi(printOffsetD)
	sw	$2,%lo(printOffsetD)($4)
	slt	$4,$2,10
	bnel	$4,$0,$L40
	lui	$2,%hi(printOffsetB)

	slt	$2,$2,100
	bne	$2,$0,$L41
	lui	$2,%hi(printOffsetB)

	li	$4,8			# 0x8
	b	$L42
	sw	$4,%lo(printOffsetB)($2)

$L32:
	lb	$3,17($19)
	beq	$3,$2,$L63
	lui	$2,%hi(g_lakituSurface)

	lh	$2,%lo(g_lakituSurface)($2)
	b	$L34
	sw	$2,%lo(wholeNumber)($20)

$L63:
	lui	$2,%hi(g_player1SpeedX)
	lwc1	$f0,%lo(g_player1SpeedX)($2)
	trunc.w.s $f2,$f0
	swc1	$f2,%lo(wholeNumber)($20)
	cvt.s.w	$f2,$f2
	sub.s	$f0,$f0,$f2
	lui	$2,%hi($LC11)
	lwc1	$f2,%lo($LC11)($2)
	mul.s	$f0,$f0,$f2
	trunc.w.s $f0,$f0
	b	$L34
	swc1	$f0,%lo(decimalNumber)($21)

$L68:
	lui	$2,%hi(g_player1SpeedY)
	lwc1	$f0,%lo(g_player1SpeedY)($2)
	trunc.w.s $f2,$f0
	swc1	$f2,%lo(wholeNumber)($20)
	cvt.s.w	$f2,$f2
	sub.s	$f0,$f0,$f2
	lui	$2,%hi($LC11)
	lwc1	$f2,%lo($LC11)($2)
	mul.s	$f0,$f0,$f2
	trunc.w.s $f0,$f0
	b	$L34
	swc1	$f0,%lo(decimalNumber)($21)

$L30:
	lb	$3,17($19)
	li	$2,1			# 0x1
	beq	$3,$2,$L64
	lui	$2,%hi(g_progressValue)

	lh	$2,%lo(g_progressValue)($2)
	b	$L34
	sw	$2,%lo(wholeNumber)($20)

$L64:
	lui	$2,%hi(g_player1SpeedZ)
	lwc1	$f0,%lo(g_player1SpeedZ)($2)
	trunc.w.s $f2,$f0
	swc1	$f2,%lo(wholeNumber)($20)
	cvt.s.w	$f2,$f2
	sub.s	$f0,$f0,$f2
	lui	$2,%hi($LC11)
	lwc1	$f2,%lo($LC11)($2)
	mul.s	$f0,$f0,$f2
	trunc.w.s $f0,$f0
	b	$L34
	swc1	$f0,%lo(decimalNumber)($21)

$L62:
	b	$L39
	sw	$2,%lo(decimalNumber)($21)

$L41:
	li	$4,16			# 0x10
	b	$L42
	sw	$4,%lo(printOffsetB)($2)

$L40:
	li	$4,24			# 0x18
	sw	$4,%lo(printOffsetB)($2)
$L42:
	bltz	$3,$L43
	lui	$3,%hi(printOffsetB)

	lw	$2,%lo(printOffsetB)($3)
	addiu	$2,$2,8
	sw	$2,%lo(printOffsetB)($3)
$L43:
	li	$2,2			# 0x2
	beql	$16,$2,$L65
	lb	$3,17($19)

	lui	$2,%hi(printOffsetA)
$L73:
	li	$3,48			# 0x30
	sw	$3,%lo(printOffsetA)($2)
	xori	$fp,$16,0x3
	sltu	$fp,$fp,1
	lb	$17,17($19)
	xori	$17,$17,0x1
	sltu	$17,$17,1
	or	$17,$fp,$17
	beq	$17,$0,$L45
	lw	$2,%lo(decimalNumber)($21)

	slt	$2,$2,100
	bne	$2,$0,$L66
	lui	$2,%hi(printOffsetC)

	sw	$0,%lo(printOffsetC)($2)
	move	$17,$fp
$L45:
	lh	$4,%lo(MenuPosition)($22)
	lui	$2,%hi(printOffsetB)
	lw	$2,%lo(printOffsetB)($2)
	lw	$7,%lo(wholeNumber)($20)
	move	$6,$23
	lh	$5,2($18)
	jal	printStringNumber
	addu	$4,$4,$2

	lb	$2,17($19)
	xori	$2,$2,0x1
	beql	$2,$0,$L71
	lh	$4,%lo(MenuPosition)($22)

	bnel	$17,$0,$L50
	lh	$4,%lo(MenuPosition)($22)

	lhu	$2,2($18)
$L70:
	addiu	$2,$2,10
	sh	$2,2($18)
	addiu	$16,$16,1
	li	$2,4			# 0x4
	beq	$16,$2,$L67
	lw	$31,76($sp)

$L49:
	li	$2,2			# 0x2
	beq	$16,$2,$L30
	slt	$2,$16,3

	beq	$2,$0,$L31
	li	$2,3			# 0x3

	beq	$16,$0,$L32
	li	$2,1			# 0x1

	bnel	$16,$2,$L72
	lw	$2,%lo(decimalNumber)($21)

	lb	$3,17($19)
	beq	$3,$2,$L68
	lui	$2,%hi(g_lakituStatus)

	lb	$2,%lo(g_lakituStatus)($2)
	b	$L34
	sw	$2,%lo(wholeNumber)($20)

$L65:
	bne	$3,$2,$L73
	lui	$2,%hi(printOffsetA)

	lui	$3,%hi(printOffsetB)
	lw	$2,%lo(printOffsetB)($3)
	addiu	$2,$2,8
	sw	$2,%lo(printOffsetB)($3)
	lui	$2,%hi(printOffsetA)
	li	$3,48			# 0x30
	sw	$3,%lo(printOffsetA)($2)
	b	$L45
	move	$17,$0

$L66:
	lh	$4,%lo(MenuPosition)($22)
	move	$7,$0
	move	$6,$23
	lh	$5,2($18)
	jal	printStringNumber
	addiu	$4,$4,44

	lui	$2,%hi(printOffsetC)
	li	$3,8			# 0x8
	sw	$3,%lo(printOffsetC)($2)
	b	$L45
	move	$17,$fp

$L50:
$L71:
	lui	$17,%hi(printOffsetA)
	lw	$2,%lo(printOffsetA)($17)
	lui	$6,%hi($LC15)
	addiu	$6,$6,%lo($LC15)
	lh	$5,2($18)
	jal	printString
	addu	$4,$4,$2

	lh	$2,%lo(MenuPosition)($22)
	lw	$4,%lo(printOffsetA)($17)
	addu	$2,$2,$4
	addiu	$2,$2,-4
	lui	$3,%hi(printOffsetC)
	lw	$4,%lo(printOffsetC)($3)
	lw	$7,%lo(decimalNumber)($21)
	move	$6,$23
	lh	$5,2($18)
	jal	printStringNumber
	addu	$4,$2,$4

	b	$L70
	lhu	$2,2($18)

$L67:
	lw	$fp,72($sp)
	lw	$23,68($sp)
	lw	$22,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	jr	$31
	addiu	$sp,$sp,80

	.set	macro
	.set	reorder
	.end	printDetails
	.size	printDetails, .-printDetails
	.section	.rodata.str1.4
	.align	2
$LC16:
	.ascii	"Practice  ON\000"
	.align	2
$LC17:
	.ascii	"Force Items\000"
	.align	2
$LC18:
	.ascii	"Versus CPU\000"
	.align	2
$LC19:
	.ascii	"Debug CPU\000"
	.align	2
$LC20:
	.ascii	"Force Stats\000"
	.text
	.align	2
	.globl	printAnticheat
	.set	nomips16
	.set	nomicromips
	.ent	printAnticheat
	.type	printAnticheat, @function
printAnticheat:
	.frame	$sp,56,$31		# vars= 0, regs= 4/0, args= 40, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-56
	sw	$31,52($sp)
	sw	$18,48($sp)
	sw	$17,44($sp)
	jal	loadPosition
	sw	$16,40($sp)

	lui	$2,%hi(SaveGame)
	lb	$3,%lo(SaveGame)($2)
	li	$2,3			# 0x3
	beq	$3,$2,$L85
	lui	$17,%hi(MenuPosition)

$L77:
	lui	$2,%hi(SaveGame+4)
	lb	$2,%lo(SaveGame+4)($2)
	bgtz	$2,$L86
	lui	$2,%hi(SaveGame+5)

	lb	$2,%lo(SaveGame+5)($2)
	blez	$2,$L80
	li	$3,1			# 0x1

	beq	$2,$3,$L81
	li	$3,2			# 0x2

	beq	$2,$3,$L82
	lui	$16,%hi(MenuPosition)

	lui	$2,%hi(MenuPosition)
$L87:
	addiu	$2,$2,%lo(MenuPosition)
	lhu	$3,2($2)
	addiu	$3,$3,10
	b	$L76
	sh	$3,2($2)

$L85:
	lh	$5,%lo(MenuPosition)($17)
	addiu	$16,$17,%lo(MenuPosition)
	lh	$6,2($16)
	lui	$18,%hi(GraphPtr)
	li	$2,175			# 0xaf
	sw	$2,32($sp)
	sw	$0,28($sp)
	sw	$0,24($sp)
	sw	$0,20($sp)
	addiu	$2,$6,28
	sw	$2,16($sp)
	addiu	$7,$5,115
	addiu	$6,$6,18
	addiu	$5,$5,18
	jal	FillRect1ColorF
	lw	$4,%lo(GraphPtr)($18)

	jal	loadFont
	sw	$2,%lo(GraphPtr)($18)

	lui	$6,%hi($LC16)
	addiu	$6,$6,%lo($LC16)
	lh	$5,2($16)
	jal	printString
	lh	$4,%lo(MenuPosition)($17)

	lhu	$2,2($16)
	addiu	$2,$2,10
	b	$L77
	sh	$2,2($16)

$L86:
	lui	$17,%hi(MenuPosition)
	lh	$5,%lo(MenuPosition)($17)
	addiu	$16,$17,%lo(MenuPosition)
	lh	$6,2($16)
	lui	$18,%hi(GraphPtr)
	li	$2,175			# 0xaf
	sw	$2,32($sp)
	sw	$0,28($sp)
	sw	$0,24($sp)
	sw	$0,20($sp)
	addiu	$2,$6,28
	sw	$2,16($sp)
	addiu	$7,$5,107
	addiu	$6,$6,18
	addiu	$5,$5,18
	jal	FillRect1ColorF
	lw	$4,%lo(GraphPtr)($18)

	jal	loadFont
	sw	$2,%lo(GraphPtr)($18)

	lui	$6,%hi($LC17)
	addiu	$6,$6,%lo($LC17)
	lh	$5,2($16)
	jal	printString
	lh	$4,%lo(MenuPosition)($17)

	lhu	$2,2($16)
	addiu	$2,$2,10
	sh	$2,2($16)
$L76:
	lw	$31,52($sp)
$L88:
	lw	$18,48($sp)
$L89:
	lw	$17,44($sp)
	lw	$16,40($sp)
	jr	$31
	addiu	$sp,$sp,56

$L81:
	lui	$16,%hi(MenuPosition)
	lh	$5,%lo(MenuPosition)($16)
	addiu	$17,$16,%lo(MenuPosition)
	lh	$6,2($17)
	lui	$18,%hi(GraphPtr)
	li	$2,175			# 0xaf
	sw	$2,32($sp)
	sw	$0,28($sp)
	sw	$0,24($sp)
	sw	$0,20($sp)
	addiu	$2,$6,28
	sw	$2,16($sp)
	addiu	$7,$5,99
	addiu	$6,$6,18
	addiu	$5,$5,18
	jal	FillRect1ColorF
	lw	$4,%lo(GraphPtr)($18)

	jal	loadFont
	sw	$2,%lo(GraphPtr)($18)

	lui	$6,%hi($LC18)
	addiu	$6,$6,%lo($LC18)
	lh	$5,2($17)
	jal	printString
	lh	$4,%lo(MenuPosition)($16)

	b	$L87
	lui	$2,%hi(MenuPosition)

$L82:
	lh	$5,%lo(MenuPosition)($16)
	addiu	$17,$16,%lo(MenuPosition)
	lh	$6,2($17)
	lui	$18,%hi(GraphPtr)
	li	$2,175			# 0xaf
	sw	$2,32($sp)
	sw	$0,28($sp)
	sw	$0,24($sp)
	sw	$0,20($sp)
	addiu	$2,$6,28
	sw	$2,16($sp)
	addiu	$7,$5,91
	addiu	$6,$6,18
	addiu	$5,$5,18
	jal	FillRect1ColorF
	lw	$4,%lo(GraphPtr)($18)

	jal	loadFont
	sw	$2,%lo(GraphPtr)($18)

	lui	$6,%hi($LC19)
	addiu	$6,$6,%lo($LC19)
	lh	$5,2($17)
	jal	printString
	lh	$4,%lo(MenuPosition)($16)

	b	$L87
	lui	$2,%hi(MenuPosition)

$L80:
	lui	$2,%hi(SaveGame+1)
	lb	$3,%lo(SaveGame+1)($2)
	li	$2,1			# 0x1
	bne	$3,$2,$L88
	lw	$31,52($sp)

	lui	$2,%hi(HotSwapID)
	lh	$2,%lo(HotSwapID)($2)
	bne	$2,$0,$L89
	lw	$18,48($sp)

	lui	$17,%hi(MenuPosition)
	lh	$5,%lo(MenuPosition)($17)
	addiu	$16,$17,%lo(MenuPosition)
	lh	$6,2($16)
	lui	$18,%hi(GraphPtr)
	li	$2,175			# 0xaf
	sw	$2,32($sp)
	sw	$0,28($sp)
	sw	$0,24($sp)
	sw	$0,20($sp)
	addiu	$2,$6,28
	sw	$2,16($sp)
	addiu	$7,$5,107
	addiu	$6,$6,18
	addiu	$5,$5,18
	jal	FillRect1ColorF
	lw	$4,%lo(GraphPtr)($18)

	jal	loadFont
	sw	$2,%lo(GraphPtr)($18)

	lui	$6,%hi($LC20)
	addiu	$6,$6,%lo($LC20)
	lh	$5,2($16)
	jal	printString
	lh	$4,%lo(MenuPosition)($17)

	lhu	$2,2($16)
	addiu	$2,$2,10
	b	$L76
	sh	$2,2($16)

	.set	macro
	.set	reorder
	.end	printAnticheat
	.size	printAnticheat, .-printAnticheat
	.align	2
	.globl	CheckMenuButton
	.set	nomips16
	.set	nomicromips
	.ent	CheckMenuButton
	.type	CheckMenuButton, @function
CheckMenuButton:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(ButtonHolding)
	addiu	$2,$2,%lo(ButtonHolding)
	addu	$2,$2,$4
	lb	$3,0($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L96
	sll	$2,$4,2

	lui	$3,%hi(GlobalController)
	addiu	$3,$3,%lo(GlobalController)
	addu	$2,$2,$3
	lw	$2,0($2)
	lhu	$3,4($2)
	beql	$3,$0,$L94
	lhu	$3,10($2)

	sll	$5,$4,1
	lui	$6,%hi(MenuButtonHeld)
	addiu	$6,$6,%lo(MenuButtonHeld)
	addu	$5,$5,$6
	sh	$3,0($5)
	lhu	$2,6($2)
	bne	$2,$0,$L99
	lui	$2,%hi(ButtonHolding)

	addiu	$2,$2,%lo(ButtonHolding)
	addu	$4,$2,$4
	li	$2,1			# 0x1
	jr	$31
	sb	$2,0($4)

$L96:
	lui	$3,%hi(GlobalController)
	addiu	$3,$3,%lo(GlobalController)
	addu	$2,$2,$3
	lw	$2,0($2)
	lhu	$3,4($2)
	bne	$3,$0,$L97
	lui	$3,%hi(ButtonTimer)

	lhu	$2,10($2)
	bne	$2,$0,$L98
	addiu	$3,$3,%lo(ButtonTimer)

	sll	$2,$4,1
	lui	$3,%hi(MenuButtonHeld)
	addiu	$3,$3,%lo(MenuButtonHeld)
	addu	$2,$2,$3
	sh	$0,0($2)
	lui	$2,%hi(ButtonHolding)
	addiu	$2,$2,%lo(ButtonHolding)
	addu	$2,$2,$4
	sb	$0,0($2)
	lui	$2,%hi(ButtonTimer)
	addiu	$2,$2,%lo(ButtonTimer)
	addu	$4,$2,$4
	jr	$31
	sb	$0,0($4)

$L97:
	addiu	$3,$3,%lo(ButtonTimer)
$L98:
	addu	$3,$3,$4
	lbu	$2,0($3)
	addiu	$2,$2,1
	sll	$2,$2,24
	sra	$2,$2,24
	sb	$2,0($3)
	slt	$2,$2,15
	bne	$2,$0,$L99
	lui	$2,%hi(ButtonHolding)

	addiu	$2,$2,%lo(ButtonHolding)
	addu	$2,$2,$4
	sb	$0,0($2)
	jr	$31
	sb	$0,0($3)

$L94:
	beql	$3,$0,$L95
	sll	$2,$4,1

	sll	$5,$4,1
	lui	$6,%hi(MenuButtonHeld)
	addiu	$6,$6,%lo(MenuButtonHeld)
	addu	$5,$5,$6
	sh	$3,0($5)
	lhu	$2,12($2)
	bne	$2,$0,$L99
	lui	$2,%hi(ButtonHolding)

	addiu	$2,$2,%lo(ButtonHolding)
	addu	$4,$2,$4
	li	$2,1			# 0x1
	jr	$31
	sb	$2,0($4)

$L95:
	lui	$3,%hi(MenuButtonHeld)
	addiu	$3,$3,%lo(MenuButtonHeld)
	addu	$2,$2,$3
	sh	$0,0($2)
	lui	$2,%hi(ButtonHolding)
	addiu	$2,$2,%lo(ButtonHolding)
	addu	$2,$2,$4
	sb	$0,0($2)
	lui	$2,%hi(ButtonTimer)
	addiu	$2,$2,%lo(ButtonTimer)
	addu	$4,$2,$4
	sb	$0,0($4)
$L99:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	CheckMenuButton
	.size	CheckMenuButton, .-CheckMenuButton
	.align	2
	.globl	swapParameter
	.set	nomips16
	.set	nomicromips
	.ent	swapParameter
	.type	swapParameter, @function
swapParameter:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$4,24($sp)
	bne	$6,$0,$L101
	sw	$5,28($sp)

	lui	$2,%hi(MenuIndex)
	lw	$2,%lo(MenuIndex)($2)
	sll	$2,$2,4
	addu	$5,$5,$2
	lui	$2,%hi(ParameterIndex)
	lw	$2,%lo(ParameterIndex)($2)
	addiu	$2,$2,-1
	lui	$3,%hi(MenuOverflow)
	lw	$3,%lo(MenuOverflow)($3)
	addu	$2,$2,$3
	lw	$3,12($5)
	addu	$2,$3,$2
	lb	$3,0($2)
	blez	$3,$L108
	li	$4,1224736768			# 0x49000000

	addiu	$3,$3,-1
	sb	$3,0($2)
	jal	playSound
	ori	$4,$4,0x8000

	b	$L106
	lw	$31,20($sp)

$L101:
	lui	$2,%hi(MenuIndex)
	lw	$2,%lo(MenuIndex)($2)
	sll	$2,$2,4
	addu	$5,$5,$2
	lui	$2,%hi(ParameterIndex)
	lw	$2,%lo(ParameterIndex)($2)
	addiu	$2,$2,-1
	lui	$3,%hi(MenuOverflow)
	lw	$3,%lo(MenuOverflow)($3)
	addu	$2,$2,$3
	lw	$3,12($5)
	addu	$3,$3,$2
	lb	$6,0($3)
	lw	$4,8($5)
	sll	$2,$2,4
	addu	$2,$4,$2
	lw	$2,4($2)
	addiu	$2,$2,-1
	sltu	$2,$6,$2
	bne	$2,$0,$L105
	addiu	$6,$6,1

	li	$4,1224736768			# 0x49000000
$L108:
	jal	playSound
	ori	$4,$4,0x8002

	lw	$31,20($sp)
$L106:
$L107:
	jr	$31
	addiu	$sp,$sp,24

$L105:
	sb	$6,0($3)
	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8000

	b	$L107
	lw	$31,20($sp)

	.set	macro
	.set	reorder
	.end	swapParameter
	.size	swapParameter, .-swapParameter
	.align	2
	.globl	GameOptionsHandler
	.set	nomips16
	.set	nomicromips
	.ent	GameOptionsHandler
	.type	GameOptionsHandler, @function
GameOptionsHandler:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$16,16($sp)
	jal	CheckMenuButton
	move	$16,$4

	lui	$2,%hi(ButtonHolding)
	addiu	$2,$2,%lo(ButtonHolding)
	addu	$2,$2,$16
	lb	$2,0($2)
	bne	$2,$0,$L141
	lw	$31,20($sp)

	sll	$2,$16,1
	lui	$3,%hi(MenuButtonHeld)
	addiu	$3,$3,%lo(MenuButtonHeld)
	addu	$2,$2,$3
	lhu	$2,0($2)
	li	$3,1024			# 0x400
	beq	$2,$3,$L111
	sltu	$3,$2,1025

	beq	$3,$0,$L112
	li	$3,256			# 0x100

	beq	$2,$3,$L113
	li	$3,512			# 0x200

	bne	$2,$3,$L141
	li	$2,1			# 0x1

	lui	$4,%hi(ButtonHolding)
	addiu	$4,$4,%lo(ButtonHolding)
	addu	$16,$4,$16
	sb	$2,0($16)
	lui	$2,%hi(ParameterIndex)
	lw	$2,%lo(ParameterIndex)($2)
	blez	$2,$L122
	lui	$3,%hi(GameOKMenu)

	lw	$3,%lo(GameOKMenu)($3)
	lui	$4,%hi(MenuIndex)
	lw	$4,%lo(MenuIndex)($4)
	sltu	$3,$4,$3
	bne	$3,$0,$L135
	li	$3,1			# 0x1

	beq	$2,$3,$L136
	lui	$3,%hi(SYSTEM_Region)

	lw	$3,%lo(SYSTEM_Region)($3)
	bne	$3,$0,$L125
	lui	$3,%hi(MenuCup)

	lw	$3,%lo(MenuCup)($3)
	sll	$3,$3,3
	li	$4,-2146500608			# 0xffffffff800f0000
	addiu	$4,$4,11284
	addu	$3,$3,$4
	addiu	$2,$2,-2
	sll	$2,$2,1
	addu	$2,$3,$2
$L126:
	lui	$3,%hi(GlobalAddressA)
	sw	$2,%lo(GlobalAddressA)($3)
	lh	$3,0($2)
	blezl	$3,$L141
	lw	$31,20($sp)

	addiu	$3,$3,-1
	sh	$3,0($2)
	jal	copyCourseTable
	li	$4,1			# 0x1

	b	$L141
	lw	$31,20($sp)

$L112:
	li	$3,2048			# 0x800
	bne	$2,$3,$L109
	li	$2,1			# 0x1

	lui	$4,%hi(ButtonHolding)
	addiu	$4,$4,%lo(ButtonHolding)
	addu	$16,$4,$16
	sb	$2,0($16)
	lui	$2,%hi(ParameterIndex)
	lw	$2,%lo(ParameterIndex)($2)
	lui	$3,%hi(MenuOverflow)
	lw	$3,%lo(MenuOverflow)($3)
	addu	$4,$2,$3
	blez	$4,$L141
	lw	$31,20($sp)

	li	$4,1			# 0x1
	beql	$2,$4,$L137
	lui	$4,%hi(GameOKMenu)

$L131:
	addiu	$2,$2,-1
$L143:
	lui	$3,%hi(ParameterIndex)
	sw	$2,%lo(ParameterIndex)($3)
$L132:
	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x801c

$L109:
	lw	$31,20($sp)
$L141:
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

$L113:
	lui	$4,%hi(ButtonHolding)
	addiu	$4,$4,%lo(ButtonHolding)
	addu	$16,$4,$16
	li	$2,1			# 0x1
	sb	$2,0($16)
	lui	$2,%hi(ParameterIndex)
	lw	$2,%lo(ParameterIndex)($2)
	blez	$2,$L116
	lui	$3,%hi(GameOKMenu)

	lw	$3,%lo(GameOKMenu)($3)
	lui	$4,%hi(MenuIndex)
	lw	$4,%lo(MenuIndex)($4)
	sltu	$3,$4,$3
	bne	$3,$0,$L138
	li	$3,1			# 0x1

	beq	$2,$3,$L139
	lui	$3,%hi(SYSTEM_Region)

	lw	$3,%lo(SYSTEM_Region)($3)
	bne	$3,$0,$L119
	lui	$3,%hi(MenuCup)

	lw	$3,%lo(MenuCup)($3)
	sll	$3,$3,3
	li	$4,-2146500608			# 0xffffffff800f0000
	addiu	$4,$4,11284
	addu	$3,$3,$4
	addiu	$2,$2,-2
	sll	$2,$2,1
	addu	$2,$3,$2
$L120:
	lui	$3,%hi(GlobalAddressA)
	sw	$2,%lo(GlobalAddressA)($3)
	lh	$3,0($2)
	slt	$4,$3,19
	beql	$4,$0,$L141
	lw	$31,20($sp)

	addiu	$3,$3,1
	sh	$3,0($2)
	jal	copyCourseTable
	li	$4,1			# 0x1

	b	$L141
	lw	$31,20($sp)

$L138:
	lui	$2,%hi(GameOKMenu)
	li	$6,1			# 0x1
	lw	$4,%lo(GameOKMenu)($2)
	addiu	$2,$2,%lo(GameOKMenu)
	jal	swapParameter
	lw	$5,4($2)

	b	$L141
	lw	$31,20($sp)

$L139:
	lui	$2,%hi(MenuCup)
	lw	$2,%lo(MenuCup)($2)
	slt	$3,$2,3
	beq	$3,$0,$L141
	lw	$31,20($sp)

	addiu	$2,$2,1
	lui	$3,%hi(MenuCup)
	b	$L109
	sw	$2,%lo(MenuCup)($3)

$L119:
	lw	$3,%lo(MenuCup)($3)
	sll	$3,$3,3
	li	$4,-2146500608			# 0xffffffff800f0000
	addiu	$4,$4,11188
	addu	$3,$3,$4
	addiu	$2,$2,-2
	sll	$2,$2,1
	b	$L120
	addu	$2,$3,$2

$L116:
	lui	$2,%hi(MenuIndex)
	lw	$3,%lo(MenuIndex)($2)
	lui	$2,%hi(GameOKMenu)
	lw	$2,%lo(GameOKMenu)($2)
	sltu	$2,$3,$2
	beq	$2,$0,$L121
	li	$4,1224736768			# 0x49000000

	addiu	$3,$3,1
	lui	$2,%hi(MenuIndex)
	sw	$3,%lo(MenuIndex)($2)
	lui	$2,%hi(MenuOverflow)
	sw	$0,%lo(MenuOverflow)($2)
	jal	playSound
	ori	$4,$4,0x8001

	b	$L141
	lw	$31,20($sp)

$L121:
	jal	playSound
	ori	$4,$4,0x8002

	b	$L141
	lw	$31,20($sp)

$L135:
	lui	$2,%hi(GameOKMenu)
	move	$6,$0
	lw	$4,%lo(GameOKMenu)($2)
	addiu	$2,$2,%lo(GameOKMenu)
	jal	swapParameter
	lw	$5,4($2)

	b	$L141
	lw	$31,20($sp)

$L136:
	lui	$2,%hi(MenuCup)
	lw	$2,%lo(MenuCup)($2)
	blez	$2,$L109
	addiu	$2,$2,-1

	lui	$3,%hi(MenuCup)
	b	$L109
	sw	$2,%lo(MenuCup)($3)

$L125:
	lw	$3,%lo(MenuCup)($3)
	sll	$3,$3,3
	li	$4,-2146500608			# 0xffffffff800f0000
	addiu	$4,$4,11188
	addu	$3,$3,$4
	addiu	$2,$2,-2
	sll	$2,$2,1
	b	$L126
	addu	$2,$3,$2

$L122:
	lui	$2,%hi(MenuIndex)
	lw	$2,%lo(MenuIndex)($2)
	blez	$2,$L127
	addiu	$2,$2,-1

	lui	$3,%hi(MenuIndex)
	sw	$2,%lo(MenuIndex)($3)
	lui	$2,%hi(MenuOverflow)
	sw	$0,%lo(MenuOverflow)($2)
	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8001

	b	$L141
	lw	$31,20($sp)

$L127:
	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8002

	b	$L141
	lw	$31,20($sp)

$L111:
	lui	$4,%hi(ButtonHolding)
	addiu	$4,$4,%lo(ButtonHolding)
	addu	$16,$4,$16
	li	$2,1			# 0x1
	sb	$2,0($16)
	lui	$2,%hi(GameOKMenu)
	lw	$6,%lo(GameOKMenu)($2)
	lui	$2,%hi(MenuIndex)
	lw	$5,%lo(MenuIndex)($2)
	sltu	$2,$5,$6
	beq	$2,$0,$L128
	li	$4,4			# 0x4

	lui	$2,%hi(GameOKMenu+4)
	lw	$2,%lo(GameOKMenu+4)($2)
	sll	$3,$5,4
	addu	$2,$2,$3
	lh	$4,4($2)
$L128:
	lui	$2,%hi(GlobalIntA)
	sw	$4,%lo(GlobalIntA)($2)
	lui	$2,%hi(ParameterIndex)
	lw	$3,%lo(ParameterIndex)($2)
	lui	$2,%hi(MenuOverflow)
	lw	$7,%lo(MenuOverflow)($2)
	addu	$2,$3,$7
	slt	$2,$2,$4
	beq	$2,$0,$L141
	lw	$31,20($sp)

	li	$2,7			# 0x7
	beq	$3,$2,$L140
	sltu	$5,$5,$6

	addiu	$3,$3,1
$L142:
	lui	$2,%hi(ParameterIndex)
	sw	$3,%lo(ParameterIndex)($2)
$L130:
	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x801c

	b	$L141
	lw	$31,20($sp)

$L140:
	beq	$5,$0,$L142
	addiu	$3,$3,1

	addiu	$7,$7,1
	lui	$2,%hi(MenuOverflow)
	b	$L130
	sw	$7,%lo(MenuOverflow)($2)

$L137:
	lw	$4,%lo(GameOKMenu)($4)
	lui	$5,%hi(MenuIndex)
	lw	$5,%lo(MenuIndex)($5)
	sltu	$4,$5,$4
	beql	$4,$0,$L143
	addiu	$2,$2,-1

	blez	$3,$L131
	addiu	$3,$3,-1

	lui	$2,%hi(MenuOverflow)
	b	$L132
	sw	$3,%lo(MenuOverflow)($2)

	.set	macro
	.set	reorder
	.end	GameOptionsHandler
	.size	GameOptionsHandler, .-GameOptionsHandler
	.align	2
	.globl	TitleMenuHandler
	.set	nomips16
	.set	nomicromips
	.ent	TitleMenuHandler
	.type	TitleMenuHandler, @function
TitleMenuHandler:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$16,16($sp)
	jal	CheckMenuButton
	move	$16,$4

	lui	$2,%hi(ButtonHolding)
	addiu	$2,$2,%lo(ButtonHolding)
	addu	$2,$2,$16
	lb	$2,0($2)
	bne	$2,$0,$L174
	lw	$31,20($sp)

	sll	$2,$16,1
	lui	$3,%hi(MenuButtonHeld)
	addiu	$3,$3,%lo(MenuButtonHeld)
	addu	$2,$2,$3
	lhu	$2,0($2)
	li	$3,1024			# 0x400
	beq	$2,$3,$L146
	sltu	$3,$2,1025

	beq	$3,$0,$L147
	li	$3,256			# 0x100

	beq	$2,$3,$L148
	li	$3,512			# 0x200

	bne	$2,$3,$L174
	li	$2,1			# 0x1

	lui	$4,%hi(ButtonHolding)
	addiu	$4,$4,%lo(ButtonHolding)
	addu	$16,$4,$16
	sb	$2,0($16)
	lui	$2,%hi(ParameterIndex)
	lw	$2,%lo(ParameterIndex)($2)
	blez	$2,$L157
	lui	$3,%hi(MenuIndex)

	lw	$3,%lo(MenuIndex)($3)
	slt	$3,$3,2
	bne	$3,$0,$L168
	li	$3,1			# 0x1

	beq	$2,$3,$L169
	lui	$3,%hi(SYSTEM_Region)

	lw	$3,%lo(SYSTEM_Region)($3)
	bne	$3,$0,$L160
	lui	$3,%hi(MenuCup)

	lw	$3,%lo(MenuCup)($3)
	sll	$3,$3,3
	li	$4,-2146500608			# 0xffffffff800f0000
	addiu	$4,$4,11284
	addu	$3,$3,$4
	addiu	$2,$2,-2
	sll	$2,$2,1
	addu	$2,$3,$2
$L161:
	lui	$3,%hi(GlobalAddressA)
	sw	$2,%lo(GlobalAddressA)($3)
	lh	$3,0($2)
	blezl	$3,$L174
	lw	$31,20($sp)

	addiu	$3,$3,-1
	sh	$3,0($2)
	jal	copyCourseTable
	li	$4,1			# 0x1

	b	$L174
	lw	$31,20($sp)

$L147:
	li	$3,2048			# 0x800
	bne	$2,$3,$L144
	li	$2,1			# 0x1

	lui	$4,%hi(ButtonHolding)
	addiu	$4,$4,%lo(ButtonHolding)
	addu	$16,$4,$16
	sb	$2,0($16)
	lui	$2,%hi(ParameterIndex)
	lw	$2,%lo(ParameterIndex)($2)
	lui	$3,%hi(MenuOverflow)
	lw	$3,%lo(MenuOverflow)($3)
	addu	$4,$2,$3
	blez	$4,$L174
	lw	$31,20($sp)

	li	$4,1			# 0x1
	beql	$2,$4,$L170
	lui	$4,%hi(MenuIndex)

$L165:
	addiu	$2,$2,-1
$L176:
	lui	$3,%hi(ParameterIndex)
	sw	$2,%lo(ParameterIndex)($3)
$L166:
	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x801c

$L144:
	lw	$31,20($sp)
$L174:
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

$L148:
	lui	$4,%hi(ButtonHolding)
	addiu	$4,$4,%lo(ButtonHolding)
	addu	$16,$4,$16
	li	$2,1			# 0x1
	sb	$2,0($16)
	lui	$2,%hi(ParameterIndex)
	lw	$2,%lo(ParameterIndex)($2)
	blez	$2,$L151
	lui	$3,%hi(MenuIndex)

	lw	$3,%lo(MenuIndex)($3)
	slt	$3,$3,2
	bne	$3,$0,$L171
	li	$3,1			# 0x1

	beq	$2,$3,$L172
	lui	$3,%hi(SYSTEM_Region)

	lw	$3,%lo(SYSTEM_Region)($3)
	bne	$3,$0,$L154
	lui	$3,%hi(MenuCup)

	lw	$3,%lo(MenuCup)($3)
	sll	$3,$3,3
	li	$4,-2146500608			# 0xffffffff800f0000
	addiu	$4,$4,11284
	addu	$3,$3,$4
	addiu	$2,$2,-2
	sll	$2,$2,1
	addu	$2,$3,$2
$L155:
	lui	$3,%hi(GlobalAddressA)
	sw	$2,%lo(GlobalAddressA)($3)
	lh	$3,0($2)
	slt	$4,$3,19
	beql	$4,$0,$L174
	lw	$31,20($sp)

	addiu	$3,$3,1
	sh	$3,0($2)
	jal	copyCourseTable
	li	$4,1			# 0x1

	b	$L174
	lw	$31,20($sp)

$L171:
	lui	$2,%hi(GameOKMenu)
	li	$6,1			# 0x1
	lw	$4,%lo(GameOKMenu)($2)
	addiu	$2,$2,%lo(GameOKMenu)
	jal	swapParameter
	lw	$5,4($2)

	b	$L174
	lw	$31,20($sp)

$L172:
	lui	$2,%hi(MenuCup)
	lw	$2,%lo(MenuCup)($2)
	slt	$3,$2,3
	beq	$3,$0,$L174
	lw	$31,20($sp)

	addiu	$2,$2,1
	lui	$3,%hi(MenuCup)
	b	$L144
	sw	$2,%lo(MenuCup)($3)

$L154:
	lw	$3,%lo(MenuCup)($3)
	sll	$3,$3,3
	li	$4,-2146500608			# 0xffffffff800f0000
	addiu	$4,$4,11188
	addu	$3,$3,$4
	addiu	$2,$2,-2
	sll	$2,$2,1
	b	$L155
	addu	$2,$3,$2

$L151:
	lui	$2,%hi(MenuIndex)
	lw	$2,%lo(MenuIndex)($2)
	slt	$3,$2,4
	beq	$3,$0,$L156
	li	$4,1224736768			# 0x49000000

	addiu	$2,$2,1
	lui	$3,%hi(MenuIndex)
	sw	$2,%lo(MenuIndex)($3)
	lui	$2,%hi(MenuOverflow)
	sw	$0,%lo(MenuOverflow)($2)
	jal	playSound
	ori	$4,$4,0x8001

	b	$L174
	lw	$31,20($sp)

$L156:
	jal	playSound
	ori	$4,$4,0x8002

	b	$L174
	lw	$31,20($sp)

$L168:
	lui	$2,%hi(GameOKMenu)
	move	$6,$0
	lw	$4,%lo(GameOKMenu)($2)
	addiu	$2,$2,%lo(GameOKMenu)
	jal	swapParameter
	lw	$5,4($2)

	b	$L174
	lw	$31,20($sp)

$L169:
	lui	$2,%hi(MenuCup)
	lw	$2,%lo(MenuCup)($2)
	blez	$2,$L144
	addiu	$2,$2,-1

	lui	$3,%hi(MenuCup)
	b	$L144
	sw	$2,%lo(MenuCup)($3)

$L160:
	lw	$3,%lo(MenuCup)($3)
	sll	$3,$3,3
	li	$4,-2146500608			# 0xffffffff800f0000
	addiu	$4,$4,11188
	addu	$3,$3,$4
	addiu	$2,$2,-2
	sll	$2,$2,1
	b	$L161
	addu	$2,$3,$2

$L157:
	lui	$2,%hi(MenuIndex)
	lw	$2,%lo(MenuIndex)($2)
	blez	$2,$L162
	addiu	$2,$2,-1

	lui	$3,%hi(MenuIndex)
	sw	$2,%lo(MenuIndex)($3)
	lui	$2,%hi(MenuOverflow)
	sw	$0,%lo(MenuOverflow)($2)
	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8001

	b	$L174
	lw	$31,20($sp)

$L162:
	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8002

	b	$L174
	lw	$31,20($sp)

$L146:
	lui	$4,%hi(ButtonHolding)
	addiu	$4,$4,%lo(ButtonHolding)
	addu	$16,$4,$16
	li	$2,1			# 0x1
	sb	$2,0($16)
	lui	$2,%hi(ParameterIndex)
	lw	$4,%lo(ParameterIndex)($2)
	lui	$2,%hi(MenuOverflow)
	lw	$6,%lo(MenuOverflow)($2)
	lui	$2,%hi(MenuIndex)
	lw	$5,%lo(MenuIndex)($2)
	addu	$2,$4,$6
	lui	$3,%hi(GameOKMenu+4)
	lw	$3,%lo(GameOKMenu+4)($3)
	sll	$7,$5,4
	addu	$3,$3,$7
	lh	$3,4($3)
	slt	$2,$2,$3
	beq	$2,$0,$L174
	lw	$31,20($sp)

	li	$2,4			# 0x4
	beq	$4,$2,$L173
	slt	$5,$5,3

	addiu	$4,$4,1
$L175:
	lui	$2,%hi(ParameterIndex)
	sw	$4,%lo(ParameterIndex)($2)
$L164:
	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x801c

	b	$L174
	lw	$31,20($sp)

$L173:
	beql	$5,$0,$L175
	addiu	$4,$4,1

	addiu	$6,$6,1
	lui	$2,%hi(MenuOverflow)
	b	$L164
	sw	$6,%lo(MenuOverflow)($2)

$L170:
	lw	$4,%lo(MenuIndex)($4)
	slt	$4,$4,3
	beql	$4,$0,$L176
	addiu	$2,$2,-1

	blez	$3,$L165
	addiu	$3,$3,-1

	lui	$2,%hi(MenuOverflow)
	b	$L166
	sw	$3,%lo(MenuOverflow)($2)

	.set	macro
	.set	reorder
	.end	TitleMenuHandler
	.size	TitleMenuHandler, .-TitleMenuHandler
	.align	2
	.globl	titleMenu
	.set	nomips16
	.set	nomicromips
	.ent	titleMenu
	.type	titleMenu, @function
titleMenu:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(MenuBlink)
	lhu	$2,%lo(MenuBlink)($2)
	sltu	$4,$2,31
	beq	$4,$0,$L178
	move	$3,$0

	addiu	$2,$2,1
	andi	$3,$2,0xffff
$L178:
	lui	$2,%hi(MenuBlink)
	sh	$3,%lo(MenuBlink)($2)
	lui	$2,%hi(titleDemo)
	lw	$2,%lo(titleDemo)($2)
	slt	$2,$2,5
	bne	$2,$0,$L181
	lui	$2,%hi(g_mracewayTime)

	lui	$2,%hi(titleDemo)
	li	$3,4			# 0x4
	sw	$3,%lo(titleDemo)($2)
	lui	$2,%hi(g_mracewayTime)
$L181:
	jr	$31
	sw	$0,%lo(g_mracewayTime)($2)

	.set	macro
	.set	reorder
	.end	titleMenu
	.size	titleMenu, .-titleMenu
	.align	2
	.globl	CheckPlayerSelect
	.set	nomips16
	.set	nomicromips
	.ent	CheckPlayerSelect
	.type	CheckPlayerSelect, @function
CheckPlayerSelect:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(PlayerCharacterSelect)
	addiu	$2,$2,%lo(PlayerCharacterSelect)
	addu	$2,$4,$2
	lb	$2,0($2)
	lui	$3,%hi(g_playerCount)
	lw	$8,%lo(g_playerCount)($3)
	lui	$12,%hi(PlayerCharacterSelect)
	li	$11,1			# 0x1
	b	$L188
	move	$10,$0

$L194:
	lui	$3,%hi(GlobalBoolC)
	li	$4,1			# 0x1
	jr	$31
	sb	$4,%lo(GlobalBoolC)($3)

$L186:
	addiu	$3,$3,1
$L195:
	beq	$3,$8,$L192
	addiu	$6,$6,1

$L187:
	beql	$4,$3,$L195
	addiu	$3,$3,1

	lb	$7,0($6)
	beql	$7,$2,$L186
	move	$9,$10

	b	$L195
	addiu	$3,$3,1

$L192:
	bne	$9,$0,$L193
	lui	$3,%hi(GlobalBoolC)

$L188:
	addu	$3,$2,$5
	sltu	$3,$3,8
	beql	$3,$0,$L183
	lui	$2,%hi(GlobalBoolC)

	addu	$2,$5,$2
	sll	$2,$2,16
	blez	$8,$L194
	sra	$2,$2,16

	addiu	$6,$12,%lo(PlayerCharacterSelect)
	move	$9,$11
	b	$L187
	move	$3,$0

$L193:
	li	$4,1			# 0x1
	jr	$31
	sb	$4,%lo(GlobalBoolC)($3)

$L183:
	li	$3,1			# 0x1
	sb	$3,%lo(GlobalBoolC)($2)
	jr	$31
	li	$2,-1			# 0xffffffffffffffff

	.set	macro
	.set	reorder
	.end	CheckPlayerSelect
	.size	CheckPlayerSelect, .-CheckPlayerSelect
	.align	2
	.globl	PlayerSelectSetup
	.set	nomips16
	.set	nomicromips
	.ent	PlayerSelectSetup
	.type	PlayerSelectSetup, @function
PlayerSelectSetup:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lui	$18,%hi(targetAddress)
	lw	$3,%lo(targetAddress)($18)
	lui	$2,%hi(BackupPortraitTable)
	addiu	$2,$2,%lo(BackupPortraitTable)
	sw	$2,0($3)
	lui	$17,%hi(sourceAddress)
	lw	$3,%lo(sourceAddress)($17)
	lui	$2,%hi(SelectPortraitTable)
	addiu	$2,$2,%lo(SelectPortraitTable)
	sw	$2,0($3)
	lui	$16,%hi(dataLength)
	li	$2,288			# 0x120
	jal	runRAM
	sw	$2,%lo(dataLength)($16)

	lui	$2,%hi(asm_DispOBSubPSelCursor1)
	li	$3,-2146828288			# 0xffffffff800a0000
	addiu	$3,$3,2248
	sw	$3,%lo(asm_DispOBSubPSelCursor1)($2)
	addiu	$2,$2,%lo(asm_DispOBSubPSelCursor1)
	sw	$3,4($2)
	sw	$3,8($2)
	sw	$3,12($2)
	lui	$2,%hi(PlayerSelectPositions)
	addiu	$2,$2,%lo(PlayerSelectPositions)
	lhu	$3,2($2)
	addiu	$3,$3,-10
	sh	$3,2($2)
	lhu	$3,10($2)
	addiu	$3,$3,-10
	sh	$3,10($2)
	lhu	$3,18($2)
	addiu	$3,$3,-10
	sh	$3,18($2)
	lhu	$3,26($2)
	addiu	$3,$3,-10
	sh	$3,26($2)
	lw	$3,%lo(targetAddress)($18)
	lui	$2,%hi(BackupNamePlateTable)
	addiu	$2,$2,%lo(BackupNamePlateTable)
	sw	$2,0($3)
	lw	$3,%lo(sourceAddress)($17)
	lui	$2,%hi(SelectNamePlateTable)
	addiu	$2,$2,%lo(SelectNamePlateTable)
	sw	$2,0($3)
	li	$2,32			# 0x20
	jal	runRAM
	sw	$2,%lo(dataLength)($16)

	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	PlayerSelectSetup
	.size	PlayerSelectSetup, .-PlayerSelectSetup
	.align	2
	.globl	PlayerSelectMenu
	.set	nomips16
	.set	nomicromips
	.ent	PlayerSelectMenu
	.type	PlayerSelectMenu, @function
PlayerSelectMenu:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, gp= 0
	.mask	0x800f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$19,32($sp)
	sw	$18,28($sp)
	sw	$17,24($sp)
	sw	$16,20($sp)
	move	$17,$4
	move	$16,$5
	jal	CheckMenuButton
	move	$4,$5

	lui	$2,%hi(PlayerOK)
	addiu	$4,$2,%lo(PlayerOK)
	lwl	$3,%lo(PlayerOK)($2)
	lwr	$3,3($4)
	move	$2,$3
	lui	$3,%hi(GlobalIntC)
	sw	$2,%lo(GlobalIntC)($3)
	lui	$2,%hi(KBGNumberNext)
	lw	$2,%lo(KBGNumberNext)($2)
	beq	$2,$0,$L267
	lui	$2,%hi(jtbl_DispObjPsel)

	lui	$2,%hi(MenuBackup)
	lb	$2,%lo(MenuBackup)($2)
	bne	$2,$0,$L267
	lui	$2,%hi(jtbl_DispObjPsel)

	lui	$2,%hi(KBGNumberNext)
	sw	$0,%lo(KBGNumberNext)($2)
	lui	$2,%hi(jtbl_DispObjPsel)
$L267:
	li	$3,-2146828288			# 0xffffffff800a0000
	addiu	$3,$3,2248
	sw	$3,%lo(jtbl_DispObjPsel)($2)
	addiu	$2,$2,%lo(jtbl_DispObjPsel)
	sw	$3,4($2)
	sw	$3,8($2)
	sw	$3,12($2)
	sw	$3,16($2)
	sw	$3,20($2)
	sw	$3,24($2)
	sw	$3,28($2)
	lui	$2,%hi(PlayerShowStats)
	addiu	$3,$2,%lo(PlayerShowStats)
	swl	$0,%lo(PlayerShowStats)($2)
	swr	$0,3($3)
	lui	$2,%hi(HotSwapID)
	sh	$0,%lo(HotSwapID)($2)
	jal	copyCourseTable
	move	$4,$0

	li	$2,-1			# 0xffffffffffffffff
	lui	$3,%hi(courseValue)
	sh	$2,%lo(courseValue)($3)
	lui	$3,%hi(hsLabel)
	sh	$2,%lo(hsLabel)($3)
	lui	$3,%hi(asm_BlinkCheck)
	li	$2,337641472			# 0x14200000
	addiu	$2,$2,14
	sw	$2,%lo(asm_BlinkCheck)($3)
	lui	$2,%hi(MenuBackup)
	lb	$2,%lo(MenuBackup)($2)
	bne	$2,$0,$L268
	lui	$2,%hi(GlobalBoolA)

	li	$2,2			# 0x2
	beq	$17,$2,$L252
	lui	$2,%hi(MenuProgress)

	addiu	$2,$2,%lo(MenuProgress)
	addu	$2,$16,$2
	lb	$2,0($2)
	beq	$2,$0,$L223
	li	$3,1			# 0x1

	beq	$2,$3,$L224
	lui	$2,%hi(PlayerShowStats)

$L200:
	lui	$2,%hi(GlobalBoolA)
$L268:
	li	$3,1			# 0x1
	sb	$3,%lo(GlobalBoolA)($2)
	lui	$2,%hi(g_playerCount)
	lw	$6,%lo(g_playerCount)($2)
	blez	$6,$L233
	lui	$2,%hi(PlayerOK)

	addiu	$2,$2,%lo(PlayerOK)
	addu	$6,$6,$2
	move	$5,$0
	li	$4,1			# 0x1
	li	$8,1			# 0x1
	b	$L235
	move	$7,$0

$L252:
	lui	$2,%hi(PlayerEngineSelect)
	addiu	$2,$2,%lo(PlayerEngineSelect)
	addu	$2,$16,$2
	lui	$18,%hi(PlayerCharacterSelect)
	addiu	$18,$18,%lo(PlayerCharacterSelect)
	addu	$18,$16,$18
	lb	$3,0($18)
	lui	$19,%hi(CharacterConvert)
	addiu	$19,$19,%lo(CharacterConvert)
	addu	$3,$3,$19
	lb	$5,0($2)
	jal	SetEngine
	lb	$4,1($3)

	lui	$2,%hi(PlayerSteerSelect)
	addiu	$2,$2,%lo(PlayerSteerSelect)
	addu	$2,$16,$2
	lb	$3,0($18)
	addu	$19,$3,$19
	lb	$5,0($2)
	jal	SetSteering
	lb	$4,1($19)

	lui	$2,%hi(MenuProgress)
	addiu	$2,$2,%lo(MenuProgress)
	addu	$2,$16,$2
	lb	$2,0($2)
	bne	$2,$0,$L202
	li	$3,1			# 0x1

	lui	$2,%hi(PlayerOK)
	addiu	$2,$2,%lo(PlayerOK)
	addu	$2,$2,$16
	sb	$0,0($2)
	lui	$2,%hi(PlayerShowStats)
	addiu	$2,$2,%lo(PlayerShowStats)
	addu	$2,$2,$16
	sb	$0,0($2)
	sll	$2,$16,2
	lui	$3,%hi(asm_DispOBSubPSelCursor1)
	addiu	$3,$3,%lo(asm_DispOBSubPSelCursor1)
	addu	$2,$2,$3
	li	$3,-2146828288			# 0xffffffff800a0000
	addiu	$3,$3,2248
	sw	$3,0($2)
	sll	$2,$16,1
	lui	$3,%hi(MenuButtonHeld)
	addiu	$3,$3,%lo(MenuButtonHeld)
	addu	$2,$2,$3
	lhu	$2,0($2)
	li	$3,16384			# 0x4000
	beq	$2,$3,$L203
	sltu	$3,$2,16385

	beq	$3,$0,$L204
	li	$3,256			# 0x100

	beq	$2,$3,$L205
	li	$3,512			# 0x200

	bne	$2,$3,$L200
	li	$5,-1			# 0xffffffffffffffff

	jal	CheckPlayerSelect
	move	$4,$16

	li	$3,-1			# 0xffffffffffffffff
	bnel	$2,$3,$L253
	li	$4,1224736768			# 0x49000000

$L208:
	lui	$2,%hi(asm_BlinkCheck)
	b	$L200
	sw	$0,%lo(asm_BlinkCheck)($2)

$L204:
	li	$3,32768			# 0x8000
	bne	$2,$3,$L268
	lui	$2,%hi(GlobalBoolA)

	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8001

	lui	$2,%hi(MenuProgress)
	addiu	$2,$2,%lo(MenuProgress)
	addu	$2,$2,$16
	lbu	$3,0($2)
	addiu	$3,$3,1
	b	$L200
	sb	$3,0($2)

$L253:
	jal	playSound
	ori	$4,$4,0x8001

	li	$5,-1			# 0xffffffffffffffff
	jal	CheckPlayerSelect
	move	$4,$16

	lui	$3,%hi(PlayerCharacterSelect)
	addiu	$3,$3,%lo(PlayerCharacterSelect)
	addu	$3,$3,$16
	b	$L208
	sb	$2,0($3)

$L205:
	li	$5,1			# 0x1
	jal	CheckPlayerSelect
	move	$4,$16

	li	$3,-1			# 0xffffffffffffffff
	bnel	$2,$3,$L254
	li	$4,1224736768			# 0x49000000

$L209:
	lui	$2,%hi(asm_BlinkCheck)
	b	$L200
	sw	$0,%lo(asm_BlinkCheck)($2)

$L254:
	jal	playSound
	ori	$4,$4,0x8001

	li	$5,1			# 0x1
	jal	CheckPlayerSelect
	move	$4,$16

	lui	$3,%hi(PlayerCharacterSelect)
	addiu	$3,$3,%lo(PlayerCharacterSelect)
	addu	$3,$3,$16
	b	$L209
	sb	$2,0($3)

$L203:
	jal	SetFadeOutB
	nop

	lui	$2,%hi(PlayerShowStats)
	addiu	$3,$2,%lo(PlayerShowStats)
	swl	$0,%lo(PlayerShowStats)($2)
	swr	$0,3($3)
	lui	$2,%hi(MenuBackup)
	li	$3,1			# 0x1
	b	$L200
	sb	$3,%lo(MenuBackup)($2)

$L202:
	beql	$2,$3,$L255
	lui	$2,%hi(PlayerOK)

	li	$3,2			# 0x2
	beq	$2,$3,$L256
	li	$3,3			# 0x3

	bne	$2,$3,$L268
	lui	$2,%hi(GlobalBoolA)

	lui	$2,%hi(PlayerShowStats)
	addiu	$2,$2,%lo(PlayerShowStats)
	addu	$2,$2,$16
	sb	$0,0($2)
	lui	$2,%hi(PlayerOK)
	addiu	$2,$2,%lo(PlayerOK)
	addu	$2,$2,$16
	lb	$3,0($2)
	li	$2,1			# 0x1
	bne	$3,$2,$L257
	lui	$2,%hi(PlayerOK)

	sll	$2,$16,1
$L263:
	lui	$3,%hi(MenuButtonHeld)
	addiu	$3,$3,%lo(MenuButtonHeld)
	addu	$2,$2,$3
	lhu	$2,0($2)
	andi	$2,$2,0x4000
	beq	$2,$0,$L268
	lui	$2,%hi(GlobalBoolA)

	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8002

	lui	$2,%hi(MenuProgress)
	addiu	$2,$2,%lo(MenuProgress)
	addu	$2,$2,$16
	lbu	$3,0($2)
	addiu	$3,$3,-1
	b	$L200
	sb	$3,0($2)

$L255:
	addiu	$2,$2,%lo(PlayerOK)
	addu	$2,$2,$16
	sb	$0,0($2)
	lui	$2,%hi(PlayerShowStats)
	addiu	$2,$2,%lo(PlayerShowStats)
	addu	$2,$2,$16
	sb	$3,0($2)
	sll	$2,$16,2
	lui	$3,%hi(asm_DispOBSubPSelCursor1)
	addiu	$3,$3,%lo(asm_DispOBSubPSelCursor1)
	addu	$2,$2,$3
	li	$3,-2146828288			# 0xffffffff800a0000
	addiu	$3,$3,252
	sw	$3,0($2)
	sll	$2,$16,1
	lui	$3,%hi(MenuButtonHeld)
	addiu	$3,$3,%lo(MenuButtonHeld)
	addu	$2,$2,$3
	lhu	$2,0($2)
	li	$3,16384			# 0x4000
	beq	$2,$3,$L211
	sltu	$3,$2,16385

	beq	$3,$0,$L212
	li	$3,256			# 0x100

	beq	$2,$3,$L213
	li	$3,512			# 0x200

	bne	$2,$3,$L200
	lui	$2,%hi(PlayerEngineSelect)

	addiu	$2,$2,%lo(PlayerEngineSelect)
	addu	$2,$2,$16
	lb	$2,0($2)
	blez	$2,$L268
	lui	$2,%hi(GlobalBoolA)

	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8001

	lui	$2,%hi(PlayerEngineSelect)
	addiu	$2,$2,%lo(PlayerEngineSelect)
	addu	$2,$2,$16
	lbu	$3,0($2)
	addiu	$3,$3,-1
	b	$L200
	sb	$3,0($2)

$L212:
	li	$3,32768			# 0x8000
	bne	$2,$3,$L268
	lui	$2,%hi(GlobalBoolA)

	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8001

	lui	$2,%hi(MenuProgress)
	addiu	$2,$2,%lo(MenuProgress)
	addu	$2,$2,$16
	lbu	$3,0($2)
	addiu	$3,$3,1
	b	$L200
	sb	$3,0($2)

$L213:
	lui	$2,%hi(PlayerEngineSelect)
	addiu	$2,$2,%lo(PlayerEngineSelect)
	addu	$2,$2,$16
	lb	$2,0($2)
	slt	$2,$2,2
	beq	$2,$0,$L268
	lui	$2,%hi(GlobalBoolA)

	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8001

	lui	$2,%hi(PlayerEngineSelect)
	addiu	$2,$2,%lo(PlayerEngineSelect)
	addu	$2,$2,$16
	lbu	$3,0($2)
	addiu	$3,$3,1
	b	$L200
	sb	$3,0($2)

$L211:
	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8002

	lui	$2,%hi(MenuProgress)
	addiu	$2,$2,%lo(MenuProgress)
	addu	$2,$2,$16
	lbu	$3,0($2)
	addiu	$3,$3,-1
	b	$L200
	sb	$3,0($2)

$L256:
	lui	$2,%hi(PlayerOK)
	addiu	$2,$2,%lo(PlayerOK)
	addu	$2,$2,$16
	sb	$0,0($2)
	lui	$2,%hi(PlayerShowStats)
	addiu	$2,$2,%lo(PlayerShowStats)
	addu	$2,$2,$16
	li	$3,1			# 0x1
	sb	$3,0($2)
	sll	$2,$16,2
	lui	$3,%hi(asm_DispOBSubPSelCursor1)
	addiu	$3,$3,%lo(asm_DispOBSubPSelCursor1)
	addu	$2,$2,$3
	li	$3,-2146828288			# 0xffffffff800a0000
	addiu	$3,$3,252
	sw	$3,0($2)
	sll	$2,$16,1
	lui	$3,%hi(MenuButtonHeld)
	addiu	$3,$3,%lo(MenuButtonHeld)
	addu	$2,$2,$3
	lhu	$2,0($2)
	li	$3,16384			# 0x4000
	beq	$2,$3,$L217
	sltu	$3,$2,16385

	beq	$3,$0,$L218
	li	$3,256			# 0x100

	beq	$2,$3,$L219
	li	$3,512			# 0x200

	bne	$2,$3,$L200
	lui	$2,%hi(PlayerSteerSelect)

	addiu	$2,$2,%lo(PlayerSteerSelect)
	addu	$2,$2,$16
	lb	$2,0($2)
	blez	$2,$L268
	lui	$2,%hi(GlobalBoolA)

	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8001

	lui	$2,%hi(PlayerSteerSelect)
	addiu	$2,$2,%lo(PlayerSteerSelect)
	addu	$2,$2,$16
	lbu	$3,0($2)
	addiu	$3,$3,-1
	b	$L200
	sb	$3,0($2)

$L218:
	li	$3,32768			# 0x8000
	bne	$2,$3,$L268
	lui	$2,%hi(GlobalBoolA)

	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8001

	lui	$2,%hi(MenuProgress)
	addiu	$2,$2,%lo(MenuProgress)
	addu	$2,$2,$16
	lbu	$3,0($2)
	addiu	$3,$3,1
	b	$L200
	sb	$3,0($2)

$L219:
	lui	$2,%hi(PlayerSteerSelect)
	addiu	$2,$2,%lo(PlayerSteerSelect)
	addu	$2,$2,$16
	lb	$2,0($2)
	slt	$2,$2,2
	beq	$2,$0,$L268
	lui	$2,%hi(GlobalBoolA)

	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8001

	lui	$2,%hi(PlayerSteerSelect)
	addiu	$2,$2,%lo(PlayerSteerSelect)
	addu	$2,$2,$16
	lbu	$3,0($2)
	addiu	$3,$3,1
	b	$L200
	sb	$3,0($2)

$L217:
	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8002

	lui	$2,%hi(MenuProgress)
	addiu	$2,$2,%lo(MenuProgress)
	addu	$2,$2,$16
	lbu	$3,0($2)
	addiu	$3,$3,-1
	b	$L200
	sb	$3,0($2)

$L257:
	addiu	$2,$2,%lo(PlayerOK)
	addu	$2,$2,$16
	li	$3,1			# 0x1
	sb	$3,0($2)
	lui	$2,%hi(PlayerCharacterSelect)
	addiu	$2,$2,%lo(PlayerCharacterSelect)
	addu	$2,$2,$16
	lb	$2,0($2)
	lui	$3,%hi(CharacterConvert)
	addiu	$3,$3,%lo(CharacterConvert)
	addu	$2,$2,$3
	lb	$4,1($2)
	sll	$4,$4,4
	li	$2,687865856			# 0x29000000
	ori	$2,$2,0x800e
	jal	playSound
	addu	$4,$4,$2

	b	$L263
	sll	$2,$16,1

$L223:
	lui	$2,%hi(PlayerShowStats)
	addiu	$2,$2,%lo(PlayerShowStats)
	addu	$2,$2,$16
	li	$3,1			# 0x1
	sb	$3,0($2)
	sll	$2,$16,2
	lui	$3,%hi(asm_DispOBSubPSelCursor1)
	addiu	$3,$3,%lo(asm_DispOBSubPSelCursor1)
	addu	$2,$2,$3
	li	$3,-2146828288			# 0xffffffff800a0000
	addiu	$3,$3,2248
	sw	$3,0($2)
	lui	$2,%hi(PlayerOK)
	addiu	$2,$2,%lo(PlayerOK)
	addu	$2,$2,$16
	sb	$0,0($2)
	sll	$2,$16,1
	lui	$3,%hi(MenuButtonHeld)
	addiu	$3,$3,%lo(MenuButtonHeld)
	addu	$2,$2,$3
	lhu	$2,0($2)
	li	$3,16384			# 0x4000
	beq	$2,$3,$L225
	sltu	$3,$2,16385

	beq	$3,$0,$L226
	li	$3,256			# 0x100

	beq	$2,$3,$L227
	li	$3,512			# 0x200

	bne	$2,$3,$L200
	li	$5,-1			# 0xffffffffffffffff

	jal	CheckPlayerSelect
	move	$4,$16

	li	$3,-1			# 0xffffffffffffffff
	bnel	$2,$3,$L258
	li	$4,1224736768			# 0x49000000

$L230:
	lui	$2,%hi(asm_BlinkCheck)
	b	$L200
	sw	$0,%lo(asm_BlinkCheck)($2)

$L226:
	li	$3,32768			# 0x8000
	bne	$2,$3,$L268
	lui	$2,%hi(GlobalBoolA)

	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8001

	lui	$2,%hi(MenuProgress)
	addiu	$2,$2,%lo(MenuProgress)
	addu	$2,$2,$16
	lbu	$3,0($2)
	addiu	$3,$3,1
	b	$L200
	sb	$3,0($2)

$L258:
	jal	playSound
	ori	$4,$4,0x8001

	li	$5,-1			# 0xffffffffffffffff
	jal	CheckPlayerSelect
	move	$4,$16

	lui	$3,%hi(PlayerCharacterSelect)
	addiu	$3,$3,%lo(PlayerCharacterSelect)
	addu	$3,$3,$16
	b	$L230
	sb	$2,0($3)

$L227:
	li	$5,1			# 0x1
	jal	CheckPlayerSelect
	move	$4,$16

	li	$3,-1			# 0xffffffffffffffff
	bnel	$2,$3,$L259
	li	$4,1224736768			# 0x49000000

$L231:
	lui	$2,%hi(asm_BlinkCheck)
	b	$L200
	sw	$0,%lo(asm_BlinkCheck)($2)

$L259:
	jal	playSound
	ori	$4,$4,0x8001

	li	$5,1			# 0x1
	jal	CheckPlayerSelect
	move	$4,$16

	lui	$3,%hi(PlayerCharacterSelect)
	addiu	$3,$3,%lo(PlayerCharacterSelect)
	addu	$3,$3,$16
	b	$L231
	sb	$2,0($3)

$L225:
	jal	SetFadeOutB
	nop

	lui	$2,%hi(PlayerShowStats)
	addiu	$3,$2,%lo(PlayerShowStats)
	swl	$0,%lo(PlayerShowStats)($2)
	swr	$0,3($3)
	lui	$2,%hi(MenuBackup)
	li	$3,1			# 0x1
	b	$L200
	sb	$3,%lo(MenuBackup)($2)

$L224:
	addiu	$2,$2,%lo(PlayerShowStats)
	addu	$2,$2,$16
	sb	$0,0($2)
	lui	$2,%hi(PlayerOK)
	addiu	$2,$2,%lo(PlayerOK)
	addu	$2,$2,$16
	lb	$3,0($2)
	li	$2,1			# 0x1
	bne	$3,$2,$L260
	lui	$2,%hi(PlayerOK)

	sll	$2,$16,2
$L264:
	lui	$3,%hi(asm_DispOBSubPSelCursor1)
	addiu	$3,$3,%lo(asm_DispOBSubPSelCursor1)
	addu	$2,$2,$3
	li	$3,-2146828288			# 0xffffffff800a0000
	addiu	$3,$3,252
	sw	$3,0($2)
	sll	$2,$16,1
	lui	$3,%hi(MenuButtonHeld)
	addiu	$3,$3,%lo(MenuButtonHeld)
	addu	$2,$2,$3
	lhu	$2,0($2)
	andi	$2,$2,0x4000
	beq	$2,$0,$L268
	lui	$2,%hi(GlobalBoolA)

	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8002

	lui	$2,%hi(MenuProgress)
	addiu	$2,$2,%lo(MenuProgress)
	addu	$2,$2,$16
	lbu	$3,0($2)
	addiu	$3,$3,-1
	b	$L200
	sb	$3,0($2)

$L260:
	addiu	$2,$2,%lo(PlayerOK)
	addu	$2,$2,$16
	li	$3,1			# 0x1
	sb	$3,0($2)
	lui	$2,%hi(PlayerCharacterSelect)
	addiu	$2,$2,%lo(PlayerCharacterSelect)
	addu	$2,$2,$16
	lb	$2,0($2)
	lui	$3,%hi(CharacterConvert)
	addiu	$3,$3,%lo(CharacterConvert)
	addu	$2,$2,$3
	lb	$4,1($2)
	sll	$4,$4,4
	li	$2,687865856			# 0x29000000
	ori	$2,$2,0x800e
	jal	playSound
	addu	$4,$4,$2

	b	$L264
	sll	$2,$16,2

$L234:
	addiu	$2,$2,1
$L269:
	beq	$2,$6,$L261
	nop

$L235:
	lb	$3,0($2)
	bnel	$3,$0,$L269
	addiu	$2,$2,1

	move	$5,$8
	b	$L234
	move	$4,$7

$L261:
	beq	$5,$0,$L233
	lui	$2,%hi(GlobalBoolA)

	bne	$4,$0,$L233
	sb	$4,%lo(GlobalBoolA)($2)

	lui	$2,%hi(menuScreenC)
$L265:
	lb	$3,%lo(menuScreenC)($2)
	li	$2,2			# 0x2
	beq	$3,$2,$L270
	sll	$2,$16,1

$L239:
	lui	$3,%hi(GlobalMenuHUD)
$L271:
	addiu	$3,$3,%lo(GlobalMenuHUD)
	addiu	$4,$3,1280
	b	$L243
	li	$5,4			# 0x4

$L233:
	lui	$2,%hi(menuScreenC)
	lb	$3,%lo(menuScreenC)($2)
	li	$2,2			# 0x2
	beq	$3,$2,$L237
	lui	$2,%hi(menuScreenC)

	li	$3,2			# 0x2
	sb	$3,%lo(menuScreenC)($2)
	sll	$2,$16,1
$L270:
	lui	$3,%hi(MenuButtonHeld)
	addiu	$3,$3,%lo(MenuButtonHeld)
	addu	$2,$2,$3
	lhu	$2,0($2)
	andi	$2,$2,0x4000
	beq	$2,$0,$L271
	lui	$3,%hi(GlobalMenuHUD)

	lui	$2,%hi(menuScreenC)
	sb	$0,%lo(menuScreenC)($2)
	lui	$2,%hi(g_playerCount)
	lw	$5,%lo(g_playerCount)($2)
	blez	$5,$L240
	lui	$2,%hi(PlayerOK)

	addiu	$2,$2,%lo(PlayerOK)
	lui	$4,%hi(MenuProgress)
	addiu	$4,$4,%lo(MenuProgress)
	addu	$5,$5,$2
	xori	$3,$17,0x2
	sltu	$3,$3,1
$L241:
	sb	$0,0($2)
	sb	$3,0($4)
	addiu	$2,$2,1
	bne	$5,$2,$L241
	addiu	$4,$4,1

$L240:
	lui	$2,%hi(asm_DispOBSubPSelCursor1)
	li	$3,-2146828288			# 0xffffffff800a0000
	addiu	$3,$3,2248
	sw	$3,%lo(asm_DispOBSubPSelCursor1)($2)
	addiu	$2,$2,%lo(asm_DispOBSubPSelCursor1)
	sw	$3,4($2)
	sw	$3,8($2)
	b	$L239
	sw	$3,12($2)

$L237:
	sll	$2,$16,1
	lui	$3,%hi(MenuButtonHeld)
	addiu	$3,$3,%lo(MenuButtonHeld)
	addu	$2,$2,$3
	lh	$2,0($2)
	bgezl	$2,$L270
	sll	$2,$16,1

	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8000

	jal	SetFadeOut
	li	$4,30			# 0x1e

	b	$L265
	lui	$2,%hi(menuScreenC)

$L242:
	addiu	$3,$3,40
$L266:
	beq	$3,$4,$L262
	lw	$31,36($sp)

$L243:
	lw	$2,0($3)
	addiu	$2,$2,-43
	sltu	$2,$2,8
	bnel	$2,$0,$L242
	sw	$5,4($3)

	b	$L266
	addiu	$3,$3,40

$L262:
	lw	$19,32($sp)
	lw	$18,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,40

	.set	macro
	.set	reorder
	.end	PlayerSelectMenu
	.size	PlayerSelectMenu, .-PlayerSelectMenu
	.align	2
	.globl	PlayerSelectMenuAfter
	.set	nomips16
	.set	nomicromips
	.ent	PlayerSelectMenuAfter
	.type	PlayerSelectMenuAfter, @function
PlayerSelectMenuAfter:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(g_playerCount)
	lw	$10,%lo(g_playerCount)($2)
	blez	$10,$L276
	lui	$7,%hi(asm_DispOBSubPSelCursor1)

	addiu	$7,$7,%lo(asm_DispOBSubPSelCursor1)
	lui	$2,%hi(PlayerCharacterSelect)
	addiu	$2,$2,%lo(PlayerCharacterSelect)
	lui	$6,%hi(g_CharacterSelections)
	addiu	$6,$6,%lo(g_CharacterSelections)
	lui	$5,%hi(MenuProgress)
	addiu	$5,$5,%lo(MenuProgress)
	move	$3,$0
	li	$9,-2146828288			# 0xffffffff800a0000
	addiu	$9,$9,2248
	lui	$8,%hi(CharacterConvert)
	addiu	$8,$8,%lo(CharacterConvert)
$L274:
	sw	$9,0($7)
	lb	$4,0($2)
	addu	$4,$4,$8
	lbu	$4,1($4)
	sb	$4,0($6)
	sb	$3,0($2)
	sb	$0,0($5)
	addiu	$3,$3,1
	addiu	$7,$7,4
	addiu	$2,$2,1
	addiu	$6,$6,1
	bne	$3,$10,$L274
	addiu	$5,$5,1

$L276:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	PlayerSelectMenuAfter
	.size	PlayerSelectMenuAfter, .-PlayerSelectMenuAfter
	.align	2
	.globl	PlayerSelectMenuBefore
	.set	nomips16
	.set	nomicromips
	.ent	PlayerSelectMenuBefore
	.type	PlayerSelectMenuBefore, @function
PlayerSelectMenuBefore:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(g_playerCount)
	lw	$5,%lo(g_playerCount)($2)
	addiu	$3,$5,-1
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,1
	sll	$3,$5,6
	addu	$2,$2,$3
	sra	$2,$2,1
	subu	$2,$0,$2
	addiu	$2,$2,160
	lui	$3,%hi(GlobalIntA)
	blez	$5,$L278
	sw	$2,%lo(GlobalIntA)($3)

	lui	$3,%hi(PlayerSelectPositions)
	addiu	$3,$3,%lo(PlayerSelectPositions)
	sll	$4,$5,3
	addu	$4,$4,$3
$L279:
	sh	$2,0($3)
	addiu	$3,$3,8
	bne	$3,$4,$L279
	addiu	$2,$2,70

	lui	$3,%hi(GlobalIntA)
	sw	$2,%lo(GlobalIntA)($3)
	lui	$2,%hi(MenuBackup)
	sb	$0,%lo(MenuBackup)($2)
	lui	$4,%hi(PlayerCharacterSelect)
	addiu	$4,$4,%lo(PlayerCharacterSelect)
	lui	$3,%hi(asm_DispOBSubPSelCursor1)
	addiu	$3,$3,%lo(asm_DispOBSubPSelCursor1)
	move	$2,$0
	li	$6,-2146828288			# 0xffffffff800a0000
	addiu	$6,$6,2248
$L281:
	sb	$2,0($4)
	sw	$6,0($3)
	addiu	$2,$2,1
	addiu	$4,$4,1
	bne	$5,$2,$L281
	addiu	$3,$3,4

	jr	$31
	nop

$L278:
	lui	$2,%hi(MenuBackup)
	jr	$31
	sb	$0,%lo(MenuBackup)($2)

	.set	macro
	.set	reorder
	.end	PlayerSelectMenuBefore
	.size	PlayerSelectMenuBefore, .-PlayerSelectMenuBefore
	.align	2
	.globl	MapSelectMenu
	.set	nomips16
	.set	nomicromips
	.ent	MapSelectMenu
	.type	MapSelectMenu, @function
MapSelectMenu:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$16,16($sp)
	lui	$2,%hi(g_gameMode)
	lw	$3,%lo(g_gameMode)($2)
	li	$2,3			# 0x3
	beq	$3,$2,$L296
	move	$16,$4

	li	$3,1			# 0x1
$L287:
	lui	$2,%hi(GlobalShortA)
	sh	$3,%lo(GlobalShortA)($2)
	lui	$2,%hi(ROptionPressed)
	lw	$2,%lo(ROptionPressed)($2)
	beql	$2,$0,$L303
	sll	$2,$16,2

	addiu	$2,$2,2
	lui	$3,%hi(GlobalFrameCount)
	lw	$3,%lo(GlobalFrameCount)($3)
	sltu	$2,$3,$2
	beq	$2,$0,$L298
	lui	$2,%hi(ROptionPressed)

	sll	$2,$16,2
$L303:
	lui	$3,%hi(GlobalController)
	addiu	$3,$3,%lo(GlobalController)
	addu	$2,$2,$3
	lw	$2,0($2)
	lhu	$2,6($2)
	andi	$2,$2,0x10
	bnel	$2,$0,$L299
	li	$4,1224736768			# 0x49000000

$L289:
	lui	$2,%hi(menuScreenA)
	lb	$3,%lo(menuScreenA)($2)
	lui	$2,%hi(GlobalShortA)
	lh	$2,%lo(GlobalShortA)($2)
	beq	$3,$2,$L300
	lui	$2,%hi(PlayerOK)

$L304:
	addiu	$3,$2,%lo(PlayerOK)
	swl	$0,%lo(PlayerOK)($2)
	swr	$0,3($3)
	lui	$2,%hi(HotSwapID)
	lh	$2,%lo(HotSwapID)($2)
	blez	$2,$L293
	lui	$2,%hi(courseValue)

	li	$3,-1			# 0xffffffffffffffff
	sh	$3,%lo(courseValue)($2)
	lui	$2,%hi(gpCourseIndex)
	sh	$0,%lo(gpCourseIndex)($2)
	lui	$2,%hi(g_gameMode)
	lw	$2,%lo(g_gameMode)($2)
	beq	$2,$0,$L294
	addiu	$2,$2,-1

	sltu	$2,$2,3
	beq	$2,$0,$L286
	lui	$2,%hi(g_cupSelect)

	lb	$2,%lo(g_cupSelect)($2)
	sll	$2,$2,2
	lui	$3,%hi(g_courseSelect)
	lb	$3,%lo(g_courseSelect)($3)
	addu	$2,$2,$3
	lui	$3,%hi(courseValue)
	sh	$2,%lo(courseValue)($3)
$L286:
	lw	$31,20($sp)
$L306:
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

$L296:
	b	$L287
	li	$3,4			# 0x4

$L298:
	sw	$0,%lo(ROptionPressed)($2)
	li	$2,6			# 0x6
	lui	$3,%hi(KBGNumber)
	sw	$2,%lo(KBGNumber)($3)
	lui	$3,%hi(KBGNumberNext)
	sw	$2,%lo(KBGNumberNext)($3)
	lui	$2,%hi(KBGChange)
	li	$3,1			# 0x1
	jal	SetFadeOutTaData
	sw	$3,%lo(KBGChange)($2)

	b	$L303
	sll	$2,$16,2

$L299:
	jal	playSound
	ori	$4,$4,0x9010

	lui	$2,%hi(GlobalFrameCount)
	lw	$3,%lo(GlobalFrameCount)($2)
	lui	$2,%hi(ROptionPressed)
	b	$L289
	sw	$3,%lo(ROptionPressed)($2)

$L300:
	sll	$16,$16,2
	lui	$4,%hi(GlobalController)
	addiu	$4,$4,%lo(GlobalController)
	addu	$16,$16,$4
	lw	$2,0($16)
	lhu	$2,6($2)
	andi	$3,$2,0x2
	bne	$3,$0,$L301
	nop

	andi	$2,$2,0x1
	bne	$2,$0,$L302
	nop

	lui	$2,%hi(courseValue)
$L305:
	jal	LoadCustomHeader
	lh	$4,%lo(courseValue)($2)

	b	$L304
	lui	$2,%hi(PlayerOK)

$L301:
	jal	swapHS
	move	$4,$0

	b	$L305
	lui	$2,%hi(courseValue)

$L302:
	jal	swapHS
	li	$4,1			# 0x1

	b	$L305
	lui	$2,%hi(courseValue)

$L294:
	lui	$2,%hi(g_cupSelect)
	lb	$2,%lo(g_cupSelect)($2)
	sll	$2,$2,2
	lui	$3,%hi(courseValue)
	b	$L286
	sh	$2,%lo(courseValue)($3)

$L293:
	jal	LoadCustomHeader
	li	$4,-1			# 0xffffffffffffffff

	b	$L306
	lw	$31,20($sp)

	.set	macro
	.set	reorder
	.end	MapSelectMenu
	.size	MapSelectMenu, .-MapSelectMenu
	.section	.rodata.str1.4
	.align	2
$LC21:
	.ascii	"GAME SETUP\000"
	.text
	.align	2
	.globl	DrawGameSelect
	.set	nomips16
	.set	nomicromips
	.ent	DrawGameSelect
	.type	DrawGameSelect, @function
DrawGameSelect:
	.frame	$sp,48,$31		# vars= 0, regs= 1/0, args= 40, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-48
	sw	$31,44($sp)
	li	$2,175			# 0xaf
	sw	$2,28($sp)
	sw	$0,24($sp)
	sw	$0,20($sp)
	sw	$0,16($sp)
	li	$7,25			# 0x19
	li	$6,190			# 0xbe
	li	$5,18			# 0x12
	jal	DrawBox
	li	$4,65			# 0x41

	lui	$7,%hi($LC21)
	addiu	$7,$7,%lo($LC21)
	lui	$2,%hi($LC22)
	lw	$6,%lo($LC22)($2)
	li	$5,16			# 0x10
	jal	PrintBigText
	li	$4,90			# 0x5a

	lui	$2,%hi(ROptionPressed)
	lw	$2,%lo(ROptionPressed)($2)
	beq	$2,$0,$L308
	li	$3,32			# 0x20

	sw	$3,36($sp)
	li	$2,64			# 0x40
	sw	$2,32($sp)
	sw	$3,28($sp)
	sw	$2,24($sp)
	lui	$2,%hi(V64x32)
	addiu	$2,$2,%lo(V64x32)
	sw	$2,20($sp)
	lui	$2,%hi(MenuIconsRAM)
	lw	$2,%lo(MenuIconsRAM)($2)
	addiu	$2,$2,4096
	sw	$2,16($sp)
	lui	$2,%hi($LC22)
	lw	$7,%lo($LC22)($2)
	move	$6,$0
	li	$5,200			# 0xc8
	jal	KWTexture2DRGBA
	li	$4,70			# 0x46

	lw	$31,44($sp)
$L311:
	jr	$31
	addiu	$sp,$sp,48

$L308:
	sw	$3,36($sp)
	li	$2,64			# 0x40
	sw	$2,32($sp)
	sw	$3,28($sp)
	sw	$2,24($sp)
	lui	$2,%hi(V64x32)
	addiu	$2,$2,%lo(V64x32)
	sw	$2,20($sp)
	lui	$2,%hi(MenuIconsRAM)
	lw	$2,%lo(MenuIconsRAM)($2)
	sw	$2,16($sp)
	lui	$2,%hi($LC22)
	lw	$7,%lo($LC22)($2)
	move	$6,$0
	li	$5,200			# 0xc8
	jal	KWTexture2DRGBA
	li	$4,70			# 0x46

	b	$L311
	lw	$31,44($sp)

	.set	macro
	.set	reorder
	.end	DrawGameSelect
	.size	DrawGameSelect, .-DrawGameSelect
	.section	.rodata.str1.4
	.align	2
$LC23:
	.ascii	"Original Set\000"
	.align	2
$LC25:
	.ascii	"Custom Set \000"
	.align	2
$LC26:
	.ascii	"Custom Set\000"
	.text
	.align	2
	.globl	DrawMapSelect
	.set	nomips16
	.set	nomicromips
	.ent	DrawMapSelect
	.type	DrawMapSelect, @function
DrawMapSelect:
	.frame	$sp,48,$31		# vars= 0, regs= 2/0, args= 40, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-48
	sw	$31,44($sp)
	sw	$16,40($sp)
	li	$2,175			# 0xaf
	sw	$2,28($sp)
	sw	$0,24($sp)
	sw	$0,20($sp)
	sw	$0,16($sp)
	li	$7,25			# 0x19
	li	$6,190			# 0xbe
	li	$5,18			# 0x12
	jal	DrawBox
	li	$4,65			# 0x41

	lui	$2,%hi(HotSwapID)
	lh	$2,%lo(HotSwapID)($2)
	beq	$2,$0,$L319
	slt	$3,$2,10

	beq	$3,$0,$L315
	sw	$2,16($sp)

	lui	$7,%hi($LC25)
	addiu	$7,$7,%lo($LC25)
	lui	$2,%hi($LC24)
	lw	$6,%lo($LC24)($2)
	li	$5,16			# 0x10
	jal	PrintBigTextNumberNoGap
	li	$4,80			# 0x50

	lui	$2,%hi(ROptionPressed)
$L320:
	lw	$2,%lo(ROptionPressed)($2)
	beq	$2,$0,$L316
	li	$3,32			# 0x20

	sw	$3,36($sp)
	li	$2,64			# 0x40
	sw	$2,32($sp)
	sw	$3,28($sp)
	sw	$2,24($sp)
	lui	$2,%hi(V64x32)
	addiu	$2,$2,%lo(V64x32)
	sw	$2,20($sp)
	lui	$2,%hi(MenuIconsRAM)
	lw	$2,%lo(MenuIconsRAM)($2)
	addiu	$2,$2,4096
	sw	$2,16($sp)
	lui	$2,%hi($LC22)
	lw	$7,%lo($LC22)($2)
	move	$6,$0
	li	$5,200			# 0xc8
	jal	KWTexture2DRGBA
	li	$4,70			# 0x46

	lui	$2,%hi($LC22)
$L321:
	lw	$16,%lo($LC22)($2)
	move	$7,$0
	move	$6,$16
	li	$5,35			# 0x23
	jal	SpriteBtnCLeft
	li	$4,45			# 0x2d

	move	$7,$0
	move	$6,$16
	li	$5,35			# 0x23
	jal	SpriteBtnCRight
	li	$4,279			# 0x117

	lw	$31,44($sp)
	lw	$16,40($sp)
	jr	$31
	addiu	$sp,$sp,48

$L319:
	lui	$7,%hi($LC23)
	addiu	$7,$7,%lo($LC23)
	lui	$2,%hi($LC24)
	lw	$6,%lo($LC24)($2)
	li	$5,16			# 0x10
	jal	PrintBigText
	li	$4,80			# 0x50

	b	$L320
	lui	$2,%hi(ROptionPressed)

$L315:
	lui	$7,%hi($LC26)
	addiu	$7,$7,%lo($LC26)
	lui	$2,%hi($LC24)
	lw	$6,%lo($LC24)($2)
	li	$5,16			# 0x10
	jal	PrintBigTextNumberNoGap
	li	$4,80			# 0x50

	b	$L320
	lui	$2,%hi(ROptionPressed)

$L316:
	sw	$3,36($sp)
	li	$2,64			# 0x40
	sw	$2,32($sp)
	sw	$3,28($sp)
	sw	$2,24($sp)
	lui	$2,%hi(V64x32)
	addiu	$2,$2,%lo(V64x32)
	sw	$2,20($sp)
	lui	$2,%hi(MenuIconsRAM)
	lw	$2,%lo(MenuIconsRAM)($2)
	sw	$2,16($sp)
	lui	$2,%hi($LC22)
	lw	$7,%lo($LC22)($2)
	move	$6,$0
	li	$5,200			# 0xc8
	jal	KWTexture2DRGBA
	li	$4,70			# 0x46

	b	$L321
	lui	$2,%hi($LC22)

	.set	macro
	.set	reorder
	.end	DrawMapSelect
	.size	DrawMapSelect, .-DrawMapSelect
	.section	.rodata.str1.4
	.align	2
$LC27:
	.ascii	"Player Select\000"
	.text
	.align	2
	.globl	DrawPlayerSelect
	.set	nomips16
	.set	nomicromips
	.ent	DrawPlayerSelect
	.type	DrawPlayerSelect, @function
DrawPlayerSelect:
	.frame	$sp,40,$31		# vars= 0, regs= 1/0, args= 32, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	li	$2,175			# 0xaf
	sw	$2,28($sp)
	sw	$0,24($sp)
	sw	$0,20($sp)
	sw	$0,16($sp)
	li	$7,25			# 0x19
	li	$6,190			# 0xbe
	li	$5,18			# 0x12
	jal	DrawBox
	li	$4,65			# 0x41

	lui	$7,%hi($LC27)
	addiu	$7,$7,%lo($LC27)
	lui	$2,%hi($LC24)
	lw	$6,%lo($LC24)($2)
	li	$5,16			# 0x10
	jal	PrintBigText
	li	$4,75			# 0x4b

	lw	$31,36($sp)
	jr	$31
	addiu	$sp,$sp,40

	.set	macro
	.set	reorder
	.end	DrawPlayerSelect
	.size	DrawPlayerSelect, .-DrawPlayerSelect
	.align	2
	.globl	GameSelectMenu
	.set	nomips16
	.set	nomicromips
	.ent	GameSelectMenu
	.type	GameSelectMenu, @function
GameSelectMenu:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$16,16($sp)
	jal	CheckMenuButton
	move	$16,$4

	sll	$2,$16,1
	lui	$3,%hi(MenuButtonHeld)
	addiu	$3,$3,%lo(MenuButtonHeld)
	addu	$2,$2,$3
	lhu	$2,0($2)
	li	$3,1024			# 0x400
	beq	$2,$3,$L325
	li	$3,2048			# 0x800

	bne	$2,$3,$L337
	lui	$2,%hi(GameMenuIndex)

	lb	$2,%lo(GameMenuIndex)($2)
	blez	$2,$L327
	lui	$3,%hi(GameMenuIndex)

	addiu	$2,$2,1
	sb	$2,%lo(GameMenuIndex)($3)
	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8000

$L325:
	lui	$2,%hi(GameMenuIndex)
$L336:
	lb	$2,%lo(GameMenuIndex)($2)
	slt	$3,$2,2
	bne	$3,$0,$L334
	addiu	$2,$2,1

	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8002

	lui	$2,%hi(GameMenuIndex)
$L337:
	lb	$2,%lo(GameMenuIndex)($2)
	bne	$2,$0,$L335
	lw	$31,20($sp)

	sll	$16,$16,1
	lui	$4,%hi(MenuButtonHeld)
	addiu	$4,$4,%lo(MenuButtonHeld)
	addu	$16,$16,$4
	lhu	$2,0($16)
	li	$3,256			# 0x100
	beq	$2,$3,$L330
	li	$3,512			# 0x200

	bne	$2,$3,$L338
	lw	$16,16($sp)

	lui	$2,%hi(g_playerCount)
	lw	$2,%lo(g_playerCount)($2)
	slt	$3,$2,2
	bne	$3,$0,$L331
	addiu	$2,$2,-1

	lui	$3,%hi(g_playerCount)
	sw	$2,%lo(g_playerCount)($3)
	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8000

	b	$L335
	lw	$31,20($sp)

$L327:
	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8002

	b	$L336
	lui	$2,%hi(GameMenuIndex)

$L334:
	lui	$3,%hi(GameMenuIndex)
	sb	$2,%lo(GameMenuIndex)($3)
	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8000

	b	$L337
	lui	$2,%hi(GameMenuIndex)

$L331:
	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x8002

	b	$L335
	lw	$31,20($sp)

$L330:
	lui	$2,%hi(g_playerCount)
	lw	$2,%lo(g_playerCount)($2)
	slt	$3,$2,4
	beq	$3,$0,$L339
	li	$4,1224736768			# 0x49000000

	addiu	$2,$2,1
	lui	$3,%hi(g_playerCount)
	sw	$2,%lo(g_playerCount)($3)
$L339:
	jal	playSound
	ori	$4,$4,0x8000

	lw	$31,20($sp)
$L335:
	lw	$16,16($sp)
$L338:
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	GameSelectMenu
	.size	GameSelectMenu, .-GameSelectMenu
	.align	2
	.globl	PlayerSelectSwitch
	.set	nomips16
	.set	nomicromips
	.ent	PlayerSelectSwitch
	.type	PlayerSelectSwitch, @function
PlayerSelectSwitch:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sll	$2,$5,2
	lui	$3,%hi(GlobalController)
	addiu	$3,$3,%lo(GlobalController)
	addu	$2,$2,$3
	lw	$2,0($2)
	lhu	$2,6($2)
	andi	$2,$2,0x10
	beq	$2,$0,$L346
	lui	$2,%hi(MenuToggle)

	lui	$3,%hi(MenuToggle)
	lbu	$2,%lo(MenuToggle)($3)
	xori	$2,$2,0x1
	sb	$2,%lo(MenuToggle)($3)
	lui	$2,%hi(MenuToggle)
$L346:
	lbu	$2,%lo(MenuToggle)($2)
	beql	$2,$0,$L342
	sll	$5,$5,16

	sll	$4,$5,16
	jal	GameOptionsHandler
	sra	$4,$4,16

	lw	$31,20($sp)
$L345:
	jr	$31
	addiu	$sp,$sp,24

$L342:
	sra	$5,$5,16
	lui	$2,%hi(SaveGame+1)
	jal	PlayerSelectMenu
	lb	$4,%lo(SaveGame+1)($2)

	b	$L345
	lw	$31,20($sp)

	.set	macro
	.set	reorder
	.end	PlayerSelectSwitch
	.size	PlayerSelectSwitch, .-PlayerSelectSwitch
	.align	2
	.globl	MapSelectSwitch
	.set	nomips16
	.set	nomicromips
	.ent	MapSelectSwitch
	.type	MapSelectSwitch, @function
MapSelectSwitch:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$17,$4
	move	$16,$5
	move	$18,$6
	sll	$4,$5,16
	jal	MapSelectMenu
	sra	$4,$4,16

	move	$6,$18
	move	$5,$16
	jal	MSelController
	move	$4,$17

	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	MapSelectSwitch
	.size	MapSelectSwitch, .-MapSelectSwitch
	.align	2
	.globl	GameSelectSwitch
	.set	nomips16
	.set	nomicromips
	.ent	GameSelectSwitch
	.type	GameSelectSwitch, @function
GameSelectSwitch:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$17,$4
	move	$16,$5
	lui	$2,%hi(ROptionPressed)
	lw	$2,%lo(ROptionPressed)($2)
	beq	$2,$0,$L350
	move	$18,$6

	addiu	$2,$2,2
	lui	$3,%hi(GlobalFrameCount)
	lw	$3,%lo(GlobalFrameCount)($3)
	sltu	$2,$3,$2
	beq	$2,$0,$L354
	lui	$2,%hi(ROptionPressed)

$L350:
	sll	$2,$16,2
$L355:
	lui	$3,%hi(GlobalController)
	addiu	$3,$3,%lo(GlobalController)
	addu	$2,$2,$3
	lw	$2,0($2)
	lhu	$2,6($2)
	andi	$2,$2,0x10
	beq	$2,$0,$L351
	move	$6,$18

	li	$4,1224736768			# 0x49000000
	jal	playSound
	ori	$4,$4,0x9010

	lui	$2,%hi(GlobalFrameCount)
	lw	$3,%lo(GlobalFrameCount)($2)
	lui	$2,%hi(ROptionPressed)
	sw	$3,%lo(ROptionPressed)($2)
	lw	$31,28($sp)
$L356:
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

$L354:
	sw	$0,%lo(ROptionPressed)($2)
	li	$2,6			# 0x6
	lui	$3,%hi(KBGNumber)
	sw	$2,%lo(KBGNumber)($3)
	lui	$3,%hi(KBGNumberNext)
	sw	$2,%lo(KBGNumberNext)($3)
	lui	$2,%hi(KBGChange)
	li	$3,1			# 0x1
	jal	SetFadeOutTaData
	sw	$3,%lo(KBGChange)($2)

	b	$L355
	sll	$2,$16,2

$L351:
	move	$5,$16
	jal	GSelController
	move	$4,$17

	b	$L356
	lw	$31,28($sp)

	.set	macro
	.set	reorder
	.end	GameSelectSwitch
	.size	GameSelectSwitch, .-GameSelectSwitch
	.align	2
	.globl	DataMenuController
	.set	nomips16
	.set	nomicromips
	.ent	DataMenuController
	.type	DataMenuController, @function
DataMenuController:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(ROptionPressed)
	sw	$0,%lo(ROptionPressed)($2)
	sll	$5,$5,2
	lui	$2,%hi(GlobalController)
	addiu	$2,$2,%lo(GlobalController)
	addu	$5,$5,$2
	lw	$2,0($5)
	lhu	$2,6($2)
	andi	$2,$2,0x4000
	bne	$2,$0,$L363
	lui	$2,%hi(LastMenuID)

	jr	$31
	nop

$L363:
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	lh	$2,%lo(LastMenuID)($2)
	lui	$3,%hi(KBGNumber)
	sw	$2,%lo(KBGNumber)($3)
	lui	$3,%hi(KBGNumberNext)
	sw	$2,%lo(KBGNumberNext)($3)
	lui	$2,%hi(KBGChange)
	li	$3,1			# 0x1
	jal	SetFadeOutB
	sw	$3,%lo(KBGChange)($2)

	lw	$31,20($sp)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	DataMenuController
	.size	DataMenuController, .-DataMenuController
	.align	2
	.globl	TitleMenuSwitch
	.set	nomips16
	.set	nomicromips
	.ent	TitleMenuSwitch
	.type	TitleMenuSwitch, @function
TitleMenuSwitch:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sll	$2,$5,2
	lui	$3,%hi(GlobalController)
	addiu	$3,$3,%lo(GlobalController)
	addu	$2,$2,$3
	lw	$2,0($2)
	lhu	$3,6($2)
	andi	$7,$3,0x300
	bnel	$7,$0,$L386
	lui	$3,%hi(TitleSwitch)

	lhu	$7,12($2)
	andi	$7,$7,0x300
	beq	$7,$0,$L368
	andi	$3,$3,0xc00

	lui	$3,%hi(TitleSwitch)
$L386:
	lw	$3,%lo(TitleSwitch)($3)
	bne	$3,$0,$L369
	lui	$3,%hi(SaveGame+13)

	lui	$3,%hi(SaveGame+14)
	lb	$7,%lo(SaveGame+14)($3)
	li	$3,1			# 0x1
	beq	$7,$3,$L384
	lui	$3,%hi(SaveGame+14)

	li	$7,1			# 0x1
	sb	$7,%lo(SaveGame+14)($3)
$L371:
	lhu	$3,6($2)
	andi	$3,$3,0xc00
	bnel	$3,$0,$L387
	lui	$2,%hi(TitleSwitch)

	lhu	$2,12($2)
	andi	$2,$2,0xc00
	beq	$2,$0,$L375
	lui	$2,%hi(TitleSwitch)

$L387:
	li	$3,1			# 0x1
	sw	$3,%lo(TitleSwitch)($2)
$L375:
	jal	TitleController
	nop

	lw	$31,20($sp)
	jr	$31
	addiu	$sp,$sp,24

$L384:
	b	$L371
	sb	$0,%lo(SaveGame+14)($3)

$L369:
	lb	$7,%lo(SaveGame+13)($3)
	li	$3,1			# 0x1
	beq	$7,$3,$L385
	lui	$3,%hi(SaveGame+13)

	li	$7,1			# 0x1
	sb	$7,%lo(SaveGame+13)($3)
$L373:
	lhu	$3,6($2)
	andi	$3,$3,0xc00
	bnel	$3,$0,$L388
	lui	$2,%hi(TitleSwitch)

	lhu	$2,12($2)
	andi	$2,$2,0xc00
	bne	$2,$0,$L388
	lui	$2,%hi(TitleSwitch)

	b	$L375
	nop

$L385:
	b	$L373
	sb	$0,%lo(SaveGame+13)($3)

$L368:
	bnel	$3,$0,$L389
	lui	$2,%hi(TitleSwitch)

	lhu	$2,12($2)
	andi	$2,$2,0xc00
	beq	$2,$0,$L375
	lui	$2,%hi(TitleSwitch)

$L389:
	lw	$2,%lo(TitleSwitch)($2)
	beq	$2,$0,$L387
	lui	$2,%hi(TitleSwitch)

$L388:
	b	$L375
	sw	$0,%lo(TitleSwitch)($2)

	.set	macro
	.set	reorder
	.end	TitleMenuSwitch
	.size	TitleMenuSwitch, .-TitleMenuSwitch
	.align	2
	.globl	MiniMapDraw
	.set	nomips16
	.set	nomicromips
	.ent	MiniMapDraw
	.type	MiniMapDraw, @function
MiniMapDraw:
	.frame	$sp,72,$31		# vars= 8, regs= 10/0, args= 24, gp= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-72
	sw	$31,68($sp)
	sw	$fp,64($sp)
	sw	$23,60($sp)
	sw	$22,56($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	lui	$2,%hi(SaveGame)
	lb	$3,%lo(SaveGame)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L396
	lui	$16,%hi(g_SimpleObjectArray)

$L391:
	jal	KWReturnViewport
	nop

	jal	KawanoDrawFinal
	nop

	lw	$31,68($sp)
	lw	$fp,64($sp)
	lw	$23,60($sp)
	lw	$22,56($sp)
	lw	$21,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	jr	$31
	addiu	$sp,$sp,72

$L396:
	addiu	$16,$16,%lo(g_SimpleObjectArray)
	addiu	$18,$16,11200
	move	$20,$0
	li	$17,47			# 0x2f
	lui	$fp,%hi(g_mapScale)
	lui	$2,%hi($LC28)
	lw	$23,%lo($LC28)($2)
	lui	$22,%hi(g_mapY)
	lui	$21,%hi(g_mapX)
	lui	$2,%hi(RCIconMap)
	addiu	$2,$2,%lo(RCIconMap)
	b	$L393
	sw	$2,24($sp)

$L392:
$L397:
	beq	$16,$18,$L391
	nop

$L393:
	lh	$2,0($16)
	bnel	$2,$17,$L397
	addiu	$16,$16,112

	addiu	$20,$20,1
	lwc1	$f0,%lo(g_mapScale)($fp)
	li	$2,-2145910784			# 0xffffffff80180000
	ori	$2,$2,0xd2f8
	lhu	$5,0($2)
	lhu	$3,%lo(g_mapY)($22)
	addu	$5,$5,$3
	lhu	$3,-16($2)
	addu	$5,$5,$3
	lh	$4,-64($2)
	srl	$3,$4,31
	addu	$3,$3,$4
	sra	$3,$3,1
	subu	$5,$5,$3
	lwc1	$f2,32($16)
	mul.s	$f2,$f0,$f2
	trunc.w.s $f2,$f2
	mfc1	$3,$f2
	nop
	addu	$5,$3,$5
	lhu	$4,-8($2)
	lhu	$3,%lo(g_mapX)($21)
	addu	$4,$4,$3
	lhu	$3,-24($2)
	addu	$4,$4,$3
	lh	$3,-72($2)
	srl	$2,$3,31
	addu	$2,$2,$3
	sra	$2,$2,1
	subu	$2,$4,$2
	lwc1	$f2,24($16)
	mul.s	$f0,$f0,$f2
	trunc.w.s $f0,$f0
	mfc1	$4,$f0
	nop
	addu	$4,$4,$2
	li	$19,8			# 0x8
	sw	$19,20($sp)
	sw	$19,16($sp)
	lw	$7,24($sp)
	move	$6,$23
	sll	$5,$5,16
	sra	$5,$5,16
	sll	$4,$4,16
	jal	KWSpriteScale
	sra	$4,$4,16

	bne	$20,$19,$L392
	addiu	$16,$16,112

	b	$L391
	nop

	.set	macro
	.set	reorder
	.end	MiniMapDraw
	.size	MiniMapDraw, .-MiniMapDraw
	.globl	TitleSwitch
	.section	.bss,"aw",@nobits
	.align	2
	.type	TitleSwitch, @object
	.size	TitleSwitch, 4
TitleSwitch:
	.space	4
	.globl	GameMenuIndex
	.type	GameMenuIndex, @object
	.size	GameMenuIndex, 1
GameMenuIndex:
	.space	1
	.section	.rodata.cst4,"aM",@progbits,4
	.align	2
$LC11:
	.word	1148846080
	.align	2
$LC12:
	.word	931135488
	.align	2
$LC13:
	.word	1135869952
	.align	2
$LC22:
	.word	1065353216
	.align	2
$LC24:
	.word	1063675494
	.align	2
$LC28:
	.word	1056964608
	.ident	"GCC: (GNU) 10.1.0"
