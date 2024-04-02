	.file	1 "OverKartVariables.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.globl	stickNames
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
$LC0:
	.ascii	"U\000"
	.align	2
$LC1:
	.ascii	"D\000"
	.align	2
$LC2:
	.ascii	"L\000"
	.align	2
$LC3:
	.ascii	"R\000"
	.align	2
$LC4:
	.ascii	"S\000"
	.data
	.align	4
	.type	stickNames, @object
	.size	stickNames, 20
stickNames:
	.word	$LC0
	.word	$LC1
	.word	$LC2
	.word	$LC3
	.word	$LC4
	.globl	names
	.section	.rodata.str1.4
	.align	2
$LC5:
	.ascii	"A\000"
	.align	2
$LC6:
	.ascii	"B\000"
	.align	2
$LC7:
	.ascii	"Z\000"
	.align	2
$LC8:
	.ascii	"\000"
	.data
	.align	4
	.type	names, @object
	.size	names, 64
names:
	.word	$LC5
	.word	$LC6
	.word	$LC7
	.word	$LC4
	.word	$LC0
	.word	$LC1
	.word	$LC2
	.word	$LC3
	.word	$LC8
	.word	$LC8
	.word	$LC2
	.word	$LC3
	.word	$LC0
	.word	$LC1
	.word	$LC2
	.word	$LC3
	.globl	mapChar
	.align	4
	.type	mapChar, @object
	.size	mapChar, 168
mapChar:
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	2
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	3
	.word	2
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	3
	.word	2
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.globl	mapLimits
	.align	4
	.type	mapLimits, @object
	.size	mapLimits, 24
mapLimits:
	.word	7
	.word	7
	.word	7
	.word	2
	.word	2
	.word	2
	.globl	mapParameters
	.section	.rodata.str1.4
	.align	2
$LC9:
	.ascii	"0.0\000"
	.align	2
$LC10:
	.ascii	"0.5\000"
	.align	2
$LC11:
	.ascii	"1.0\000"
	.align	2
$LC12:
	.ascii	"1.5\000"
	.align	2
$LC13:
	.ascii	"2.0\000"
	.align	2
$LC14:
	.ascii	"2.5\000"
	.align	2
$LC15:
	.ascii	"3.0\000"
	.align	2
$LC16:
	.ascii	"Off\000"
	.align	2
$LC17:
	.ascii	"On\000"
	.data
	.align	4
	.type	mapParameters, @object
	.size	mapParameters, 168
mapParameters:
	.word	$LC9
	.word	$LC10
	.word	$LC11
	.word	$LC12
	.word	$LC13
	.word	$LC14
	.word	$LC15
	.word	$LC9
	.word	$LC10
	.word	$LC11
	.word	$LC12
	.word	$LC13
	.word	$LC14
	.word	$LC15
	.word	$LC9
	.word	$LC10
	.word	$LC11
	.word	$LC12
	.word	$LC13
	.word	$LC14
	.word	$LC15
	.word	$LC16
	.word	$LC17
	.word	$LC8
	.word	$LC8
	.word	$LC8
	.word	$LC8
	.word	$LC8
	.word	$LC16
	.word	$LC17
	.word	$LC8
	.word	$LC8
	.word	$LC8
	.word	$LC8
	.word	$LC8
	.word	$LC16
	.word	$LC17
	.word	$LC8
	.word	$LC8
	.word	$LC8
	.word	$LC8
	.word	$LC8
	.globl	mapOptions
	.section	.rodata.str1.4
	.align	2
$LC18:
	.ascii	"X Scale\000"
	.align	2
$LC19:
	.ascii	"Y Scale\000"
	.align	2
$LC20:
	.ascii	"Z Scale\000"
	.align	2
$LC21:
	.ascii	"X Mirror\000"
	.align	2
$LC22:
	.ascii	"Y Mirror\000"
	.align	2
$LC23:
	.ascii	"Z Mirror\000"
	.data
	.align	4
	.type	mapOptions, @object
	.size	mapOptions, 24
mapOptions:
	.word	$LC18
	.word	$LC19
	.word	$LC20
	.word	$LC21
	.word	$LC22
	.word	$LC23
	.globl	renderChar
	.align	4
	.type	renderChar, @object
	.size	renderChar, 108
renderChar:
	.word	3
	.word	2
	.word	0
	.word	3
	.word	2
	.word	0
	.word	3
	.word	2
	.word	0
	.word	10
	.word	8
	.word	0
	.word	7
	.word	8
	.word	0
	.word	7
	.word	8
	.word	0
	.word	3
	.word	2
	.word	0
	.word	3
	.word	2
	.word	0
	.word	3
	.word	2
	.word	8
	.globl	renderLimits
	.align	4
	.type	renderLimits, @object
	.size	renderLimits, 36
renderLimits:
	.word	2
	.word	2
	.word	2
	.word	2
	.word	2
	.word	2
	.word	2
	.word	2
	.word	3
	.globl	renderParameters
	.section	.rodata.str1.4
	.align	2
$LC24:
	.ascii	"USA\000"
	.align	2
$LC25:
	.ascii	"JP\000"
	.align	2
$LC26:
	.ascii	"Horizontal\000"
	.align	2
$LC27:
	.ascii	"Vertical\000"
	.align	2
$LC28:
	.ascii	"Default\000"
	.align	2
$LC29:
	.ascii	"Extended\000"
	.align	2
$LC30:
	.ascii	"Console\000"
	.align	2
$LC31:
	.ascii	"Emulator\000"
	.align	2
$LC32:
	.ascii	"Shortcut\000"
	.data
	.align	4
	.type	renderParameters, @object
	.size	renderParameters, 108
renderParameters:
	.word	$LC24
	.word	$LC25
	.word	$LC8
	.word	$LC16
	.word	$LC17
	.word	$LC8
	.word	$LC16
	.word	$LC17
	.word	$LC8
	.word	$LC26
	.word	$LC27
	.word	$LC8
	.word	$LC28
	.word	$LC29
	.word	$LC8
	.word	$LC30
	.word	$LC31
	.word	$LC8
	.word	$LC16
	.word	$LC17
	.word	$LC8
	.word	$LC16
	.word	$LC17
	.word	$LC8
	.word	$LC16
	.word	$LC17
	.word	$LC32
	.globl	renderOptions
	.section	.rodata.str1.4
	.align	2
$LC33:
	.ascii	"Audio Mode\000"
	.align	2
$LC34:
	.ascii	"Widescreen\000"
	.align	2
$LC35:
	.ascii	"Anti-Alias\000"
	.align	2
$LC36:
	.ascii	"Screen Split\000"
	.align	2
$LC37:
	.ascii	"Draw Dist.\000"
	.align	2
$LC38:
	.ascii	"Game Tempo\000"
	.align	2
$LC39:
	.ascii	"Cull ModeShow FPS\000"
	.align	2
$LC40:
	.ascii	"Input Disp.\000"
	.align	2
$LC41:
	.ascii	"Detail Disp.\000"
	.data
	.align	4
	.type	renderOptions, @object
	.size	renderOptions, 36
renderOptions:
	.word	$LC33
	.word	$LC34
	.word	$LC35
	.word	$LC36
	.word	$LC37
	.word	$LC38
	.word	$LC39
	.word	$LC40
	.word	$LC41
	.globl	battleParameters
	.section	.rodata.str1.4
	.align	2
$LC42:
	.ascii	"CTF\000"
	.align	2
$LC43:
	.ascii	"Soccer\000"
	.data
	.align	4
	.type	battleParameters, @object
	.size	battleParameters, 24
battleParameters:
	.word	$LC28
	.word	$LC42
	.word	$LC43
	.word	$LC16
	.word	$LC17
	.space	4
	.globl	battleOptions
	.section	.rodata.str1.4
	.align	2
$LC44:
	.ascii	"Game Mode\000"
	.align	2
$LC45:
	.ascii	"Mirror Mode\000"
	.data
	.align	4
	.type	battleOptions, @object
	.size	battleOptions, 8
battleOptions:
	.word	$LC44
	.word	$LC45
	.globl	gameChar
	.align	4
	.type	gameChar, @object
	.size	gameChar, 128
gameChar:
	.word	7
	.word	8
	.word	9
	.word	8
	.word	7
	.word	5
	.word	8
	.word	0
	.word	3
	.word	2
	.word	0
	.word	0
	.word	3
	.word	2
	.word	0
	.word	0
	.word	7
	.word	6
	.word	8
	.word	4
	.word	7
	.word	8
	.word	8
	.word	5
	.word	3
	.word	2
	.word	0
	.word	0
	.word	3
	.word	2
	.word	0
	.word	0
	.globl	gameLimits
	.align	4
	.type	gameLimits, @object
	.size	gameLimits, 32
gameLimits:
	.word	4
	.word	2
	.word	2
	.word	2
	.word	4
	.word	4
	.word	2
	.word	2
	.globl	gameParameters
	.section	.rodata.str1.4
	.align	2
$LC46:
	.ascii	"Red Coin\000"
	.align	2
$LC47:
	.ascii	"Gold Coin\000"
	.align	2
$LC48:
	.ascii	"Practice\000"
	.align	2
$LC49:
	.ascii	"Classic\000"
	.align	2
$LC50:
	.ascii	"Equal\000"
	.align	2
$LC51:
	.ascii	"Enhanced\000"
	.align	2
$LC52:
	.ascii	"Random\000"
	.align	2
$LC53:
	.ascii	"Balanced\000"
	.align	2
$LC54:
	.ascii	"None\000"
	.align	2
$LC55:
	.ascii	"Bots 2-4\000"
	.align	2
$LC56:
	.ascii	"Bots 3+4\000"
	.align	2
$LC57:
	.ascii	"Bot 4\000"
	.data
	.align	4
	.type	gameParameters, @object
	.size	gameParameters, 128
gameParameters:
	.word	$LC28
	.word	$LC46
	.word	$LC47
	.word	$LC48
	.word	$LC49
	.word	$LC50
	.word	$LC51
	.word	$LC8
	.word	$LC16
	.word	$LC17
	.word	$LC8
	.word	$LC8
	.word	$LC16
	.word	$LC17
	.word	$LC8
	.word	$LC8
	.word	$LC28
	.word	$LC52
	.word	$LC53
	.word	$LC54
	.word	$LC49
	.word	$LC55
	.word	$LC56
	.word	$LC57
	.word	$LC16
	.word	$LC17
	.word	$LC8
	.word	$LC8
	.word	$LC16
	.word	$LC17
	.word	$LC8
	.word	$LC8
	.globl	gameOptions
	.section	.rodata.str1.4
	.align	2
$LC58:
	.ascii	"Racer Stats\000"
	.align	2
$LC59:
	.ascii	"GP Always Advance\000"
	.align	2
$LC60:
	.ascii	"All Cup\000"
	.align	2
$LC61:
	.ascii	"Items\000"
	.align	2
$LC62:
	.ascii	"Multiplayer\000"
	.align	2
$LC63:
	.ascii	"Explorer Mode\000"
	.align	2
$LC64:
	.ascii	"Flycam Mode\000"
	.data
	.align	4
	.type	gameOptions, @object
	.size	gameOptions, 32
gameOptions:
	.word	$LC44
	.word	$LC58
	.word	$LC59
	.word	$LC60
	.word	$LC61
	.word	$LC62
	.word	$LC63
	.word	$LC64
	.globl	menuChar
	.align	4
	.type	menuChar, @object
	.size	menuChar, 16
menuChar:
	.word	12
	.word	14
	.word	11
	.word	10
	.globl	menuNames
	.section	.rodata.str1.4
	.align	2
$LC65:
	.ascii	"Game Options\000"
	.align	2
$LC66:
	.ascii	"Render Options\000"
	.align	2
$LC67:
	.ascii	"Map Options\000"
	.align	2
$LC68:
	.ascii	"Cup Editor\000"
	.data
	.align	4
	.type	menuNames, @object
	.size	menuNames, 16
menuNames:
	.word	$LC65
	.word	$LC66
	.word	$LC67
	.word	$LC68
	.globl	battleChar
	.align	4
	.type	battleChar, @object
	.size	battleChar, 24
battleChar:
	.word	7
	.word	3
	.word	6
	.word	3
	.word	2
	.space	4
	.globl	battleLimits
	.align	4
	.type	battleLimits, @object
	.size	battleLimits, 8
battleLimits:
	.word	3
	.word	2
	.globl	MenuIconsRAM
	.section	.bss,"aw",@nobits
	.align	4
	.type	MenuIconsRAM, @object
	.size	MenuIconsRAM, 4
MenuIconsRAM:
	.space	4
	.globl	Splash3DRAM
	.align	4
	.type	Splash3DRAM, @object
	.size	Splash3DRAM, 4
Splash3DRAM:
	.space	4
	.globl	BackdropRAM
	.align	4
	.type	BackdropRAM, @object
	.size	BackdropRAM, 4
BackdropRAM:
	.space	4
	.globl	StartLogoRAM
	.align	4
	.type	StartLogoRAM, @object
	.size	StartLogoRAM, 4
StartLogoRAM:
	.space	4
	.globl	GameOKMenu
	.align	4
	.type	GameOKMenu, @object
	.size	GameOKMenu, 8
GameOKMenu:
	.space	8
	.globl	OKMapOptions
	.align	4
	.type	OKMapOptions, @object
	.size	OKMapOptions, 96
OKMapOptions:
	.space	96
	.globl	OKRenderOptions
	.align	4
	.type	OKRenderOptions, @object
	.size	OKRenderOptions, 144
OKRenderOptions:
	.space	144
	.globl	OKGameOptions
	.align	4
	.type	OKGameOptions, @object
	.size	OKGameOptions, 128
OKGameOptions:
	.space	128
	.globl	MapPanel
	.align	4
	.type	MapPanel, @object
	.size	MapPanel, 16
MapPanel:
	.space	16
	.globl	RenderPanel
	.align	4
	.type	RenderPanel, @object
	.size	RenderPanel, 16
RenderPanel:
	.space	16
	.globl	BattlePanel
	.align	4
	.type	BattlePanel, @object
	.size	BattlePanel, 16
BattlePanel:
	.space	16
	.globl	RacePanel
	.align	4
	.type	RacePanel, @object
	.size	RacePanel, 16
RacePanel:
	.space	16
	.globl	pageLimit
	.data
	.align	2
	.type	pageLimit, @object
	.size	pageLimit, 20
pageLimit:
	.word	8
	.word	9
	.word	6
	.word	5
	.word	2
	.globl	SaveStateCourseID
	.section	.bss
	.align	2
	.type	SaveStateCourseID, @object
	.size	SaveStateCourseID, 4
SaveStateCourseID:
	.space	4
	.globl	addTurn
	.align	1
	.type	addTurn, @object
	.size	addTurn, 2
addTurn:
	.space	2
	.globl	baseTurn
	.align	1
	.type	baseTurn, @object
	.size	baseTurn, 2
baseTurn:
	.space	2
	.globl	ControllerInputY
	.data
	.align	1
	.type	ControllerInputY, @object
	.size	ControllerInputY, 2
ControllerInputY:
	.half	215
	.globl	ControllerInputX
	.align	1
	.type	ControllerInputX, @object
	.size	ControllerInputX, 2
ControllerInputX:
	.half	247
	.globl	stickCoord
	.align	2
	.type	stickCoord, @object
	.size	stickCoord, 20
stickCoord:
	.half	1
	.half	0
	.half	1
	.half	2
	.half	0
	.half	1
	.half	2
	.half	1
	.half	1
	.half	1
	.globl	stickColor
	.align	2
	.type	stickColor, @object
	.size	stickColor, 30
stickColor:
	.half	192
	.half	192
	.half	192
	.half	192
	.half	192
	.half	192
	.half	192
	.half	192
	.half	192
	.half	192
	.half	192
	.half	192
	.half	255
	.half	255
	.half	255
	.globl	coords
	.align	2
	.type	coords, @object
	.size	coords, 64
coords:
	.half	3
	.half	1
	.half	3
	.half	2
	.half	5
	.half	1
	.half	3
	.half	0
	.half	1
	.half	0
	.half	1
	.half	2
	.half	0
	.half	1
	.half	2
	.half	1
	.half	0
	.half	0
	.half	0
	.half	0
	.half	4
	.half	0
	.half	6
	.half	0
	.half	5
	.half	0
	.half	5
	.half	2
	.half	4
	.half	1
	.half	6
	.half	1
	.globl	colors
	.align	2
	.type	colors, @object
	.size	colors, 96
colors:
	.half	0
	.half	192
	.half	255
	.half	0
	.half	255
	.half	0
	.half	255
	.half	255
	.half	255
	.half	255
	.half	0
	.half	0
	.half	192
	.half	192
	.half	192
	.half	192
	.half	192
	.half	192
	.half	192
	.half	192
	.half	192
	.half	192
	.half	192
	.half	192
	.half	0
	.half	0
	.half	0
	.half	0
	.half	0
	.half	0
	.half	255
	.half	255
	.half	255
	.half	255
	.half	255
	.half	255
	.half	255
	.half	255
	.half	0
	.half	255
	.half	255
	.half	0
	.half	255
	.half	255
	.half	0
	.half	255
	.half	255
	.half	0
	.globl	FlyCamSpeed
	.align	1
	.type	FlyCamSpeed, @object
	.size	FlyCamSpeed, 2
FlyCamSpeed:
	.half	5
	.globl	InputColor
	.section	.bss
	.align	2
	.type	InputColor, @object
	.size	InputColor, 16
InputColor:
	.space	16
	.globl	LocalInput
	.align	2
	.type	LocalInput, @object
	.size	LocalInput, 8
LocalInput:
	.space	8
	.globl	FlyCamLook
	.align	2
	.type	FlyCamLook, @object
	.size	FlyCamLook, 16
FlyCamLook:
	.space	16
	.globl	FlyCamRadian
	.align	2
	.type	FlyCamRadian, @object
	.size	FlyCamRadian, 4
FlyCamRadian:
	.space	4
	.globl	FlyCamBackupPosition
	.align	2
	.type	FlyCamBackupPosition, @object
	.size	FlyCamBackupPosition, 12
FlyCamBackupPosition:
	.space	12
	.globl	FlyCamDirection
	.align	1
	.type	FlyCamDirection, @object
	.size	FlyCamDirection, 2
FlyCamDirection:
	.space	2
	.globl	FlyCamPilot
	.align	1
	.type	FlyCamPilot, @object
	.size	FlyCamPilot, 2
FlyCamPilot:
	.space	2
	.globl	FlyCamViewCheck
	.align	1
	.type	FlyCamViewCheck, @object
	.size	FlyCamViewCheck, 2
FlyCamViewCheck:
	.space	2
	.globl	FlyCamView
	.align	1
	.type	FlyCamView, @object
	.size	FlyCamView, 2
FlyCamView:
	.space	2
	.globl	FlyCamSectionCheck
	.align	1
	.type	FlyCamSectionCheck, @object
	.size	FlyCamSectionCheck, 2
FlyCamSectionCheck:
	.space	2
	.globl	FlyCamSection
	.align	1
	.type	FlyCamSection, @object
	.size	FlyCamSection, 2
FlyCamSection:
	.space	2
	.globl	FlyCamCheck
	.type	FlyCamCheck, @object
	.size	FlyCamCheck, 1
FlyCamCheck:
	.space	1
	.globl	FlyCamToggle
	.type	FlyCamToggle, @object
	.size	FlyCamToggle, 1
FlyCamToggle:
	.space	1
	.globl	MiniMapMode
	.type	MiniMapMode, @object
	.size	MiniMapMode, 1
MiniMapMode:
	.space	1
	.globl	GenericInput
	.type	GenericInput, @object
	.size	GenericInput, 1
GenericInput:
	.space	1
	.globl	FlyCamPosition
	.align	2
	.type	FlyCamPosition, @object
	.size	FlyCamPosition, 12
FlyCamPosition:
	.space	12
	.globl	ItemChance
	.align	2
	.type	ItemChance, @object
	.size	ItemChance, 32
ItemChance:
	.space	32
	.globl	AnalogInput
	.align	2
	.type	AnalogInput, @object
	.size	AnalogInput, 8
AnalogInput:
	.space	8
	.globl	PrintCount
	.align	2
	.type	PrintCount, @object
	.size	PrintCount, 4
PrintCount:
	.space	4
	.globl	PrintLog
	.align	2
	.type	PrintLog, @object
	.size	PrintLog, 396
PrintLog:
	.space	396
	.globl	LoadedProgress
	.align	2
	.type	LoadedProgress, @object
	.size	LoadedProgress, 4
LoadedProgress:
	.space	4
	.globl	mapMode
	.data
	.align	2
	.type	mapMode, @object
	.size	mapMode, 4
mapMode:
	.word	SaveGame+32
	.globl	battleMode
	.align	2
	.type	battleMode, @object
	.size	battleMode, 4
battleMode:
	.word	SaveGame+24
	.globl	renderMode
	.align	2
	.type	renderMode, @object
	.size	renderMode, 4
renderMode:
	.word	SaveGame+8
	.globl	gameMode
	.align	2
	.type	gameMode, @object
	.size	gameMode, 4
gameMode:
	.word	SaveGame
	.globl	SaveGame
	.section	.bss
	.align	2
	.type	SaveGame, @object
	.size	SaveGame, 500
SaveGame:
	.space	500
	.ident	"GCC: (GNU) 10.1.0"
