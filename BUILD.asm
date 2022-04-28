.n64
//.open "ROM\amp2.z64", "ROM\BASE.z64", 0



.open "ROM\stock.z64", "ROM\BASE.z64", 0
.definelabel PAYLOAD_ROM, 		0x00D00000
.definelabel PAYLOAD_RAM, 		0x80400000
.definelabel DMA_FUNC,    		0x80001158
.definelabel RAM_END,           org(EndRAMData)

.definelabel DMA_MAX_LENGTH,       org(EndRAMData) - org(StartRAMData)
.definelabel Printf, 			0x800D6420
.definelabel ok_ModelDataRawSize,     filesize("data\ModelData\ModelData.raw")
.definelabel itemChanceHi,    hi(org(ok_ItemTable))
.definelabel itemChanceLo,    lo(org(ok_ItemTable))
.definelabel OKBuild, 1


.include "..\library\GameVariables\NTSC\GameOffsets.asm"
.include "..\library\GameVariables\NTSC\StatsOffsets.asm"
.include "..\library\OKHeader.asm"
.include "..\library\GameVariables\NTSC\OKAssembly.asm"
.include "data\ModelData\ModelData.asm"

.org 0xBFFFFC
.word 0xF00000

.if OKBuild
//fix the flip and stop that shit
.org 0x095C64
NOP
//Remove the default Title Screen Image
.org 0x09F8C4
NOP

.endif


//BUILD ROUTINE LIBRARY
.include "..\Library\LIBRARYBUILD3.asm"


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



     .include "..\Library\LIBRARYBUILD.asm"

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






.align 0x10
.include "..\Library\LIBRARYBUILD2.asm"


.headersize 0
.org 0xEFFFF8
.word DMA_MAX_LENGTH
.word 0xFFFFFFFF
.close