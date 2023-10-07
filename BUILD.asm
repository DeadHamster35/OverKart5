.n64
//.open "ROM\amp2.z64", "ROM\BASE.z64", 0



.open "ROM\stock.z64", "ROM\BASE.z64", 0
.definelabel PAYLOAD_ROM, 		0x01200000
.definelabel PAYLOAD_RAM, 		0x80400000
.definelabel RAM_END,           org(EndRAMData)

.definelabel DMA_MAX_LENGTH,       org(EndRAMData) - org(StartRAMData)
.definelabel ok_ModelDataRawSize,     filesize("data\ModelData\Binary\ModelData.raw")
.definelabel itemChanceHi,    hi(org(ok_ItemTable))
.definelabel itemChanceLo,    lo(org(ok_ItemTable))
.definelabel OKBuild, 0
.definelabel CFLG_LapCounter, 1

.include "..\library\GameVariables\NTSC\GameOffsets.asm"
.include "..\library\GameVariables\NTSC\StatsOffsets.asm"
.include "..\library\OKHeader.asm"
.include "..\library\GameVariables\NTSC\OKAssembly.asm"

.org 0xBFFFFC
.word 0xF00000








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
     .importobj "Protec.o"
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


     .include "..\Library\LIBRARYBUILD2.asm"
.align 0x10
EndRAMData:



.headersize 0
//ROM data
//Offsets are ROM Relative- Headersize 0
     
     Splash3D:
     .import "data\\SplashLogo\\model\\SplashLogo.bin"
     .align 0x10
     Splash3DEnd:
     BackDrop:
     .import "data\\SplashLogo\\backdrop.bin"
     .align 0x10
     BackDropEnd:
     
     
     RAMCheck:
     .import "Data\test\output\RAMCheck.bin"
     .align 0x10
     RAMCheckEnd:

     LogoROM:
     .import "data\\ModelData\\Logo\\Logo.bin" ;; 0xD388
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
     .import "Data\test\Pirate512.MIO0"
     .align 0x10
     PirateEnd:

     ModelDataStart:
     .import "data\\ModelData\\Binary\\ModelData.bin"
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


    
.include "CustomMenu\MenuBuild.asm"


.align 0x10
.include "..\Library\LIBRARYBUILD3.asm"

.include "..\Library\LIBRARYBUILD4.asm"
.headersize 0

.org 0x20
.ascii "TARMAC64 BASE 6.0   "


.org 0xEFFFF8
.word DMA_MAX_LENGTH
.word 0xFFFFFFFF
.close