.n64




.open "ROM\V7Set.z64", "ROM\BASE.z64", 0
.definelabel ROM_SIZE, 		filesize("ROM\V7Set.z64")
.definelabel PAYLOAD_ROM, 0xF00000
.definelabel PAYLOAD_RAM, 		0x80400000
.definelabel RAM_END,           org(EndRAMData)

.definelabel DMA_MAX_LENGTH,       org(EndRAMData) - org(StartRAMData)
.definelabel ok_ModelDataRawSize,     0x6000
.definelabel itemChanceHi,    hi(org(ok_ItemTable))
.definelabel itemChanceLo,    lo(org(ok_ItemTable))
.definelabel OKBuild, 1
.definelabel CFLG_LapCounter, 1

.include "..\library\GameVariables\NTSC\GameOffsets.asm"
.include "..\library\GameVariables\NTSC\StatsOffsets.asm"
.include "..\library\OKHeader.asm"
.include "..\library\GameVariables\NTSC\OKAssembly.asm"






.if OKBuild

     //Lucky Blank Function
     .org 0x124BF4
     JAL ResultsCheck


     .org 0x0FA178
     JAL CameraCheckFunc
     .org 0x0FA194
     JAL CameraCheckFunc
     .org 0x0FA1AC
     JAL CameraCheckFunc
     .org 0x0FA1C8
     JAL CameraCheckFunc
     .org 0x0FA1E0
     JAL CameraCheckFunc
     .org 0x0FA1F8
     JAL CameraCheckFunc
     .org 0x0FA210
     JAL CameraCheckFunc
     .org 0x00218C
     JAL CameraCheckFunc
     .org 0x002438
     JAL CameraCheckFunc
     .org 0x002458
     JAL CameraCheckFunc
     .org 0x0025E0
     JAL CameraCheckFunc
     .org 0x002600
     JAL CameraCheckFunc
     .org 0x0027F8
     JAL CameraCheckFunc
     .org 0x002818
     JAL CameraCheckFunc
     .org 0x002838
     JAL CameraCheckFunc
     .org 0x002858
     JAL CameraCheckFunc

     .org 0x10F23C
     JAL KartCheckFuncA
     NOP
     .org 0x10F524
     JAL KartCheckFuncA
     NOP
     .org 0x10FB30
     JAL KartCheckFuncA
     NOP
     .org 0x110128
     JAL KartCheckFuncA
     NOP

     .org 0x10F254
     JAL KartCheckFuncA2
     NOP
     .org 0x10F53C
     JAL KartCheckFuncA2
     NOP
     .org 0x10FB48
     JAL KartCheckFuncA2
     NOP
     .org 0x110140
     JAL KartCheckFuncA2
     NOP


     //
     //

     
     .org 0x10F81C
     JAL KartCheckFuncB 
     NOP
     .org 0x10FE44
     JAL KartCheckFuncB
     NOP
     .org 0x11040C
     JAL KartCheckFuncB     
     NOP

     .org 0x10F834
     JAL KartCheckFuncB2
     NOP
     .org 0x10FE5C
     JAL KartCheckFuncB2
     NOP
     .org 0x110424
     JAL KartCheckFuncB2    
     NOP


     //
     //
     

     .org 0x1106F0
     JAL KartCheckFuncC     
     NOP

     .org 0x110708
     JAL KartCheckFuncC2
     NOP

     
     //
     //


     .org 0x110A34
     JAL KartCheckFuncD
     NOP

     .org 0x110A4C
     JAL KartCheckFuncD2
     NOP

.endif




//jump past minimum speed requirements
.org 0x0090CC
.word 0x100000CA
//branch to 0x800087FE

//0x80008800
.org 0x009400
JAL RubberBandMan


.if OKBuild
//fix the flip and stop that shit
.org 0x095C64
NOP

//Remove the default Title Screen Image
.org 0x09F8C4
NOP
.endif



///
/// UI Elements 
///

//Disable Map Select Texture
.org 0x095F40
LI $a3, 1

//Disable Player Select Texture
.org 0x095E0C
LI $a3, 1

//Disable Game Select Texture
.org 0x095CB8
LI $a3, 1

//Disable GameSelectMenu
.org 0x095CA4
//LI $a3, 15


///
///
///



//Disable the UI Overlay Labels
//Map Select Time Trial Ghost Info
.org 0x0960D0
LI $a3, 1
.org 0x0960E4
LI $a3, 1
.org 0x0960F8
LI $a3, 1

//Map Select GP CC Overlay Label
.org 0x096118
LI $a3, 1




//Disable the DATA menu
//Only loads the Background image
.org 0x9593C
.word 0x100001FC   //Hardcode Branch Command. 
NOP


//Disable Options/Data Menu Icons
.org 0x095D2C
NOP
.org 0x095D40
NOP


//This is a weird hack to disable the Game Select Menu's Option/Data Menu Toggles.
//It changes the button-check to an invalid value of unused bits- impossible to press.
.org 0x0B3806
.halfword 0x0080
.org 0x0B385E
.halfword 0x0080


//NOP Options/Data Sound Calls
.org 0x0B386C
NOP
.org 0x0B38C4
NOP


//Disable C-button Z-Button C Button Z Button merge
.org 0x001584
ori   $t4, $a1, 0x0000



.org 0xB105C
//DATA Controller
JAL DataMenuController
.org 0x0B10C0
//TitleController
JAL TitleMenuSwitch
.org 0x0B10D8
//Game Select
JAL GameSelectSwitch
.org 0x0B10F0
//Player Select
//JAL PlayerSelectSwitch
.org 0x0B1108
//Map Select
JAL MapSelectSwitch


///
/// - BUILD ROUTINE LIBRARY
///

.include "..\Library\LIBRARYBUILD1.asm"

///
///
///







///
/// - Local OverKart Custom Code
///

.headersize PAYLOAD_RAM - PAYLOAD_ROM
.org PAYLOAD_RAM
StartRAMData:
     
     .align 0x10
     .importobj "OverKartVariables.o"
     .align 0x10
     .importobj "MarioKartAI.o"
     .align 0x10
     .importobj "OKMenu.o"
     .align 0x10
     .importobj "MarioKartPractice.o"
     .align 0x10
     .importobj "LitroFunc.o"
     .align 0x10
     .importobj "OverKart.o"
     .align 0x10
     .importobj "OverKartObjectHandler.o"
     .align 0x10
     .importobj "ModelData.o"
     RCIconMap:
     .import "data\\RedSquare.png.RAW"          
     .align 0x10
     .importobj "TitleMenu.o"
     .align 0x10

     .if OKBuild
     .align 0x10
     .importobj "Cheat.o"
     .endif


     .include "..\Library\LIBRARYBUILD2.asm"
.align 0x10
EndRAMData:



.headersize 0
//ROM data
//Offsets are ROM Relative- Headersize 0


     .if OKBuild
          Seg12BIN:
          .align 0x10
          .import "data\\Segment12.bin"
          .align 0x10
          Seg12END:
     .endif

     Splash3D:
     .import "data\\SplashLogo\\model\\SplashLogo.bin"
     .align 0x10
     Splash3DEnd:
     BackDrop:
     .import "data\\SplashLogo\\backdrop.bin"
     .align 0x10
     BackDropEnd:

     
     
     .definelabel OverwriteCrash, 1
    
     Crash:
     .import "data/CrashBanner.RAW"
     .align 0x10
     CrashEnd:
     
     
     RAMCheck:
     .import "Data\test\output\RAMCheck.bin"
     .align 0x10
     RAMCheckEnd:

     
     LogoROM:
     .import "data\\Logo.bin" ;; 0xD388
     .align 0x10
     
     BackgroundLogo:
     .import "data\\SplashLogo\\BackgroundSource.bin"
     .align 0x10
     BackgroundEnd:

     StartLogo:
     .import "data\\SplashLogo\\output\\PressStart.png.RAW.MIO0"
     .align 0x10
     StartEnd:
     Pirate:
     .import "Data\\PiracyWarning.MIO0"
     .align 0x10
     PirateEnd:


     
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


     .definelabel OverWriteFonts, 1

     .align 0x10
     NiceFontROM:
     .import "../library/data/nice_font.mio0.bin"

     .align 0x10
     HudButtonsROM:
     .import "../library/data/hud_buttons.mio0.bin"

     .align 0x10
     BigFontROM:
     .import "data/Newfont.MIO0"

     .align 0x10
     ROptionROM:
     .import "data\ROption.MIO0"
     .align 0x10
     ROptionEnd:


     
//END ROM DATA

///
/// - End Custom OverKart Code
///


    
//.include "CustomMenu\MenuBuild.asm"

.org ROM_SIZE
.align 0x10
.include "..\Library\LIBRARYBUILD3.asm"

.include "..\Library\LIBRARYBUILD4.asm"


.headersize 0
.org 0x20
//.ascii "TARMAC 64     031824"
//.ascii "OVERKART64 V6 070624"
.ascii "MK64 BETAPAK6 071524"

//.org 0x3EFFFF1
//.ascii "63MEGFUCKREPROS"
.org 0x12FFFFC
.ascii "BETA"
.close