#include "../Library/MainInclude.h"
#include "OKInclude.h"


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

	SaveFunc800B45E0 = 0x03E0000800000000;
	SaveFunc800B4670 = 0x03E0000800000000;
	SaveFunc800B559C = 0x03E0000800000000;
	SaveFunc800B5948 = 0x03E0000800000000;
	LoadFunc800B4A10 = 0x03E0000800000000;
	
	ConsolePlatform = CheckPlatform();
	EmulatorPlatform = CheckEmulator();	
	
	if (SwopCheck == 0x11342067)
	{
		StopSwop = true;
	}
	else
	{
		StopSwop = false;		
	}
	SwopCheck = 0x11342067;
	
	
	
	*(short*)(0x800DC6FE) = 0xFFFF;

	
	loadEEPROM((uint)&SaveGame);	
	
	if ((GlobalController[0]->ButtonHeld & BTN_L) == BTN_L)
	{
		gameMode[0] = 2;
		modMode[0] = 2;
	}

	
	dataLength = 8;
	*sourceAddress = (long)((long)(&g_SequenceTable) + (3 * 8) + 4);	
	*targetAddress = (long)&ok_Sequence;
	runRAM();

	*sourceAddress = (long)((long)(&g_InstrumentTable) + (3 * 8) + 4);
	*targetAddress = (long)&ok_Instrument;
	runRAM();
	
	
	loadLogo();
	copyCourseTable(1);
	NopSplashCheckCode();
	FlyCamInit();
	startupSwitch = 35;
	nopASM = 0;
	HotSwapID = 0;
	asm_SongA = 0x240E0001;
	asm_SongB = 0x240E0001;
	g_sfxPause = 0; //Just for Amped Up (To fix some mute sfx when pausing the game)
	hsGP = 0;
	FlyCamSpeed = 5;
	ok_Knowledge = (long)(&ok_Target);

	/*
	*targetAddress = (long)&BackupPortraitTable;
	*sourceAddress = (long)&SelectPortraitTable;
	dataLength = 288;
	runRAM();
	
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
	
	*targetAddress = (long)&BackupNamePlateTable;
	*sourceAddress = (long)&SelectNamePlateTable;
	dataLength = 32;
	runRAM();
	*/
	
	*(long*)(&ok_USAudio) = *(long*)(&g_RawAudio + 1);
	*(long*)(&ok_USAudio + 1) = *(long*)(&g_InstrumentTable + 1);


	*(long*)(&ok_MRSong) = *(long*)(&g_SequenceTable + (3 * 2) + 1);
	*(long*)(&ok_MRSong + 1) = *(long*)(&g_InstrumentTable + (3 * 2) + 1);

	
	
	FreeSpaceAddress = (int)&ok_Storage;
	SaveGame.TENNES = false;
	
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
	if(SaveGame.TENNES == 1)
	{
		KWSpriteDiv(256,120,(ushort*)&Pirate,512,240,4);
	}
	else
	{
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
				GetSurfaceID();			
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
				MenuChanged = -1;
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
					printStringNumber(76,170,"Base Version -",OverKartHeader.Version);
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
	
	if (OverKartHeader.Version != 0xFFFFFFFF)
	{
		SetCloudType((char)OverKartHeader.SkyType);
		SetWeatherType((char)OverKartHeader.WeatherType);
		SetWeather3D(OverKartHeader.SkyType == 3);
		SetWaterType((char)OverKartHeader.WaterType);
	}
	
	
	if (SYSTEM_Region == 0x01)
	{
		
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
		if (g_courseID == 0x14)
		{
			g_player1ScreenWidth = 0x0240;
		}
	}

	switch(KBGNumber)
	{
		case 10:
		{
			if (MenuChanged != 10)
			{	
				MenuChanged = 10;

				if ((SaveGame.SaveVersion != 3) && (SaveGame.SaveVersion != 99))
				{
					SaveGame.SaveVersion = 3;	
					for (int This = 0; This < 8; This++)
					{
						renderMode[This] = 0;
						modMode[This] = 0;
						gameMode[This] = 0;
					}		
					gameMode[4] = 1;
					renderMode[1] = 1;
					renderMode[2] = 0;

					if (!ConsolePlatform)
					{
						renderMode[4] = 1;
					}
					SaveGame.TENNES = DPR();
					
				}
			}
			break;
		}
		case 11:
		{
			if (MenuChanged != 11)
			{
				MenuChanged = 11;
				saveEEPROM((uint)&SaveGame);
			}
			//GameSelectMenu();
			HotSwapID = 0;
			break;
		}
		case 12:
		{
			//PlayerSelectMenu((short)gameMode[1]);
			//PlayerSelectMenuStart();
			MenuChanged = 12;
			HotSwapID = 0;
			break;
		}			
		case 13:
		{
			if (MenuChanged != 13)
			{
				MenuChanged = 13;
				
				
				resetMap();
				setAlwaysAdvance();				
				HotSwapID = 0;
				stockASM();
				hsLabel = -1;
				courseValue = -1;
				setPreviews();
				previewRefresh();
			}	

			switch(g_gameMode)
			{
				//GRAND PRIX

				case 0:
				{
					if (courseValue != (g_cupSelect * 4))
					{
						FreeSpaceAddress = (int)&ok_Storage;
						break;
					}	
				}
				case 1:
				case 2:
				case 3:
				{
					if (courseValue != (g_cupSelect * 4)  + g_courseSelect)
					{
						FreeSpaceAddress = (int)&ok_Storage;
						break;
					}
				}
			}	

			//PlayerSelectMenuAfter();		
			MapSelectMenu();


			
			break;
			
		}
		default:
		{
			hsLabel = -1;
			MenuChanged = -1;
			break;
			
		}
	}

}
void PrintMenuFunction()
{		
	if(SaveGame.TENNES)
	{
		if (SaveGame.SaveVersion != 99)
		{
			SaveGame.SaveVersion = 99;
			*sourceAddress = (int)(&LogoROM);
			*targetAddress = (int)(&ok_FreeSpace);
			dataLength = PirateEnd - Pirate;
			runDMA();
			*sourceAddress = (int)(&ok_FreeSpace);
			*targetAddress = (int)(&ok_Logo);
			runMIO();
		}
		KWSpriteDiv(256,120,(ushort*)&ok_Logo,512,240,4);
	}

	//loadFont();
	//printStringUnsignedHex(0,10,"",(long)(&ok_FreeSpace));
}


