#include <stdbool.h>
#include "../library/SubProgram.h"
#include "../library/SharedFunctions.h"
#include "../library/Struct.h"
#include "../library/OKHeader.h"
#include "../library/PlayerChecks.h"
#include "../library/OKExternal.h"
#include "../library/LibraryVariables.h"
#include "../library/GameVariables/NTSC/OKassembly.h"
#include "../library/GameVariables/NTSC/GameOffsets.h"
#include "OverKartVariables.h"
#include "OverKartObjectHandler.h"
#include "MarioKartPractice.h"
#include "../library/MarioKartMenu.h"
#include "../library/OKCustomObjects.h"
#include "../library/CustomLevels.h"
#include "data/NewLogo/logo.h"
#include "Protec.h"


#include "LitroFunc.h"


void loadLogo()
{
	SetSegment(8,(int)(&ok_Logo));
	*sourceAddress = (int)(&LogoROM);
	*targetAddress = (int)(&ok_FreeSpace);
	dataLength = 0xD388;
	runDMA();
	*sourceAddress = (int)(&ok_FreeSpace);
	*targetAddress = (int)(&ok_Logo);
	runMIO();
	g_NintendoLogoOffset = 0x080059E8;
	g_NintendoLogoBorder = 0x256B9478;
}


void okSetup(void)
{
	loadHeaderOffsets();
	
	ConsolePlatform = CheckPlatform();
	
	SaveFunc800B45E0 = 0x03E0000800000000;
	SaveFunc800B4670 = 0x03E0000800000000;
	SaveFunc800B559C = 0x03E0000800000000;
	SaveFunc800B5948 = 0x03E0000800000000;
	LoadFunc800B4A10 = 0x03E0000800000000;
	
	

	//g_DebugTextPalette = 0x0000FFFFA5290001;
	loadEEPROM((uint)&SaveGame);
	
	if (SaveGame.SaveVersion != 1)
	{
		SaveGame.SaveVersion = 1;	
		for (int This = 0; This < 8; This++)
		{
			renderMode[This] = 0;
			modMode[This] = 0;
			gameMode[This] = 0;
		}		
		gameMode[4] = 1;
		renderMode[1] = 1;
		renderMode[2] = 0;
		saveEEPROM((uint)&SaveGame);
	}
	if ((GlobalController[0]->ButtonHeld & BTN_L) == BTN_L)
	{
		gameMode[0] = 2;
		modMode[0] = 2;
	}
	
	DPR();
	loadLogo();
	copyCourseTable(1);
	startupSwitch = 35;
	nopASM = 0;
	HotSwapID = 0;
	asm_SongA = 0x240E0001;
	asm_SongB = 0x240E0001;
	g_sfxPause = 0; //Just for Amped Up (To fix some mute sfx when pausing the game)
	hsGP = 0;
	FlyCamSpeed = 5;
	ok_Knowledge = (long)(&ok_Target);

	
	*targetAddress = (long)&BackupPortraitTable;
	*sourceAddress = (long)&SelectPortraitTable;
	dataLength = 288;
	runRAM();
	/*
	asm_PlayerSelectController = 0;
	//asm_PlayerSelectDoObjectP5 = 0;
	//asm_PlayerSelectDoObjectP6 = 0;
	//asm_PlayerSelectDoObjectP7 = 0;
	//asm_PlayerSelectDoObjectP8 = 0;
	asm_DispOBSubPSelCursor1[0] = 0x800A08C8;
	asm_DispOBSubPSelCursor1[1] = 0x800A08C8;
	asm_DispOBSubPSelCursor1[2] = 0x800A08C8;
	asm_DispOBSubPSelCursor1[3] = 0x800A08C8;
	//asm_DOBPSelTurnIn = 0;
	//asm_DOBPSelTurnOut = 0;
	
	
	PlayerSelectPositions[0].y -= 10;
	PlayerSelectPositions[1].y -= 10;
	PlayerSelectPositions[2].y -= 10;
	PlayerSelectPositions[3].y -= 10;
	*/
	
	*(long*)(&ok_USAudio) = *(long*)(&g_RawAudio + 1);
	*(long*)(&ok_USAudio + 1) = *(long*)(&g_InstrumentTable + 1);


	*(long*)(&ok_MRSong) = *(long*)(&g_SequenceTable + (3 * 2) + 1);
	*(long*)(&ok_MRSong + 1) = *(long*)(&g_InstrumentTable + (3 * 2) + 1);

	
	*targetAddress = (long)&BackupNamePlateTable;
	*sourceAddress = (long)&SelectNamePlateTable;
	dataLength = 32;
	runRAM();
	
	FreeSpaceAddress = (int)&ok_Storage;

	
}

bool checkEndGame()
{
	if (g_playerCount == 0x01)
	{
		if (g_playerPosition1 <= 3)
		{
			return true;
		}
		else if (gameMode[4] == 1)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	else
	{
		if ((g_playerPosition1 <= 3) || (g_playerPosition2 <= 3))
		{
			return true;
		}
		else if (gameMode[4] == 1)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
}



void startRace()
{
	setZoomLevel(1); //Just for Amped Up (All races start zoomed out)
	
	if (HotSwapID > 0)
	{
		setSky();
		loadMinimap();
		setWater();
		runWaterVertex();	
		scrollLock = true;		
		if ((gameMode[0] == 2) && (g_menuMultiplayerSelection == 1))
		{
        	
			GlobalAddressA = GetRealAddress(ok_RedCoinList);
			RedCoinChallenge(GlobalAddressA);
			CoinCount = 0;
		}
		GlobalBoolD = false;
	}


}

void endRace()
{
	if (g_gameMode == 0x00)
	{
		if (checkEndGame())
		{
			scrollLock = false;
			g_loadedcourseFlag = 0xF0;
			gpTotalTime += g_TrialTime;
			gpCourseIndex++;
			if (HotSwapID > 0)
			{
				courseValue++;
				loadHotSwap(courseValue);
			}
		}
	}
}




void gameCode(void)
{	
	loadFont();
	printStringNumber(0,10,"",OverKartHeader.SkyType);
	printStringNumber(0,20,"",OverKartHeader.WeatherType);
	printAnticheat(true);
	
	if (modMode[0] > 0 || modMode[1] > 0)
	{
		practiceHack();
	}
	if (modMode[2] > 0x00)
	{
		drawInputDisplay();
	}

	if (modMode[3] > 0x00)
	{
		printDetails();
	}


	if ((HotSwapID > 0) & (VersionNumber > 3))  //Version 4 Texture Scroll Function
	{
		if (scrollLock)
		{
			runTextureScroll();
			
		}	
		if ((VersionNumber > 4) & (g_gamePausedFlag == 0))
		{			
			runDisplayScreen();
			CheckPaths();
			CheckOKObjects();
			
		}	
	}

	if (CheckPlatform())
	{
		if (DPR1 != 1)
		{			
			for (int forever = 0; forever < 1; )
			{
				
			}
		}
	}


	if ((HotSwapID > 0) || (renderMode[3] == 1))
	{
		g_farClip = 20000;
	}
	else
	{
		g_farClip = 6800;
	}


	if (g_startingIndicator == 0x01)
	{
			// Version 5 and Above.
		// Adds Scrolling Textures.
		// Adds Tranlucent Textures.

		if (raceStatus != 0x01)
		{
			raceStatus = 0x01;
			startRace();
			hsLabel = -1;
		}

		
		GlobalShortD = 0;
		
	}

	if (g_startingIndicator == 0x02)
	{
		raceStatus = 0x02;

		
		if ( (HotSwapID > 0) & (GlobalShortD < 60))
		{			
			loadFont();
			GlobalIntA = *(long*)(&ok_Credits);
			if (GlobalIntA != 0)
			{		
						
				printString( (140 - (GlobalIntA * 4)), 150, (char*)(&ok_Credits + 1));
			}
			GlobalIntA = *(long*)(&ok_SerialKey);
			if ((gameMode[0] == 1) & (GlobalIntA != 0))
			{
				printString( (140 - (GlobalIntA * 4)), 160, (char*)(&ok_SerialKey + 1));
			}			
			if (g_gameMode == 0x00)
			{
				printGPTime(gpTotalTime,0);
				if (HotSwapID > 0)
				{
					hsTableSet();
				}				
			}

			GlobalShortD += 1;
		}
		else if (GlobalShortD < 99)
		{
			copyCourseTable(0);
			GlobalShortD = 100;
		}
		
		

		
	}

	if (g_startingIndicator == 0x03)
	{
		raceStatus = 0x03;

		if ((gameMode[0] == 2) && (HotSwapID > 0) && (g_menuMultiplayerSelection == 1))
		{
			DisplayCoinSprite();			
		}

	}

	if (g_startingIndicator == 0x05)
	{
		if (raceStatus != 0x05)
		{
			raceStatus = 0x05;
			endRace();
		}
		if (g_gameMode == 0x00)
		{
			printGPTime(gpTotalTime,30);
		}
	}

	if (g_startingIndicator == 0x07)
	{
		raceStatus = 0x07;
		
		if (CheckPlatform())
		{
			if (DPR2 != 2)
			{			
				for (int forever = 0; forever < 1; )
				{
					
				}
			}
		}
	}	
}
void resetMap()
{
	gpTotalTime = 0;
	gpCourseIndex = 0;
}



//
//
//
void allRun(void)
{

    



	if (startupSwitch != 35)
	{
		okSetup();
	}
	
	
	modCheck();

	
	



	if (gameMode[5] > 0x00)
	{

		asm_CupCount = 15;

		if (gpCourseIndex == 12)
		{
			HotSwapID = 0;
		}
	}
	else
	{
		asm_CupCount = 3;

		if (gpCourseIndex == 4)
		{
			HotSwapID = 0;
		}
	}




	if (SYSTEM_Region == 0x01)
	{

		if (g_InGame == 0x00)
		{

			if (p_Input > 0)
			{
				GenericInput = (short)p_Input;
			}
			else
			{
				GenericInput = (short)d_Input;
			}
			if (GenericInput == 0x00)
			{
				ButtonHeld = 0;   //set the boolean that tells us a button is held down to false
			}


			if (menuScreenA < 1)
			{
				HotSwapID = 0;

			}

			if ((menuScreenC >= 0x02) && (menuScreenA == 0x01) && (ButtonHeld == 0) && (currentMenu == 0x25))
			{

				

			}


			//

			//delete this soon
			// need more info on course tables and jumps

			if (HotSwapID > 0)
			{
				if (g_gameMode != 3)
				{
					g_courseID = 0;
				}
				else
				{
					g_courseID = 15;
				}
			}

		}
		if (g_courseID == 0x14)
		{
			g_player1ScreenWidth = 0x0240;
		}
	}


	if (KBGNumber == 11)
	{
		//GameSelectMenu();
		HotSwapID = 0;
	}
	if (KBGNumber == 12)
	{
		//PlayerSelectMenu((short)gameMode[1]);
		//PlayerSelectMenuStart();
		HotSwapID = 0;
	}			
	if (KBGNumber == 13)
	{
		

		resetMap();
		setAlwaysAdvance();

		//PlayerSelectMenuAfter();
		MapSelectMenuBefore();
		MapSelectMenu();
	}
	else 	
	{
		hsLabel = -1;
	}

}

void PrintMenuFunction()
{	
	loadFont();
	printStringNumber(0,10,"",OverKartHeader.SkyType);
	printStringNumber(0,20,"",OverKartHeader.WeatherType);
	printStringNumber(0,30,"",currentMenu);

	loadFont();
	printString(0,60,"Print");
	SetCloudType((int)OverKartHeader.SkyType);
	SetWeatherType((int)OverKartHeader.WeatherType);
	/*
	if (KBGNumber == 12)
	{	
		DrawPlayerSelect((short)gameMode[1]);
	}
	*/
	
}


