	.file	1 "OverKart.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.globl	DetectEmulator
	.set	nomips16
	.set	nomicromips
	.ent	DetectEmulator
	.type	DetectEmulator, @function
DetectEmulator:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	li	$2,-1542455296			# 0xffffffffa4100000
	lw	$2,16($2)
	beq	$2,$0,$L4
	li	$3,-1539309568			# 0xffffffffa4400000

	lw	$4,56($3)
	li	$2,1790705664			# 0x6abc0000
	ori	$2,$2,0xdef9
	lw	$3,120($3)
	beql	$3,$2,$L3
	li	$2,-1539309568			# 0xffffffffa4400000

	jr	$31
	li	$2,1			# 0x1

$L3:
	sw	$4,56($2)
	jr	$31
	move	$2,$0

$L4:
	jr	$31
	li	$2,1			# 0x1

	.set	macro
	.set	reorder
	.end	DetectEmulator
	.size	DetectEmulator, .-DetectEmulator
	.align	2
	.globl	DebugLog
	.set	nomips16
	.set	nomicromips
	.ent	DebugLog
	.type	DebugLog, @function
DebugLog:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(PrintCount)
	lw	$2,%lo(PrintCount)($2)
	sltu	$2,$2,99
	bne	$2,$0,$L7
	lui	$6,%hi(PrintCount)

	lui	$2,%hi(PrintCount)
	sw	$0,%lo(PrintCount)($2)
$L7:
	lw	$2,%lo(PrintCount)($6)
	sll	$3,$2,2
	lui	$5,%hi(PrintLog)
	addiu	$5,$5,%lo(PrintLog)
	addu	$3,$3,$5
	sw	$4,0($3)
	addiu	$2,$2,1
	jr	$31
	sw	$2,%lo(PrintCount)($6)

	.set	macro
	.set	reorder
	.end	DebugLog
	.size	DebugLog, .-DebugLog
	.align	2
	.globl	loadLogo
	.set	nomips16
	.set	nomicromips
	.ent	loadLogo
	.type	loadLogo, @function
loadLogo:
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
	lui	$16,%hi(ok_Logo)
	addiu	$16,$16,%lo(ok_Logo)
	move	$5,$16
	jal	SetSegment
	li	$4,8			# 0x8

	lui	$19,%hi(sourceAddress)
	lw	$3,%lo(sourceAddress)($19)
	lui	$2,%hi(LogoROM)
	addiu	$2,$2,%lo(LogoROM)
	sw	$2,0($3)
	lui	$18,%hi(targetAddress)
	lw	$2,%lo(targetAddress)($18)
	lui	$17,%hi(ok_FreeSpace)
	addiu	$17,$17,%lo(ok_FreeSpace)
	sw	$17,0($2)
	lui	$2,%hi(dataLength)
	li	$3,14528			# 0x38c0
	jal	runDMA
	sw	$3,%lo(dataLength)($2)

	lw	$2,%lo(sourceAddress)($19)
	sw	$17,0($2)
	lw	$2,%lo(targetAddress)($18)
	jal	runMIO
	sw	$16,0($2)

	lui	$3,%hi(g_NintendoLogoOffset)
	li	$2,134217728			# 0x8000000
	addiu	$2,$2,23152
	sw	$2,%lo(g_NintendoLogoOffset)($3)
	lui	$3,%hi(g_NintendoLogoBorder)
	li	$2,627769344			# 0x256b0000
	ori	$2,$2,0x9478
	sw	$2,%lo(g_NintendoLogoBorder)($3)
	lw	$31,36($sp)
	lw	$19,32($sp)
	lw	$18,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,40

	.set	macro
	.set	reorder
	.end	loadLogo
	.size	loadLogo, .-loadLogo
	.align	2
	.globl	SetMenuPanels
	.set	nomips16
	.set	nomicromips
	.ent	SetMenuPanels
	.type	SetMenuPanels, @function
SetMenuPanels:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$5,%hi(RacePanel)
	addiu	$2,$5,%lo(RacePanel)
	lui	$3,%hi(GameOKMenu+4)
	sw	$2,%lo(GameOKMenu+4)($3)
	lui	$3,%hi(menuNames)
	lw	$6,%lo(menuNames)($3)
	sw	$6,%lo(RacePanel)($5)
	addiu	$3,$3,%lo(menuNames)
	lw	$5,4($3)
	sw	$5,16($2)
	lw	$3,8($3)
	sw	$3,32($2)
	lui	$3,%hi(menuChar)
	lw	$5,%lo(menuChar)($3)
	sh	$5,6($2)
	addiu	$3,$3,%lo(menuChar)
	lw	$5,4($3)
	sh	$5,22($2)
	lw	$3,8($3)
	sh	$3,38($2)
	lui	$3,%hi(pageLimit)
	addiu	$3,$3,%lo(pageLimit)
	lw	$5,4($3)
	sh	$5,20($2)
	lw	$3,8($3)
	sh	$3,36($2)
	lui	$3,%hi(renderMode)
	lw	$3,%lo(renderMode)($3)
	sw	$3,28($2)
	lui	$3,%hi(mapMode)
	lw	$3,%lo(mapMode)($3)
	sw	$3,44($2)
	lui	$3,%hi(OKGameOptions)
	addiu	$3,$3,%lo(OKGameOptions)
	sw	$3,8($2)
	lui	$3,%hi(OKRenderOptions)
	addiu	$3,$3,%lo(OKRenderOptions)
	sw	$3,24($2)
	lui	$3,%hi(OKMapOptions)
	addiu	$3,$3,%lo(OKMapOptions)
	beq	$4,$0,$L11
	sw	$3,40($2)

	li	$2,1			# 0x1
	beq	$4,$2,$L12
	lui	$2,%hi(pageLimit+16)

$L15:
	lui	$2,%hi(pageLimit+4)
$L25:
	lw	$2,%lo(pageLimit+4)($2)
	blez	$2,$L26
	lui	$2,%hi(pageLimit+8)

	lui	$9,%hi(renderLimits)
	addiu	$9,$9,%lo(renderLimits)
	lui	$8,%hi(renderParameters)
	addiu	$8,$8,%lo(renderParameters)
	lui	$7,%hi(renderChar)
	addiu	$7,$7,%lo(renderChar)
	lui	$6,%hi(renderOptions)
	addiu	$6,$6,%lo(renderOptions)
	move	$3,$0
	lui	$10,%hi(GameOKMenu)
	addiu	$10,$10,%lo(GameOKMenu)
	lui	$11,%hi(pageLimit)
	addiu	$11,$11,%lo(pageLimit)
$L18:
	sll	$2,$3,4
	lw	$4,4($10)
	lw	$4,24($4)
	addu	$4,$4,$2
	lw	$5,0($9)
	sw	$5,4($4)
	lw	$4,4($10)
	lw	$5,24($4)
	addu	$5,$5,$2
	sw	$8,8($5)
	lw	$5,24($4)
	addu	$5,$5,$2
	sw	$7,12($5)
	lw	$4,24($4)
	addu	$2,$4,$2
	lw	$4,0($6)
	sw	$4,0($2)
	addiu	$3,$3,1
	addiu	$9,$9,4
	addiu	$8,$8,12
	addiu	$7,$7,12
	lw	$2,4($11)
	slt	$2,$3,$2
	bne	$2,$0,$L18
	addiu	$6,$6,4

	lui	$2,%hi(pageLimit+8)
$L26:
	lw	$2,%lo(pageLimit+8)($2)
	blez	$2,$L27
	lui	$9,%hi(mapLimits)

	addiu	$9,$9,%lo(mapLimits)
	lui	$8,%hi(mapParameters)
	addiu	$8,$8,%lo(mapParameters)
	lui	$7,%hi(mapChar)
	addiu	$7,$7,%lo(mapChar)
	lui	$6,%hi(mapOptions)
	addiu	$6,$6,%lo(mapOptions)
	move	$3,$0
	lui	$10,%hi(GameOKMenu)
	addiu	$10,$10,%lo(GameOKMenu)
	lui	$11,%hi(pageLimit)
	addiu	$11,$11,%lo(pageLimit)
$L20:
	sll	$2,$3,4
	lw	$4,4($10)
	lw	$4,40($4)
	addu	$4,$4,$2
	lw	$5,0($9)
	sw	$5,4($4)
	lw	$4,4($10)
	lw	$5,40($4)
	addu	$5,$5,$2
	sw	$8,8($5)
	lw	$5,40($4)
	addu	$5,$5,$2
	sw	$7,12($5)
	lw	$4,40($4)
	addu	$2,$4,$2
	lw	$4,0($6)
	sw	$4,0($2)
	addiu	$3,$3,1
	addiu	$9,$9,4
	addiu	$8,$8,28
	addiu	$7,$7,28
	lw	$2,8($11)
	slt	$2,$3,$2
	bne	$2,$0,$L20
	addiu	$6,$6,4

$L27:
	jr	$31
	nop

$L11:
	lui	$2,%hi(pageLimit)
	lw	$3,%lo(pageLimit)($2)
	lui	$2,%hi(RacePanel)
	addiu	$2,$2,%lo(RacePanel)
	sh	$3,4($2)
	lui	$5,%hi(gameMode)
	lw	$5,%lo(gameMode)($5)
	blez	$3,$L15
	sw	$5,12($2)

	lui	$9,%hi(gameLimits)
	addiu	$9,$9,%lo(gameLimits)
	lui	$8,%hi(gameParameters)
	addiu	$8,$8,%lo(gameParameters)
	lui	$7,%hi(gameChar)
	addiu	$7,$7,%lo(gameChar)
	lui	$6,%hi(gameOptions)
	addiu	$6,$6,%lo(gameOptions)
	lui	$10,%hi(GameOKMenu)
	addiu	$10,$10,%lo(GameOKMenu)
	lui	$11,%hi(pageLimit)
$L16:
	sll	$2,$4,4
	lw	$3,4($10)
	lw	$3,8($3)
	addu	$3,$3,$2
	lw	$5,0($9)
	sw	$5,4($3)
	lw	$3,4($10)
	lw	$5,8($3)
	addu	$5,$5,$2
	sw	$8,8($5)
	lw	$5,8($3)
	addu	$5,$5,$2
	sw	$7,12($5)
	lw	$3,8($3)
	addu	$2,$3,$2
	lw	$3,0($6)
	sw	$3,0($2)
	addiu	$4,$4,1
	addiu	$9,$9,4
	addiu	$8,$8,16
	addiu	$7,$7,16
	lw	$2,%lo(pageLimit)($11)
	slt	$2,$4,$2
	bne	$2,$0,$L16
	addiu	$6,$6,4

	b	$L25
	lui	$2,%hi(pageLimit+4)

$L12:
	lw	$3,%lo(pageLimit+16)($2)
	lui	$2,%hi(RacePanel)
	addiu	$2,$2,%lo(RacePanel)
	sh	$3,4($2)
	lui	$4,%hi(battleMode)
	lw	$4,%lo(battleMode)($4)
	blez	$3,$L15
	sw	$4,12($2)

	lui	$9,%hi(battleLimits)
	addiu	$9,$9,%lo(battleLimits)
	lui	$8,%hi(battleParameters)
	addiu	$8,$8,%lo(battleParameters)
	lui	$7,%hi(battleChar)
	addiu	$7,$7,%lo(battleChar)
	lui	$6,%hi(battleOptions)
	addiu	$6,$6,%lo(battleOptions)
	move	$3,$0
	lui	$10,%hi(GameOKMenu)
	addiu	$10,$10,%lo(GameOKMenu)
	lui	$11,%hi(pageLimit)
	addiu	$11,$11,%lo(pageLimit)
$L17:
	sll	$2,$3,4
	lw	$4,4($10)
	lw	$4,8($4)
	addu	$4,$4,$2
	lw	$5,0($9)
	sw	$5,4($4)
	lw	$4,4($10)
	lw	$5,8($4)
	addu	$5,$5,$2
	sw	$8,8($5)
	lw	$5,8($4)
	addu	$5,$5,$2
	sw	$7,12($5)
	lw	$4,8($4)
	addu	$2,$4,$2
	lw	$4,0($6)
	sw	$4,0($2)
	addiu	$3,$3,1
	addiu	$9,$9,4
	addiu	$8,$8,12
	addiu	$7,$7,12
	lw	$2,16($11)
	slt	$2,$3,$2
	bne	$2,$0,$L17
	addiu	$6,$6,4

	b	$L25
	lui	$2,%hi(pageLimit+4)

	.set	macro
	.set	reorder
	.end	SetMenuPanels
	.size	SetMenuPanels, .-SetMenuPanels
	.align	2
	.globl	okSetup
	.set	nomips16
	.set	nomicromips
	.ent	okSetup
	.type	okSetup, @function
okSetup:
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
	jal	loadLogo
	sw	$16,20($sp)

	jal	loadArrows
	lui	$16,%hi(SaveGame)

	jal	loadHeaderOffsets
	lui	$19,%hi(dataLength)

	jal	loadHudButtons
	lui	$18,%hi(sourceAddress)

	jal	SetupFontF3D
	lui	$17,%hi(targetAddress)

	jal	loadEEPROM
	addiu	$4,$16,%lo(SaveGame)

	jal	CheckContPackMenu
	addiu	$16,$16,%lo(SaveGame)

	li	$2,8			# 0x8
	sw	$2,%lo(dataLength)($19)
	lw	$3,%lo(sourceAddress)($18)
	lui	$2,%hi(g_MUSSequenceTable+28)
	addiu	$2,$2,%lo(g_MUSSequenceTable+28)
	sw	$2,0($3)
	lw	$3,%lo(targetAddress)($17)
	lui	$2,%hi(ok_Sequence)
	addiu	$2,$2,%lo(ok_Sequence)
	jal	runRAM
	sw	$2,0($3)

	lw	$3,%lo(sourceAddress)($18)
	lui	$2,%hi(g_MUSInstrumentTable+28)
	addiu	$2,$2,%lo(g_MUSInstrumentTable+28)
	sw	$2,0($3)
	lw	$3,%lo(targetAddress)($17)
	lui	$2,%hi(ok_Instrument)
	addiu	$2,$2,%lo(ok_Instrument)
	jal	runRAM
	sw	$2,0($3)

	lw	$3,%lo(sourceAddress)($18)
	lui	$2,%hi(g_BombTable)
	addiu	$2,$2,%lo(g_BombTable)
	sw	$2,0($3)
	lw	$3,%lo(targetAddress)($17)
	lui	$2,%hi(ok_Bomb)
	addiu	$2,$2,%lo(ok_Bomb)
	sw	$2,0($3)
	li	$2,168			# 0xa8
	jal	runRAM
	sw	$2,%lo(dataLength)($19)

	jal	loadBigFont
	nop

	jal	copyCourseTable
	li	$4,1			# 0x1

	jal	NopSplashCheckCode
	nop

	lui	$2,%hi(HotSwapID)
	sh	$0,%lo(HotSwapID)($2)
	jal	copyCourseTable
	move	$4,$0

	lui	$2,%hi(raceStatus)
	li	$3,255			# 0xff
	sh	$3,%lo(raceStatus)($2)
	li	$2,604897280			# 0x240e0000
	addiu	$2,$2,1
	lui	$3,%hi(asm_SongA)
	sw	$2,%lo(asm_SongA)($3)
	lui	$3,%hi(asm_SongB)
	sw	$2,%lo(asm_SongB)($3)
	lui	$2,%hi(g_sfxPause)
	sb	$0,%lo(g_sfxPause)($2)
	lui	$2,%hi(HotSwapGP)
	sh	$0,%lo(HotSwapGP)($2)
	lui	$2,%hi(MapModeCheck)
	sh	$0,%lo(MapModeCheck)($2)
	lui	$2,%hi(PrintCount)
	sw	$0,%lo(PrintCount)($2)
	lui	$2,%hi(YFLIP)
	sh	$0,%lo(YFLIP)($2)
	lui	$2,%hi(ZFLIP)
	sh	$0,%lo(ZFLIP)($2)
	lui	$2,%hi(ok_USAudio)
	lui	$3,%hi(g_MUSRawAudioTable+4)
	lw	$3,%lo(g_MUSRawAudioTable+4)($3)
	sw	$3,%lo(ok_USAudio)($2)
	addiu	$2,$2,%lo(ok_USAudio)
	lui	$3,%hi(g_MUSInstrumentTable+4)
	lw	$3,%lo(g_MUSInstrumentTable+4)($3)
	sw	$3,4($2)
	lui	$2,%hi(ok_MRSong)
	lui	$3,%hi(g_MUSSequenceTable)
	addiu	$3,$3,%lo(g_MUSSequenceTable)
	lw	$4,28($3)
	sw	$4,%lo(ok_MRSong)($2)
	addiu	$2,$2,%lo(ok_MRSong)
	lw	$3,32($3)
	sw	$3,4($2)
	lui	$3,%hi(FreeSpaceAddress)
	lui	$2,%hi(ok_Storage)
	addiu	$2,$2,%lo(ok_Storage)
	sw	$2,%lo(FreeSpaceAddress)($3)
	sb	$0,40($16)
	lui	$2,%hi(GameOKMenu)
	li	$3,3			# 0x3
	sw	$3,%lo(GameOKMenu)($2)
	jal	SetMenuPanels
	move	$4,$0

	lui	$2,%hi(startupSwitch)
	li	$3,1			# 0x1
	sh	$3,%lo(startupSwitch)($2)
	lw	$31,36($sp)
	lw	$19,32($sp)
	lw	$18,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,40

	.set	macro
	.set	reorder
	.end	okSetup
	.size	okSetup, .-okSetup
	.align	2
	.globl	checkEndGame
	.set	nomips16
	.set	nomicromips
	.ent	checkEndGame
	.type	checkEndGame, @function
checkEndGame:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(g_playerCount)
	lw	$3,%lo(g_playerCount)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L36
	lui	$2,%hi(g_playerPosition1)

	lw	$2,%lo(g_playerPosition1)($2)
	slt	$2,$2,4
	bne	$2,$0,$L34
	nop

	lui	$2,%hi(g_playerPosition2)
	lw	$2,%lo(g_playerPosition2)($2)
	slt	$2,$2,4
	bne	$2,$0,$L35
	nop

	lui	$2,%hi(SaveGame+2)
	lb	$2,%lo(SaveGame+2)($2)
	xori	$2,$2,0x1
	jr	$31
	sltu	$2,$2,1

$L36:
	lw	$2,%lo(g_playerPosition1)($2)
	slt	$2,$2,4
	bne	$2,$0,$L33
	nop

	lui	$2,%hi(SaveGame+2)
	lb	$2,%lo(SaveGame+2)($2)
	xori	$2,$2,0x1
	jr	$31
	sltu	$2,$2,1

$L33:
	jr	$31
	li	$2,1			# 0x1

$L34:
	jr	$31
	li	$2,1			# 0x1

$L35:
	jr	$31
	li	$2,1			# 0x1

	.set	macro
	.set	reorder
	.end	checkEndGame
	.size	checkEndGame, .-checkEndGame
	.align	2
	.globl	startRace
	.set	nomips16
	.set	nomicromips
	.ent	startRace
	.type	startRace, @function
startRace:
	.frame	$sp,40,$31		# vars= 0, regs= 4/0, args= 24, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	jal	setZoomLevel
	li	$4,1			# 0x1

	lui	$2,%hi(g_loadedcourseFlag)
	li	$3,240			# 0xf0
	jal	InitialCustomParticleBuffer
	sh	$3,%lo(g_loadedcourseFlag)($2)

	lui	$2,%hi(g_gameMode)
	lw	$3,%lo(g_gameMode)($2)
	li	$2,3			# 0x3
	beq	$3,$2,$L61
	lui	$2,%hi(SaveGame+1)

$L69:
	lb	$3,%lo(SaveGame+1)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L42
	lui	$2,%hi(g_gameMode)

	lw	$3,%lo(g_gameMode)($2)
	li	$2,1			# 0x1
	bne	$3,$2,$L43
	nop

$L42:
	jal	checkStats
	li	$4,1			# 0x1

	lui	$2,%hi(g_gameMode)
$L68:
	lw	$2,%lo(g_gameMode)($2)
	beq	$2,$0,$L62
	lui	$2,%hi(g_raceClass)

	lui	$2,%hi(HotSwapID)
$L70:
	lh	$2,%lo(HotSwapID)($2)
	blez	$2,$L46
	lui	$2,%hi(g_gameMode)

	lw	$3,%lo(g_gameMode)($2)
	li	$2,1			# 0x1
	bnel	$3,$2,$L63
	li	$4,100663296			# 0x6000000

$L47:
	jal	EmptyActionData
	nop

	jal	setSky
	nop

	jal	setWater
	nop

	jal	loadMinimap
	nop

	b	$L67
	lui	$2,%hi(SaveGame)

$L61:
	lui	$2,%hi(SaveGame+24)
	lb	$2,%lo(SaveGame+24)($2)
	li	$3,1			# 0x1
	beq	$2,$3,$L39
	li	$3,2			# 0x2

	beq	$2,$3,$L40
	li	$7,1			# 0x1

	beq	$2,$0,$L64
	nop

	lui	$2,%hi(SaveGame+1)
	lb	$3,%lo(SaveGame+1)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L42
	nop

$L43:
	jal	checkStats
	move	$4,$0

	b	$L68
	lui	$2,%hi(g_gameMode)

$L64:
	jal	SlayerInit
	nop

	b	$L69
	lui	$2,%hi(SaveGame+1)

$L39:
	li	$2,1			# 0x1
	sw	$2,16($sp)
	lui	$7,%hi(MushroomModels)
	addiu	$7,$7,%lo(MushroomModels)
	lui	$2,%hi(RedMushroom)
	lw	$6,%lo(RedMushroom)($2)
	lui	$5,%hi(FlagModels)
	addiu	$5,$5,%lo(FlagModels)
	lui	$2,%hi(BattleFlag)
	jal	PlaceFlags
	lw	$4,%lo(BattleFlag)($2)

	b	$L69
	lui	$2,%hi(SaveGame+1)

$L40:
	lui	$6,%hi(MushroomModels)
	addiu	$6,$6,%lo(MushroomModels)
	lui	$2,%hi(RedMushroom)
	lw	$5,%lo(RedMushroom)($2)
	lui	$2,%hi(SoccerBall)
	jal	PlaceBalls
	lw	$4,%lo(SoccerBall)($2)

	b	$L69
	lui	$2,%hi(SaveGame+1)

$L62:
	jal	SetAIDifficulty
	lw	$4,%lo(g_raceClass)($2)

	b	$L70
	lui	$2,%hi(HotSwapID)

$L63:
	jal	GetRealAddress
	addiu	$4,$4,1640

	jal	PlaceSIBox
	move	$4,$2

	lui	$2,%hi(g_gameMode)
	lw	$3,%lo(g_gameMode)($2)
	li	$2,3			# 0x3
	bne	$3,$2,$L47
	nop

	lui	$2,%hi(SaveGame)
$L67:
	lb	$3,%lo(SaveGame)($2)
	li	$2,1			# 0x1
	beql	$3,$2,$L65
	li	$4,100663296			# 0x6000000

$L49:
	lui	$2,%hi(SaveGame)
	lb	$3,%lo(SaveGame)($2)
	li	$2,2			# 0x2
	beq	$3,$2,$L66
	lui	$2,%hi(g_playerCount)

$L50:
	lui	$2,%hi(VersionNumber)
	lw	$2,%lo(VersionNumber)($2)
	slt	$2,$2,5
	bne	$2,$0,$L72
	lw	$31,36($sp)

	move	$16,$0
	li	$17,100			# 0x64
	sll	$4,$16,16
$L73:
	jal	ClearOKObject
	sra	$4,$4,16

	addiu	$16,$16,1
	bne	$16,$17,$L73
	sll	$4,$16,16

	jal	loadOKObjects
	nop

	jal	setOKObjects
	nop

$L37:
	lw	$31,36($sp)
$L72:
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	jr	$31
	addiu	$sp,$sp,40

$L65:
	jal	GetRealAddress
	addiu	$4,$4,1568

	jal	RedCoinChallenge
	move	$4,$2

	lui	$2,%hi(CoinCount)
	sh	$0,%lo(CoinCount)($2)
	addiu	$2,$2,%lo(CoinCount)
	sh	$0,2($2)
	sh	$0,4($2)
	b	$L49
	sh	$0,6($2)

$L66:
	lw	$2,%lo(g_playerCount)($2)
	sll	$2,$2,3
	slt	$3,$2,10
	bnel	$3,$0,$L51
	lui	$2,%hi(GlobalIntA)

	lui	$3,%hi(GlobalIntA)
	sw	$2,%lo(GlobalIntA)($3)
$L52:
	lui	$2,%hi(pathOffset)
	jal	GetRealAddress
	lw	$4,%lo(pathOffset)($2)

	lui	$3,%hi(GlobalIntA)
	lw	$5,%lo(GlobalIntA)($3)
	jal	GoldCoinChallenge
	move	$4,$2

	lui	$2,%hi(CoinCount)
	sh	$0,%lo(CoinCount)($2)
	addiu	$2,$2,%lo(CoinCount)
	sh	$0,2($2)
	sh	$0,4($2)
	sh	$0,6($2)
	sh	$0,8($2)
	sh	$0,10($2)
	sh	$0,12($2)
	b	$L50
	sh	$0,14($2)

$L51:
	li	$3,10			# 0xa
	b	$L52
	sw	$3,%lo(GlobalIntA)($2)

$L46:
	lui	$2,%hi(SaveGame)
	lb	$3,%lo(SaveGame)($2)
	li	$2,2			# 0x2
	bne	$3,$2,$L72
	lw	$31,36($sp)

	lui	$2,%hi(g_playerCount)
	lw	$2,%lo(g_playerCount)($2)
	sll	$2,$2,3
	slt	$3,$2,10
	bnel	$3,$0,$L55
	lui	$2,%hi(GlobalIntA)

	lui	$3,%hi(GlobalIntA)
	sw	$2,%lo(GlobalIntA)($3)
$L56:
	lui	$2,%hi(g_courseID)
	lh	$2,%lo(g_courseID)($2)
	li	$3,4			# 0x4
	beq	$2,$3,$L57
	lui	$3,%hi(PathTable)

	sll	$2,$2,4
	addiu	$3,$3,%lo(PathTable)
	addu	$2,$2,$3
	jal	GetRealAddress
	lw	$4,0($2)

	lui	$3,%hi(GlobalIntA)
	lw	$5,%lo(GlobalIntA)($3)
	jal	GoldCoinChallenge
	move	$4,$2

	lui	$2,%hi(CoinCount)
$L71:
	sh	$0,%lo(CoinCount)($2)
	addiu	$2,$2,%lo(CoinCount)
	sh	$0,2($2)
	sh	$0,4($2)
	sh	$0,6($2)
	sh	$0,8($2)
	sh	$0,10($2)
	sh	$0,12($2)
	b	$L37
	sh	$0,14($2)

$L55:
	li	$3,10			# 0xa
	b	$L56
	sw	$3,%lo(GlobalIntA)($2)

$L57:
	lui	$16,%hi(GlobalIntA)
	lw	$2,%lo(GlobalIntA)($16)
	mtc1	$2,$f0
	nop
	cvt.s.w	$f2,$f0
	lui	$3,%hi($LC0)
	lwc1	$f0,%lo($LC0)($3)
	mul.s	$f0,$f2,$f0
	trunc.w.s $f0,$f0
	swc1	$f0,%lo(GlobalIntA)($16)
	lui	$17,%hi(PathTable)
	addiu	$17,$17,%lo(PathTable)
	jal	GetRealAddress
	lw	$4,64($17)

	lw	$5,%lo(GlobalIntA)($16)
	jal	GoldCoinChallenge
	move	$4,$2

	lui	$18,%hi(g_courseID)
	lh	$2,%lo(g_courseID)($18)
	sll	$2,$2,4
	addu	$2,$2,$17
	jal	GetRealAddress
	lw	$4,4($2)

	lw	$5,%lo(GlobalIntA)($16)
	jal	GoldCoinChallenge
	move	$4,$2

	lh	$2,%lo(g_courseID)($18)
	sll	$2,$2,4
	addu	$2,$2,$17
	jal	GetRealAddress
	lw	$4,8($2)

	lw	$5,%lo(GlobalIntA)($16)
	jal	GoldCoinChallenge
	move	$4,$2

	lh	$2,%lo(g_courseID)($18)
	sll	$2,$2,4
	addu	$17,$2,$17
	jal	GetRealAddress
	lw	$4,12($17)

	lw	$5,%lo(GlobalIntA)($16)
	jal	GoldCoinChallenge
	move	$4,$2

	b	$L71
	lui	$2,%hi(CoinCount)

	.set	macro
	.set	reorder
	.end	startRace
	.size	startRace, .-startRace
	.align	2
	.globl	endRace
	.set	nomips16
	.set	nomicromips
	.ent	endRace
	.type	endRace, @function
endRace:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(scrollLock)
	sb	$0,%lo(scrollLock)($2)
	lui	$2,%hi(g_gameMode)
	lw	$2,%lo(g_gameMode)($2)
	bne	$2,$0,$L81
	nop

	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	jal	checkEndGame
	nop

	beq	$2,$0,$L80
	lw	$31,20($sp)

	lui	$3,%hi(gpCourseIndex)
	lhu	$2,%lo(gpCourseIndex)($3)
	addiu	$2,$2,1
	sh	$2,%lo(gpCourseIndex)($3)
	lui	$2,%hi(g_loadedcourseFlag)
	li	$3,240			# 0xf0
	sh	$3,%lo(g_loadedcourseFlag)($2)
	lw	$31,20($sp)
$L80:
	jr	$31
	addiu	$sp,$sp,24

$L81:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	endRace
	.size	endRace, .-endRace
	.align	2
	.globl	CheckIFrames
	.set	nomips16
	.set	nomicromips
	.ent	CheckIFrames
	.type	CheckIFrames, @function
CheckIFrames:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(IFrames)
	addiu	$2,$2,%lo(IFrames)
	b	$L84
	addiu	$4,$2,16

$L83:
	addiu	$2,$2,2
$L87:
	beq	$2,$4,$L88
	nop

$L84:
	lh	$3,0($2)
	beql	$3,$0,$L87
	addiu	$2,$2,2

	addiu	$3,$3,-1
	b	$L83
	sh	$3,0($2)

$L88:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	CheckIFrames
	.size	CheckIFrames, .-CheckIFrames
	.align	2
	.globl	ExecuteItemHook
	.set	nomips16
	.set	nomicromips
	.ent	ExecuteItemHook
	.type	ExecuteItemHook, @function
ExecuteItemHook:
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
	bne	$3,$2,$L95
	move	$16,$4

	lui	$2,%hi(SaveGame+24)
$L97:
	lb	$2,%lo(SaveGame+24)($2)
	li	$3,1			# 0x1
	beq	$2,$3,$L91
	li	$3,2			# 0x2

	beql	$2,$3,$L92
	lui	$4,%hi(g_PlayerStructTable)

	beq	$2,$0,$L96
	nop

	lw	$31,20($sp)
$L98:
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

$L95:
	jal	ExecuteItem
	nop

	b	$L97
	lui	$2,%hi(SaveGame+24)

$L96:
	jal	ExecuteItem
	move	$4,$16

	b	$L98
	lw	$31,20($sp)

$L91:
	lui	$4,%hi(g_PlayerStructTable)
	addiu	$4,$4,%lo(g_PlayerStructTable)
	subu	$4,$16,$4
	srl	$4,$4,3
	li	$2,310181888			# 0x127d0000
	ori	$2,$2,0xfa39
	multu	$4,$2
	mfhi	$4
	srl	$4,$4,5
	sll	$2,$4,2
	lui	$3,%hi(GlobalController)
	addiu	$3,$3,%lo(GlobalController)
	addu	$2,$2,$3
	lw	$2,0($2)
	lhu	$2,6($2)
	andi	$2,$2,0x2000
	beq	$2,$0,$L98
	lw	$31,20($sp)

	jal	CheckExecuteItem
	nop

	beql	$2,$0,$L98
	lw	$31,20($sp)

	jal	ExecuteItem
	move	$4,$16

	b	$L98
	lw	$31,20($sp)

$L92:
	addiu	$4,$4,%lo(g_PlayerStructTable)
	subu	$4,$16,$4
	srl	$4,$4,3
	li	$2,310181888			# 0x127d0000
	ori	$2,$2,0xfa39
	multu	$4,$2
	mfhi	$4
	srl	$4,$4,5
	sll	$2,$4,2
	lui	$3,%hi(GlobalController)
	addiu	$3,$3,%lo(GlobalController)
	addu	$2,$2,$3
	lw	$2,0($2)
	lhu	$2,6($2)
	andi	$2,$2,0x2000
	beq	$2,$0,$L98
	lw	$31,20($sp)

	jal	CheckExecuteItem
	nop

	beql	$2,$0,$L98
	lw	$31,20($sp)

	jal	ExecuteItem
	move	$4,$16

	b	$L98
	lw	$31,20($sp)

	.set	macro
	.set	reorder
	.end	ExecuteItemHook
	.size	ExecuteItemHook, .-ExecuteItemHook
	.align	2
	.globl	CheckBattleCDown
	.set	nomips16
	.set	nomicromips
	.ent	CheckBattleCDown
	.type	CheckBattleCDown, @function
CheckBattleCDown:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(SaveGame+24)
	lb	$2,%lo(SaveGame+24)($2)
	li	$3,1			# 0x1
	beq	$2,$3,$L100
	li	$3,2			# 0x2

	beq	$2,$3,$L101
	lui	$2,%hi(g_playerCount)

$L120:
	jr	$31
	nop

$L100:
	lui	$2,%hi(g_playerCount)
	lw	$2,%lo(g_playerCount)($2)
	blez	$2,$L119
	nop

	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lui	$17,%hi(GlobalController)
	addiu	$17,$17,%lo(GlobalController)
	move	$16,$0
	b	$L106
	lui	$18,%hi(g_playerCount)

$L101:
	lw	$3,%lo(g_playerCount)($2)
	blez	$3,$L120
	move	$2,$0

	addiu	$2,$2,1
$L118:
	bne	$2,$3,$L118
	addiu	$2,$2,1

	jr	$31
	nop

$L119:
	jr	$31
	nop

$L105:
$L117:
	lw	$2,%lo(g_playerCount)($18)
	slt	$2,$16,$2
	beq	$2,$0,$L116
	addiu	$17,$17,4

$L106:
	lw	$2,0($17)
	lhu	$2,6($2)
	andi	$2,$2,0x4
	beql	$2,$0,$L105
	addiu	$16,$16,1

	jal	DropFlag
	move	$4,$16

	b	$L117
	addiu	$16,$16,1

$L116:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	CheckBattleCDown
	.size	CheckBattleCDown, .-CheckBattleCDown
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
$LC3:
	.ascii	"\000"
	.align	2
$LC4:
	.ascii	"Base Version -\000"
	.text
	.align	2
	.globl	gameCode
	.set	nomips16
	.set	nomicromips
	.ent	gameCode
	.type	gameCode, @function
gameCode:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 24, gp= 0
	.mask	0x800f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-48
	sw	$31,44($sp)
	sw	$19,40($sp)
	sw	$18,36($sp)
	sw	$17,32($sp)
	jal	loadFont
	sw	$16,28($sp)

	lui	$2,%hi(scrollLock)
	lbu	$2,%lo(scrollLock)($2)
	beq	$2,$0,$L185
	lui	$2,%hi(SaveGame+40)

	lui	$17,%hi(ScrollValues)
	addiu	$17,$17,%lo(ScrollValues)
	move	$16,$0
	lui	$18,%hi($LC3)
	addiu	$18,$18,%lo($LC3)
	li	$19,88			# 0x58
$L123:
	lw	$7,0($17)
	move	$6,$18
	move	$5,$16
	jal	printStringNumber
	move	$4,$0

	lw	$7,4($17)
	move	$6,$18
	addiu	$5,$16,10
	jal	printStringNumber
	move	$4,$0

	addiu	$16,$16,22
	bne	$16,$19,$L123
	addiu	$17,$17,8

	lui	$2,%hi(SaveGame+40)
$L185:
	lbu	$2,%lo(SaveGame+40)($2)
	beq	$2,$0,$L124
	li	$2,4			# 0x4

	sw	$2,20($sp)
	li	$2,240			# 0xf0
	sw	$2,16($sp)
	li	$7,512			# 0x200
	lui	$6,%hi(Pirate)
	addiu	$6,$6,%lo(Pirate)
	li	$5,120			# 0x78
	jal	KWSpriteDiv
	li	$4,256			# 0x100

	lw	$31,44($sp)
$L179:
	lw	$19,40($sp)
	lw	$18,36($sp)
	lw	$17,32($sp)
	lw	$16,28($sp)
	jr	$31
	addiu	$sp,$sp,48

$L124:
	jal	CheckIFrames
	nop

	lui	$2,%hi(SaveGame+13)
	lb	$2,%lo(SaveGame+13)($2)
	bne	$2,$0,$L126
	lui	$2,%hi(g_gameMode)

	lw	$3,%lo(g_gameMode)($2)
	li	$2,1			# 0x1
	bne	$3,$2,$L158
	nop

	lui	$2,%hi(HotSwapID)
	lh	$2,%lo(HotSwapID)($2)
	blez	$2,$L129
	nop

	lui	$2,%hi(OverKartHeader+122)
	jal	StaticTempo
	lb	$4,%lo(OverKartHeader+122)($2)

	b	$L173
	lui	$2,%hi(g_gameMode)

$L158:
	jal	DynamicTempo
	nop

	b	$L173
	lui	$2,%hi(g_gameMode)

$L129:
	jal	StaticTempo
	li	$4,2			# 0x2

	b	$L173
	lui	$2,%hi(g_gameMode)

$L126:
	jal	StaticTempo
	li	$4,2			# 0x2

	lui	$2,%hi(g_gameMode)
$L173:
	lw	$3,%lo(g_gameMode)($2)
	li	$2,3			# 0x3
	beq	$3,$2,$L159
	lui	$2,%hi(SaveGame+24)

	lui	$2,%hi(MapModeCheck)
$L174:
	lh	$2,%lo(MapModeCheck)($2)
	bne	$2,$0,$L133
	lui	$2,%hi(SaveGame)

	lb	$3,%lo(SaveGame)($2)
	li	$2,3			# 0x3
	bne	$3,$2,$L186
	lui	$2,%hi(SaveGame+7)

$L133:
	jal	practiceHack
	nop

	lui	$2,%hi(SaveGame+7)
$L186:
	lb	$3,%lo(SaveGame+7)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L160
	nop

	lui	$2,%hi(SaveGame)
$L175:
	addiu	$2,$2,%lo(SaveGame)
	lb	$3,6($2)
	sltu	$3,$0,$3
	lui	$4,%hi(SurfaceExplorerMode)
	sb	$3,%lo(SurfaceExplorerMode)($4)
	lb	$2,16($2)
	bgtz	$2,$L161
	nop

	lui	$2,%hi(SaveGame+17)
$L176:
	lb	$2,%lo(SaveGame+17)($2)
	bgtz	$2,$L162
	nop

	lui	$2,%hi(HotSwapID)
$L177:
	lh	$2,%lo(HotSwapID)($2)
	blez	$2,$L138
	lui	$2,%hi(g_gamePausedFlag)

	lb	$2,%lo(g_gamePausedFlag)($2)
	bne	$2,$0,$L152
	lui	$2,%hi($LC1)

	lui	$2,%hi(scrollLock)
	lbu	$2,%lo(scrollLock)($2)
	bne	$2,$0,$L163
	lui	$2,%hi($LC1)

	b	$L139
	lwc1	$f0,%lo($LC1)($2)

$L159:
	lb	$2,%lo(SaveGame+24)($2)
	li	$3,1			# 0x1
	beq	$2,$3,$L131
	li	$3,2			# 0x2

	bnel	$2,$3,$L174
	lui	$2,%hi(MapModeCheck)

	jal	CaptureBalls
	nop

	b	$L174
	lui	$2,%hi(MapModeCheck)

$L131:
	jal	CaptureFlag
	nop

	b	$L174
	lui	$2,%hi(MapModeCheck)

$L160:
	jal	RunFlyCam
	nop

	b	$L175
	lui	$2,%hi(SaveGame)

$L161:
	jal	drawInputDisplay
	nop

	b	$L176
	lui	$2,%hi(SaveGame+17)

$L162:
	jal	printDetails
	nop

	b	$L177
	lui	$2,%hi(HotSwapID)

$L163:
	jal	runTextureScroll
	nop

	jal	CheckOKObjects
	nop

	jal	runDisplayScreen
	nop

	jal	runWaterVertex
	nop

	jal	LavaFloorRecoil
	nop

	jal	CheckPaths
	nop

	lui	$2,%hi(HotSwapID)
	lh	$2,%lo(HotSwapID)($2)
	blez	$2,$L138
	lui	$2,%hi($LC1)

	b	$L139
	lwc1	$f0,%lo($LC1)($2)

$L138:
	lui	$2,%hi(SaveGame+12)
	lb	$3,%lo(SaveGame+12)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L155
	lui	$2,%hi($LC2)

	b	$L139
	lwc1	$f0,%lo($LC2)($2)

$L152:
	lwc1	$f0,%lo($LC1)($2)
$L139:
	lui	$2,%hi(g_farClip)
	swc1	$f0,%lo(g_farClip)($2)
	lui	$2,%hi(g_startingIndicator)
	lw	$3,%lo(g_startingIndicator)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L164
	lui	$2,%hi(raceStatus)

$L140:
	lui	$2,%hi(g_startingIndicator)
	lw	$3,%lo(g_startingIndicator)($2)
	li	$2,2			# 0x2
	beq	$3,$2,$L165
	lui	$2,%hi(raceStatus)

$L142:
	lui	$2,%hi(g_startingIndicator)
	lw	$3,%lo(g_startingIndicator)($2)
	li	$2,3			# 0x3
	beq	$3,$2,$L166
	lui	$2,%hi(g_startingIndicator)

$L184:
	lw	$3,%lo(g_startingIndicator)($2)
	li	$2,5			# 0x5
	bne	$3,$2,$L143
	lui	$2,%hi(raceStatus)

	lh	$3,%lo(raceStatus)($2)
	li	$2,5			# 0x5
	beq	$3,$2,$L149
	lui	$2,%hi(gpTotalTime)

	lwc1	$f0,%lo(gpTotalTime)($2)
	lui	$3,%hi(g_TrialTime)
	lwc1	$f2,%lo(g_TrialTime)($3)
	add.s	$f0,$f0,$f2
	swc1	$f0,%lo(gpTotalTime)($2)
	lui	$2,%hi(raceStatus)
	li	$3,5			# 0x5
	sh	$3,%lo(raceStatus)($2)
$L149:
	lui	$2,%hi(g_gameMode)
	lw	$2,%lo(g_gameMode)($2)
	bnel	$2,$0,$L183
	lui	$2,%hi(SaveGame+15)

	li	$5,30			# 0x1e
	lui	$2,%hi(gpTotalTime)
	jal	printGPTime
	lwc1	$f12,%lo(gpTotalTime)($2)

	b	$L178
	lui	$2,%hi(g_startingIndicator)

$L155:
	lui	$2,%hi($LC1)
	b	$L139
	lwc1	$f0,%lo($LC1)($2)

$L164:
	lh	$3,%lo(raceStatus)($2)
	li	$2,1			# 0x1
	bne	$3,$2,$L167
	lui	$2,%hi(raceStatus)

$L141:
	lui	$2,%hi(GlobalShortD)
	b	$L140
	sh	$0,%lo(GlobalShortD)($2)

$L167:
	li	$3,1			# 0x1
	jal	startRace
	sh	$3,%lo(raceStatus)($2)

	li	$2,-1			# 0xffffffffffffffff
	lui	$3,%hi(hsLabel)
	sh	$2,%lo(hsLabel)($3)
	lui	$3,%hi(MenuChanged)
	b	$L141
	sb	$2,%lo(MenuChanged)($3)

$L165:
	li	$3,2			# 0x2
	sh	$3,%lo(raceStatus)($2)
	lui	$2,%hi(scrollLock)
	li	$3,1			# 0x1
	sb	$3,%lo(scrollLock)($2)
	lui	$2,%hi(GlobalShortD)
	lh	$2,%lo(GlobalShortD)($2)
	slt	$2,$2,60
	bne	$2,$0,$L168
	nop

$L143:
	lui	$2,%hi(g_startingIndicator)
$L178:
	lw	$2,%lo(g_startingIndicator)($2)
	li	$3,6			# 0x6
	bnel	$2,$3,$L187
	li	$3,7			# 0x7

	lui	$2,%hi(raceStatus)
	sh	$3,%lo(raceStatus)($2)
$L150:
	lui	$2,%hi(SaveGame+15)
$L183:
	lb	$3,%lo(SaveGame+15)($2)
	li	$2,1			# 0x1
	bnel	$3,$2,$L179
	lw	$31,44($sp)

	li	$5,10			# 0xa
	jal	DrawFPS
	li	$4,220			# 0xdc

	b	$L179
	lw	$31,44($sp)

$L168:
	jal	printAnticheat
	li	$4,1			# 0x1

	lui	$2,%hi(HotSwapID)
	lh	$2,%lo(HotSwapID)($2)
	bgtz	$2,$L169
	lui	$3,%hi(GlobalShortD)

$L180:
	lhu	$2,%lo(GlobalShortD)($3)
	addiu	$2,$2,1
	b	$L142
	sh	$2,%lo(GlobalShortD)($3)

$L169:
	jal	loadFont
	nop

	lui	$2,%hi(ok_Credits)
	lw	$2,%lo(ok_Credits)($2)
	lui	$3,%hi(GlobalIntA)
	bne	$2,$0,$L170
	sw	$2,%lo(GlobalIntA)($3)

	lui	$2,%hi(ok_SerialKey)
$L181:
	lw	$2,%lo(ok_SerialKey)($2)
	lui	$3,%hi(GlobalIntA)
	sw	$2,%lo(GlobalIntA)($3)
	lui	$3,%hi(g_gameMode)
	lw	$4,%lo(g_gameMode)($3)
	li	$3,1			# 0x1
	beq	$4,$3,$L171
	nop

	lui	$2,%hi(g_gameMode)
$L182:
	lw	$2,%lo(g_gameMode)($2)
	bne	$2,$0,$L180
	lui	$3,%hi(GlobalShortD)

	move	$5,$0
	lui	$2,%hi(gpTotalTime)
	jal	printGPTime
	lwc1	$f12,%lo(gpTotalTime)($2)

	lui	$2,%hi(HotSwapID)
	lh	$2,%lo(HotSwapID)($2)
	blezl	$2,$L180
	lui	$3,%hi(GlobalShortD)

	jal	hsTableSet
	nop

	b	$L180
	lui	$3,%hi(GlobalShortD)

$L170:
	li	$3,35			# 0x23
	subu	$2,$3,$2
	lui	$6,%hi(ok_Credits+4)
	addiu	$6,$6,%lo(ok_Credits+4)
	li	$5,150			# 0x96
	jal	printString
	sll	$4,$2,2

	b	$L181
	lui	$2,%hi(ok_SerialKey)

$L171:
	beq	$2,$0,$L180
	lui	$3,%hi(GlobalShortD)

	li	$3,35			# 0x23
	subu	$2,$3,$2
	lui	$6,%hi(ok_SerialKey+4)
	addiu	$6,$6,%lo(ok_SerialKey+4)
	li	$5,160			# 0xa0
	jal	printString
	sll	$4,$2,2

	lui	$2,%hi(OverKartHeader)
	lw	$7,%lo(OverKartHeader)($2)
	lui	$6,%hi($LC4)
	addiu	$6,$6,%lo($LC4)
	li	$5,170			# 0xaa
	jal	printStringNumber
	li	$4,76			# 0x4c

	b	$L182
	lui	$2,%hi(g_gameMode)

$L166:
	lui	$2,%hi(raceStatus)
	li	$3,3			# 0x3
	sh	$3,%lo(raceStatus)($2)
	lui	$2,%hi(SaveGame)
	lb	$3,%lo(SaveGame)($2)
	li	$2,2			# 0x2
	beq	$3,$2,$L172
	lui	$2,%hi(HotSwapID)

$L148:
	lui	$2,%hi(g_startingIndicator)
$L188:
	lw	$2,%lo(g_startingIndicator)($2)
	li	$3,7			# 0x7
$L187:
	bne	$2,$3,$L150
	lui	$2,%hi(raceStatus)

	lh	$3,%lo(raceStatus)($2)
	li	$2,7			# 0x7
	beql	$3,$2,$L183
	lui	$2,%hi(SaveGame+15)

	lui	$2,%hi(raceStatus)
	li	$3,7			# 0x7
	jal	endRace
	sh	$3,%lo(raceStatus)($2)

	b	$L183
	lui	$2,%hi(SaveGame+15)

$L172:
	lh	$2,%lo(HotSwapID)($2)
	blez	$2,$L148
	lui	$2,%hi(g_menuMultiplayerSelection)

	lb	$3,%lo(g_menuMultiplayerSelection)($2)
	li	$2,1			# 0x1
	bnel	$3,$2,$L188
	lui	$2,%hi(g_startingIndicator)

	jal	DisplayCoinSprite
	nop

	b	$L184
	lui	$2,%hi(g_startingIndicator)

	.set	macro
	.set	reorder
	.end	gameCode
	.size	gameCode, .-gameCode
	.align	2
	.globl	resetMap
	.set	nomips16
	.set	nomicromips
	.ent	resetMap
	.type	resetMap, @function
resetMap:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$2,%hi(gpTotalTime)
	sw	$0,%lo(gpTotalTime)($2)
	lui	$2,%hi(gpCourseIndex)
	jr	$31
	sh	$0,%lo(gpCourseIndex)($2)

	.set	macro
	.set	reorder
	.end	resetMap
	.size	resetMap, .-resetMap
	.align	2
	.globl	SearchJRK0
	.set	nomips16
	.set	nomicromips
	.ent	SearchJRK0
	.type	SearchJRK0, @function
SearchJRK0:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	li	$2,-2147483648			# 0xffffffff80000000
	li	$4,54525952			# 0x3400000
	addiu	$4,$4,8
	li	$5,-2139095040			# 0xffffffff80800000
	lw	$3,0($2)
$L194:
	beq	$3,$4,$L195
	nop

	addiu	$2,$2,4
	bnel	$2,$5,$L194
	lw	$3,0($2)

	move	$2,$0
$L195:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	SearchJRK0
	.size	SearchJRK0, .-SearchJRK0
	.align	2
	.globl	allRun
	.set	nomips16
	.set	nomicromips
	.ent	allRun
	.type	allRun, @function
allRun:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	jal	MakeRandom
	sw	$16,16($sp)

	lui	$2,%hi(GlobalController+16)
	lw	$2,%lo(GlobalController+16)($2)
	lhu	$2,6($2)
	bne	$2,$0,$L230
	nop

	lui	$2,%hi(SaveGame+14)
$L236:
	lb	$3,%lo(SaveGame+14)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L198
	li	$3,14			# 0xe

	li	$3,320			# 0x140
$L198:
	lui	$2,%hi(CullDL_Parameters)
	sw	$3,%lo(CullDL_Parameters)($2)
	lui	$2,%hi(GlobalIntD)
	jal	osGetCount
	sw	$0,%lo(GlobalIntD)($2)

	lui	$3,%hi(ClockCycle)
	sw	$2,%lo(ClockCycle)($3)
	lui	$4,%hi(OldCycle)
	lw	$3,%lo(OldCycle)($4)
	subu	$3,$2,$3
	lui	$5,%hi(CycleCount)
	sw	$3,%lo(CycleCount)($5)
	sw	$2,%lo(OldCycle)($4)
	lui	$3,%hi(GlobalFrameCount)
	lw	$2,%lo(GlobalFrameCount)($3)
	addiu	$2,$2,1
	sw	$2,%lo(GlobalFrameCount)($3)
	lui	$2,%hi(startupSwitch)
	lh	$2,%lo(startupSwitch)($2)
	li	$3,1			# 0x1
	beq	$2,$3,$L199
	li	$3,2			# 0x2

	beq	$2,$3,$L200
	nop

	beq	$2,$0,$L231
	nop

$L201:
	lui	$2,%hi(gMatrixCount)
$L237:
	sh	$0,%lo(gMatrixCount)($2)
	lui	$2,%hi(HotSwapID)
	lh	$3,%lo(HotSwapID)($2)
	beq	$3,$0,$L202
	li	$2,1			# 0x1

	lui	$2,%hi(OverKartHeader+121)
	lb	$2,%lo(OverKartHeader+121)($2)
	xori	$2,$2,0x1
	sltu	$2,$2,1
$L202:
	lui	$3,%hi(gBackgroundFlag)
	sh	$2,%lo(gBackgroundFlag)($3)
	lui	$2,%hi(SaveGame+3)
	lb	$2,%lo(SaveGame+3)($2)
	blez	$2,$L203
	lui	$2,%hi(asm_CupCount)

	li	$3,15			# 0xf
	sh	$3,%lo(asm_CupCount)($2)
	lui	$2,%hi(g_startingIndicator)
	lw	$2,%lo(g_startingIndicator)($2)
	slt	$2,$2,6
	bne	$2,$0,$L240
	lui	$16,%hi(OverKartHeader)

	lui	$2,%hi(gpCourseIndex)
	lh	$3,%lo(gpCourseIndex)($2)
	li	$2,16			# 0x10
	beq	$3,$2,$L232
	lui	$2,%hi(g_NewSequenceMode)

$L204:
	lui	$16,%hi(OverKartHeader)
$L240:
	addiu	$16,$16,%lo(OverKartHeader)
$L241:
	lb	$4,68($16)
	xori	$4,$4,0x3
	jal	SetWeather3D
	sltu	$4,$4,1

	jal	SetWaterType
	lb	$4,141($16)

	lui	$2,%hi(SYSTEM_Region)
	lw	$3,%lo(SYSTEM_Region)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L233
	lui	$2,%hi(HotSwapID)

$L205:
	lui	$2,%hi(KBGNumber)
	lw	$2,%lo(KBGNumber)($2)
	addiu	$2,$2,-6
	sltu	$3,$2,8
	beq	$3,$0,$L209
	sll	$2,$2,2

	lui	$3,%hi($L211)
	addiu	$3,$3,%lo($L211)
	addu	$2,$3,$2
	lw	$2,0($2)
	jr	$2
	nop

	.rdata
	.align	2
	.align	2
$L211:
	.word	$L216
	.word	$L209
	.word	$L215
	.word	$L209
	.word	$L214
	.word	$L213
	.word	$L212
	.word	$L210
	.text
$L230:
	jal	MakeRandom
	nop

	b	$L236
	lui	$2,%hi(SaveGame+14)

$L231:
	jal	okSetup
	nop

	b	$L237
	lui	$2,%hi(gMatrixCount)

$L199:
	lui	$2,%hi(GlobalController)
	lw	$3,%lo(GlobalController)($2)
	lhu	$2,4($3)
	andi	$2,$2,0x20
	beq	$2,$0,$L237
	lui	$2,%hi(gMatrixCount)

	lhu	$2,6($3)
	andi	$2,$2,0x400
	beql	$2,$0,$L237
	lui	$2,%hi(gMatrixCount)

	lui	$2,%hi(MapModeCheck)
	li	$3,1			# 0x1
	b	$L201
	sh	$3,%lo(MapModeCheck)($2)

$L200:
	jal	modCheck
	nop

	b	$L237
	lui	$2,%hi(gMatrixCount)

$L232:
	li	$3,1			# 0x1
	sw	$3,%lo(g_NewSequenceMode)($2)
	lui	$2,%hi(KBGNumber)
	li	$3,11			# 0xb
	b	$L204
	sw	$3,%lo(KBGNumber)($2)

$L203:
	li	$3,3			# 0x3
	sh	$3,%lo(asm_CupCount)($2)
	lui	$2,%hi(g_startingIndicator)
	lw	$2,%lo(g_startingIndicator)($2)
	slt	$2,$2,6
	bne	$2,$0,$L240
	lui	$16,%hi(OverKartHeader)

	lui	$2,%hi(gpCourseIndex)
	lh	$3,%lo(gpCourseIndex)($2)
	li	$2,4			# 0x4
	bne	$3,$2,$L241
	addiu	$16,$16,%lo(OverKartHeader)

	lui	$2,%hi(g_NewSequenceMode)
	li	$3,1			# 0x1
	sw	$3,%lo(g_NewSequenceMode)($2)
	lui	$2,%hi(KBGNumber)
	li	$3,11			# 0xb
	b	$L204
	sw	$3,%lo(KBGNumber)($2)

$L233:
	lh	$2,%lo(HotSwapID)($2)
	blez	$2,$L206
	lui	$2,%hi(g_gameMode)

	lw	$3,%lo(g_gameMode)($2)
	li	$2,3			# 0x3
	beq	$3,$2,$L207
	lui	$2,%hi(g_courseID)

	b	$L205
	sh	$0,%lo(g_courseID)($2)

$L207:
	li	$3,15			# 0xf
	b	$L205
	sh	$3,%lo(g_courseID)($2)

$L206:
	lui	$2,%hi(g_courseID)
	lh	$3,%lo(g_courseID)($2)
	li	$2,20			# 0x14
	bne	$3,$2,$L205
	lui	$2,%hi(g_player1ScreenWidth)

	li	$3,576			# 0x240
	b	$L205
	sh	$3,%lo(g_player1ScreenWidth)($2)

$L216:
	lui	$2,%hi(MenuChanged)
	lb	$2,%lo(MenuChanged)($2)
	li	$3,6			# 0x6
	beq	$2,$3,$L217
	lui	$3,%hi(LastMenuID)

	sh	$2,%lo(LastMenuID)($3)
	lui	$2,%hi(MenuChanged)
	li	$3,6			# 0x6
	sb	$3,%lo(MenuChanged)($2)
$L217:
	jal	GameOptionsHandler
	li	$4,4			# 0x4

$L196:
	lw	$31,28($sp)
$L238:
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

$L215:
	lui	$2,%hi(MenuChanged)
	lb	$2,%lo(MenuChanged)($2)
	li	$3,8			# 0x8
	beq	$2,$3,$L196
	lui	$3,%hi(LastMenuID)

	sh	$2,%lo(LastMenuID)($3)
	lui	$2,%hi(MenuChanged)
	li	$3,8			# 0x8
	b	$L196
	sb	$3,%lo(MenuChanged)($2)

$L214:
	lui	$2,%hi(MenuChanged)
	lb	$2,%lo(MenuChanged)($2)
	li	$3,10			# 0xa
	beq	$2,$3,$L238
	lw	$31,28($sp)

	lui	$3,%hi(LastMenuID)
	sh	$2,%lo(LastMenuID)($3)
	lui	$2,%hi(MenuChanged)
	li	$3,10			# 0xa
	sb	$3,%lo(MenuChanged)($2)
	lui	$2,%hi(MenuIndex)
	jal	loadCoinSprite
	sw	$0,%lo(MenuIndex)($2)

	jal	loadArrows
	lui	$16,%hi(SaveGame)

	jal	loadNumberSprites
	addiu	$16,$16,%lo(SaveGame)

	jal	loadCoin
	nop

	lui	$2,%hi(startupSwitch)
	li	$3,2			# 0x2
	jal	DPR
	sh	$3,%lo(startupSwitch)($2)

	jal	DPRSave
	sb	$2,40($16)

	lb	$2,41($16)
	li	$3,7			# 0x7
	beq	$2,$3,$L219
	li	$3,99			# 0x63

	beq	$2,$3,$L219
	lui	$2,%hi(SaveGame+41)

	li	$3,7			# 0x7
	sb	$3,%lo(SaveGame+41)($2)
	move	$2,$0
	lui	$8,%hi(renderMode)
	lui	$7,%hi(gameMode)
	lui	$6,%hi(mapMode)
	lui	$5,%hi(battleMode)
	li	$4,8			# 0x8
$L220:
	lw	$3,%lo(renderMode)($8)
	addu	$3,$3,$2
	sb	$0,0($3)
	lw	$3,%lo(gameMode)($7)
	addu	$3,$3,$2
	sb	$0,0($3)
	lw	$3,%lo(mapMode)($6)
	addu	$3,$3,$2
	sb	$0,0($3)
	lw	$3,%lo(battleMode)($5)
	addu	$3,$3,$2
	addiu	$2,$2,1
	bne	$2,$4,$L220
	sb	$0,0($3)

	lui	$5,%hi(renderMode)
	li	$4,16			# 0x10
$L221:
	lw	$3,%lo(renderMode)($5)
	addu	$3,$3,$2
	addiu	$2,$2,1
	bne	$2,$4,$L221
	sb	$0,0($3)

	lui	$2,%hi(SaveGame)
	addiu	$2,$2,%lo(SaveGame)
	li	$3,1			# 0x1
	sb	$3,10($2)
	sb	$3,13($2)
	sb	$3,14($2)
	li	$3,2			# 0x2
	sb	$3,32($2)
	sb	$3,33($2)
	sb	$3,34($2)
$L219:
	lui	$2,%hi(scrollLock)
	sb	$0,%lo(scrollLock)($2)
	lui	$2,%hi(g_startingIndicator)
	b	$L196
	sw	$0,%lo(g_startingIndicator)($2)

$L213:
	lui	$2,%hi(MenuChanged)
	lb	$2,%lo(MenuChanged)($2)
	li	$3,11			# 0xb
	bne	$2,$3,$L234
	lui	$3,%hi(menuScreenB)

$L222:
	jal	copyCourseTable
	move	$4,$0

	b	$L238
	lw	$31,28($sp)

$L234:
	li	$4,3			# 0x3
	sb	$4,%lo(menuScreenB)($3)
	lui	$3,%hi(LastMenuID)
	sh	$2,%lo(LastMenuID)($3)
	lui	$2,%hi(MenuChanged)
	li	$3,11			# 0xb
	sb	$3,%lo(MenuChanged)($2)
	lui	$18,%hi(sourceAddress)
	lw	$4,%lo(sourceAddress)($18)
	lui	$2,%hi(ROptionROM)
	addiu	$3,$2,%lo(ROptionROM)
	sw	$3,0($4)
	lui	$17,%hi(targetAddress)
	lw	$2,%lo(targetAddress)($17)
	lui	$16,%hi(ok_FreeSpace)
	addiu	$16,$16,%lo(ok_FreeSpace)
	sw	$16,0($2)
	lui	$2,%hi(ROptionEnd)
	addiu	$2,$2,%lo(ROptionEnd)
	subu	$2,$2,$3
	lui	$3,%hi(dataLength)
	jal	runDMA
	sw	$2,%lo(dataLength)($3)

	lw	$2,%lo(sourceAddress)($18)
	sw	$16,0($2)
	lw	$3,%lo(targetAddress)($17)
	lui	$2,%hi(ok_Storage)
	addiu	$2,$2,%lo(ok_Storage)
	sw	$2,0($3)
	lui	$3,%hi(MenuIconsRAM)
	jal	runMIO
	sw	$2,%lo(MenuIconsRAM)($3)

	lui	$3,%hi(GlobalAddressA)
	sw	$2,%lo(GlobalAddressA)($3)
	lui	$2,%hi(scrollLock)
	sb	$0,%lo(scrollLock)($2)
	lui	$2,%hi(g_startingIndicator)
	sw	$0,%lo(g_startingIndicator)($2)
	lui	$4,%hi(SaveGame)
	jal	saveEEPROM
	addiu	$4,$4,%lo(SaveGame)

	b	$L222
	nop

$L212:
	lui	$2,%hi(MenuChanged)
	lb	$3,%lo(MenuChanged)($2)
	li	$2,12			# 0xc
	beq	$3,$2,$L196
	lui	$2,%hi(g_gameMode)

	lw	$3,%lo(g_gameMode)($2)
	li	$2,3			# 0x3
	beq	$3,$2,$L235
	nop

	jal	SetMenuPanels
	move	$4,$0

	lui	$2,%hi(MenuProgress)
$L239:
	sb	$0,%lo(MenuProgress)($2)
	addiu	$2,$2,%lo(MenuProgress)
	sb	$0,1($2)
	sb	$0,2($2)
	sb	$0,3($2)
	lui	$2,%hi(MenuChanged)
	lb	$4,%lo(MenuChanged)($2)
	lui	$3,%hi(LastMenuID)
	sh	$4,%lo(LastMenuID)($3)
	li	$3,12			# 0xc
	sb	$3,%lo(MenuChanged)($2)
	lui	$2,%hi(scrollLock)
	sb	$0,%lo(scrollLock)($2)
	lui	$2,%hi(HotSwapID)
	sh	$0,%lo(HotSwapID)($2)
	jal	copyCourseTable
	move	$4,$0

	b	$L238
	lw	$31,28($sp)

$L235:
	jal	SetMenuPanels
	li	$4,1			# 0x1

	b	$L239
	lui	$2,%hi(MenuProgress)

$L210:
	lui	$2,%hi(MenuChanged)
	lb	$2,%lo(MenuChanged)($2)
	li	$3,13			# 0xd
	beq	$2,$3,$L238
	lw	$31,28($sp)

	lui	$3,%hi(LastMenuID)
	sh	$2,%lo(LastMenuID)($3)
	lui	$2,%hi(MenuChanged)
	li	$3,13			# 0xd
	sb	$3,%lo(MenuChanged)($2)
	lui	$18,%hi(sourceAddress)
	lw	$4,%lo(sourceAddress)($18)
	lui	$2,%hi(ROptionROM)
	addiu	$3,$2,%lo(ROptionROM)
	sw	$3,0($4)
	lui	$17,%hi(targetAddress)
	lw	$2,%lo(targetAddress)($17)
	lui	$16,%hi(ok_FreeSpace)
	addiu	$16,$16,%lo(ok_FreeSpace)
	sw	$16,0($2)
	lui	$2,%hi(ROptionEnd)
	addiu	$2,$2,%lo(ROptionEnd)
	subu	$2,$2,$3
	lui	$3,%hi(dataLength)
	jal	runDMA
	sw	$2,%lo(dataLength)($3)

	lw	$2,%lo(sourceAddress)($18)
	sw	$16,0($2)
	lw	$3,%lo(targetAddress)($17)
	lui	$2,%hi(ok_Storage)
	addiu	$2,$2,%lo(ok_Storage)
	sw	$2,0($3)
	lui	$3,%hi(MenuIconsRAM)
	jal	runMIO
	sw	$2,%lo(MenuIconsRAM)($3)

	lui	$3,%hi(GlobalAddressA)
	sw	$2,%lo(GlobalAddressA)($3)
	lui	$2,%hi(MenuIndex)
	jal	resetMap
	sw	$0,%lo(MenuIndex)($2)

	jal	setAlwaysAdvance
	nop

	lui	$2,%hi(HotSwapID)
	sh	$0,%lo(HotSwapID)($2)
	jal	copyCourseTable
	move	$4,$0

	jal	setPreviews
	nop

	jal	previewRefresh
	nop

	jal	setBanners
	nop

	li	$2,-1			# 0xffffffffffffffff
	lui	$3,%hi(hsLabel)
	sh	$2,%lo(hsLabel)($3)
	lui	$3,%hi(courseValue)
	sh	$2,%lo(courseValue)($3)
	lui	$2,%hi(scrollLock)
	sb	$0,%lo(scrollLock)($2)
	lui	$2,%hi(g_startingIndicator)
	b	$L196
	sw	$0,%lo(g_startingIndicator)($2)

$L209:
	li	$2,-1			# 0xffffffffffffffff
	lui	$3,%hi(hsLabel)
	sh	$2,%lo(hsLabel)($3)
	lui	$3,%hi(MenuChanged)
	b	$L196
	sb	$2,%lo(MenuChanged)($3)

	.set	macro
	.set	reorder
	.end	allRun
	.size	allRun, .-allRun
	.align	2
	.globl	PrintMenuFunction
	.set	nomips16
	.set	nomicromips
	.ent	PrintMenuFunction
	.type	PrintMenuFunction, @function
PrintMenuFunction:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	PrintMenuFunction
	.size	PrintMenuFunction, .-PrintMenuFunction
	.align	2
	.globl	ScreenDrawHook
	.set	nomips16
	.set	nomicromips
	.ent	ScreenDrawHook
	.type	ScreenDrawHook, @function
ScreenDrawHook:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	jal	DoObjBlock
	move	$4,$0

	lw	$31,20($sp)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	ScreenDrawHook
	.size	ScreenDrawHook, .-ScreenDrawHook
	.globl	ROptionPressed
	.section	.bss,"aw",@nobits
	.align	2
	.type	ROptionPressed, @object
	.size	ROptionPressed, 4
ROptionPressed:
	.space	4
	.globl	LastMenuID
	.align	1
	.type	LastMenuID, @object
	.size	LastMenuID, 2
LastMenuID:
	.space	2
	.globl	MapModeCheck
	.align	1
	.type	MapModeCheck, @object
	.size	MapModeCheck, 2
MapModeCheck:
	.space	2
	.globl	RandomDPR
	.align	2
	.type	RandomDPR, @object
	.size	RandomDPR, 4
RandomDPR:
	.space	4
	.globl	DPRTester
	.align	2
	.type	DPRTester, @object
	.size	DPRTester, 4
DPRTester:
	.space	4
	.section	.rodata.cst4,"aM",@progbits,4
	.align	2
$LC0:
	.word	1050253722
	.align	2
$LC1:
	.word	1184645120
	.align	2
$LC2:
	.word	1171554304
	.ident	"GCC: (GNU) 10.1.0"
