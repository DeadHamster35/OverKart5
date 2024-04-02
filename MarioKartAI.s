	.file	1 "MarioKartAI.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.globl	fastAI
	.set	nomips16
	.set	nomicromips
	.ent	fastAI
	.type	fastAI, @function
fastAI:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(g_raceClass)
	lw	$2,%lo(g_raceClass)($2)
	li	$3,1			# 0x1
	beq	$2,$3,$L2
	li	$3,2			# 0x2

	beq	$2,$3,$L3
	lui	$3,%hi($LC2)

	beq	$2,$0,$L21
	lui	$3,%hi($LC0)

$L4:
	lui	$2,%hi(g_startingIndicator)
	lw	$2,%lo(g_startingIndicator)($2)
	slt	$3,$2,3
	beq	$3,$0,$L5
	li	$3,3			# 0x3

	lui	$2,%hi(GlobalCharC)
	lb	$2,%lo(GlobalCharC)($2)
	bne	$2,$0,$L28
	lui	$2,%hi(g_gameTimer)

	lui	$2,%hi(GlobalCharC)
	li	$3,1			# 0x1
	sb	$3,%lo(GlobalCharC)($2)
$L7:
	lui	$2,%hi(g_gameTimer)
$L28:
	lwc1	$f2,%lo(g_gameTimer)($2)
	lui	$2,%hi($LC3)
	lwc1	$f0,%lo($LC3)($2)
	c.lt.s	$f0,$f2
	nop
	bc1f	$L33
	lui	$2,%hi(g_playerCount)

	lw	$2,%lo(g_playerCount)($2)
	li	$3,2			# 0x2
	beq	$2,$3,$L15
	slt	$3,$2,3

	bne	$3,$0,$L22
	li	$3,3			# 0x3

	beq	$2,$3,$L16
	li	$3,4			# 0x4

	bne	$2,$3,$L33
	lui	$2,%hi(GlobalFloatA)

$L30:
	lwc1	$f0,%lo(GlobalFloatA)($2)
	trunc.w.s $f0,$f0
	lui	$3,%hi(cpu2Speed)
	swc1	$f0,%lo(cpu2Speed)($3)
	lui	$3,%hi(cpu3Speed)
	swc1	$f0,%lo(cpu3Speed)($3)
	lui	$3,%hi(cpu4Speed)
	jr	$31
	swc1	$f0,%lo(cpu4Speed)($3)

$L21:
	lui	$2,%hi(GlobalFloatA)
	lwc1	$f0,%lo($LC0)($3)
	b	$L4
	swc1	$f0,%lo(GlobalFloatA)($2)

$L2:
	lui	$3,%hi($LC1)
	lui	$2,%hi(GlobalFloatA)
	lwc1	$f0,%lo($LC1)($3)
	b	$L4
	swc1	$f0,%lo(GlobalFloatA)($2)

$L3:
	lui	$2,%hi(GlobalFloatA)
	lwc1	$f0,%lo($LC2)($3)
	b	$L4
	swc1	$f0,%lo(GlobalFloatA)($2)

$L5:
	bne	$2,$3,$L7
	lui	$2,%hi(GlobalCharC)

	lb	$3,%lo(GlobalCharC)($2)
	li	$2,1			# 0x1
	bne	$3,$2,$L28
	lui	$2,%hi(g_gameTimer)

	lui	$2,%hi(GlobalCharC)
	sb	$0,%lo(GlobalCharC)($2)
	lui	$2,%hi(g_playerCount)
	lw	$2,%lo(g_playerCount)($2)
	li	$3,3			# 0x3
	beq	$2,$3,$L8
	slt	$3,$2,4

	beq	$3,$0,$L9
	li	$3,1			# 0x1

	beq	$2,$3,$L10
	li	$3,2			# 0x2

	bne	$2,$3,$L33
	lui	$2,%hi(boost2)

	li	$3,2			# 0x2
	sb	$3,%lo(boost2)($2)
	lui	$2,%hi(g_gameTimer)
	lwc1	$f2,%lo(g_gameTimer)($2)
	lui	$2,%hi($LC3)
	lwc1	$f0,%lo($LC3)($2)
	c.lt.s	$f0,$f2
	nop
	bc1t	$L29
	lui	$2,%hi(GlobalFloatA)

$L33:
	jr	$31
	nop

$L9:
	li	$3,4			# 0x4
	bne	$2,$3,$L33
	li	$2,2			# 0x2

	lui	$3,%hi(boost2)
	sb	$2,%lo(boost2)($3)
	lui	$3,%hi(boost3)
	sb	$2,%lo(boost3)($3)
	lui	$3,%hi(boost4)
	sb	$2,%lo(boost4)($3)
	lui	$2,%hi(g_gameTimer)
	lwc1	$f2,%lo(g_gameTimer)($2)
	lui	$2,%hi($LC3)
	lwc1	$f0,%lo($LC3)($2)
	c.lt.s	$f0,$f2
	nop
	bc1t	$L30
	lui	$2,%hi(GlobalFloatA)

	jr	$31
	nop

$L10:
	li	$2,2			# 0x2
	lui	$3,%hi(boost2)
	sb	$2,%lo(boost2)($3)
	lui	$3,%hi(boost3)
	sb	$2,%lo(boost3)($3)
	lui	$3,%hi(boost4)
	sb	$2,%lo(boost4)($3)
	lui	$2,%hi(g_gameTimer)
	lwc1	$f2,%lo(g_gameTimer)($2)
	lui	$2,%hi($LC3)
	lwc1	$f0,%lo($LC3)($2)
	c.lt.s	$f0,$f2
	nop
	bc1t	$L31
	lui	$2,%hi(GlobalFloatA)

	jr	$31
	nop

$L8:
	li	$2,2			# 0x2
	lui	$3,%hi(boost2)
	sb	$2,%lo(boost2)($3)
	lui	$3,%hi(boost3)
	sb	$2,%lo(boost3)($3)
	lui	$2,%hi(g_gameTimer)
	lwc1	$f2,%lo(g_gameTimer)($2)
	lui	$2,%hi($LC3)
	lwc1	$f0,%lo($LC3)($2)
	c.lt.s	$f0,$f2
	nop
	bc1f	$L32
	nop

$L16:
	lui	$2,%hi(GlobalFloatA)
	lwc1	$f0,%lo(GlobalFloatA)($2)
	trunc.w.s $f0,$f0
	lui	$3,%hi(cpu2Speed)
	swc1	$f0,%lo(cpu2Speed)($3)
	lui	$3,%hi(cpu3Speed)
	jr	$31
	swc1	$f0,%lo(cpu3Speed)($3)

$L22:
	li	$3,1			# 0x1
	bne	$2,$3,$L33
	lui	$2,%hi(GlobalFloatA)

$L31:
	lwc1	$f0,%lo(GlobalFloatA)($2)
	trunc.w.s $f0,$f0
	lui	$3,%hi(cpu2Speed)
	swc1	$f0,%lo(cpu2Speed)($3)
	lui	$3,%hi(cpu3Speed)
	swc1	$f0,%lo(cpu3Speed)($3)
	lui	$3,%hi(cpu4Speed)
	jr	$31
	swc1	$f0,%lo(cpu4Speed)($3)

$L32:
	jr	$31
	nop

$L15:
	lui	$2,%hi(GlobalFloatA)
$L29:
	lwc1	$f0,%lo(GlobalFloatA)($2)
	trunc.w.s $f0,$f0
	lui	$3,%hi(cpu2Speed)
	jr	$31
	swc1	$f0,%lo(cpu2Speed)($3)

	.set	macro
	.set	reorder
	.end	fastAI
	.size	fastAI, .-fastAI
	.align	2
	.globl	aiSetup
	.set	nomips16
	.set	nomicromips
	.ent	aiSetup
	.type	aiSetup, @function
aiSetup:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(SaveGame+5)
	lb	$2,%lo(SaveGame+5)($2)
	li	$3,2			# 0x2
	beq	$2,$3,$L35
	move	$4,$2

	slt	$3,$2,3
	beq	$3,$0,$L36
	li	$3,3			# 0x3

	beq	$2,$0,$L50
	li	$3,1			# 0x1

	bne	$2,$3,$L39
	li	$3,1			# 0x1

	lui	$5,%hi(player2OK)
	sb	$3,%lo(player2OK)($5)
	lui	$5,%hi(player3OK)
	sb	$3,%lo(player3OK)($5)
	lui	$5,%hi(player4OK)
	sb	$3,%lo(player4OK)($5)
$L41:
	lui	$3,%hi(g_startingIndicator)
	lw	$3,%lo(g_startingIndicator)($3)
	addiu	$3,$3,-3
	sltu	$3,$3,4
	bne	$3,$0,$L48
	sll	$5,$2,2

$L50:
	jr	$31
	nop

$L36:
	bne	$2,$3,$L39
	lui	$3,%hi(player4OK)

	li	$5,1			# 0x1
	b	$L41
	sb	$5,%lo(player4OK)($3)

$L35:
	li	$3,1			# 0x1
	lui	$5,%hi(player3OK)
	sb	$3,%lo(player3OK)($5)
	lui	$5,%hi(player4OK)
	b	$L41
	sb	$3,%lo(player4OK)($5)

$L39:
	lui	$3,%hi(g_startingIndicator)
	lw	$3,%lo(g_startingIndicator)($3)
	addiu	$3,$3,-3
	sltu	$3,$3,4
	beq	$3,$0,$L50
	slt	$3,$2,4

	beq	$3,$0,$L50
	sll	$5,$2,2

$L48:
	lui	$3,%hi(GlobalLap)
	addiu	$3,$3,%lo(GlobalLap)
	addu	$3,$3,$5
	sll	$5,$2,3
	subu	$5,$5,$2
	sll	$5,$5,4
	subu	$5,$5,$2
	sll	$5,$5,2
	subu	$2,$5,$2
	sll	$2,$2,3
	lui	$5,%hi(GlobalPlayer)
	addiu	$5,$5,%lo(GlobalPlayer)
	addu	$5,$5,$2
	b	$L43
	li	$6,-28672			# 0xffffffffffff9000

$L42:
	addiu	$4,$4,1
$L47:
	addiu	$3,$3,4
	slt	$2,$4,4
	beq	$2,$0,$L50
	addiu	$5,$5,3544

$L43:
	lw	$2,0($3)
	lw	$2,0($2)
	slt	$2,$2,3
	bnel	$2,$0,$L42
	sh	$6,0($5)

	b	$L47
	addiu	$4,$4,1

	.set	macro
	.set	reorder
	.end	aiSetup
	.size	aiSetup, .-aiSetup
	.align	2
	.globl	RubberBandMan
	.set	nomips16
	.set	nomicromips
	.ent	RubberBandMan
	.type	RubberBandMan, @function
RubberBandMan:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(scrollLock)
	lbu	$2,%lo(scrollLock)($2)
	beq	$2,$0,$L69
	nop

	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$16,16($sp)
	move	$16,$4
	lui	$2,%hi(g_EnemyTargetPlayer)
	lh	$6,%lo(g_EnemyTargetPlayer)($2)
	lui	$2,%hi(g_raceClass)
	lw	$2,%lo(g_raceClass)($2)
	sll	$2,$2,1
	lui	$3,%hi(RubberCheck)
	addiu	$3,$3,%lo(RubberCheck)
	addu	$2,$2,$3
	lh	$7,0($2)
	lwc1	$f2,148($5)
	cvt.d.s	$f2,$f2
	mtc1	$7,$f0
	nop
	cvt.d.w	$f0,$f0
	lui	$2,%hi($LC4)
	ldc1	$f4,%lo($LC4)($2)
	mul.d	$f0,$f0,$f4
	lui	$2,%hi($LC5)
	ldc1	$f4,%lo($LC5)($2)
	div.d	$f0,$f0,$f4
	c.lt.d	$f2,$f0
	nop
	bc1t	$L65
	move	$4,$5

	sll	$3,$16,2
	lui	$2,%hi(g_GameLapTable)
	addiu	$2,$2,%lo(g_GameLapTable)
	addu	$3,$3,$2
	lw	$3,0($3)
	sll	$5,$6,2
	addu	$2,$5,$2
	lw	$2,0($2)
	slt	$5,$3,$2
	bne	$5,$0,$L66
	sll	$5,$16,1

	lui	$8,%hi(g_playerPathPointTable)
	addiu	$8,$8,%lo(g_playerPathPointTable)
	addu	$5,$5,$8
	beq	$3,$2,$L67
	lh	$5,0($5)

	slt	$3,$2,$3
	beq	$3,$0,$L68
	lw	$31,20($sp)

	slt	$7,$5,$7
	beq	$7,$0,$L58
	lui	$2,%hi($LC6)

	jal	AccelOn
	nop

	lui	$2,%hi(RubberChar)
	addiu	$2,$2,%lo(RubberChar)
	addu	$16,$16,$2
	li	$2,4			# 0x4
	b	$L51
	sb	$2,0($16)

$L65:
	jal	AccelOn
	nop

	lui	$4,%hi(RubberChar)
	addiu	$4,$4,%lo(RubberChar)
	addu	$16,$16,$4
	sb	$0,0($16)
$L51:
	lw	$31,20($sp)
$L68:
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

$L66:
	jal	AccelOn
	nop

	lui	$4,%hi(RubberChar)
	addiu	$4,$4,%lo(RubberChar)
	addu	$16,$16,$4
	li	$2,1			# 0x1
	b	$L51
	sb	$2,0($16)

$L67:
	sll	$6,$6,1
	addu	$6,$6,$8
	lh	$2,0($6)
	addu	$7,$2,$7
	slt	$7,$5,$7
	beq	$7,$0,$L57
	lui	$2,%hi($LC6)

	jal	AccelOn
	nop

	lui	$2,%hi(RubberChar)
	addiu	$2,$2,%lo(RubberChar)
	addu	$16,$16,$2
	li	$2,2			# 0x2
	b	$L51
	sb	$2,0($16)

$L57:
	jal	AccelOff
	lw	$5,%lo($LC6)($2)

	lui	$2,%hi(RubberChar)
	addiu	$2,$2,%lo(RubberChar)
	addu	$16,$16,$2
	li	$2,3			# 0x3
	b	$L51
	sb	$2,0($16)

$L58:
	jal	AccelOff
	lw	$5,%lo($LC6)($2)

	lui	$2,%hi(RubberChar)
	addiu	$2,$2,%lo(RubberChar)
	addu	$16,$16,$2
	li	$2,5			# 0x5
	b	$L51
	sb	$2,0($16)

$L69:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	RubberBandMan
	.size	RubberBandMan, .-RubberBandMan
	.align	2
	.globl	SetAIDifficulty
	.set	nomips16
	.set	nomicromips
	.ent	SetAIDifficulty
	.type	SetAIDifficulty, @function
SetAIDifficulty:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(g_playerCount)
	lw	$3,%lo(g_playerCount)($2)
	slt	$2,$3,8
	beq	$2,$0,$L74
	sll	$4,$4,1

	lui	$2,%hi(DifficultyCurve)
	addiu	$2,$2,%lo(DifficultyCurve)
	addu	$4,$4,$2
	lh	$2,0($4)
	mtc1	$2,$f0
	nop
	cvt.s.w	$f2,$f0
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,4
	subu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$4,$2,3
	lui	$2,%hi(GlobalPlayer)
	addiu	$2,$2,%lo(GlobalPlayer)
	addu	$2,$2,$4
	li	$4,8			# 0x8
$L72:
	lwc1	$f0,532($2)
	add.s	$f0,$f0,$f2
	swc1	$f0,532($2)
	addiu	$3,$3,1
	bne	$3,$4,$L72
	addiu	$2,$2,3544

$L74:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	SetAIDifficulty
	.size	SetAIDifficulty, .-SetAIDifficulty
	.globl	DifficultyCurve
	.data
	.align	2
	.type	DifficultyCurve, @object
	.size	DifficultyCurve, 8
DifficultyCurve:
	.half	0
	.half	5
	.half	10
	.half	12
	.globl	RubberChar
	.section	.bss,"aw",@nobits
	.align	2
	.type	RubberChar, @object
	.size	RubberChar, 8
RubberChar:
	.space	8
	.globl	RubberCheck
	.data
	.align	2
	.type	RubberCheck, @object
	.size	RubberCheck, 8
RubberCheck:
	.half	10
	.half	20
	.half	25
	.half	28
	.section	.rodata.cst4,"aM",@progbits,4
	.align	2
$LC0:
	.word	1140391936
	.align	2
$LC1:
	.word	1140948992
	.align	2
$LC2:
	.word	1141145600
	.align	2
$LC3:
	.word	1084227584
	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
$LC4:
	.word	1077018624
	.word	0
	.align	3
$LC5:
	.word	1080754176
	.word	0
	.section	.rodata.cst4
	.align	2
$LC6:
	.word	1065353216
	.ident	"GCC: (GNU) 10.1.0"
