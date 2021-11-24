#include "../Library/MainInclude.h"
#include "OKInclude.h"

#if OverKartBuild
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
#endif

void okSetup(void)
{

	SaveFunc800B45E0 = 0x03E0000800000000;
	SaveFunc800B4670 = 0x03E0000800000000;
	SaveFunc800B559C = 0x03E0000800000000;
	SaveFunc800B5948 = 0x03E0000800000000;
	LoadFunc800B4A10 = 0x03E0000800000000;
	
	ConsolePlatform = CheckPlatform();
	EmulatorPlatform = CheckEmulator();	
	
	loadHeaderOffsets();

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
		SaveGame.GameSettings.GameMode = 2;
		SaveGame.ModSettings.PracticeMode = 2;
	}

	
	dataLength = 8;
	*sourceAddress = (long)((long)(&g_SequenceTable) + (3 * 8) + 4);	
	*targetAddress = (long)&ok_Sequence;
	runRAM();

	*sourceAddress = (long)((long)(&g_InstrumentTable) + (3 * 8) + 4);
	*targetAddress = (long)&ok_Instrument;
	runRAM();

	*sourceAddress = (int)&g_BombTable;
	*targetAddress = (long)&ok_Bomb;	
	dataLength = 0xA8;
	runRAM();
	
	#if OverKartBuild
	loadLogo();
	#endif
	copyCourseTable(1);
	NopSplashCheckCode();
	FlyCamInit();
	startupSwitch = 1;
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
		else if (SaveGame.GameSettings.GPMode == 1)
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
		else if (SaveGame.GameSettings.GPMode == 1)
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
	g_loadedcourseFlag = 0xF0;
	if (HotSwapID > 0)
	{
		if (g_gameMode != 0)
		{
			gpCourseIndex = 0;
		}
		
		if (g_gameMode != 3)
		{
			EmptyActionData();
		
			setSky();
			setWater();
			loadMinimap();				
		}
		if ((SaveGame.GameSettings.GameMode == 2))
		{        	
			GlobalAddressA = GetRealAddress(0x060009D8);
			RedCoinChallenge(GlobalAddressA);
			CoinCount = 0;
		}		
		if (VersionNumber > 4)
		{
			for (int This = 0; This < 100; This++)
			{
				ClearOKObject(This);
			}
			loadOKObjects();
			setOKObjects();					
			loadTextureScrollTranslucent();
		}
	}
	

}

void endRace()
{
	if (g_gameMode == 0x00)
	{
		if (checkEndGame())
		{
			scrollLock = false;
		}
		if (!scrollLock)
		{	
			gpTotalTime += g_TrialTime;
			gpCourseIndex++;
		}
	}
}

void MapStartup(short InputID)
{
	LoadCustomHeader(courseValue + gpCourseIndex);
	SetCustomData();
	LoadMapData(InputID);
	
	setPath();
}
void InitialMapCode()
{
	
	InitialMap();
	
	if ((HotSwapID > 0) && (g_gameMode == 3))
	{
		SearchListFile(0x06000000 | OverKartHeader.SurfaceMapPosition);
		MakeCollision();
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
		
		
		if (SaveGame.ModSettings.PracticeMode > 0 || SaveGame.ModSettings.FlycamMode > 0)
		{
			//practiceHack();		
		}
		if (SaveGame.ModSettings.InputMode > 0x00)
		{
			drawInputDisplay();
		}

		if (SaveGame.ModSettings.DetailMode > 0x00)
		{
			printDetails();
		}

		
		if (HotSwapID > 0)   //Version 4 Texture Scroll Function
		{			
			if ((g_gamePausedFlag == 0) && (scrollLock))
			{
				runTextureScroll();
				CheckOKObjects();
				runDisplayScreen();
				CheckPaths();
				GetSurfaceID();	
				
				
			}	
		}
		

		if ((HotSwapID > 0) || (SaveGame.RenderSettings.DrawMode == 1))
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
			scrollLock = true;
			
			if (GlobalShortD < 60)
			{	
				printAnticheat(true);		
				if  (HotSwapID > 0)
				{
					loadFont();
					GlobalIntA = *(long*)(&ok_Credits);
					if (GlobalIntA != 0)
					{		
								
						printString( (140 - (GlobalIntA * 4)), 150, (char*)(&ok_Credits + 1));
					}
					GlobalIntA = *(long*)(&ok_SerialKey);
					if ((SaveGame.GameSettings.GameMode == 1) & (GlobalIntA != 0))
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

			if ((SaveGame.GameSettings.GameMode == 2) && (HotSwapID > 0) && (g_menuMultiplayerSelection == 1))
			{
				DisplayCoinSprite();			
			}

		}
		
		if (g_startingIndicator == 0x05)
		{
			if (raceStatus != 0x05)
			{
				raceStatus = 0x05;
			}
			if (g_gameMode == 0x00)
			{
				printGPTime(gpTotalTime,30);
			}
		}

		if (g_startingIndicator == 0x07)
		{
			raceStatus = 0x07;
			endRace();
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
	
	switch (startupSwitch)
	{
		case 0:
		okSetup();
		break;

		case 1:
		break;
		
		case 2:
		modCheck();
		break;
	}
	
	
	
	
	
	
	



	if (SaveGame.GameSettings.CupMode > 0x00)
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
	
	
	
	SetCloudType((char)OverKartHeader.SkyType);
	SetWeatherType((char)OverKartHeader.WeatherType);
	SetWeather3D(OverKartHeader.SkyType == 3);
	SetWaterType((char)OverKartHeader.WaterType);
	
	
	
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
			scrollLock = false;
			g_startingIndicator = 0;
			if (MenuChanged != 10)
			{	
				loadCoinSprite();
				loadArrows();
				loadNumberSprites();
				loadCoin();
				SetFontColor(26,26,29,12,12,15);

				MenuAngle[2] = -30;
				MenuAngle[3] = 30;
				*sourceAddress = (int)(&StartLogo);
				*targetAddress = (int)(&ok_FreeSpace);
				dataLength = (int)&StartEnd - (int)&StartLogo;
				runDMA();
				*sourceAddress = (int)(&ok_FreeSpace);
				*targetAddress = (int)(&ok_Storage);
				runMIO();

				*sourceAddress = (int)(&BackDrop);
				*targetAddress = (int)(&ok_FreeSpace);
				dataLength = (int)&BackDropEnd - (int)&BackDrop;
				runDMA();
				*sourceAddress = (int)(&ok_FreeSpace);
				*targetAddress = (int)(&ok_Storage) + 0x5000;
				runMIO();
				
				*sourceAddress = (int)(&Splash3D);
				*targetAddress = (int)(&ok_FreeSpace);
				dataLength = (int)&Splash3DEnd - (int)&Splash3D;
				runDMA();
				*sourceAddress = (int)(&ok_FreeSpace);
				*targetAddress = (int)(&ok_Storage) + 0x25000;
				runMIO();
				SetSegment(0xA, *targetAddress);

				MenuChanged = 10;
				startupSwitch = 2;

				#if ProtectMode
					SaveGame.TENNES = DPR();
					DPRSave();
				#endif

				if ((SaveGame.SaveVersion != 3) && (SaveGame.SaveVersion != 99))
				{
					SaveGame.SaveVersion = 3;	
					for (int This = 0; This < 8; This++)
					{
						renderMode[This] = 0;
						modMode[This] = 0;
						gameMode[This] = 0;
					}
					SaveGame.RenderSettings.AliasMode = 1;

					if (!ConsolePlatform)
					{
						SaveGame.RenderSettings.TempoMode = 1;
					}
					
					
				}
			}
			break;
		}
		
		case 11:
		{
			scrollLock = false;
			g_startingIndicator = 0;
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
			scrollLock = false;
			//PlayerSelectMenu((short)gameMode[1]);
			//PlayerSelectMenuStart();
			MenuChanged = 12;
			HotSwapID = 0;
			break;
		}			
		case 13:
		{
			scrollLock = false;
			g_startingIndicator = 0;
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
	

	#if ProtectMode
	if(SaveGame.TENNES == 1)
	{		
		if (SaveGame.SaveVersion != 99)
		{
			SaveGame.SaveVersion = 99;
			*sourceAddress = (int)(&Pirate);
			*targetAddress = (int)(&ok_FreeSpace);
			dataLength = (int)&PirateEnd - (int)&Pirate;
			runDMA();
			*sourceAddress = (int)(&ok_FreeSpace);
			*targetAddress = (int)(&ok_Storage);
			runMIO();
		}
		KWSpriteDiv(256,120,(ushort*)&ok_Storage,512,240,4);
	}
	#endif
}

void DisplayCrashScreen()
{
	*sourceAddress = (int)(&Crash);
	*targetAddress = *(uint*)0x80162D5C;
	dataLength = (int)&CrashEnd - (int)&Crash;
	runDMA();
}


void XLUDisplay(Screen* PlayerScreen)
{	
	if ((OverKartHeader.Version > 4) && (HotSwapID > 0))
	{	
		if (g_gameMode != 3)
		{
			DisplayGroupmap(GetRealAddress(SegmentAddress(6,OverKartHeader.XLUSectionViewPosition)), PlayerScreen);
		}
		else
		{
			*(long*)*graphPointer = (long)(0x06000000);
			*graphPointer = *graphPointer + 4;
			*(long*)*graphPointer = (long)(SegmentAddress(6,OverKartHeader.XLUSectionViewPosition));
			*graphPointer = *graphPointer + 4;
		}
	}
}

