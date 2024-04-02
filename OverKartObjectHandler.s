	.file	1 "OverKartObjectHandler.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.globl	DrawPerScreen
	.set	nomips16
	.set	nomicromips
	.ent	DrawPerScreen
	.type	DrawPerScreen, @function
DrawPerScreen:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(scrollLock)
	lbu	$2,%lo(scrollLock)($2)
	beq	$2,$0,$L14
	nop

	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$16,16($sp)
	lui	$2,%hi(HotSwapID)
	lh	$2,%lo(HotSwapID)($2)
	bgtz	$2,$L10
	move	$16,$4

	lui	$2,%hi(g_gameMode)
$L12:
	lw	$3,%lo(g_gameMode)($2)
	li	$2,3			# 0x3
	beq	$3,$2,$L11
	lui	$2,%hi(SaveGame+24)

	lw	$31,20($sp)
$L13:
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

$L10:
	jal	DrawOKObjects
	nop

	b	$L12
	lui	$2,%hi(g_gameMode)

$L11:
	lb	$2,%lo(SaveGame+24)($2)
	li	$3,1			# 0x1
	beq	$2,$3,$L4
	li	$3,2			# 0x2

	bnel	$2,$3,$L13
	lw	$31,20($sp)

	jal	DrawGameFlags
	move	$4,$16

	b	$L13
	lw	$31,20($sp)

$L4:
	jal	DrawGameFlags
	move	$4,$16

	jal	DrawGameBase
	move	$4,$16

	b	$L13
	lw	$31,20($sp)

$L14:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	DrawPerScreen
	.size	DrawPerScreen, .-DrawPerScreen
	.align	2
	.globl	loadCoin
	.set	nomips16
	.set	nomicromips
	.ent	loadCoin
	.type	loadCoin, @function
loadCoin:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, gp= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lui	$19,%hi(ok_ModelData)
	addiu	$19,$19,%lo(ok_ModelData)
	move	$5,$19
	jal	SetSegment
	li	$4,8			# 0x8

	lui	$18,%hi(sourceAddress)
	lw	$3,%lo(sourceAddress)($18)
	lui	$2,%hi(ModelDataStart)
	addiu	$2,$2,%lo(ModelDataStart)
	sw	$2,0($3)
	lui	$17,%hi(targetAddress)
	lw	$2,%lo(targetAddress)($17)
	lui	$16,%hi(ok_FreeSpace)
	addiu	$16,$16,%lo(ok_FreeSpace)
	sw	$16,0($2)
	lui	$20,%hi(dataLength)
	li	$2,61608			# 0xf0a8
	jal	runDMA
	sw	$2,%lo(dataLength)($20)

	lw	$2,%lo(sourceAddress)($18)
	sw	$16,0($2)
	lw	$2,%lo(targetAddress)($17)
	jal	runMIO
	sw	$19,0($2)

	lw	$3,%lo(sourceAddress)($18)
	lui	$2,%hi(RCSpriteROM)
	addiu	$2,$2,%lo(RCSpriteROM)
	sw	$2,0($3)
	lw	$2,%lo(targetAddress)($17)
	sw	$16,0($2)
	li	$2,516			# 0x204
	jal	runDMA
	sw	$2,%lo(dataLength)($20)

	lw	$2,%lo(sourceAddress)($18)
	sw	$16,0($2)
	lw	$3,%lo(targetAddress)($17)
	lui	$2,%hi(ok_RedCoinSprite)
	addiu	$2,$2,%lo(ok_RedCoinSprite)
	jal	runMIO
	sw	$2,0($3)

	lw	$31,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,40

	.set	macro
	.set	reorder
	.end	loadCoin
	.size	loadCoin, .-loadCoin
	.align	2
	.globl	DropCoins
	.set	nomips16
	.set	nomicromips
	.ent	DropCoins
	.type	DropCoins, @function
DropCoins:
	.frame	$sp,80,$31		# vars= 0, regs= 9/4, args= 24, gp= 0
	.mask	0x80ff0000,-20
	.fmask	0x00f00000,-8
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-80
	sw	$31,60($sp)
	sw	$23,56($sp)
	sw	$22,52($sp)
	sw	$21,48($sp)
	sw	$20,44($sp)
	sw	$19,40($sp)
	sw	$18,36($sp)
	sw	$17,32($sp)
	sw	$16,28($sp)
	sdc1	$f22,72($sp)
	sdc1	$f20,64($sp)
	move	$17,$4
	sll	$5,$4,1
	lui	$2,%hi(IFrames)
	addiu	$2,$2,%lo(IFrames)
	addu	$2,$5,$2
	li	$3,90			# 0x5a
	sh	$3,0($2)
	lui	$4,%hi(objectPosition)
	lui	$3,%hi(GlobalPlayer)
	sll	$2,$17,3
	subu	$2,$2,$17
	sll	$2,$2,4
	subu	$2,$2,$17
	sll	$2,$2,2
	subu	$2,$2,$17
	sll	$2,$2,3
	addiu	$3,$3,%lo(GlobalPlayer)
	addu	$2,$3,$2
	lwc1	$f0,20($2)
	swc1	$f0,%lo(objectPosition)($4)
	addiu	$3,$4,%lo(objectPosition)
	lwc1	$f0,24($2)
	swc1	$f0,4($3)
	lwc1	$f0,28($2)
	swc1	$f0,8($3)
	lui	$2,%hi(CoinCount)
	addiu	$2,$2,%lo(CoinCount)
	addu	$5,$5,$2
	lh	$2,0($5)
	blez	$2,$L18
	move	$18,$0

	lui	$22,%hi(objectVelocity)
	addiu	$16,$22,%lo(objectVelocity)
	lui	$2,%hi($LC0)
	lwc1	$f22,%lo($LC0)($2)
	lui	$20,%hi(GlobalPlayer)
	sll	$2,$17,3
	subu	$2,$2,$17
	sll	$2,$2,4
	subu	$2,$2,$17
	sll	$2,$2,2
	subu	$2,$2,$17
	sll	$2,$2,3
	addiu	$20,$20,%lo(GlobalPlayer)
	addu	$20,$20,$2
	lui	$2,%hi($LC1)
	lwc1	$f20,%lo($LC1)($2)
	lui	$21,%hi(objectAngle)
	addiu	$21,$21,%lo(objectAngle)
	lui	$2,%hi($LC2)
	lw	$23,%lo($LC2)($2)
	move	$19,$5
$L19:
	jal	MakeRandomLimmit
	li	$4,6			# 0x6

	addiu	$2,$2,-3
	mtc1	$2,$f0
	nop
	cvt.s.w	$f0,$f0
	swc1	$f0,%lo(objectVelocity)($22)
	swc1	$f22,4($16)
	jal	MakeRandomLimmit
	li	$4,8			# 0x8

	addiu	$2,$2,-4
	mtc1	$2,$f0
	nop
	cvt.s.w	$f0,$f0
	swc1	$f0,8($16)
	lh	$5,46($20)
	jal	MakeAlignVector
	move	$4,$16

	swc1	$f20,16($sp)
	li	$7,48			# 0x30
	move	$6,$16
	move	$5,$21
	lui	$4,%hi(objectPosition)
	jal	MasterCreateObject
	addiu	$4,$4,%lo(objectPosition)

	move	$5,$23
	sll	$4,$17,24
	jal	ChangeMaxSpeed
	sra	$4,$4,24

	addiu	$18,$18,1
	lh	$2,0($19)
	slt	$2,$18,$2
	bne	$2,$0,$L19
	nop

$L18:
	sll	$17,$17,1
	lui	$2,%hi(CoinCount)
	addiu	$2,$2,%lo(CoinCount)
	addu	$17,$17,$2
	sh	$0,0($17)
	lw	$31,60($sp)
	lw	$23,56($sp)
	lw	$22,52($sp)
	lw	$21,48($sp)
	lw	$20,44($sp)
	lw	$19,40($sp)
	lw	$18,36($sp)
	lw	$17,32($sp)
	lw	$16,28($sp)
	ldc1	$f22,72($sp)
	ldc1	$f20,64($sp)
	jr	$31
	addiu	$sp,$sp,80

	.set	macro
	.set	reorder
	.end	DropCoins
	.size	DropCoins, .-DropCoins
	.align	2
	.globl	CheckHit
	.set	nomips16
	.set	nomicromips
	.ent	CheckHit
	.type	CheckHit, @function
CheckHit:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$16,16($sp)
	lui	$2,%hi(SaveGame)
	lb	$3,%lo(SaveGame)($2)
	li	$2,2			# 0x2
	beq	$3,$2,$L26
	move	$16,$4

	lui	$2,%hi(g_gameMode)
$L28:
	lw	$3,%lo(g_gameMode)($2)
	li	$2,3			# 0x3
	beq	$3,$2,$L27
	nop

	lw	$31,20($sp)
$L29:
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

$L26:
	jal	DropCoins
	nop

	b	$L28
	lui	$2,%hi(g_gameMode)

$L27:
	jal	DropFlag
	move	$4,$16

	b	$L29
	lw	$31,20($sp)

	.set	macro
	.set	reorder
	.end	CheckHit
	.size	CheckHit, .-CheckHit
	.align	2
	.globl	ItemboxCollideCheck
	.set	nomips16
	.set	nomicromips
	.ent	ItemboxCollideCheck
	.type	ItemboxCollideCheck, @function
ItemboxCollideCheck:
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
	jal	CollisionSphere
	move	$16,$5

	beql	$2,$0,$L31
	lh	$2,6($16)

	li	$2,3			# 0x3
	sh	$2,6($16)
	li	$2,-32768			# 0xffffffffffff8000
	sh	$2,2($16)
	sh	$0,4($16)
	lhu	$2,0($17)
	andi	$2,$2,0x4000
	beq	$2,$0,$L46
	lw	$31,28($sp)

	lui	$2,%hi(g_PlayerStructTable)
	addiu	$2,$2,%lo(g_PlayerStructTable)
	subu	$2,$17,$2
	li	$4,1240924160			# 0x49f70000
	ori	$4,$4,0xe8e3
	mult	$2,$4
	mfhi	$4
	sra	$4,$4,10
	sra	$2,$2,31
	lw	$5,108($16)
	bne	$5,$0,$L45
	subu	$18,$4,$2

	lui	$2,%hi(SaveGame+4)
	lb	$2,%lo(SaveGame+4)($2)
	li	$3,1			# 0x1
	beq	$2,$3,$L34
	li	$3,2			# 0x2

	beql	$2,$3,$L35
	lh	$2,4($17)

	bnel	$2,$0,$L47
	lw	$18,24($sp)

	move	$5,$0
	jal	RouletteStart
	move	$4,$18

	b	$L46
	lw	$31,28($sp)

$L45:
	jal	RouletteStart
	move	$4,$18

	b	$L46
	lw	$31,28($sp)

$L34:
	jal	MakeRandomLimmit
	li	$4,14			# 0xe

	sll	$3,$2,16
	sra	$3,$3,16
	slt	$4,$3,14
	bne	$4,$0,$L36
	addiu	$2,$2,1

	lui	$2,%hi(GlobalShortA)
	sh	$3,%lo(GlobalShortA)($2)
$L37:
	lui	$2,%hi(GlobalShortA)
	lh	$5,%lo(GlobalShortA)($2)
	jal	RouletteStart
	move	$4,$18

	b	$L46
	lw	$31,28($sp)

$L36:
	lui	$3,%hi(GlobalShortA)
	b	$L37
	sh	$2,%lo(GlobalShortA)($3)

$L35:
	slt	$3,$2,6
	beq	$3,$0,$L38
	slt	$3,$2,3

	beq	$3,$0,$L39
	nop

	beq	$2,$0,$L40
	addiu	$2,$2,-1

	andi	$2,$2,0xffff
	sltu	$2,$2,2
	beq	$2,$0,$L48
	lui	$2,%hi(GlobalShortA)

	jal	MakeRandomLimmit
	li	$4,16			# 0x10

	lui	$3,%hi(BalancedItemSetB)
	addiu	$3,$3,%lo(BalancedItemSetB)
	addu	$3,$3,$2
	lb	$3,0($3)
	lui	$2,%hi(GlobalShortA)
	sh	$3,%lo(GlobalShortA)($2)
	lui	$2,%hi(GlobalShortA)
$L48:
$L49:
$L50:
	lh	$5,%lo(GlobalShortA)($2)
	jal	RouletteStart
	move	$4,$18

	b	$L46
	lw	$31,28($sp)

$L38:
	addiu	$2,$2,-6
	andi	$2,$2,0xffff
	sltu	$2,$2,2
	beq	$2,$0,$L48
	lui	$2,%hi(GlobalShortA)

	jal	MakeRandomLimmit
	li	$4,16			# 0x10

	lui	$3,%hi(BalancedItemSetD)
	addiu	$3,$3,%lo(BalancedItemSetD)
	addu	$3,$3,$2
	lb	$3,0($3)
	lui	$2,%hi(GlobalShortA)
	b	$L48
	sh	$3,%lo(GlobalShortA)($2)

$L40:
	jal	MakeRandomLimmit
	li	$4,16			# 0x10

	lui	$3,%hi(BalancedItemSetA)
	addiu	$3,$3,%lo(BalancedItemSetA)
	addu	$3,$3,$2
	lb	$3,0($3)
	lui	$2,%hi(GlobalShortA)
	b	$L49
	sh	$3,%lo(GlobalShortA)($2)

$L39:
	jal	MakeRandomLimmit
	li	$4,16			# 0x10

	lui	$3,%hi(BalancedItemSetC)
	addiu	$3,$3,%lo(BalancedItemSetC)
	addu	$3,$3,$2
	lb	$3,0($3)
	lui	$2,%hi(GlobalShortA)
	b	$L50
	sh	$3,%lo(GlobalShortA)($2)

$L31:
	bne	$2,$0,$L46
	lw	$31,28($sp)

	li	$2,1			# 0x1
	sh	$2,6($16)
	li	$2,-32768			# 0xffffffffffff8000
	sh	$2,2($16)
	lw	$31,28($sp)
$L46:
	lw	$18,24($sp)
$L47:
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	ItemboxCollideCheck
	.size	ItemboxCollideCheck, .-ItemboxCollideCheck
	.align	2
	.globl	Draw3DRacer
	.set	nomips16
	.set	nomicromips
	.ent	Draw3DRacer
	.type	Draw3DRacer, @function
Draw3DRacer:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(SaveGame+11)
	lb	$2,%lo(SaveGame+11)($2)
	bne	$2,$0,$L52
	li	$2,666697728			# 0x27bd0000

	ori	$2,$2,0xffa0
	lui	$3,%hi(spriteKillA)
	sw	$2,%lo(spriteKillA)($3)
	li	$3,-20545			# 0xffffffffffffafbf
	lui	$4,%hi(spriteKillB)
	sh	$3,%lo(spriteKillB)($4)
	addiu	$2,$2,72
	lui	$4,%hi(spriteKillC)
	sw	$2,%lo(spriteKillC)($4)
	lui	$2,%hi(spriteKillD)
	jr	$31
	sh	$3,%lo(spriteKillD)($2)

$L52:
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	move	$7,$5
	li	$2,65011712			# 0x3e00000
	addiu	$2,$2,8
	lui	$3,%hi(spriteKillA)
	sw	$2,%lo(spriteKillA)($3)
	li	$3,9216			# 0x2400
	lui	$5,%hi(spriteKillB)
	sh	$3,%lo(spriteKillB)($5)
	lui	$5,%hi(spriteKillC)
	sw	$2,%lo(spriteKillC)($5)
	lui	$2,%hi(spriteKillD)
	sh	$3,%lo(spriteKillD)($2)
	lui	$6,%hi(g_PlayerStructTable)
	addiu	$6,$6,%lo(g_PlayerStructTable)
	lui	$2,%hi(GlobalUIntA)
	sw	$6,%lo(GlobalUIntA)($2)
	lui	$5,%hi(objectPosition)
	lui	$8,%hi(GlobalPlayer)
	addiu	$8,$8,%lo(GlobalPlayer)
	sll	$2,$7,3
	subu	$3,$2,$7
	sll	$3,$3,4
	subu	$3,$3,$7
	sll	$3,$3,2
	subu	$3,$3,$7
	sll	$3,$3,3
	addu	$3,$8,$3
	lh	$9,44($3)
	mtc1	$9,$f0
	nop
	cvt.s.w	$f0,$f0
	swc1	$f0,%lo(objectPosition)($5)
	addiu	$5,$5,%lo(objectPosition)
	lh	$9,46($3)
	lh	$10,120($3)
	addu	$9,$9,$10
	mtc1	$9,$f0
	nop
	cvt.s.w	$f0,$f0
	swc1	$f0,4($5)
	lh	$3,48($3)
	mtc1	$3,$f0
	nop
	cvt.s.w	$f0,$f0
	swc1	$f0,8($5)
	lui	$10,%hi(objectAngle)
	addiu	$5,$10,%lo(objectAngle)
	lui	$3,%hi(baseTurn)
	lhu	$3,%lo(baseTurn)($3)
	lui	$9,%hi(addTurn)
	lhu	$9,%lo(addTurn)($9)
	addu	$3,$3,$9
	sh	$3,4($5)
	lhu	$3,518($6)
	sll	$9,$3,1
	li	$3,16383			# 0x3fff
	subu	$3,$3,$9
	sh	$3,%lo(objectAngle)($10)
	lhu	$3,80($6)
	subu	$3,$0,$3
	sll	$3,$3,1
	sh	$3,2($5)
	subu	$2,$2,$7
	sll	$2,$2,4
	subu	$2,$2,$7
	sll	$2,$2,2
	subu	$2,$2,$7
	sll	$2,$2,3
	addiu	$2,$2,20
	lui	$3,%hi($LC3)
	lw	$7,%lo($LC3)($3)
	move	$6,$4
	jal	DrawGeometryScale
	addu	$4,$8,$2

	lw	$31,20($sp)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	Draw3DRacer
	.size	Draw3DRacer, .-Draw3DRacer
	.align	2
	.globl	DisplayObject
	.set	nomips16
	.set	nomicromips
	.ent	DisplayObject
	.type	DisplayObject, @function
DisplayObject:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$16,16($sp)
	lh	$2,0($5)
	li	$3,48			# 0x30
	beq	$2,$3,$L58
	move	$16,$5

	li	$3,49			# 0x31
	beq	$2,$3,$L59
	li	$3,47			# 0x2f

	beq	$2,$3,$L65
	lui	$2,%hi(RedCoin)

	lw	$31,20($sp)
$L67:
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

$L65:
	lw	$6,%lo(RedCoin)($2)
	lui	$2,%hi(GlobalAddressB)
	sw	$6,%lo(GlobalAddressB)($2)
	lui	$4,%hi(objectPosition)
	lwc1	$f0,24($5)
	swc1	$f0,%lo(objectPosition)($4)
	addiu	$4,$4,%lo(objectPosition)
	lwc1	$f0,28($5)
	swc1	$f0,4($4)
	lwc1	$f0,32($5)
	swc1	$f0,8($4)
	lhu	$2,18($5)
	addiu	$2,$2,546
	sll	$2,$2,16
	sra	$2,$2,16
	sh	$2,18($5)
	lui	$5,%hi(objectAngle)
	lhu	$3,16($16)
	sh	$3,%lo(objectAngle)($5)
	addiu	$5,$5,%lo(objectAngle)
	sh	$2,2($5)
	lhu	$2,20($16)
	sh	$2,4($5)
	lui	$2,%hi($LC4)
	jal	DrawGeometryScale
	lw	$7,%lo($LC4)($2)

	b	$L67
	lw	$31,20($sp)

$L58:
	lui	$2,%hi(GoldCoin)
	lw	$3,%lo(GoldCoin)($2)
	lui	$2,%hi(GlobalAddressB)
	sw	$3,%lo(GlobalAddressB)($2)
	jal	UpdateObjectGravity
	move	$4,$5

	jal	UpdateObjectVelocity
	move	$4,$16

	lui	$2,%hi($LC5)
	lw	$5,%lo($LC5)($2)
	jal	UpdateObjectFrictionScale
	move	$4,$16

	jal	UpdateObjectBump
	move	$4,$16

	lwc1	$f2,68($16)
	mtc1	$0,$f0
	nop
	c.lt.s	$f2,$f0
	nop
	bc1tl	$L61
	swc1	$f0,40($16)

$L61:
	lui	$4,%hi(objectPosition)
	lwc1	$f0,24($16)
	swc1	$f0,%lo(objectPosition)($4)
	addiu	$4,$4,%lo(objectPosition)
	lwc1	$f0,28($16)
	swc1	$f0,4($4)
	lwc1	$f0,32($16)
	swc1	$f0,8($4)
	lhu	$2,18($16)
	addiu	$2,$2,546
	sll	$2,$2,16
	sra	$2,$2,16
	sh	$2,18($16)
	lui	$5,%hi(objectAngle)
	lhu	$3,16($16)
	sh	$3,%lo(objectAngle)($5)
	addiu	$5,$5,%lo(objectAngle)
	sh	$2,2($5)
	lhu	$2,20($16)
	sh	$2,4($5)
	lui	$2,%hi($LC6)
	lw	$7,%lo($LC6)($2)
	lui	$2,%hi(GlobalAddressB)
	jal	DrawGeometryScale
	lw	$6,%lo(GlobalAddressB)($2)

	b	$L67
	lw	$31,20($sp)

$L59:
	lui	$2,%hi(GoldCoin)
	lw	$6,%lo(GoldCoin)($2)
	lui	$2,%hi(GlobalAddressB)
	sw	$6,%lo(GlobalAddressB)($2)
	lui	$4,%hi(objectPosition)
	lwc1	$f0,24($5)
	swc1	$f0,%lo(objectPosition)($4)
	addiu	$4,$4,%lo(objectPosition)
	lwc1	$f0,28($5)
	swc1	$f0,4($4)
	lwc1	$f0,32($5)
	swc1	$f0,8($4)
	lhu	$2,18($5)
	addiu	$2,$2,546
	sll	$2,$2,16
	sra	$2,$2,16
	sh	$2,18($5)
	lui	$5,%hi(objectAngle)
	lhu	$3,16($16)
	sh	$3,%lo(objectAngle)($5)
	addiu	$5,$5,%lo(objectAngle)
	sh	$2,2($5)
	lhu	$2,20($16)
	sh	$2,4($5)
	lui	$2,%hi($LC6)
	jal	DrawGeometryScale
	lw	$7,%lo($LC6)($2)

	b	$L67
	lw	$31,20($sp)

	.set	macro
	.set	reorder
	.end	DisplayObject
	.size	DisplayObject, .-DisplayObject
	.align	2
	.globl	RedCoinCollide
	.set	nomips16
	.set	nomicromips
	.ent	RedCoinCollide
	.type	RedCoinCollide, @function
RedCoinCollide:
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
	move	$18,$5
	lui	$2,%hi(g_PlayerStructTable)
	addiu	$2,$2,%lo(g_PlayerStructTable)
	subu	$2,$4,$2
	li	$16,1240924160			# 0x49f70000
	ori	$16,$16,0xe8e3
	mult	$2,$16
	mfhi	$16
	sra	$16,$16,10
	sra	$2,$2,31
	subu	$16,$16,$2
	lui	$2,%hi($LC7)
	lw	$7,%lo($LC7)($2)
	addiu	$6,$5,24
	lw	$5,112($4)
	jal	TestCollideSphere
	addiu	$4,$4,20

	bne	$2,$0,$L73
	sll	$2,$16,1

$L76:
	lui	$3,%hi(CoinCount)
	addiu	$3,$3,%lo(CoinCount)
	addu	$2,$2,$3
	lh	$3,0($2)
	li	$2,8			# 0x8
	beq	$3,$2,$L74
	move	$5,$16

$L71:
	move	$2,$0
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

$L73:
	jal	deleteObjectBuffer
	move	$4,$18

	sll	$18,$16,24
	sra	$18,$18,24
	li	$5,1224736768			# 0x49000000
	ori	$5,$5,0x8017
	jal	NAPlyTrgStart
	move	$4,$18

	sll	$3,$16,1
	lui	$2,%hi(CoinCount)
	addiu	$2,$2,%lo(CoinCount)
	addu	$3,$3,$2
	lhu	$2,0($3)
	addiu	$2,$2,1
	sll	$2,$2,16
	sra	$2,$2,16
	sh	$2,0($3)
	li	$3,8			# 0x8
	bne	$2,$3,$L75
	nop

$L70:
	jal	SetAnimMusicNote
	move	$4,$18

	b	$L76
	sll	$2,$16,1

$L75:
	jal	playrandmCharacterSFX
	move	$4,$18

	b	$L70
	nop

$L74:
	jal	SetStar
	move	$4,$17

	li	$5,419430400			# 0x19000000
	ori	$5,$5,0xf103
	sll	$4,$16,24
	jal	NAPlyTrgStart
	sra	$4,$4,24

	sll	$16,$16,1
	lui	$2,%hi(CoinCount)
	addiu	$2,$2,%lo(CoinCount)
	addu	$16,$16,$2
	lhu	$2,0($16)
	addiu	$2,$2,1
	b	$L71
	sh	$2,0($16)

	.set	macro
	.set	reorder
	.end	RedCoinCollide
	.size	RedCoinCollide, .-RedCoinCollide
	.align	2
	.globl	GoldCoinCollide
	.set	nomips16
	.set	nomicromips
	.ent	GoldCoinCollide
	.type	GoldCoinCollide, @function
GoldCoinCollide:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$17,24($sp)
	sw	$16,20($sp)
	lui	$2,%hi(g_PlayerStructTable)
	addiu	$2,$2,%lo(g_PlayerStructTable)
	subu	$2,$4,$2
	li	$16,1240924160			# 0x49f70000
	ori	$16,$16,0xe8e3
	mult	$2,$16
	mfhi	$16
	sra	$16,$16,10
	sra	$2,$2,31
	subu	$16,$16,$2
	sll	$2,$16,1
	lui	$3,%hi(IFrames)
	addiu	$3,$3,%lo(IFrames)
	addu	$2,$2,$3
	lh	$2,0($2)
	bne	$2,$0,$L81
	move	$2,$0

	sll	$2,$16,1
	lui	$3,%hi(CoinCount)
	addiu	$3,$3,%lo(CoinCount)
	addu	$2,$2,$3
	lh	$2,0($2)
	slt	$2,$2,10
	bne	$2,$0,$L80
	move	$17,$5

	move	$2,$0
$L81:
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

$L80:
	lui	$2,%hi($LC7)
	lw	$7,%lo($LC7)($2)
	addiu	$6,$5,24
	lw	$5,112($4)
	jal	TestCollideSphere
	addiu	$4,$4,20

	beql	$2,$0,$L81
	move	$2,$0

	jal	deleteObjectBuffer
	move	$4,$17

	sll	$17,$16,24
	sra	$17,$17,24
	li	$5,1224736768			# 0x49000000
	ori	$5,$5,0x8017
	jal	NAPlyTrgStart
	move	$4,$17

	sll	$16,$16,1
	lui	$2,%hi(CoinCount)
	addiu	$2,$2,%lo(CoinCount)
	addu	$16,$16,$2
	lhu	$2,0($16)
	addiu	$2,$2,1
	sh	$2,0($16)
	jal	playrandmCharacterSFX
	move	$4,$17

	jal	SetAnimMusicNote
	move	$4,$17

	lui	$2,%hi($LC1)
	lw	$5,%lo($LC1)($2)
	jal	ChangeMaxSpeed
	move	$4,$17

	b	$L81
	move	$2,$0

	.set	macro
	.set	reorder
	.end	GoldCoinCollide
	.size	GoldCoinCollide, .-GoldCoinCollide
	.align	2
	.globl	CollideObject
	.set	nomips16
	.set	nomicromips
	.ent	CollideObject
	.type	CollideObject, @function
CollideObject:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	lh	$2,0($5)
	li	$3,47			# 0x2f
	beq	$2,$3,$L83
	slt	$3,$2,48

	beql	$3,$0,$L84
	addiu	$2,$2,-48

	li	$3,12			# 0xc
	bne	$2,$3,$L90
	lw	$31,20($sp)

	jal	ItemboxCollideCheck
	nop

	lw	$31,20($sp)
$L90:
	jr	$31
	addiu	$sp,$sp,24

$L84:
	andi	$2,$2,0xffff
	sltu	$2,$2,2
	beql	$2,$0,$L90
	lw	$31,20($sp)

	jal	GoldCoinCollide
	nop

	b	$L90
	lw	$31,20($sp)

$L83:
	jal	RedCoinCollide
	nop

	b	$L90
	lw	$31,20($sp)

	.set	macro
	.set	reorder
	.end	CollideObject
	.size	CollideObject, .-CollideObject
	.align	2
	.globl	RedCoinChallenge
	.set	nomips16
	.set	nomicromips
	.ent	RedCoinChallenge
	.type	RedCoinChallenge, @function
RedCoinChallenge:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, gp= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lui	$2,%hi(GlobalShortD)
	li	$3,1			# 0x1
	sh	$3,%lo(GlobalShortD)($2)
	lui	$2,%hi(g_ScreenFlip)
	lw	$3,%lo(g_ScreenFlip)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L96
	move	$16,$4

$L92:
	addiu	$20,$16,64
	lui	$18,%hi(objectPosition)
	addiu	$17,$18,%lo(objectPosition)
	lui	$19,%hi(GlobalShortD)
	lh	$2,0($16)
$L97:
	mtc1	$2,$f0
	nop
	cvt.s.w	$f2,$f0
	swc1	$f2,%lo(objectPosition)($18)
	lh	$2,2($16)
	mtc1	$2,$f0
	nop
	cvt.s.w	$f0,$f0
	swc1	$f0,4($17)
	lh	$2,4($16)
	mtc1	$2,$f0
	nop
	cvt.s.w	$f0,$f0
	swc1	$f0,8($17)
	lh	$2,%lo(GlobalShortD)($19)
	mtc1	$2,$f0
	nop
	cvt.s.w	$f0,$f0
	mul.s	$f0,$f0,$f2
	swc1	$f0,%lo(objectPosition)($18)
	li	$5,47			# 0x2f
	jal	CreateObject
	move	$4,$17

	addiu	$16,$16,8
	bnel	$16,$20,$L97
	lh	$2,0($16)

	lw	$31,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,40

$L96:
	lui	$2,%hi(GlobalShortD)
	li	$3,-1			# 0xffffffffffffffff
	b	$L92
	sh	$3,%lo(GlobalShortD)($2)

	.set	macro
	.set	reorder
	.end	RedCoinChallenge
	.size	RedCoinChallenge, .-RedCoinChallenge
	.align	2
	.globl	PlaceSIBox
	.set	nomips16
	.set	nomicromips
	.ent	PlaceSIBox
	.type	PlaceSIBox, @function
PlaceSIBox:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, gp= 0
	.mask	0x803f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-48
	sw	$31,44($sp)
	sw	$21,40($sp)
	sw	$20,36($sp)
	sw	$19,32($sp)
	sw	$18,28($sp)
	sw	$17,24($sp)
	sw	$16,20($sp)
	lui	$2,%hi(GlobalShortD)
	li	$3,1			# 0x1
	sh	$3,%lo(GlobalShortD)($2)
	lui	$2,%hi(g_ScreenFlip)
	lw	$3,%lo(g_ScreenFlip)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L104
	lui	$2,%hi(GlobalShortD)

$L99:
	move	$16,$4
	addiu	$19,$4,64
	li	$20,-32768			# 0xffffffffffff8000
	lui	$18,%hi(objectPosition)
	addiu	$17,$18,%lo(objectPosition)
	lui	$21,%hi(GlobalShortD)
	lh	$2,0($16)
$L105:
	beq	$2,$20,$L98
	li	$5,43			# 0x2b

	mtc1	$2,$f0
	nop
	cvt.s.w	$f0,$f0
	swc1	$f0,%lo(objectPosition)($18)
	lh	$2,2($16)
	mtc1	$2,$f2
	nop
	cvt.s.w	$f2,$f2
	swc1	$f2,4($17)
	lh	$2,4($16)
	mtc1	$2,$f2
	nop
	cvt.s.w	$f2,$f2
	swc1	$f2,8($17)
	lh	$2,%lo(GlobalShortD)($21)
	mtc1	$2,$f2
	nop
	cvt.s.w	$f2,$f2
	mul.s	$f0,$f2,$f0
	swc1	$f0,%lo(objectPosition)($18)
	jal	CreateObject
	move	$4,$17

	addiu	$16,$16,8
	bnel	$16,$19,$L105
	lh	$2,0($16)

$L98:
	lw	$31,44($sp)
	lw	$21,40($sp)
	lw	$20,36($sp)
	lw	$19,32($sp)
	lw	$18,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,48

$L104:
	li	$3,-1			# 0xffffffffffffffff
	b	$L99
	sh	$3,%lo(GlobalShortD)($2)

	.set	macro
	.set	reorder
	.end	PlaceSIBox
	.size	PlaceSIBox, .-PlaceSIBox
	.align	2
	.globl	GoldCoinChallenge
	.set	nomips16
	.set	nomicromips
	.ent	GoldCoinChallenge
	.type	GoldCoinChallenge, @function
GoldCoinChallenge:
	.frame	$sp,80,$31		# vars= 0, regs= 9/4, args= 24, gp= 0
	.mask	0x80ff0000,-20
	.fmask	0x00f00000,-8
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-80
	sw	$31,60($sp)
	sw	$23,56($sp)
	sw	$22,52($sp)
	sw	$21,48($sp)
	sw	$20,44($sp)
	sw	$19,40($sp)
	sw	$18,36($sp)
	sw	$17,32($sp)
	sw	$16,28($sp)
	sdc1	$f22,72($sp)
	sdc1	$f20,64($sp)
	move	$19,$4
	lui	$2,%hi(GlobalShortD)
	li	$3,1			# 0x1
	sh	$3,%lo(GlobalShortD)($2)
	lui	$2,%hi(g_ScreenFlip)
	lw	$3,%lo(g_ScreenFlip)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L112
	move	$18,$5

$L107:
	lui	$2,%hi(g_pathLength)
	lh	$2,%lo(g_pathLength)($2)
	div	$0,$2,$18
	teq	$18,$0,7
	lui	$2,%hi(GlobalIntB)
	mflo	$3
	sw	$3,%lo(GlobalIntB)($2)
	lui	$2,%hi(objectAngle)
	sh	$0,%lo(objectAngle)($2)
	addiu	$2,$2,%lo(objectAngle)
	sh	$0,2($2)
	blez	$18,$L106
	sh	$0,4($2)

	move	$16,$0
	lui	$23,%hi(GlobalIntB)
	lui	$22,%hi(objectPosition)
	addiu	$17,$22,%lo(objectPosition)
	lui	$2,%hi($LC8)
	lwc1	$f22,%lo($LC8)($2)
	lui	$2,%hi($LC9)
	lwc1	$f20,%lo($LC9)($2)
	lui	$21,%hi(objectVelocity)
	addiu	$21,$21,%lo(objectVelocity)
	lui	$20,%hi(objectAngle)
	addiu	$20,$20,%lo(objectAngle)
	lw	$2,%lo(GlobalIntB)($23)
$L113:
	mult	$16,$2
	mflo	$2
	sll	$2,$2,3
	addu	$2,$19,$2
	lh	$3,0($2)
	mtc1	$3,$f0
	nop
	cvt.s.w	$f0,$f0
	swc1	$f0,%lo(objectPosition)($22)
	lh	$3,2($2)
	mtc1	$3,$f0
	nop
	cvt.s.w	$f0,$f0
	add.s	$f0,$f0,$f22
	swc1	$f0,4($17)
	lh	$2,4($2)
	mtc1	$2,$f0
	nop
	cvt.s.w	$f0,$f0
	swc1	$f0,8($17)
	swc1	$f20,16($sp)
	li	$7,49			# 0x31
	move	$6,$21
	move	$5,$20
	jal	MasterCreateObject
	move	$4,$17

	addiu	$16,$16,1
	bne	$18,$16,$L113
	lw	$2,%lo(GlobalIntB)($23)

$L106:
	lw	$31,60($sp)
	lw	$23,56($sp)
	lw	$22,52($sp)
	lw	$21,48($sp)
	lw	$20,44($sp)
	lw	$19,40($sp)
	lw	$18,36($sp)
	lw	$17,32($sp)
	lw	$16,28($sp)
	ldc1	$f22,72($sp)
	ldc1	$f20,64($sp)
	jr	$31
	addiu	$sp,$sp,80

$L112:
	lui	$2,%hi(GlobalShortD)
	li	$3,-1			# 0xffffffffffffffff
	b	$L107
	sh	$3,%lo(GlobalShortD)($2)

	.set	macro
	.set	reorder
	.end	GoldCoinChallenge
	.size	GoldCoinChallenge, .-GoldCoinChallenge
	.globl	BalancedItemSetD
	.data
	.align	2
	.type	BalancedItemSetD, @object
	.size	BalancedItemSetD, 16
BalancedItemSetD:
	.ascii	"\006\006\006\006\012\012\012\012\012\012\012\012\010\010"
	.ascii	"\017\017"
	.globl	BalancedItemSetC
	.align	2
	.type	BalancedItemSetC, @object
	.size	BalancedItemSetC, 16
BalancedItemSetC:
	.ascii	"\004\004\004\006\006\006\016\016\017\017\012\010\007\007"
	.ascii	"\007\007"
	.globl	BalancedItemSetB
	.align	2
	.type	BalancedItemSetB, @object
	.size	BalancedItemSetB, 16
BalancedItemSetB:
	.ascii	"\001\001\002\002\004\004\005\005\006\015\015\016\003\011"
	.ascii	"\013\013"
	.globl	BalancedItemSetA
	.align	2
	.type	BalancedItemSetA, @object
	.size	BalancedItemSetA, 16
BalancedItemSetA:
	.ascii	"\001\001\001\001\002\014\014\015\003\003\011\011\011\011"
	.ascii	"\013\013"
	.section	.rodata.cst4,"aM",@progbits,4
	.align	2
$LC0:
	.word	1094713344
	.align	2
$LC1:
	.word	1077936128
	.align	2
$LC2:
	.word	-1069547520
	.align	2
$LC3:
	.word	1034147594
	.align	2
$LC4:
	.word	1036831949
	.align	2
$LC5:
	.word	1056964608
	.align	2
$LC6:
	.word	1028443341
	.align	2
$LC7:
	.word	1086324736
	.align	2
$LC8:
	.word	1084227584
	.align	2
$LC9:
	.word	1065353216
	.ident	"GCC: (GNU) 10.1.0"
