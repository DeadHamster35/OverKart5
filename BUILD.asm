.n64
//.open "ROM\amp2.z64", "ROM\BASE.z64", 0
.open "ROM\stock.z64", "ROM\BASE.z64", 0




.definelabel PAYLOAD_ROM, 		0x00D00000
.definelabel PAYLOAD_RAM, 		0x80400000
.definelabel PRELOAD_RAM,          0x80200000
.definelabel ExpansionCheckAddress,          0x80001264
.definelabel DMA_FUNC,    		0x80001158
.definelabel RAM_END,           org(EndRAMData)

.definelabel DMA_MAX_LENGTH,       org(EndRAMData) - org(StartRAMData)
.definelabel Printf, 			0x800D6420
.definelabel ok_ModelDataRawSize,     filesize("data\ModelData\ModelData.raw")
.definelabel itemChanceHi,    hi(org(ok_ItemTable))
.definelabel itemChanceLo,    lo(org(ok_ItemTable))
.definelabel OKBuild, 0

.include "..\library\GameVariables\NTSC\GameOffsets.asm"
.include "..\library\GameVariables\NTSC\StatsOffsets.asm"
.include "..\library\OKHeader.asm"
.include "..\library\GameVariables\NTSC\OKAssembly.asm"
.include "data\ModelData\ModelData.asm"

.org 0xBFFFFC
.word 0xF00000

.org 0x113FBA
.halfword 0x8080
.org 0x113FCE
.byte 0x00



.if OKBuild
//fix the flip and stop that shit
.org 0x095C64
NOP
//Remove the default Title Screen Image
.org 0x09F8C4
NOP

.endif




.org 0x079290
J SnowHook
NOP

.org 0x0FBA68
J DisplayMap2Hook
NOP
//add XLU to RGBA32

.org 0x047350
.word 0x273979E8
.org 0x0473C4
.word 0x273979E8

//fix kwtexture2D_rgba32_bl
.org 0x0473F0
.word 0x0C011869


//AddGravityHooks
.org 0x2E00C
JAL AddGravityEdit

.org 0x2F2A4
JAL AddGravityEdit

.org 0x3997C
JAL AddGravityEdit


//InitSmokeHooks
.org 0x6D59C
JAL InitRndSmokeHook

.org 0x6D584
JAL InitRapidSmokeHook

.org 0x6D520
JAL InitSpinSmokeHook


//Change kwtexture2d to use loadtile

.org 0x463E0
.word 0x0C010F0A

.org 0x123B0C
JAL MapStartup
.org 0x0036F4
JAL MapStartup
.org 0x12506C
JAL MapStartup

.org 0x0036FC
JAL InitialMapCode

.org 0x0051E8
JAL DisplayCrashScreen
.org 0x5200
NOP
.org 0x5240
NOP



//CheckMapBG_ZX Hooks
.org 0x2EBE0
JAL CheckMapBG_ZX_Hook
.org 0x2FB10
JAL CheckMapBG_ZX_Hook
.org 0x30614
JAL CheckMapBG_ZX_Hook
.org 0x39CC0
JAL CheckMapBG_ZX_Hook




//AirControlChange
.org 0x38A04
NOP

.org 0x38A10
JAL ProStickAngleHook

.org 0x38A4C
NOP





.org 0x111D4C
LB t2, -1(v0)
// fixes Alpha loading for level data vert color

.org 0x10C7E2
.halfword hi(DisplayHopTable)
.org 0x10C7EA
.halfword lo(DisplayHopTable)
.org 0x10C7D6
.halfword(100)






// fix for MKInit duplicate calls which are overwritten by our boot code.
// gamecode never needs to be reloaded.
.org 0x3314
NOP
.org 0x3354
NOP
.org 0x01CC64
NOP
.org 0x003334
NOP
.org 0x00335C
NOP






//Kart Collision Wrappers
.org 0x02BF48 
JAL BombThrowRolloverWrap
.org 0x02BF6C
JAL RolloverWrap
.org 0x02BF90
JAL WheelspinWrap
.org 0x02C044
JAL BrokenWrap
.org 0x02C068
JAL ThunderWrap
.org 0x02C08C
JAL SpinWrap
.org 0x02C0B0
JAL BombRolloverWrap
.org 0x02C0D4
JAL BombThrowRolloverWrap
.org 0x02C184
JAL ProWheelSpinWrap
.org 0x02C1A4
JAL BombRolloverWrap



.org 0x10CB44
J FreeDraw


//PlayStarMusicHook
.org 0x90420
JAL PlayStarMusicHook

//StopStarMusicHook
.org 0x904B4
JAL StopStarMusicHook

.org 0x902D8
JAL StopStarMusicHook

//PlayFinalLapMusicHook
.org 0xF8954
JAL PlayFinalLapMusicHook



.org 0x109AAA
.halfword hi(CollisionHopTable)
.org 0x109AB2
.halfword lo(CollisionHopTable)
.org 0x109A92
.halfword(100)




//original hook placement
.org 0x34BC //RAM address 0x800028BC
J GlobalCustomCode
NOP



//EventDisplay Hooks
.org 0x058EB4
JAL EventDisplay

.org 0x058F7C
JAL EventDisplay

.org 0x059044
JAL EventDisplay

.org 0x059120
JAL EventDisplay

//EventDisplay_After Hooks

.org 0x0592E4
JAL EventDisplay_After

.org 0x05938C
JAL EventDisplay_After

.org 0x059434
JAL EventDisplay_After

.org 0x0594DC
JAL EventDisplay_After


//CommonGameEvent Hooks

.org 0x05AA18
JAL CommonGameEventChart

.org 0x05AAA8
JAL CommonGameEventChart

.org 0x05AB38
JAL CommonGameEventChart

.org 0x05AC50
JAL CommonGameEventChart

.org 0x05AD08
JAL CommonGameEventChart





//title screen hook
.org 0x957D0 //RAM address 0x80094BD0
J CustomCodeTitleScreen
NOP


.org 0x2B30
J PrintMenuHook
NOP

//1p
.org 0x2214
J race1P
NOP

//2p
.org 0x269C
J race2P
NOP

.org 0x24F4
J race2PLR
NOP

//mp
.org 0x28F8
J raceMP
NOP





.headersize PAYLOAD_RAM - PAYLOAD_ROM
.org PAYLOAD_RAM
StartRAMData:

.align 0x10
bannerN:
.import "data\\banner_n.mio0.bin"        ;;  324

.align 0x10
bannerU:
.import "data\\banner_U.mio0.bin"        ;;  311

.align 0x10
set0:
.import "data\\Stock.png.MIO0"            ;;  87c
.align 0x10
set0end:

.align 0x10
set1:
.import "data\\Set1.png.MIO0"            ;;  7f5
.align 0x10
set1end:

.align 0x10
set2:
.import "data\\Set2.png.MIO0"            ;;  7fc
.align 0x10
set2end:

.align 0x10
set3:
.import "data\\Set3.png.MIO0"            ;;  808
.align 0x10
set3end:

.align 0x10
set4:
.import "data\\Set4.png.MIO0"            ;;  800
.align 0x10
set4end:



.align 0x10
CustomCodeTitleScreen:
ADDIU sp, sp, -0x20
SW ra, 0x001C (sp)
JAL	0x80095574 //run what we overwrote with our hook
NOP
JAL titleMenu
NOP
LW ra, 0x001C (sp)
ADDIU sp, sp, 0x20
J 0x80094BD8 //jump back to where we were
NOP
NOP




.align 0x10
race1P:
ADDIU sp, sp, -0x20
SW ra, 0x001C (sp) //push ra to the stack
NOP
JAL gameCode
NOP
LW ra, 0x001C (sp) //pop ra from the stack
ADDIU sp, sp, 0x20
LUI a0, 0x800E
LHU a0, 0xC520 (a0)
LUI a1, 0x800E
J 0x8000161C
NOP

.align 0x10
race2P:
ADDIU sp, sp, -0x20
SW ra, 0x001C (sp) //push ra to the stack
NOP
JAL gameCode
NOP
LW ra, 0x001C (sp) //pop ra from the stack
ADDIU sp, sp, 0x20
LUI t3, 0x800E
LW t3, 0xC5E8 (t3)
J 0x80001AA4
NOP

.align 0x10
race2PLR:
ADDIU sp, sp, -0x20
SW ra, 0x001C (sp) //push ra to the stack
NOP
JAL gameCode
NOP
LW ra, 0x001C (sp) //pop ra from the stack
ADDIU sp, sp, 0x20
LUI t3, 0x800E
LW t3, 0xC5E8 (t3)
J 0x800018FC
NOP


.align 0x10
raceMP:
ADDIU sp, sp, -0x20
SW ra, 0x001C (sp) //push ra to the stack
NOP
JAL gameCode
NOP
LW ra, 0x001C (sp) //pop ra from the stack
ADDIU sp, sp, 0x20
LUI v0, 0x800E
LW v0, 0xC5E8 (v0)
J 0x80001D00
NOP


.align 0x10
SnowHook:
LW a0, 0x40(sp)
ADDIU sp, sp, -0x20
SW ra, 0x001C (sp) //push ra to the stack
JAL SnowCustomCheck
NOP
LW ra, 0x001C (sp) //pop ra from the stack
ADDIU sp, sp, 0x20
J 0x800786B8
NOP

.align 0x10
DisplayMap2Hook:
SW ra, 0x001C(sp)
LW a0, 0x270(sp)
JAL XLUDisplay
NOP
LW ra, 0x001C(sp)
addiu sp, sp, 0x270
JR ra
NOP


.include "..\Library\LIBRARYBUILD.asm"

.align 0x10
.importobj "OverKartVariables.o"
.align 0x10
.importobj "MarioKartAI.o"
.align 0x10
.importobj "OKMenu.o"
.align 0x10
.importobj "Protec.o"
.align 0x10
.importobj "MarioKartPractice.o"
.align 0x10
.importobj "CTF.o"
.align 0x10
.importobj "LitroFunc.o"
.align 0x10
.importobj "OverKart.o"
.align 0x10
.importobj "OverKartObjectHandler.o"



.align 0x10
DisplayHop:
MOVE  $a0, $s1
JAL   DisplayObject
MOVE  $a1, $s0
J     0x802A34D4
NOP


.align 0x10
FreeDraw:
JAL DrawPerScreen
NOP
LW ra, 0x24 (sp)
LW s0, 0x18 (sp)
LW s1, 0x1C (sp)
LW s2, 0x20 (sp)
JR ra
ADDIU sp, sp, 0x98

.align 0x10
CollisionHop:
LW    $t4, 0xbc($a3)
MOVE  $a0, $a3
LW    $ra, 0x1c($sp)
JAL  CollideObject
MOVE  $a1, $s0
J     0x802A0D44
LW    $ra, 0x1c($sp)


.align 0x10
DisplayHopTable:
.word 0x802A31E4, 0x802A31FC, 0x802A3214, 0x802A32EC
.word 0x802A3318, 0x802A3330, 0x802A3348, 0x802A34C0
.word 0x802A3378, 0x802A34D4, 0x802A34D4, 0x802A34D4
.word 0x802A34D4, 0x802A3390, 0x802A33A4, 0x802A33B8
.word 0x802A33CC, 0x802A322C, 0x802A33E4, 0x802A34D4  //19
.word 0x802A34D4, 0x802A33FC, 0x802A34D4, 0x802A3428  //23
.word 0x802A3244, 0x802A34D4, 0x802A325C, 0x802A328C  //27
.word 0x802A32A4, 0x802A32BC, 0x802A32D4, 0x802A3274  //31
.word 0x802A34D4, 0x802A3414, 0x802A34D4, 0x802A345C  //35
.word 0x802A3440, 0x802A34AC, 0x802A3470, 0x802A3484  //39
.word 0x802A3360, 0x802A34D4, 0x802A3498, 0x802A3300  //43
.word 0x802A33E4, DisplayHop, DisplayHop, DisplayHop  //47
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4  //51
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4  //55
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4  //59
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4  //63
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4  //67
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4  //71
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4  //75
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4  //79
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4 //99


.align 0x10
CollisionHopTable:
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09D4
.word 0x802A04E0, 0x802A063C, 0x802A0858, 0x802A04AC  //7
.word 0x802A0968, 0x802A0D40, 0x802A0CBC, 0x802A0AA4
.word 0x802A0D40, 0x802A0D40, 0x802A0D40, 0x802A0D40
.word 0x802A0D40, 0x802A09B0, 0x802A0D40, 0x802A0D40 //19
.word 0x802A0D40, 0x802A098C, 0x802A0D40, 0x802A09B0
.word 0x802A09B0, 0x802A0D40, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A0D40, 0x802A0D40, 0x802A0D40, 0x802A0D40
.word 0x802A0D40, 0x802A0D40, 0x802A0D40, 0x802A0D40 //39
.word 0x802A0744, 0x802A0C34, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, CollisionHop, CollisionHop, CollisionHop
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0 //59
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0 //79
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0 //99



EndRAMData:



//ROM data
//Offsets are ROM Relative- Headersize 0
.headersize 0

     .align 0x10
     PreCodeROM:
     .importobj "PreCode.o"
     PreCodeEnd:




     .align 0x10
     .include "..\Library\LIBRARYBUILD2.asm"

     Splash3D:
     .import "data\\SplashLogo\\model\\SplashLogo.bin"
     .align 0x10
     Splash3DEnd:
     BackDrop:
     .import "data\\SplashLogo\\backdrop.bin"
     .align 0x10
     BackDropEnd:

     previewN:
     .import "textures\\preview_n.mio0.bin"       ;;  c10
     .align 0x10
     previewU:
     .import "textures\\preview_U.mio0.bin"       ;;  c64
     .align 0x10
     LogoROM:
     .import "data\\ModelData\\Logo\\Logo.bin" ;; 0xD388
     .align 0x10
     BackgroundLogo:
     .import "data\\SplashLogo\\BackgroundSource.bin"
     .align 0x10
     BackgroundEnd:

     StartLogo:
     .import "data\\SplashLogo\\PressStart.bin"
     .align 0x10
     StartEnd:
     Pirate:
     .import "Data\test\Pirate512.MIO0"
     .align 0x10
     PirateEnd:

     Crash:
     .import "Data\test\Crash512.bin"
     .align 0x10
     CrashEnd:
     
     TESTROMIMG:
     .import "Data\TESTROM.RAW"
     .align 0x10

     RAMCheck:
     .import "Data\test\output\RAMCheck.bin"
     .align 0x10
     RAMCheckEnd:

     ModelDataStart:
     .import "data\\ModelData\\ModelData.bin"
     .align 0x10
     ModelDataEnd:

     RCSpriteROM:
     .import "data\\RedCoinSprite16.png.MIO0" ;; 0x4F0
     .align 0x10
     ArrowsSpriteROM:
     .import "data\\arrows.png.MIO0" ;; 0x1000
     .align 0x10
     NumbersSpriteROM:
     .import "data\\number_sprites.png.MIO0" ;; 0x1600
     .align 0x10
     JP_Bank:
     .import "data\\JP_Bank.bin"
     .align 0x10
     JP_Audio:
     .import "data\\JP_Audio.bin"
     .align 0x10
//END ROM DATA




///BOOT CODE START
.align 0x10
.headersize 0
//REPLACEMENT FOR InitializeSystemWorks
BootCode:
.import "Data\BootCode.bin"


//NEW CUSTOM BOOT CODE
//OVERWRITES InitializeSystemWorks

.headersize (ExpansionCheckAddress - 0x1E64)
LoadMainCode:
.org ExpansionCheckAddress
ADDIU sp, sp, -0x20
SW ra, 0x001C (sp)
LUI a0, hi(PRELOAD_RAM)
ADDIU a0, a0, lo(PRELOAD_RAM)
LUI a1, hi(PreCodeROM)
ADDIU a1, a1, lo(PreCodeROM) //DMA from ROM address 0x00C00000
LUI a2, hi(PreCodeEnd - PreCodeROM)
JAL DMA_FUNC
ADDIU a2, lo(PreCodeEnd - PreCodeROM)
JAL  PRELOAD_RAM
NOP
JAL  (PRELOAD_RAM + 0x200)
NOP
LW ra, 0x001C (sp)
ADDIU sp, sp, 0x20
jr ra
NOP


.align 0x10
.importobj "PreSwitch.o"

.align 0x10
PrintMenuHook:
LW ra, 0x14 (sp)
SW ra, 0x1C (sp)
JAL printMenuSwitch
NOP
J 0x80001F64
LW ra, 0x001C(sp)

.align 0x10
GlobalCustomCode:
ADDIU sp, sp, -0x20
SW ra, 0x001C (sp) //push ra to the stack
NOP
JAL allRunSwitch
NOP
LW ra, 0x001C (sp) //pop ra from the stack
ADDIU sp, sp, 0x20
J 0x8000286C //tells the game where to jump back to, dont remove
NOP

//END OF NEW CUSTOM BOOT CODE

///BOOT CODE END

.headersize 0
.org 0xEFFFF8
.word DMA_MAX_LENGTH
.word 0xFFFFFFFF
.close