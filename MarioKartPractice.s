	.file	1 "MarioKartPractice.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.globl	splitFunc
	.set	nomips16
	.set	nomicromips
	.ent	splitFunc
	.type	splitFunc, @function
splitFunc:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(SplitTimerToggle)
	lb	$2,%lo(SplitTimerToggle)($2)
	li	$3,1			# 0x1
	beq	$2,$3,$L8
	li	$3,2			# 0x2

	beq	$2,$3,$L7
	li	$3,3			# 0x3

	beq	$2,$3,$L9
	lui	$2,%hi(SplitTimer)

$L10:
	jr	$31
	nop

$L8:
	lui	$2,%hi(g_progressValue)
	lh	$2,%lo(g_progressValue)($2)
	lui	$3,%hi(SplitStartMarker)
	lh	$3,%lo(SplitStartMarker)($3)
	slt	$2,$2,$3
	beq	$2,$0,$L3
	lui	$2,%hi(SplitTimerToggle)

	lui	$2,%hi(g_gameTimer)
	jr	$31
	sw	$0,%lo(g_gameTimer)($2)

$L3:
	li	$3,2			# 0x2
	sb	$3,%lo(SplitTimerToggle)($2)
$L7:
	lui	$2,%hi(g_progressValue)
	lh	$2,%lo(g_progressValue)($2)
	lui	$3,%hi(SplitEndMarker)
	lh	$3,%lo(SplitEndMarker)($3)
	slt	$2,$2,$3
	bne	$2,$0,$L10
	lui	$2,%hi(g_gameTimer)

	lwc1	$f0,%lo(g_gameTimer)($2)
	lui	$2,%hi(SplitTimer)
	swc1	$f0,%lo(SplitTimer)($2)
	lui	$2,%hi(SplitTimerToggle)
	li	$3,3			# 0x3
	sb	$3,%lo(SplitTimerToggle)($2)
	lui	$2,%hi(SplitTimer)
$L9:
	lwc1	$f0,%lo(SplitTimer)($2)
	lui	$2,%hi(g_gameTimer)
	jr	$31
	swc1	$f0,%lo(g_gameTimer)($2)

	.set	macro
	.set	reorder
	.end	splitFunc
	.size	splitFunc, .-splitFunc
	.align	2
	.globl	modCheck
	.set	nomips16
	.set	nomicromips
	.ent	modCheck
	.type	modCheck, @function
modCheck:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	lui	$2,%hi(SaveGame+8)
	lb	$2,%lo(SaveGame+8)($2)
	lui	$3,%hi(AudioLanguage)
	lhu	$3,%lo(AudioLanguage)($3)
	beq	$2,$3,$L12
	andi	$2,$2,0xffff

	lui	$3,%hi(AudioLanguage)
	bne	$2,$0,$L13
	sh	$2,%lo(AudioLanguage)($3)

	lui	$2,%hi(g_MUSRawAudioTable)
	addiu	$2,$2,%lo(g_MUSRawAudioTable)
	lui	$3,%hi(ok_USAudio)
	lw	$4,%lo(ok_USAudio)($3)
	sw	$4,4($2)
	li	$4,2359296			# 0x240000
	ori	$4,$4,0xc3f0
	sw	$4,8($2)
	lui	$2,%hi(g_MUSInstrumentTable)
	addiu	$2,$2,%lo(g_MUSInstrumentTable)
	addiu	$3,$3,%lo(ok_USAudio)
	lw	$3,4($3)
	sw	$3,4($2)
	li	$3,17616			# 0x44d0
	sw	$3,8($2)
$L14:
	jal	InitMKCode
	nop

$L12:
	lui	$2,%hi(SaveGame)
	addiu	$2,$2,%lo(SaveGame)
	lbu	$4,32($2)
	lui	$3,%hi(ScaleXMode)
	sb	$4,%lo(ScaleXMode)($3)
	lbu	$4,33($2)
	lui	$3,%hi(ScaleYMode)
	sb	$4,%lo(ScaleYMode)($3)
	lbu	$4,34($2)
	lui	$3,%hi(ScaleZMode)
	sb	$4,%lo(ScaleZMode)($3)
	lb	$4,35($2)
	lui	$3,%hi(g_ScreenFlip)
	sw	$4,%lo(g_ScreenFlip)($3)
	lb	$4,36($2)
	lui	$3,%hi(YFLIP)
	sh	$4,%lo(YFLIP)($3)
	lb	$4,37($2)
	lui	$3,%hi(ZFLIP)
	sh	$4,%lo(ZFLIP)($3)
	lb	$2,5($2)
	blez	$2,$L15
	lui	$2,%hi(g_gameMode)

	lw	$3,%lo(g_gameMode)($2)
	li	$2,1			# 0x1
	bne	$3,$2,$L24
	nop

$L15:
	lui	$2,%hi(SaveGame+9)
$L27:
	lb	$2,%lo(SaveGame+9)($2)
	blez	$2,$L16
	lui	$2,%hi(g_ScreenSplitA)

	lw	$2,%lo(g_ScreenSplitA)($2)
	beq	$2,$0,$L28
	lui	$3,%hi($LC1)

	lui	$2,%hi(SaveGame+11)
	lb	$2,%lo(SaveGame+11)($2)
	bne	$2,$0,$L29
	lui	$2,%hi(g_aspectRatio)

	lui	$3,%hi($LC0)
	lwc1	$f0,%lo($LC0)($3)
	b	$L18
	swc1	$f0,%lo(g_aspectRatio)($2)

$L13:
	lui	$2,%hi(g_MUSRawAudioTable)
	addiu	$2,$2,%lo(g_MUSRawAudioTable)
	lui	$3,%hi(JP_Audio)
	addiu	$3,$3,%lo(JP_Audio)
	sw	$3,4($2)
	li	$3,2359296			# 0x240000
	ori	$3,$3,0xc580
	sw	$3,8($2)
	lui	$2,%hi(g_MUSInstrumentTable)
	addiu	$2,$2,%lo(g_MUSInstrumentTable)
	lui	$3,%hi(JP_Bank)
	addiu	$3,$3,%lo(JP_Bank)
	sw	$3,4($2)
	li	$3,17728			# 0x4540
	b	$L14
	sw	$3,8($2)

$L24:
	jal	aiSetup
	nop

	b	$L27
	lui	$2,%hi(SaveGame+9)

$L28:
	lui	$2,%hi(g_aspectRatio)
$L29:
	lwc1	$f0,%lo($LC1)($3)
	swc1	$f0,%lo(g_aspectRatio)($2)
$L18:
	lui	$2,%hi(SaveGame+10)
	lb	$2,%lo(SaveGame+10)($2)
	blez	$2,$L20
	li	$2,65536			# 0x10000

	addiu	$2,$2,12310
	lui	$3,%hi(antialiasToggle)
	sw	$2,%lo(antialiasToggle)($3)
	lui	$3,%hi(antialiasToggleB)
	sw	$2,%lo(antialiasToggleB)($3)
$L21:
	lui	$2,%hi(SaveGame+11)
	lb	$2,%lo(SaveGame+11)($2)
	blez	$2,$L22
	lui	$2,%hi(g_playerCount)

	lw	$3,%lo(g_playerCount)($2)
	li	$2,2			# 0x2
	beq	$3,$2,$L25
	lui	$3,%hi(g_ScreenSplitA)

$L22:
	lui	$2,%hi(SaveGame+4)
	lb	$2,%lo(SaveGame+4)($2)
	xori	$2,$2,0x3
	sltu	$2,$0,$2
	lui	$3,%hi(g_ItemSetFlag)
	sh	$2,%lo(g_ItemSetFlag)($3)
	lw	$31,20($sp)
	jr	$31
	addiu	$sp,$sp,24

$L16:
	lw	$2,%lo(g_ScreenSplitA)($2)
	beq	$2,$0,$L30
	lui	$3,%hi($LC3)

	lui	$2,%hi(g_playerCount)
	lw	$3,%lo(g_playerCount)($2)
	li	$2,2			# 0x2
	beq	$3,$2,$L26
	lui	$3,%hi($LC3)

$L30:
	lui	$2,%hi(g_aspectRatio)
	lwc1	$f0,%lo($LC3)($3)
	b	$L18
	swc1	$f0,%lo(g_aspectRatio)($2)

$L26:
	lui	$3,%hi($LC2)
	lui	$2,%hi(g_aspectRatio)
	lwc1	$f0,%lo($LC2)($3)
	b	$L18
	swc1	$f0,%lo(g_aspectRatio)($2)

$L20:
	li	$2,12822			# 0x3216
	lui	$3,%hi(antialiasToggle)
	sw	$2,%lo(antialiasToggle)($3)
	lui	$3,%hi(antialiasToggleB)
	b	$L21
	sw	$2,%lo(antialiasToggleB)($3)

$L25:
	sw	$2,%lo(g_ScreenSplitA)($3)
	lui	$3,%hi(g_ScreenSplitB)
	b	$L22
	sw	$2,%lo(g_ScreenSplitB)($3)

	.set	macro
	.set	reorder
	.end	modCheck
	.size	modCheck, .-modCheck
	.align	2
	.globl	saveState
	.set	nomips16
	.set	nomicromips
	.ent	saveState
	.type	saveState, @function
saveState:
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
	lui	$16,%hi(dataLength)
	li	$2,11200			# 0x2bc0
	sw	$2,%lo(dataLength)($16)
	lui	$17,%hi(targetAddress)
	lw	$3,%lo(targetAddress)($17)
	lui	$2,%hi(ok_SaveState)
	addiu	$2,$2,%lo(ok_SaveState)
	sw	$2,0($3)
	lui	$18,%hi(sourceAddress)
	lw	$3,%lo(sourceAddress)($18)
	lui	$2,%hi(g_SimpleObjectArray)
	addiu	$2,$2,%lo(g_SimpleObjectArray)
	sw	$2,0($3)
	lw	$3,%lo(sourceAddress)($18)
	lw	$2,%lo(targetAddress)($17)
	lw	$6,%lo(dataLength)($16)
	lw	$5,0($3)
	jal	ramCopy
	lw	$4,0($2)

	lw	$3,%lo(targetAddress)($17)
	lw	$2,0($3)
	lw	$4,%lo(dataLength)($16)
	addu	$2,$2,$4
	sw	$2,0($3)
	li	$2,65536			# 0x10000
	ori	$2,$2,0xe140
	sw	$2,%lo(dataLength)($16)
	lw	$3,%lo(sourceAddress)($18)
	lui	$2,%hi(g_DynamicObjects)
	addiu	$2,$2,%lo(g_DynamicObjects)
	sw	$2,0($3)
	lw	$3,%lo(sourceAddress)($18)
	lw	$2,%lo(targetAddress)($17)
	lw	$6,%lo(dataLength)($16)
	lw	$5,0($3)
	jal	ramCopy
	lw	$4,0($2)

	lw	$3,%lo(targetAddress)($17)
	lw	$2,0($3)
	lw	$4,%lo(dataLength)($16)
	addu	$2,$2,$4
	sw	$2,0($3)
	li	$2,28352			# 0x6ec0
	sw	$2,%lo(dataLength)($16)
	lw	$3,%lo(sourceAddress)($18)
	lui	$2,%hi(g_PlayerStructTable)
	addiu	$2,$2,%lo(g_PlayerStructTable)
	sw	$2,0($3)
	lw	$3,%lo(sourceAddress)($18)
	lw	$2,%lo(targetAddress)($17)
	lw	$6,%lo(dataLength)($16)
	lw	$5,0($3)
	jal	ramCopy
	lw	$4,0($2)

	lw	$3,%lo(targetAddress)($17)
	lw	$2,0($3)
	lw	$4,%lo(dataLength)($16)
	addu	$2,$2,$4
	sw	$2,0($3)
	li	$2,2112			# 0x840
	sw	$2,%lo(dataLength)($16)
	lw	$3,%lo(sourceAddress)($18)
	lui	$2,%hi(g_CourseObstacle)
	addiu	$2,$2,%lo(g_CourseObstacle)
	sw	$2,0($3)
	lw	$3,%lo(sourceAddress)($18)
	lw	$2,%lo(targetAddress)($17)
	lw	$6,%lo(dataLength)($16)
	lw	$5,0($3)
	jal	ramCopy
	lw	$4,0($2)

	lw	$3,%lo(targetAddress)($17)
	lw	$2,0($3)
	lw	$4,%lo(dataLength)($16)
	addu	$2,$2,$4
	sw	$2,0($3)
	li	$2,736			# 0x2e0
	sw	$2,%lo(dataLength)($16)
	lw	$3,%lo(sourceAddress)($18)
	lui	$2,%hi(g_CameraTable)
	addiu	$2,$2,%lo(g_CameraTable)
	sw	$2,0($3)
	lw	$3,%lo(sourceAddress)($18)
	lw	$2,%lo(targetAddress)($17)
	lw	$6,%lo(dataLength)($16)
	lw	$5,0($3)
	jal	ramCopy
	lw	$4,0($2)

	lw	$3,%lo(targetAddress)($17)
	lw	$2,0($3)
	lw	$4,%lo(dataLength)($16)
	addu	$2,$2,$4
	sw	$2,0($3)
	li	$2,528			# 0x210
	sw	$2,%lo(dataLength)($16)
	lw	$3,%lo(sourceAddress)($18)
	lui	$2,%hi(g_hudStruct)
	addiu	$2,$2,%lo(g_hudStruct)
	sw	$2,0($3)
	lw	$3,%lo(sourceAddress)($18)
	lw	$2,%lo(targetAddress)($17)
	lw	$6,%lo(dataLength)($16)
	lw	$5,0($3)
	jal	ramCopy
	lw	$4,0($2)

	lw	$3,%lo(targetAddress)($17)
	lw	$2,0($3)
	lw	$4,%lo(dataLength)($16)
	addu	$2,$2,$4
	sw	$2,0($3)
	li	$2,32			# 0x20
	sw	$2,%lo(dataLength)($16)
	lw	$3,%lo(sourceAddress)($18)
	lui	$2,%hi(g_GameLapTable)
	addiu	$2,$2,%lo(g_GameLapTable)
	sw	$2,0($3)
	lw	$3,%lo(sourceAddress)($18)
	lw	$2,%lo(targetAddress)($17)
	lw	$6,%lo(dataLength)($16)
	lw	$5,0($3)
	jal	ramCopy
	lw	$4,0($2)

	lw	$3,%lo(targetAddress)($17)
	lw	$2,0($3)
	lw	$4,%lo(dataLength)($16)
	addu	$2,$2,$4
	sw	$2,0($3)
	li	$2,112			# 0x70
	sw	$2,%lo(dataLength)($16)
	lw	$3,%lo(sourceAddress)($18)
	lui	$2,%hi(g_TrialTime)
	addiu	$2,$2,%lo(g_TrialTime)
	sw	$2,0($3)
	lw	$3,%lo(sourceAddress)($18)
	lw	$2,%lo(targetAddress)($17)
	lw	$6,%lo(dataLength)($16)
	lw	$5,0($3)
	jal	ramCopy
	lw	$4,0($2)

	lui	$2,%hi(g_gameTimer)
	lwc1	$f0,%lo(g_gameTimer)($2)
	lui	$2,%hi(SaveTimer)
	swc1	$f0,%lo(SaveTimer)($2)
	lui	$2,%hi(SplitTimerToggle)
	lbu	$3,%lo(SplitTimerToggle)($2)
	lui	$2,%hi(SplitTimerToggleSave)
	sb	$3,%lo(SplitTimerToggleSave)($2)
	lui	$2,%hi(g_waterHeight)
	lwc1	$f0,%lo(g_waterHeight)($2)
	lui	$2,%hi(SaveState_WaterLevel)
	swc1	$f0,%lo(SaveState_WaterLevel)($2)
	lui	$2,%hi(KeystockCounter)
	lw	$3,%lo(KeystockCounter)($2)
	lui	$2,%hi(SaveState_KeystockCounter)
	sw	$3,%lo(SaveState_KeystockCounter)($2)
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	saveState
	.size	saveState, .-saveState
	.align	2
	.globl	loadState
	.set	nomips16
	.set	nomicromips
	.ent	loadState
	.type	loadState, @function
loadState:
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
	lui	$16,%hi(dataLength)
	li	$2,11200			# 0x2bc0
	sw	$2,%lo(dataLength)($16)
	lui	$18,%hi(sourceAddress)
	lw	$3,%lo(sourceAddress)($18)
	lui	$2,%hi(ok_SaveState)
	addiu	$2,$2,%lo(ok_SaveState)
	sw	$2,0($3)
	lui	$17,%hi(targetAddress)
	lw	$3,%lo(targetAddress)($17)
	lui	$2,%hi(g_SimpleObjectArray)
	addiu	$2,$2,%lo(g_SimpleObjectArray)
	sw	$2,0($3)
	lw	$3,%lo(sourceAddress)($18)
	lw	$2,%lo(targetAddress)($17)
	lw	$6,%lo(dataLength)($16)
	lw	$5,0($3)
	jal	ramCopy
	lw	$4,0($2)

	lw	$3,%lo(sourceAddress)($18)
	lw	$2,0($3)
	lw	$4,%lo(dataLength)($16)
	addu	$2,$2,$4
	sw	$2,0($3)
	li	$2,65536			# 0x10000
	ori	$2,$2,0xe140
	sw	$2,%lo(dataLength)($16)
	lw	$3,%lo(targetAddress)($17)
	lui	$2,%hi(g_DynamicObjects)
	addiu	$2,$2,%lo(g_DynamicObjects)
	sw	$2,0($3)
	lw	$3,%lo(sourceAddress)($18)
	lw	$2,%lo(targetAddress)($17)
	lw	$6,%lo(dataLength)($16)
	lw	$5,0($3)
	jal	ramCopy
	lw	$4,0($2)

	lw	$3,%lo(sourceAddress)($18)
	lw	$2,0($3)
	lw	$4,%lo(dataLength)($16)
	addu	$2,$2,$4
	sw	$2,0($3)
	li	$2,28352			# 0x6ec0
	sw	$2,%lo(dataLength)($16)
	lw	$3,%lo(targetAddress)($17)
	lui	$2,%hi(g_PlayerStructTable)
	addiu	$2,$2,%lo(g_PlayerStructTable)
	sw	$2,0($3)
	lw	$3,%lo(sourceAddress)($18)
	lw	$2,%lo(targetAddress)($17)
	lw	$6,%lo(dataLength)($16)
	lw	$5,0($3)
	jal	ramCopy
	lw	$4,0($2)

	lw	$3,%lo(sourceAddress)($18)
	lw	$2,0($3)
	lw	$4,%lo(dataLength)($16)
	addu	$2,$2,$4
	sw	$2,0($3)
	li	$2,2112			# 0x840
	sw	$2,%lo(dataLength)($16)
	lw	$3,%lo(targetAddress)($17)
	lui	$2,%hi(g_CourseObstacle)
	addiu	$2,$2,%lo(g_CourseObstacle)
	sw	$2,0($3)
	lw	$3,%lo(sourceAddress)($18)
	lw	$2,%lo(targetAddress)($17)
	lw	$6,%lo(dataLength)($16)
	lw	$5,0($3)
	jal	ramCopy
	lw	$4,0($2)

	lw	$3,%lo(sourceAddress)($18)
	lw	$2,0($3)
	lw	$4,%lo(dataLength)($16)
	addu	$2,$2,$4
	sw	$2,0($3)
	li	$2,736			# 0x2e0
	sw	$2,%lo(dataLength)($16)
	lw	$3,%lo(targetAddress)($17)
	lui	$2,%hi(g_CameraTable)
	addiu	$2,$2,%lo(g_CameraTable)
	sw	$2,0($3)
	lw	$3,%lo(sourceAddress)($18)
	lw	$2,%lo(targetAddress)($17)
	lw	$6,%lo(dataLength)($16)
	lw	$5,0($3)
	jal	ramCopy
	lw	$4,0($2)

	lw	$3,%lo(sourceAddress)($18)
	lw	$2,0($3)
	lw	$4,%lo(dataLength)($16)
	addu	$2,$2,$4
	sw	$2,0($3)
	li	$2,528			# 0x210
	sw	$2,%lo(dataLength)($16)
	lw	$3,%lo(targetAddress)($17)
	lui	$2,%hi(g_hudStruct)
	addiu	$2,$2,%lo(g_hudStruct)
	sw	$2,0($3)
	lw	$3,%lo(sourceAddress)($18)
	lw	$2,%lo(targetAddress)($17)
	lw	$6,%lo(dataLength)($16)
	lw	$5,0($3)
	jal	ramCopy
	lw	$4,0($2)

	lw	$3,%lo(sourceAddress)($18)
	lw	$2,0($3)
	lw	$4,%lo(dataLength)($16)
	addu	$2,$2,$4
	sw	$2,0($3)
	li	$2,32			# 0x20
	sw	$2,%lo(dataLength)($16)
	lw	$3,%lo(targetAddress)($17)
	lui	$2,%hi(g_GameLapTable)
	addiu	$2,$2,%lo(g_GameLapTable)
	sw	$2,0($3)
	lw	$3,%lo(sourceAddress)($18)
	lw	$2,%lo(targetAddress)($17)
	lw	$6,%lo(dataLength)($16)
	lw	$5,0($3)
	jal	ramCopy
	lw	$4,0($2)

	lw	$3,%lo(sourceAddress)($18)
	lw	$2,0($3)
	lw	$4,%lo(dataLength)($16)
	addu	$2,$2,$4
	sw	$2,0($3)
	li	$2,112			# 0x70
	sw	$2,%lo(dataLength)($16)
	lw	$3,%lo(targetAddress)($17)
	lui	$2,%hi(g_TrialTime)
	addiu	$2,$2,%lo(g_TrialTime)
	sw	$2,0($3)
	lw	$3,%lo(sourceAddress)($18)
	lw	$2,%lo(targetAddress)($17)
	lw	$6,%lo(dataLength)($16)
	lw	$5,0($3)
	jal	ramCopy
	lw	$4,0($2)

	lui	$2,%hi(SaveTimer)
	lwc1	$f0,%lo(SaveTimer)($2)
	lui	$2,%hi(g_gameTimer)
	swc1	$f0,%lo(g_gameTimer)($2)
	lui	$2,%hi(SplitTimerToggleSave)
	lbu	$3,%lo(SplitTimerToggleSave)($2)
	lui	$2,%hi(SplitTimerToggle)
	sb	$3,%lo(SplitTimerToggle)($2)
	lui	$2,%hi(SaveState_WaterLevel)
	lwc1	$f0,%lo(SaveState_WaterLevel)($2)
	lui	$2,%hi(g_waterHeight)
	swc1	$f0,%lo(g_waterHeight)($2)
	lui	$2,%hi(SaveState_KeystockCounter)
	lw	$3,%lo(SaveState_KeystockCounter)($2)
	lui	$2,%hi(KeystockCounter)
	sw	$3,%lo(KeystockCounter)($2)
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	loadState
	.size	loadState, .-loadState
	.align	2
	.globl	drawInputDisplay
	.set	nomips16
	.set	nomicromips
	.ent	drawInputDisplay
	.type	drawInputDisplay, @function
drawInputDisplay:
	.frame	$sp,96,$31		# vars= 0, regs= 8/6, args= 40, gp= 0
	.mask	0x807f0000,-28
	.fmask	0x03f00000,-8
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-96
	sw	$31,68($sp)
	sw	$22,64($sp)
	sw	$21,60($sp)
	sw	$20,56($sp)
	sw	$19,52($sp)
	sw	$18,48($sp)
	sw	$17,44($sp)
	sw	$16,40($sp)
	sdc1	$f24,88($sp)
	sdc1	$f22,80($sp)
	sdc1	$f20,72($sp)
	lui	$2,%hi(GlobalUShortA)
	li	$3,-32768			# 0xffffffffffff8000
	sh	$3,%lo(GlobalUShortA)($2)
	lui	$2,%hi(ControllerInputX)
	lh	$5,%lo(ControllerInputX)($2)
	lui	$2,%hi(ControllerInputY)
	lh	$6,%lo(ControllerInputY)($2)
	lui	$16,%hi(GraphPtr)
	li	$2,128			# 0x80
	sw	$2,32($sp)
	sw	$0,28($sp)
	sw	$0,24($sp)
	sw	$0,20($sp)
	addiu	$2,$6,16
	sw	$2,16($sp)
	addiu	$7,$5,43
	jal	FillRect1ColorF
	lw	$4,%lo(GraphPtr)($16)

	sw	$2,%lo(GraphPtr)($16)
	lui	$18,%hi(names)
	addiu	$18,$18,%lo(names)
	lui	$16,%hi(coords)
	addiu	$16,$16,%lo(coords)
	lui	$17,%hi(colors)
	addiu	$17,$17,%lo(colors)
	addiu	$21,$16,64
	lui	$20,%hi(InputColor)
	lui	$19,%hi(GlobalUShortA)
	lui	$2,%hi($LC4)
	lwc1	$f24,%lo($LC4)($2)
	lui	$2,%hi($LC5)
	lwc1	$f20,%lo($LC5)($2)
	lui	$2,%hi($LC6)
	b	$L38
	lwc1	$f22,%lo($LC6)($2)

$L37:
	addiu	$2,$20,%lo(InputColor)
	sw	$4,12($2)
	lh	$2,0($16)
	sll	$5,$2,1
	addu	$5,$5,$2
	sll	$5,$5,1
	lui	$2,%hi(ControllerInputX)
	lh	$2,%lo(ControllerInputX)($2)
	addu	$5,$5,$2
	mtc1	$5,$f0
	nop
	cvt.s.w	$f0,$f0
	lui	$3,%hi(AnalogInput)
	swc1	$f0,%lo(AnalogInput)($3)
	lh	$5,2($16)
	sll	$2,$5,2
	addu	$2,$2,$5
	lui	$5,%hi(ControllerInputY)
	lh	$5,%lo(ControllerInputY)($5)
	addu	$2,$2,$5
	mtc1	$2,$f2
	nop
	cvt.s.w	$f2,$f2
	addiu	$3,$3,%lo(AnalogInput)
	swc1	$f2,4($3)
	add.s	$f6,$f0,$f24
	add.s	$f4,$f2,$f20
	add.s	$f0,$f0,$f20
	lui	$22,%hi(GraphPtr)
	sw	$4,32($sp)
	sw	$10,28($sp)
	sw	$9,24($sp)
	sw	$8,20($sp)
	add.s	$f2,$f2,$f22
	trunc.w.s $f2,$f2
	swc1	$f2,16($sp)
	trunc.w.s $f2,$f6
	mfc1	$7,$f2
	trunc.w.s $f2,$f4
	mfc1	$6,$f2
	trunc.w.s $f0,$f0
	mfc1	$5,$f0
	jal	FillRect1ColorF
	lw	$4,%lo(GraphPtr)($22)

	sw	$2,%lo(GraphPtr)($22)
	lhu	$2,%lo(GlobalUShortA)($19)
$L49:
	srl	$2,$2,1
	sh	$2,%lo(GlobalUShortA)($19)
	addiu	$18,$18,4
	addiu	$16,$16,4
	beq	$16,$21,$L47
	addiu	$17,$17,6

$L38:
	lw	$2,0($18)
	lb	$2,0($2)
	beq	$2,$0,$L49
	lhu	$2,%lo(GlobalUShortA)($19)

	lh	$8,0($17)
	sw	$8,%lo(InputColor)($20)
	lh	$9,2($17)
	addiu	$2,$20,%lo(InputColor)
	sw	$9,4($2)
	lh	$10,4($17)
	sw	$10,8($2)
	lui	$2,%hi(p1Button)
	lh	$2,%lo(p1Button)($2)
	lhu	$3,%lo(GlobalUShortA)($19)
	and	$2,$2,$3
	bne	$2,$0,$L37
	li	$4,255			# 0xff

	b	$L37
	li	$4,64			# 0x40

$L47:
	lui	$18,%hi(stickNames)
	addiu	$18,$18,%lo(stickNames)
	lui	$16,%hi(stickCoord)
	addiu	$16,$16,%lo(stickCoord)
	lui	$17,%hi(stickColor)
	addiu	$17,$17,%lo(stickColor)
	addiu	$21,$16,16
	lui	$20,%hi(InputColor)
	lui	$19,%hi(GlobalUShortA)
	lui	$2,%hi($LC4)
	lwc1	$f24,%lo($LC4)($2)
	lui	$2,%hi($LC5)
	lwc1	$f20,%lo($LC5)($2)
	lui	$2,%hi($LC6)
	b	$L41
	lwc1	$f22,%lo($LC6)($2)

$L40:
	addiu	$2,$20,%lo(InputColor)
	sw	$4,12($2)
	lh	$2,0($16)
	sll	$5,$2,1
	addu	$5,$5,$2
	sll	$5,$5,1
	lui	$2,%hi(ControllerInputX)
	lh	$2,%lo(ControllerInputX)($2)
	addu	$5,$5,$2
	mtc1	$5,$f0
	nop
	cvt.s.w	$f0,$f0
	lui	$3,%hi(AnalogInput)
	swc1	$f0,%lo(AnalogInput)($3)
	lh	$5,2($16)
	sll	$2,$5,2
	addu	$2,$2,$5
	lui	$5,%hi(ControllerInputY)
	lh	$5,%lo(ControllerInputY)($5)
	addu	$2,$2,$5
	mtc1	$2,$f2
	nop
	cvt.s.w	$f2,$f2
	addiu	$3,$3,%lo(AnalogInput)
	swc1	$f2,4($3)
	add.s	$f6,$f0,$f24
	add.s	$f4,$f2,$f20
	add.s	$f0,$f0,$f20
	lui	$22,%hi(GraphPtr)
	sw	$4,32($sp)
	sw	$10,28($sp)
	sw	$9,24($sp)
	sw	$8,20($sp)
	add.s	$f2,$f2,$f22
	trunc.w.s $f2,$f2
	swc1	$f2,16($sp)
	trunc.w.s $f2,$f6
	mfc1	$7,$f2
	trunc.w.s $f2,$f4
	mfc1	$6,$f2
	trunc.w.s $f0,$f0
	mfc1	$5,$f0
	jal	FillRect1ColorF
	lw	$4,%lo(GraphPtr)($22)

	sw	$2,%lo(GraphPtr)($22)
	lhu	$2,%lo(GlobalUShortA)($19)
$L50:
	srl	$2,$2,1
	sh	$2,%lo(GlobalUShortA)($19)
	addiu	$18,$18,4
	addiu	$16,$16,4
	beq	$16,$21,$L48
	addiu	$17,$17,6

$L41:
	lw	$2,0($18)
	lb	$2,0($2)
	beq	$2,$0,$L50
	lhu	$2,%lo(GlobalUShortA)($19)

	lh	$8,0($17)
	sw	$8,%lo(InputColor)($20)
	lh	$9,2($17)
	addiu	$2,$20,%lo(InputColor)
	sw	$9,4($2)
	lh	$10,4($17)
	sw	$10,8($2)
	lui	$2,%hi(p1Button)
	lh	$2,%lo(p1Button)($2)
	lhu	$3,%lo(GlobalUShortA)($19)
	and	$2,$2,$3
	bne	$2,$0,$L40
	li	$4,255			# 0xff

	b	$L40
	li	$4,32			# 0x20

$L48:
	lui	$3,%hi(stickColor)
	addiu	$3,$3,%lo(stickColor)
	lh	$4,24($3)
	lui	$2,%hi(InputColor)
	sw	$4,%lo(InputColor)($2)
	lh	$8,26($3)
	addiu	$2,$2,%lo(InputColor)
	sw	$8,4($2)
	lh	$9,28($3)
	sw	$9,8($2)
	li	$10,255			# 0xff
	sw	$10,12($2)
	lui	$2,%hi(player1inputX)
	lh	$2,%lo(player1inputX)($2)
	mtc1	$2,$f0
	nop
	cvt.s.w	$f2,$f0
	lui	$2,%hi($LC7)
	lwc1	$f0,%lo($LC7)($2)
	div.s	$f2,$f2,$f0
	lui	$2,%hi($LC4)
	lwc1	$f6,%lo($LC4)($2)
	mul.s	$f2,$f2,$f6
	lui	$3,%hi(stickCoord)
	addiu	$3,$3,%lo(stickCoord)
	lh	$5,16($3)
	sll	$2,$5,1
	addu	$2,$2,$5
	sll	$2,$2,1
	mtc1	$2,$f0
	nop
	cvt.s.w	$f0,$f0
	add.s	$f2,$f2,$f0
	lui	$2,%hi(ControllerInputX)
	lh	$2,%lo(ControllerInputX)($2)
	mtc1	$2,$f0
	nop
	cvt.s.w	$f0,$f0
	add.s	$f2,$f2,$f0
	lui	$5,%hi(AnalogInput)
	swc1	$f2,%lo(AnalogInput)($5)
	lui	$2,%hi(player1inputY)
	lh	$2,%lo(player1inputY)($2)
	mtc1	$2,$f0
	nop
	cvt.s.w	$f0,$f0
	lui	$2,%hi($LC8)
	lwc1	$f4,%lo($LC8)($2)
	div.s	$f0,$f0,$f4
	lui	$2,%hi($LC6)
	lwc1	$f8,%lo($LC6)($2)
	mul.s	$f0,$f0,$f8
	lh	$2,18($3)
	sll	$3,$2,2
	addu	$3,$3,$2
	mtc1	$3,$f4
	nop
	cvt.s.w	$f4,$f4
	add.s	$f0,$f0,$f4
	lui	$2,%hi(ControllerInputY)
	lh	$3,%lo(ControllerInputY)($2)
	mtc1	$3,$f4
	nop
	cvt.s.w	$f4,$f4
	add.s	$f0,$f0,$f4
	addiu	$5,$5,%lo(AnalogInput)
	swc1	$f0,4($5)
	add.s	$f6,$f2,$f6
	lui	$2,%hi($LC5)
	lwc1	$f4,%lo($LC5)($2)
	add.s	$f10,$f0,$f4
	add.s	$f2,$f2,$f4
	lui	$16,%hi(GraphPtr)
	sw	$10,32($sp)
	sw	$9,28($sp)
	sw	$8,24($sp)
	sw	$4,20($sp)
	add.s	$f0,$f0,$f8
	trunc.w.s $f0,$f0
	swc1	$f0,16($sp)
	trunc.w.s $f0,$f6
	mfc1	$7,$f0
	trunc.w.s $f0,$f10
	mfc1	$6,$f0
	trunc.w.s $f0,$f2
	mfc1	$5,$f0
	jal	FillRect1ColorF
	lw	$4,%lo(GraphPtr)($16)

	sw	$2,%lo(GraphPtr)($16)
	lw	$31,68($sp)
	lw	$22,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	ldc1	$f24,88($sp)
	ldc1	$f22,80($sp)
	ldc1	$f20,72($sp)
	jr	$31
	addiu	$sp,$sp,96

	.set	macro
	.set	reorder
	.end	drawInputDisplay
	.size	drawInputDisplay, .-drawInputDisplay
	.align	2
	.globl	rotateCamera
	.set	nomips16
	.set	nomicromips
	.ent	rotateCamera
	.type	rotateCamera, @function
rotateCamera:
	.frame	$sp,48,$31		# vars= 0, regs= 3/4, args= 16, gp= 0
	.mask	0x80030000,-20
	.fmask	0x00f00000,-8
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-48
	sw	$31,28($sp)
	sw	$17,24($sp)
	sw	$16,20($sp)
	sdc1	$f22,40($sp)
	sdc1	$f20,32($sp)
	lui	$3,%hi(FlyCamDirection)
	lh	$2,%lo(FlyCamDirection)($3)
	mtc1	$2,$f0
	nop
	cvt.d.w	$f0,$f0
	cvt.d.s	$f12,$f12
	lui	$2,%hi($LC9)
	ldc1	$f2,%lo($LC9)($2)
	div.d	$f12,$f12,$f2
	lui	$2,%hi($LC10)
	ldc1	$f2,%lo($LC10)($2)
	mul.d	$f12,$f12,$f2
	sub.d	$f0,$f0,$f12
	trunc.w.d $f0,$f0
	mfc1	$2,$f0
	nop
	sll	$2,$2,16
	sra	$2,$2,16
	sh	$2,%lo(FlyCamDirection)($3)
	mtc1	$2,$f0
	nop
	cvt.s.w	$f12,$f0
	lui	$2,%hi($LC11)
	lwc1	$f0,%lo($LC11)($2)
	div.s	$f12,$f12,$f0
	lui	$2,%hi($LC12)
	lwc1	$f0,%lo($LC12)($2)
	mul.s	$f12,$f12,$f0
	cvt.d.s	$f12,$f12
	lui	$2,%hi($LC13)
	ldc1	$f0,%lo($LC13)($2)
	mul.d	$f12,$f12,$f0
	cvt.s.d	$f12,$f12
	lui	$17,%hi(FlyCamRadian)
	swc1	$f12,%lo(FlyCamRadian)($17)
	lui	$16,%hi(GlobalCamera)
	lw	$2,%lo(GlobalCamera)($16)
	jal	sinF
	lwc1	$f22,0($2)

	lw	$2,%lo(GlobalCamera)($16)
	lui	$3,%hi($LC14)
	lwc1	$f20,%lo($LC14)($3)
	mul.s	$f0,$f0,$f20
	add.s	$f0,$f0,$f22
	swc1	$f0,12($2)
	lwc1	$f22,8($2)
	jal	cosF
	lwc1	$f12,%lo(FlyCamRadian)($17)

	lw	$2,%lo(GlobalCamera)($16)
	mul.s	$f0,$f0,$f20
	add.s	$f0,$f0,$f22
	swc1	$f0,20($2)
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	ldc1	$f22,40($sp)
	ldc1	$f20,32($sp)
	jr	$31
	addiu	$sp,$sp,48

	.set	macro
	.set	reorder
	.end	rotateCamera
	.size	rotateCamera, .-rotateCamera
	.align	2
	.globl	moveCamera
	.set	nomips16
	.set	nomicromips
	.ent	moveCamera
	.type	moveCamera, @function
moveCamera:
	.frame	$sp,48,$31		# vars= 0, regs= 3/4, args= 16, gp= 0
	.mask	0x80030000,-20
	.fmask	0x00f00000,-8
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-48
	sw	$31,28($sp)
	sw	$17,24($sp)
	sw	$16,20($sp)
	sdc1	$f22,40($sp)
	sdc1	$f20,32($sp)
	lui	$2,%hi(FlyCamDirection)
	lh	$2,%lo(FlyCamDirection)($2)
	mtc1	$2,$f0
	nop
	cvt.s.w	$f12,$f0
	lui	$2,%hi($LC11)
	lwc1	$f0,%lo($LC11)($2)
	div.s	$f12,$f12,$f0
	lui	$2,%hi($LC12)
	lwc1	$f0,%lo($LC12)($2)
	mul.s	$f12,$f12,$f0
	cvt.d.s	$f12,$f12
	lui	$2,%hi($LC13)
	ldc1	$f0,%lo($LC13)($2)
	mul.d	$f12,$f12,$f0
	cvt.s.d	$f12,$f12
	lui	$17,%hi(FlyCamRadian)
	swc1	$f12,%lo(FlyCamRadian)($17)
	lui	$16,%hi(GlobalCamera)
	lw	$2,%lo(GlobalCamera)($16)
	lwc1	$f22,0($2)
	mtc1	$4,$f0
	jal	sinF
	cvt.s.w	$f20,$f0

	lw	$2,%lo(GlobalCamera)($16)
	mul.s	$f0,$f20,$f0
	add.s	$f0,$f0,$f22
	swc1	$f0,0($2)
	lw	$2,%lo(GlobalCamera)($16)
	lwc1	$f22,8($2)
	jal	cosF
	lwc1	$f12,%lo(FlyCamRadian)($17)

	lw	$2,%lo(GlobalCamera)($16)
	mul.s	$f0,$f20,$f0
	add.s	$f0,$f0,$f22
	swc1	$f0,8($2)
	lwc1	$f22,12($2)
	jal	sinF
	lwc1	$f12,%lo(FlyCamRadian)($17)

	lw	$2,%lo(GlobalCamera)($16)
	mul.s	$f0,$f20,$f0
	add.s	$f0,$f0,$f22
	swc1	$f0,12($2)
	lwc1	$f22,20($2)
	jal	cosF
	lwc1	$f12,%lo(FlyCamRadian)($17)

	lw	$2,%lo(GlobalCamera)($16)
	mul.s	$f20,$f20,$f0
	add.s	$f20,$f20,$f22
	swc1	$f20,20($2)
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	ldc1	$f22,40($sp)
	ldc1	$f20,32($sp)
	jr	$31
	addiu	$sp,$sp,48

	.set	macro
	.set	reorder
	.end	moveCamera
	.size	moveCamera, .-moveCamera
	.align	2
	.globl	moveCameraTilt
	.set	nomips16
	.set	nomicromips
	.ent	moveCameraTilt
	.type	moveCameraTilt, @function
moveCameraTilt:
	.frame	$sp,48,$31		# vars= 0, regs= 3/4, args= 16, gp= 0
	.mask	0x80030000,-20
	.fmask	0x00f00000,-8
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-48
	sw	$31,28($sp)
	sw	$17,24($sp)
	sw	$16,20($sp)
	sdc1	$f22,40($sp)
	sdc1	$f20,32($sp)
	lui	$2,%hi(FlyCamDirection)
	lh	$2,%lo(FlyCamDirection)($2)
	mtc1	$2,$f0
	nop
	cvt.s.w	$f0,$f0
	lui	$2,%hi($LC11)
	lwc1	$f2,%lo($LC11)($2)
	div.s	$f0,$f0,$f2
	lui	$2,%hi($LC12)
	lwc1	$f2,%lo($LC12)($2)
	mul.s	$f0,$f0,$f2
	cvt.d.s	$f0,$f0
	lui	$2,%hi($LC13)
	ldc1	$f2,%lo($LC13)($2)
	mul.d	$f0,$f0,$f2
	mtc1	$5,$f2
	nop
	cvt.d.w	$f2,$f2
	add.d	$f0,$f0,$f2
	cvt.s.d	$f0,$f0
	lui	$2,%hi(FlyCamRadian)
	blez	$5,$L56
	swc1	$f0,%lo(FlyCamRadian)($2)

	lui	$2,%hi($LC12)
	lwc1	$f2,%lo($LC12)($2)
	c.lt.s	$f2,$f0
	nop
	bc1f	$L63
	lui	$16,%hi(FlyCamRadian)

	sub.s	$f0,$f0,$f2
	lui	$2,%hi(FlyCamRadian)
	swc1	$f0,%lo(FlyCamRadian)($2)
$L63:
	lwc1	$f0,%lo(FlyCamRadian)($16)
	trunc.w.s $f0,$f0
	cvt.d.w	$f12,$f0
	lui	$2,%hi($LC15)
	ldc1	$f0,%lo($LC15)($2)
	mul.d	$f12,$f12,$f0
	cvt.s.d	$f12,$f12
	swc1	$f12,%lo(FlyCamRadian)($16)
	lui	$17,%hi(GlobalCamera)
	lw	$2,%lo(GlobalCamera)($17)
	lwc1	$f22,12($2)
	mtc1	$4,$f0
	jal	sinF
	cvt.s.w	$f20,$f0

	lw	$2,%lo(GlobalCamera)($17)
	mul.s	$f0,$f20,$f0
	add.s	$f0,$f0,$f22
	swc1	$f0,12($2)
	lwc1	$f22,20($2)
	jal	cosF
	lwc1	$f12,%lo(FlyCamRadian)($16)

	lw	$2,%lo(GlobalCamera)($17)
	mul.s	$f20,$f20,$f0
	add.s	$f20,$f20,$f22
	swc1	$f20,20($2)
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	ldc1	$f22,40($sp)
	ldc1	$f20,32($sp)
	jr	$31
	addiu	$sp,$sp,48

$L56:
	mtc1	$0,$f2
	nop
	c.lt.s	$f0,$f2
	nop
	bc1f	$L63
	lui	$16,%hi(FlyCamRadian)

	lui	$2,%hi($LC12)
	lwc1	$f2,%lo($LC12)($2)
	add.s	$f0,$f0,$f2
	lui	$2,%hi(FlyCamRadian)
	b	$L63
	swc1	$f0,%lo(FlyCamRadian)($2)

	.set	macro
	.set	reorder
	.end	moveCameraTilt
	.size	moveCameraTilt, .-moveCameraTilt
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
$LC17:
	.ascii	"FLYING\000"
	.text
	.align	2
	.globl	practiceHack
	.set	nomips16
	.set	nomicromips
	.ent	practiceHack
	.type	practiceHack, @function
practiceHack:
	.frame	$sp,48,$31		# vars= 0, regs= 2/0, args= 40, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-48
	sw	$31,44($sp)
	sw	$16,40($sp)
	lui	$2,%hi(d_Input)
	lb	$2,%lo(d_Input)($2)
	andi	$4,$2,0xf
	lui	$3,%hi(GlobalCharA)
	sb	$4,%lo(GlobalCharA)($3)
	lui	$3,%hi(p_Input)
	lh	$3,%lo(p_Input)($3)
	srl	$4,$3,4
	andi	$4,$4,0xf
	lui	$5,%hi(GlobalCharB)
	sb	$4,%lo(GlobalCharB)($5)
	sra	$2,$2,4
	andi	$2,$2,0xf
	lui	$4,%hi(GlobalCharC)
	sb	$2,%lo(GlobalCharC)($4)
	andi	$3,$3,0xf
	lui	$2,%hi(GlobalCharD)
	sb	$3,%lo(GlobalCharD)($2)
	lui	$2,%hi(SaveGame)
	lb	$3,%lo(SaveGame)($2)
	li	$2,3			# 0x3
	beq	$3,$2,$L103
	lui	$2,%hi(SplitTimerToggle)

$L65:
	lui	$2,%hi(MapModeCheck)
$L107:
	lh	$3,%lo(MapModeCheck)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L104
	lui	$2,%hi(MiniMapMode)

$L64:
	lw	$31,44($sp)
$L112:
	lw	$16,40($sp)
	jr	$31
	addiu	$sp,$sp,48

$L103:
	lb	$2,%lo(SplitTimerToggle)($2)
	bgtz	$2,$L105
	nop

	lui	$2,%hi(GlobalCharD)
$L108:
	lb	$3,%lo(GlobalCharD)($2)
	li	$2,2			# 0x2
	beq	$3,$2,$L106
	lui	$2,%hi(g_player1LocationY)

	lui	$2,%hi(GlobalController)
$L109:
	lw	$2,%lo(GlobalController)($2)
	lhu	$2,6($2)
	li	$3,1024			# 0x400
	beq	$2,$3,$L68
	sltu	$3,$2,1025

	beq	$3,$0,$L69
	li	$3,256			# 0x100

	beq	$2,$3,$L70
	li	$3,512			# 0x200

	bne	$2,$3,$L65
	lui	$2,%hi(HotSwapID)

	lh	$2,%lo(HotSwapID)($2)
	sll	$2,$2,4
	lui	$3,%hi(g_courseID)
	lh	$3,%lo(g_courseID)($3)
	addu	$2,$2,$3
	addiu	$2,$2,1
	lui	$3,%hi(SaveStateCourseID)
	jal	saveState
	sw	$2,%lo(SaveStateCourseID)($3)

	b	$L107
	lui	$2,%hi(MapModeCheck)

$L105:
	jal	splitFunc
	nop

	b	$L108
	lui	$2,%hi(GlobalCharD)

$L106:
	lwc1	$f0,%lo(g_player1LocationY)($2)
	lui	$3,%hi($LC16)
	lwc1	$f2,%lo($LC16)($3)
	add.s	$f0,$f0,$f2
	swc1	$f0,%lo(g_player1LocationY)($2)
	lui	$2,%hi(g_player1SpeedY)
	sw	$0,%lo(g_player1SpeedY)($2)
	lui	$16,%hi(GraphPtr)
	li	$2,175			# 0xaf
	sw	$2,32($sp)
	sw	$0,28($sp)
	sw	$0,24($sp)
	sw	$0,20($sp)
	li	$2,53			# 0x35
	sw	$2,16($sp)
	li	$7,120			# 0x78
	li	$6,43			# 0x2b
	li	$5,23			# 0x17
	jal	FillRect1ColorF
	lw	$4,%lo(GraphPtr)($16)

	jal	loadFont
	sw	$2,%lo(GraphPtr)($16)

	lui	$6,%hi($LC17)
	addiu	$6,$6,%lo($LC17)
	li	$5,25			# 0x19
	jal	printString
	li	$4,5			# 0x5

	b	$L109
	lui	$2,%hi(GlobalController)

$L69:
	li	$3,2048			# 0x800
	bne	$2,$3,$L65
	li	$16,-2147024896			# 0xffffffff80070000

	ori	$16,$16,0xac54
	sw	$0,0($16)
	lui	$2,%hi(g_gameLapPlayer1)
	sw	$0,%lo(g_gameLapPlayer1)($2)
	lui	$2,%hi(GlobalHud)
	lw	$2,%lo(GlobalHud)($2)
	sb	$0,112($2)
	sb	$0,114($2)
	sb	$0,118($2)
	sb	$0,119($2)
	lui	$3,%hi($LC18)
	lui	$2,%hi(g_gameTimer)
	lwc1	$f0,%lo($LC18)($3)
	swc1	$f0,%lo(g_gameTimer)($2)
	lui	$2,%hi(GlobalPlayer+16)
	sh	$0,%lo(GlobalPlayer+16)($2)
	li	$5,14			# 0xe
	jal	RouletteStart
	move	$4,$0

	li	$2,272629760			# 0x10400000
	addiu	$2,$2,9
	b	$L65
	sw	$2,0($16)

$L70:
	lui	$2,%hi(HotSwapID)
	lh	$2,%lo(HotSwapID)($2)
	sll	$2,$2,4
	lui	$3,%hi(g_courseID)
	lh	$3,%lo(g_courseID)($3)
	addu	$2,$2,$3
	addiu	$2,$2,1
	lui	$3,%hi(SaveStateCourseID)
	lw	$3,%lo(SaveStateCourseID)($3)
	bnel	$2,$3,$L107
	lui	$2,%hi(MapModeCheck)

	jal	loadState
	nop

	b	$L107
	lui	$2,%hi(MapModeCheck)

$L68:
	lui	$2,%hi(g_courseID)
	lh	$2,%lo(g_courseID)($2)
	sll	$2,$2,4
	lui	$3,%hi(PathTable)
	addiu	$3,$3,%lo(PathTable)
	addu	$2,$2,$3
	jal	GetRealAddress
	lw	$4,0($2)

	lui	$3,%hi(GlobalPlayer)
	addiu	$3,$3,%lo(GlobalPlayer)
	lh	$4,0($2)
	mtc1	$4,$f0
	nop
	cvt.s.w	$f0,$f0
	swc1	$f0,20($3)
	lh	$4,2($2)
	mtc1	$4,$f0
	nop
	cvt.s.w	$f0,$f0
	swc1	$f0,24($3)
	lh	$2,4($2)
	mtc1	$2,$f0
	nop
	cvt.s.w	$f0,$f0
	swc1	$f0,28($3)
	li	$2,-32768			# 0xffffffffffff8000
	b	$L65
	sh	$2,46($3)

$L104:
	jal	printMap
	lb	$4,%lo(MiniMapMode)($2)

	lui	$2,%hi(g_startingIndicator)
	lw	$2,%lo(g_startingIndicator)($2)
	slt	$2,$2,3
	bne	$2,$0,$L110
	lui	$2,%hi(GlobalController)

	lui	$2,%hi(g_GameLapTable)
	li	$3,1			# 0x1
	sw	$3,%lo(g_GameLapTable)($2)
	addiu	$2,$2,%lo(g_GameLapTable)
	sw	$0,4($2)
	sw	$0,8($2)
	sw	$0,12($2)
	sw	$0,16($2)
	sw	$0,20($2)
	sw	$0,24($2)
	sw	$0,28($2)
	lui	$2,%hi(GlobalController)
$L110:
	lw	$3,%lo(GlobalController)($2)
	lhu	$2,4($3)
	andi	$4,$2,0x10
	beql	$4,$0,$L75
	lui	$3,%hi(MiniMapMode)

	lhu	$2,6($3)
	andi	$3,$2,0x400
	beq	$3,$0,$L111
	andi	$2,$2,0x800

	lui	$3,%hi(MiniMapMode)
	lb	$3,%lo(MiniMapMode)($3)
	slt	$4,$3,3
	beq	$4,$0,$L111
	nop

	addiu	$3,$3,1
	lui	$4,%hi(MiniMapMode)
	sb	$3,%lo(MiniMapMode)($4)
$L111:
	beq	$2,$0,$L112
	lw	$31,44($sp)

	lui	$2,%hi(MiniMapMode)
	lb	$2,%lo(MiniMapMode)($2)
	blez	$2,$L112
	addiu	$2,$2,-1

	lui	$3,%hi(MiniMapMode)
	b	$L64
	sb	$2,%lo(MiniMapMode)($3)

$L75:
	lb	$3,%lo(MiniMapMode)($3)
	li	$4,2			# 0x2
	beq	$3,$4,$L77
	slt	$4,$3,3

	beq	$4,$0,$L78
	li	$4,3			# 0x3

	beq	$3,$0,$L79
	li	$4,1			# 0x1

	bne	$3,$4,$L64
	li	$3,1024			# 0x400

	beq	$2,$3,$L87
	sltu	$3,$2,1025

	beq	$3,$0,$L88
	li	$3,256			# 0x100

	beq	$2,$3,$L89
	li	$3,512			# 0x200

	bne	$2,$3,$L64
	lui	$3,%hi(g_startX)

	lhu	$2,%lo(g_startX)($3)
	addiu	$2,$2,-1
	b	$L64
	sh	$2,%lo(g_startX)($3)

$L78:
	bne	$3,$4,$L64
	li	$3,1024			# 0x400

	beq	$2,$3,$L97
	sltu	$3,$2,1025

	beq	$3,$0,$L98
	li	$3,256			# 0x100

	beq	$2,$3,$L99
	li	$3,512			# 0x200

	bne	$2,$3,$L64
	lui	$3,%hi(RadarLineX)

	lhu	$2,%lo(RadarLineX)($3)
	addiu	$2,$2,-1
	b	$L64
	sh	$2,%lo(RadarLineX)($3)

$L79:
	li	$3,1024			# 0x400
	beq	$2,$3,$L82
	sltu	$3,$2,1025

	beq	$3,$0,$L83
	li	$3,256			# 0x100

	beq	$2,$3,$L84
	li	$3,512			# 0x200

	bne	$2,$3,$L64
	lui	$3,%hi(g_mapX)

	lhu	$2,%lo(g_mapX)($3)
	addiu	$2,$2,-1
	b	$L64
	sh	$2,%lo(g_mapX)($3)

$L83:
	li	$3,2048			# 0x800
	bne	$2,$3,$L64
	lui	$3,%hi(g_mapY)

	lhu	$2,%lo(g_mapY)($3)
	addiu	$2,$2,-1
	b	$L64
	sh	$2,%lo(g_mapY)($3)

$L84:
	lui	$3,%hi(g_mapX)
	lhu	$2,%lo(g_mapX)($3)
	addiu	$2,$2,1
	b	$L64
	sh	$2,%lo(g_mapX)($3)

$L82:
	lui	$3,%hi(g_mapY)
	lhu	$2,%lo(g_mapY)($3)
	addiu	$2,$2,1
	b	$L64
	sh	$2,%lo(g_mapY)($3)

$L88:
	li	$3,2048			# 0x800
	bne	$2,$3,$L64
	lui	$3,%hi(g_startY)

	lhu	$2,%lo(g_startY)($3)
	addiu	$2,$2,-1
	b	$L64
	sh	$2,%lo(g_startY)($3)

$L89:
	lui	$3,%hi(g_startX)
	lhu	$2,%lo(g_startX)($3)
	addiu	$2,$2,1
	b	$L64
	sh	$2,%lo(g_startX)($3)

$L87:
	lui	$3,%hi(g_startY)
	lhu	$2,%lo(g_startY)($3)
	addiu	$2,$2,1
	b	$L64
	sh	$2,%lo(g_startY)($3)

$L77:
	li	$3,1024			# 0x400
	beq	$2,$3,$L92
	sltu	$3,$2,1025

	beq	$3,$0,$L93
	li	$3,256			# 0x100

	beq	$2,$3,$L94
	li	$3,512			# 0x200

	bne	$2,$3,$L64
	lui	$2,%hi(g_mapScale)

	lwc1	$f0,%lo(g_mapScale)($2)
	cvt.d.s	$f0,$f0
	lui	$3,%hi($LC19)
	ldc1	$f2,%lo($LC19)($3)
	sub.d	$f0,$f0,$f2
	cvt.s.d	$f0,$f0
	b	$L64
	swc1	$f0,%lo(g_mapScale)($2)

$L93:
	li	$3,2048			# 0x800
	bne	$2,$3,$L64
	lui	$2,%hi(g_mapScale)

	lwc1	$f0,%lo(g_mapScale)($2)
	cvt.d.s	$f0,$f0
	lui	$3,%hi($LC20)
	ldc1	$f2,%lo($LC20)($3)
	add.d	$f0,$f0,$f2
	cvt.s.d	$f0,$f0
	b	$L64
	swc1	$f0,%lo(g_mapScale)($2)

$L94:
	lui	$2,%hi(g_mapScale)
	lwc1	$f0,%lo(g_mapScale)($2)
	cvt.d.s	$f0,$f0
	lui	$3,%hi($LC19)
	ldc1	$f2,%lo($LC19)($3)
	add.d	$f0,$f0,$f2
	cvt.s.d	$f0,$f0
	b	$L64
	swc1	$f0,%lo(g_mapScale)($2)

$L92:
	lui	$2,%hi(g_mapScale)
	lwc1	$f0,%lo(g_mapScale)($2)
	cvt.d.s	$f0,$f0
	lui	$3,%hi($LC20)
	ldc1	$f2,%lo($LC20)($3)
	sub.d	$f0,$f0,$f2
	cvt.s.d	$f0,$f0
	b	$L64
	swc1	$f0,%lo(g_mapScale)($2)

$L98:
	li	$3,2048			# 0x800
	bne	$2,$3,$L64
	lui	$3,%hi(RadarLineY)

	lhu	$2,%lo(RadarLineY)($3)
	addiu	$2,$2,1
	b	$L64
	sh	$2,%lo(RadarLineY)($3)

$L99:
	lui	$3,%hi(RadarLineX)
	lhu	$2,%lo(RadarLineX)($3)
	addiu	$2,$2,1
	b	$L64
	sh	$2,%lo(RadarLineX)($3)

$L97:
	lui	$3,%hi(RadarLineY)
	lhu	$2,%lo(RadarLineY)($3)
	addiu	$2,$2,-1
	b	$L64
	sh	$2,%lo(RadarLineY)($3)

	.set	macro
	.set	reorder
	.end	practiceHack
	.size	practiceHack, .-practiceHack
	.section	.rodata.str1.4
	.align	2
$LC22:
	.ascii	"SECTION-\000"
	.align	2
$LC23:
	.ascii	"VIEW-\000"
	.align	2
$LC24:
	.ascii	"SPEED-\000"
	.text
	.align	2
	.globl	RunFlyCam
	.set	nomips16
	.set	nomicromips
	.ent	RunFlyCam
	.type	RunFlyCam, @function
RunFlyCam:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$17,24($sp)
	sw	$16,20($sp)
	lui	$2,%hi(GlobalController)
	lw	$2,%lo(GlobalController)($2)
	lhu	$2,6($2)
	andi	$2,$2,0x2
	beq	$2,$0,$L154
	lui	$2,%hi(FlyCamToggle)

	lui	$2,%hi(GlobalCamera)
	lw	$2,%lo(GlobalCamera)($2)
	lhu	$3,38($2)
	lui	$2,%hi(FlyCamDirection)
	sh	$3,%lo(FlyCamDirection)($2)
	lui	$2,%hi(g_player1Section)
	lhu	$3,%lo(g_player1Section)($2)
	lui	$2,%hi(FlyCamSectionCheck)
	sh	$3,%lo(FlyCamSectionCheck)($2)
	lui	$2,%hi(g_player1View)
	lhu	$3,%lo(g_player1View)($2)
	lui	$2,%hi(FlyCamViewCheck)
	sh	$3,%lo(FlyCamViewCheck)($2)
	lui	$2,%hi(dataLength)
	li	$3,32			# 0x20
	sw	$3,%lo(dataLength)($2)
	lui	$2,%hi(FlyCamToggle)
	lb	$2,%lo(FlyCamToggle)($2)
	beq	$2,$0,$L143
	lui	$2,%hi(FlyCamToggle)

	sb	$0,%lo(FlyCamToggle)($2)
	li	$3,-2144731136			# 0xffffffff802a0000
	li	$2,201392128			# 0xc010000
	addiu	$2,$2,25453
	sw	$2,23704($3)
	li	$2,-2147418112			# 0xffffffff80010000
	ori	$2,$2,0xee98
	li	$3,666697728			# 0x27bd0000
	ori	$3,$3,0xffc8
	sw	$3,0($2)
	li	$3,-2144796672			# 0xffffffff80290000
	li	$2,31916032			# 0x1e70000
	addiu	$2,$2,8225
	sw	$2,4436($3)
	li	$2,612630528			# 0x24840000
	ori	$2,$2,0xfffc
	sw	$2,4452($3)
	li	$2,-2147287040			# 0xffffffff80030000
	ori	$2,$2,0x82dc
	li	$3,1006764032			# 0x3c020000
	ori	$3,$3,0x800e
	sw	$3,0($2)
	li	$3,-1941831680			# 0xffffffff8c420000
	ori	$3,$3,0xc52c
	sw	$3,4($2)
	lui	$2,%hi(GlobalFloatC)
	lwc1	$f0,%lo(GlobalFloatC)($2)
	lui	$2,%hi(GlobalPlayer+548)
	swc1	$f0,%lo(GlobalPlayer+548)($2)
	lui	$2,%hi(sourceAddress)
	lw	$3,%lo(sourceAddress)($2)
	lui	$2,%hi(ok_FreeCamBackup)
	addiu	$2,$2,%lo(ok_FreeCamBackup)
	sw	$2,0($3)
$L116:
	lui	$2,%hi(targetAddress)
	lw	$3,%lo(targetAddress)($2)
	li	$2,-2145910784			# 0xffffffff80180000
	ori	$2,$2,0xcab0
	jal	runRAM
	sw	$2,0($3)

	lui	$2,%hi(FlyCamToggle)
$L154:
	lb	$2,%lo(FlyCamToggle)($2)
	blez	$2,$L117
	lui	$2,%hi(GlobalController)

	lw	$2,%lo(GlobalController)($2)
	lhu	$3,4($2)
	andi	$3,$3,0x20
	bne	$3,$0,$L144
	lui	$3,%hi(GlobalPlayer)

	addiu	$3,$3,%lo(GlobalPlayer)
	lui	$4,%hi(FlyCamBackupPosition)
	lwc1	$f0,%lo(FlyCamBackupPosition)($4)
	swc1	$f0,20($3)
	addiu	$4,$4,%lo(FlyCamBackupPosition)
	lwc1	$f0,4($4)
	swc1	$f0,24($3)
	lwc1	$f0,8($4)
	swc1	$f0,28($3)
	lhu	$3,6($2)
	li	$4,256			# 0x100
	beq	$3,$4,$L123
	li	$4,512			# 0x200

	bnel	$3,$4,$L155
	lhu	$3,4($2)

	lui	$3,%hi(FlyCamSectionCheck)
	lh	$3,%lo(FlyCamSectionCheck)($3)
	slt	$4,$3,2
	bne	$4,$0,$L124
	addiu	$3,$3,-1

	lui	$4,%hi(FlyCamSectionCheck)
	b	$L124
	sh	$3,%lo(FlyCamSectionCheck)($4)

$L143:
	li	$3,1			# 0x1
	sb	$3,%lo(FlyCamToggle)($2)
	li	$2,-2144731136			# 0xffffffff802a0000
	sw	$0,23704($2)
	li	$3,65011712			# 0x3e00000
	addiu	$3,$3,8
	li	$2,-2147418112			# 0xffffffff80010000
	ori	$2,$2,0xee98
	sw	$3,0($2)
	lui	$2,%hi(FlyCamSection)
	addiu	$2,$2,%lo(FlyCamSection)
	li	$5,-2144796672			# 0xffffffff80290000
	srl	$4,$2,16
	li	$6,1006895104			# 0x3c040000
	or	$4,$4,$6
	sw	$4,4436($5)
	andi	$2,$2,0xffff
	li	$4,-2071724032			# 0xffffffff84840000
	or	$2,$2,$4
	sw	$2,4452($5)
	lui	$16,%hi(GlobalPlayer)
	addiu	$16,$16,%lo(GlobalPlayer)
	lwc1	$f0,548($16)
	lui	$2,%hi(GlobalFloatC)
	swc1	$f0,%lo(GlobalFloatC)($2)
	lui	$2,%hi($LC21)
	lwc1	$f0,%lo($LC21)($2)
	swc1	$f0,548($16)
	li	$2,-2147287040			# 0xffffffff80030000
	ori	$2,$2,0x82dc
	sw	$3,0($2)
	sw	$0,4($2)
	lui	$17,%hi(sourceAddress)
	lw	$3,%lo(sourceAddress)($17)
	li	$2,-2145910784			# 0xffffffff80180000
	ori	$2,$2,0xcab0
	sw	$2,0($3)
	lui	$2,%hi(targetAddress)
	lw	$3,%lo(targetAddress)($2)
	lui	$2,%hi(ok_FreeCamBackup)
	addiu	$2,$2,%lo(ok_FreeCamBackup)
	jal	runRAM
	sw	$2,0($3)

	lw	$3,%lo(sourceAddress)($17)
	lui	$2,%hi(ok_FreeCam)
	addiu	$2,$2,%lo(ok_FreeCam)
	sw	$2,0($3)
	lui	$2,%hi(FlyCamBackupPosition)
	lwc1	$f0,20($16)
	swc1	$f0,%lo(FlyCamBackupPosition)($2)
	addiu	$2,$2,%lo(FlyCamBackupPosition)
	lwc1	$f0,24($16)
	swc1	$f0,4($2)
	lwc1	$f0,28($16)
	b	$L116
	swc1	$f0,8($2)

$L144:
	jal	loadFont
	lui	$17,%hi(FlyCamSpeed)

	lui	$2,%hi(FlyCamSectionCheck)
	lh	$7,%lo(FlyCamSectionCheck)($2)
	lui	$6,%hi($LC22)
	addiu	$6,$6,%lo($LC22)
	li	$5,25			# 0x19
	jal	printStringNumber
	li	$4,5			# 0x5

	lui	$2,%hi(FlyCamViewCheck)
	lh	$7,%lo(FlyCamViewCheck)($2)
	lui	$6,%hi($LC23)
	addiu	$6,$6,%lo($LC23)
	li	$5,35			# 0x23
	jal	printStringNumber
	li	$4,5			# 0x5

	lh	$7,%lo(FlyCamSpeed)($17)
	lui	$6,%hi($LC24)
	addiu	$6,$6,%lo($LC24)
	li	$5,45			# 0x2d
	jal	printStringNumber
	li	$4,5			# 0x5

	lui	$16,%hi(GlobalController)
	lw	$2,%lo(GlobalController)($16)
	lh	$6,2($2)
	mtc1	$6,$f0
	nop
	cvt.s.w	$f0,$f0
	lui	$2,%hi($LC25)
	lwc1	$f2,%lo($LC25)($2)
	div.s	$f0,$f0,$f2
	lh	$6,%lo(FlyCamSpeed)($17)
	mtc1	$6,$f2
	nop
	cvt.s.w	$f2,$f2
	mul.s	$f0,$f0,$f2
	mfc1	$6,$f0
	li	$5,75			# 0x4b
	jal	printFloat
	move	$4,$0

	lw	$2,%lo(GlobalController)($16)
	lhu	$2,6($2)
	li	$3,1024			# 0x400
	beq	$2,$3,$L119
	li	$3,2048			# 0x800

	bne	$2,$3,$L156
	lui	$2,%hi(g_ScreenFlip)

	lui	$2,%hi(FlyCamSpeed)
	lh	$2,%lo(FlyCamSpeed)($2)
	slt	$3,$2,5
	beql	$3,$0,$L122
	addiu	$2,$2,5

	addiu	$2,$2,1
	lui	$3,%hi(FlyCamSpeed)
	b	$L117
	sh	$2,%lo(FlyCamSpeed)($3)

$L119:
	lui	$2,%hi(FlyCamSpeed)
	lh	$2,%lo(FlyCamSpeed)($2)
	slt	$3,$2,6
	bne	$3,$0,$L121
	slt	$3,$2,2

	addiu	$2,$2,-5
	lui	$3,%hi(FlyCamSpeed)
	b	$L117
	sh	$2,%lo(FlyCamSpeed)($3)

$L121:
	bne	$3,$0,$L117
	addiu	$2,$2,-1

	lui	$3,%hi(FlyCamSpeed)
	b	$L117
	sh	$2,%lo(FlyCamSpeed)($3)

$L122:
	lui	$3,%hi(FlyCamSpeed)
	b	$L117
	sh	$2,%lo(FlyCamSpeed)($3)

$L123:
	lui	$4,%hi(FlyCamSectionCheck)
	lhu	$3,%lo(FlyCamSectionCheck)($4)
	addiu	$3,$3,1
	sh	$3,%lo(FlyCamSectionCheck)($4)
$L124:
	lhu	$3,4($2)
$L155:
	li	$4,1024			# 0x400
	beq	$3,$4,$L125
	li	$4,2048			# 0x800

	bnel	$3,$4,$L157
	lhu	$3,10($2)

	lui	$3,%hi(GlobalCamera)
	lw	$4,%lo(GlobalCamera)($3)
	lui	$3,%hi(FlyCamSpeed)
	lh	$3,%lo(FlyCamSpeed)($3)
	mtc1	$3,$f0
	nop
	cvt.s.w	$f2,$f0
	lwc1	$f0,16($4)
	add.s	$f0,$f0,$f2
	swc1	$f0,16($4)
$L126:
	lhu	$3,10($2)
$L157:
	andi	$4,$3,0x100
	bne	$4,$0,$L145
	andi	$3,$3,0x200

	bne	$3,$0,$L146
	lui	$3,%hi(FlyCamSpeed)

	lui	$2,%hi(FlyCamPilot)
$L151:
	lh	$3,%lo(FlyCamPilot)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L147
	lui	$2,%hi(FlyCamSpeed)

	lui	$2,%hi(GlobalController)
	lw	$2,%lo(GlobalController)($2)
	lh	$2,4($2)
	bltz	$2,$L148
	lui	$2,%hi(FlyCamSpeed)

	lui	$2,%hi(GlobalController)
$L153:
	lw	$2,%lo(GlobalController)($2)
	lhu	$2,4($2)
	andi	$2,$2,0x4000
	bne	$2,$0,$L149
	lui	$2,%hi(FlyCamSpeed)

	lui	$2,%hi(GlobalController)
$L152:
	lw	$4,%lo(GlobalController)($2)
	lhu	$2,10($4)
	andi	$2,$2,0xc00
	beq	$2,$0,$L156
	lui	$2,%hi(g_ScreenFlip)

	lui	$2,%hi(GlobalCamera)
	lw	$5,%lo(GlobalCamera)($2)
	lui	$2,%hi(FlyCamSpeed)
	lh	$2,%lo(FlyCamSpeed)($2)
	mtc1	$2,$f0
	nop
	cvt.s.w	$f4,$f0
	lh	$3,2($4)
	mtc1	$3,$f0
	nop
	cvt.s.w	$f2,$f0
	lui	$2,%hi($LC25)
	lwc1	$f8,%lo($LC25)($2)
	div.s	$f2,$f2,$f8
	mul.s	$f2,$f2,$f4
	lwc1	$f6,16($5)
	add.s	$f2,$f6,$f2
	swc1	$f2,16($5)
	lh	$2,2($4)
	mtc1	$2,$f0
	nop
	cvt.s.w	$f0,$f0
	div.s	$f0,$f0,$f8
	mul.s	$f0,$f0,$f4
	lwc1	$f2,4($5)
	add.s	$f0,$f2,$f0
	swc1	$f0,4($5)
$L117:
	lui	$2,%hi(g_ScreenFlip)
$L156:
	lw	$3,%lo(g_ScreenFlip)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L150
	lui	$2,%hi(FlyCamDirection)

	lhu	$2,%lo(FlyCamDirection)($2)
	lui	$3,%hi(GlobalUShortA)
	sh	$2,%lo(GlobalUShortA)($3)
	sltu	$3,$2,8190
	beq	$3,$0,$L138
	sltu	$3,$2,24570

	lui	$2,%hi(FlyCamViewCheck)
	li	$3,2			# 0x2
	sh	$3,%lo(FlyCamViewCheck)($2)
$L134:
	lui	$2,%hi(FlyCamSectionCheck)
	lh	$2,%lo(FlyCamSectionCheck)($2)
	addiu	$2,$2,-1
	sll	$2,$2,2
	lui	$3,%hi(FlyCamViewCheck)
	lhu	$3,%lo(FlyCamViewCheck)($3)
	addu	$2,$2,$3
	lui	$3,%hi(FlyCamSection)
	sh	$2,%lo(FlyCamSection)($3)
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

$L125:
	lui	$3,%hi(GlobalCamera)
	lw	$4,%lo(GlobalCamera)($3)
	lui	$3,%hi(FlyCamSpeed)
	lh	$3,%lo(FlyCamSpeed)($3)
	mtc1	$3,$f0
	nop
	cvt.s.w	$f2,$f0
	lwc1	$f0,16($4)
	sub.s	$f0,$f0,$f2
	b	$L126
	swc1	$f0,16($4)

$L145:
	lui	$3,%hi(FlyCamSpeed)
	lh	$3,%lo(FlyCamSpeed)($3)
	mtc1	$3,$f0
	nop
	cvt.d.w	$f12,$f0
	lui	$3,%hi($LC26)
	ldc1	$f0,%lo($LC26)($3)
	mul.d	$f12,$f12,$f0
	lh	$2,0($2)
	mtc1	$2,$f0
	nop
	cvt.s.w	$f0,$f0
	lui	$2,%hi($LC25)
	lwc1	$f2,%lo($LC25)($2)
	div.s	$f0,$f0,$f2
	cvt.d.s	$f0,$f0
	mul.d	$f12,$f12,$f0
	jal	rotateCamera
	cvt.s.d	$f12,$f12

	b	$L151
	lui	$2,%hi(FlyCamPilot)

$L146:
	lh	$3,%lo(FlyCamSpeed)($3)
	mtc1	$3,$f0
	nop
	cvt.d.w	$f12,$f0
	lui	$3,%hi($LC26)
	ldc1	$f0,%lo($LC26)($3)
	mul.d	$f12,$f12,$f0
	lh	$2,0($2)
	mtc1	$2,$f0
	nop
	cvt.s.w	$f0,$f0
	lui	$2,%hi($LC25)
	lwc1	$f2,%lo($LC25)($2)
	div.s	$f0,$f0,$f2
	cvt.d.s	$f0,$f0
	mul.d	$f12,$f12,$f0
	jal	rotateCamera
	cvt.s.d	$f12,$f12

	b	$L151
	lui	$2,%hi(FlyCamPilot)

$L147:
	jal	moveCamera
	lh	$4,%lo(FlyCamSpeed)($2)

	b	$L152
	lui	$2,%hi(GlobalController)

$L148:
	lh	$4,%lo(FlyCamSpeed)($2)
	jal	moveCamera
	sll	$4,$4,1

	b	$L153
	lui	$2,%hi(GlobalController)

$L149:
	lh	$4,%lo(FlyCamSpeed)($2)
	subu	$4,$0,$4
	jal	moveCamera
	sll	$4,$4,1

	b	$L152
	lui	$2,%hi(GlobalController)

$L150:
	lhu	$2,%lo(FlyCamDirection)($2)
	lui	$3,%hi(GlobalUShortA)
	sh	$2,%lo(GlobalUShortA)($3)
	sltu	$3,$2,8190
	beq	$3,$0,$L133
	sltu	$3,$2,24570

	lui	$2,%hi(FlyCamViewCheck)
	li	$3,2			# 0x2
	b	$L134
	sh	$3,%lo(FlyCamViewCheck)($2)

$L133:
	beq	$3,$0,$L135
	li	$3,40950			# 0x9ff6

	lui	$2,%hi(FlyCamViewCheck)
	li	$3,3			# 0x3
	b	$L134
	sh	$3,%lo(FlyCamViewCheck)($2)

$L135:
	sltu	$3,$2,$3
	beq	$3,$0,$L136
	li	$3,57330			# 0xdff2

	lui	$2,%hi(FlyCamViewCheck)
	b	$L134
	sh	$0,%lo(FlyCamViewCheck)($2)

$L136:
	sltu	$2,$2,$3
	beq	$2,$0,$L137
	lui	$2,%hi(FlyCamViewCheck)

	li	$3,1			# 0x1
	b	$L134
	sh	$3,%lo(FlyCamViewCheck)($2)

$L137:
	li	$3,2			# 0x2
	b	$L134
	sh	$3,%lo(FlyCamViewCheck)($2)

$L138:
	beq	$3,$0,$L139
	li	$3,40950			# 0x9ff6

	lui	$2,%hi(FlyCamViewCheck)
	li	$3,1			# 0x1
	b	$L134
	sh	$3,%lo(FlyCamViewCheck)($2)

$L139:
	sltu	$3,$2,$3
	beq	$3,$0,$L140
	li	$3,57330			# 0xdff2

	lui	$2,%hi(FlyCamViewCheck)
	b	$L134
	sh	$0,%lo(FlyCamViewCheck)($2)

$L140:
	sltu	$2,$2,$3
	beq	$2,$0,$L141
	lui	$2,%hi(FlyCamViewCheck)

	li	$3,3			# 0x3
	b	$L134
	sh	$3,%lo(FlyCamViewCheck)($2)

$L141:
	li	$3,2			# 0x2
	b	$L134
	sh	$3,%lo(FlyCamViewCheck)($2)

	.set	macro
	.set	reorder
	.end	RunFlyCam
	.size	RunFlyCam, .-RunFlyCam
	.align	2
	.globl	FlycamInit
	.set	nomips16
	.set	nomicromips
	.ent	FlycamInit
	.type	FlycamInit, @function
FlycamInit:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(ok_FreeCam)
	addiu	$2,$2,%lo(ok_FreeCam)
	addiu	$4,$2,80
	li	$3,-16777216			# 0xffffffffff000000
	ori	$3,$3,0xff00
	sw	$3,0($2)
$L161:
	addiu	$2,$2,4
	bnel	$2,$4,$L161
	sw	$3,0($2)

	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	FlycamInit
	.size	FlycamInit, .-FlycamInit
	.globl	SplitEndMarker
	.section	.bss,"aw",@nobits
	.align	1
	.type	SplitEndMarker, @object
	.size	SplitEndMarker, 2
SplitEndMarker:
	.space	2
	.globl	SplitStartMarker
	.align	1
	.type	SplitStartMarker, @object
	.size	SplitStartMarker, 2
SplitStartMarker:
	.space	2
	.globl	SplitTimer
	.align	2
	.type	SplitTimer, @object
	.size	SplitTimer, 4
SplitTimer:
	.space	4
	.globl	SaveTimer
	.align	2
	.type	SaveTimer, @object
	.size	SaveTimer, 4
SaveTimer:
	.space	4
	.globl	SplitTimerToggleSave
	.type	SplitTimerToggleSave, @object
	.size	SplitTimerToggleSave, 1
SplitTimerToggleSave:
	.space	1
	.globl	SplitTimerToggle
	.type	SplitTimerToggle, @object
	.size	SplitTimerToggle, 1
SplitTimerToggle:
	.space	1
	.globl	SaveState_KeystockCounter
	.align	2
	.type	SaveState_KeystockCounter, @object
	.size	SaveState_KeystockCounter, 4
SaveState_KeystockCounter:
	.space	4
	.globl	SaveState_WaterLevel
	.align	2
	.type	SaveState_WaterLevel, @object
	.size	SaveState_WaterLevel, 4
SaveState_WaterLevel:
	.space	4
	.section	.rodata.cst4,"aM",@progbits,4
	.align	2
$LC0:
	.word	1080033280
	.align	2
$LC1:
	.word	1071877708
	.align	2
$LC2:
	.word	1076538027
	.align	2
$LC3:
	.word	1068149424
	.align	2
$LC4:
	.word	1086324736
	.align	2
$LC5:
	.word	1065353216
	.align	2
$LC6:
	.word	1084227584
	.align	2
$LC7:
	.word	1123942400
	.align	2
$LC8:
	.word	-1023541248
	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
$LC9:
	.word	1081507840
	.word	0
	.align	3
$LC10:
	.word	1089470432
	.word	0
	.section	.rodata.cst4
	.align	2
$LC11:
	.word	1199570688
	.align	2
$LC12:
	.word	1135869952
	.section	.rodata.cst8
	.align	3
$LC13:
	.word	1066524487
	.word	584335455
	.section	.rodata.cst4
	.align	2
$LC14:
	.word	1117782016
	.section	.rodata.cst8
	.align	3
$LC15:
	.word	-1080959161
	.word	584335455
	.section	.rodata.cst4
	.align	2
$LC16:
	.word	1077936128
	.align	2
$LC18:
	.word	1119092736
	.section	.rodata.cst8
	.align	3
$LC19:
	.word	1062232653
	.word	-755914244
	.align	3
$LC20:
	.word	1058682594
	.word	-350469331
	.section	.rodata.cst4
	.align	2
$LC21:
	.word	981668463
	.align	2
$LC25:
	.word	1120403456
	.section	.rodata.cst8
	.align	3
$LC26:
	.word	1071644672
	.word	0
	.ident	"GCC: (GNU) 10.1.0"
