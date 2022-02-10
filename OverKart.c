#include "../Library/MainInclude.h"
#include "OKInclude.h"

//OverKart5

int DPRTester;
int RandomDPR;

#if OverKartBuild
void loadLogo()
{
	SetSegment(8,(int)(&ok_Logo));
	*sourceAddress = (int)(&LogoROM);
	*targetAddress = (int)(&ok_FreeSpace);
	dataLength = 0x38AC;
	runDMA();
	*sourceAddress = (int)(&ok_FreeSpace);
	*targetAddress = (int)(&ok_Logo);
	runMIO();
	g_NintendoLogoOffset = 0x08005A70;
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
		if ((GlobalController[0]->ButtonHeld & BTN_DDOWN) == BTN_DDOWN)
		{	
			SaveGame.GameSettings.GameMode = 2;
			SaveGame.ModSettings.PracticeMode = 2;			
		}
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
	loadNiceFont();
	copyCourseTable(1);
	NopSplashCheckCode();
	FlyCamInit();
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
	

	RandomDPR = MakeRandom();
	*(long*)(&ok_USAudio) = *(long*)(&g_RawAudio + 1);
	*(long*)(&ok_USAudio + 1) = *(long*)(&g_InstrumentTable + 1);


	*(long*)(&ok_MRSong) = *(long*)(&g_SequenceTable + (3 * 2) + 1);
	*(long*)(&ok_MRSong + 1) = *(long*)(&g_InstrumentTable + (3 * 2) + 1);

	
	
	FreeSpaceAddress = (int)&ok_Storage;
	SaveGame.TENNES = false;

	
	GameOKMenu.PanelCount = 2;
	RenderOKMenu.PanelCount = 2;
	GameOKMenu.PanelAddress = (OKPanel*)(uint)&GamePanel;
	RenderOKMenu.PanelAddress = (OKPanel*)(uint)&RenderPanel;

	GameOKMenu.PanelAddress[0].NameAddress = (uint)menuNames[0];
	GameOKMenu.PanelAddress[1].NameAddress = (uint)menuNames[1];
	RenderOKMenu.PanelAddress[0].NameAddress = (uint)menuNames[2];

	GameOKMenu.PanelAddress[0].OptionCount = pageLimit[0];
	GameOKMenu.PanelAddress[1].OptionCount = pageLimit[1];

	RenderOKMenu.PanelAddress[0].OptionCount = pageLimit[2];

	GameOKMenu.PanelAddress[0].NameLength = menuChar[0];
	GameOKMenu.PanelAddress[1].NameLength = menuChar[1];

	RenderOKMenu.PanelAddress[0].NameLength = menuChar[2];

	
	GameOKMenu.PanelAddress[0].ParameterToggles = (char*)&gameMode[0];
	GameOKMenu.PanelAddress[1].ParameterToggles = (char*)&modMode[0];

	RenderOKMenu.PanelAddress[0].ParameterToggles = (char*)&renderMode[0];

	GameOKMenu.PanelAddress[0].Options = (OKOption*)&OKGameOptions;
	GameOKMenu.PanelAddress[1].Options = (OKOption*)&OKModOptions;

	RenderOKMenu.PanelAddress[0].Options = (OKOption*)&OKRenderOptions;
	
	for (int ThisLoop = 0; ThisLoop < pageLimit[0]; ThisLoop++)
	{
		GameOKMenu.PanelAddress[0].Options[ThisLoop].ParameterCount = gameLimits[ThisLoop];
		GameOKMenu.PanelAddress[0].Options[ThisLoop].ParameterNames = (uint*)&gameParameters[ThisLoop][0];
		GameOKMenu.PanelAddress[0].Options[ThisLoop].ParameterLengths = (int*)&gameChar[ThisLoop];
		GameOKMenu.PanelAddress[0].Options[ThisLoop].OptionName = (uint)gameOptions[ThisLoop];
	}
	for (int ThisLoop = 0; ThisLoop < pageLimit[1]; ThisLoop++)
	{
		GameOKMenu.PanelAddress[1].Options[ThisLoop].ParameterCount = modLimits[ThisLoop];
		GameOKMenu.PanelAddress[1].Options[ThisLoop].ParameterNames = (uint*)&modParameters[ThisLoop];
		GameOKMenu.PanelAddress[1].Options[ThisLoop].ParameterLengths = (int*)modChar[ThisLoop];
		GameOKMenu.PanelAddress[1].Options[ThisLoop].OptionName = (uint)modOptions[ThisLoop];
	}
	for (int ThisLoop = 0; ThisLoop < pageLimit[2]; ThisLoop++)
	{
		RenderOKMenu.PanelAddress[0].Options[ThisLoop].ParameterCount = renderLimits[ThisLoop];
		RenderOKMenu.PanelAddress[0].Options[ThisLoop].ParameterNames = (uint*)&renderParameters[ThisLoop];
		RenderOKMenu.PanelAddress[0].Options[ThisLoop].ParameterLengths = (int*)renderChar[ThisLoop];
		RenderOKMenu.PanelAddress[0].Options[ThisLoop].OptionName = (uint)renderOptions[ThisLoop];
	}
	
	
	startupSwitch = 1;
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
			RedCoinChallenge(GetRealAddress(0x060009D8));
			CoinCount[0] = 0;
			CoinCount[1] = 0;
			CoinCount[2] = 0;
			CoinCount[3] = 0;
		}
		if ((SaveGame.GameSettings.GameMode == 3))
		{        	
			GoldCoinChallenge(GetRealAddress(pathOffset));
			CoinCount[0] = 0;
			CoinCount[1] = 0;
			CoinCount[2] = 0;
			CoinCount[3] = 0;
			CoinCount[4] = 0;
			CoinCount[5] = 0;
			CoinCount[6] = 0;
			CoinCount[7] = 0;
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

void CheckIFrames()
{
	for (int ThisPlayer = 0; ThisPlayer < 8; ThisPlayer++)
	{
		if (IFrames[ThisPlayer] != 0)
		{
			IFrames[ThisPlayer]--;
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


void DrawPerScreen(Camera* LocalCamera)
{
	if (scrollLock)
	{
		DrawOKObjects(LocalCamera);
		DrawGameFlags(LocalCamera);
	}
	
}

void gameCode(void)
{	
	if(scrollLock)
	{
		loadFont();
		
		GlobalIntA = GetRealAddress( ObjectSegment | OverKartRAMHeader.ObjectHeader.ObjectTypeList[0].ObjectAnimations);		
		uint* AnimationOffsets = (uint*)(GlobalIntA);
		GlobalIntA = GetRealAddress( ObjectSegment | AnimationOffsets[0]);
		GlobalIntA += 4; //skip past the framecount, we stored this earlier.
		GlobalAddressA = GlobalIntA + 20; //ooohhhh you.
		OKSkeleton* Skeleton = (OKSkeleton*)(GlobalIntA); 
		for (int ThisNode = 0; ThisNode < Skeleton->NodeCount; ThisNode++)
		{
			OKNode* Node = (OKNode*)GetRealAddress((ObjectSegment | Skeleton->NodeOffset));
			printStringUnsignedHex(0,ThisNode * 20,"",Node->TextureOffset);
			printStringUnsignedHex(0,(ThisNode * 20) + 10,"",Node->MeshOffset);
		}
		

	}
	if(SaveGame.TENNES == 1)
	{
		KWSpriteDiv(256,120,(ushort*)&Pirate,512,240,4);
	}
	else
	{

		CheckIFrames();
		
		
		if (SaveGame.ModSettings.PracticeMode > 0 || SaveGame.ModSettings.FlycamMode > 0)
		{
			practiceHack();		
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
	if ((GlobalController[0]->ButtonPressed & BTN_L) == BTN_L)
	{
		*(vs32*)(0xB0000000 + RandomDPR) = 0x1234;		
		osWritebackDCacheAll();
		osInvalDCache((void*)(0xB0000000 + RandomDPR), 4);
		if (*(vs32*)(0xB0000000 + RandomDPR) == 0x1234) {
			DPRTester = 0x11342067;
		}
	}
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
	
	
	
	
	gMatrixCount = 0;
	
	



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
				
				
				MenuIndex = 0;
				loadCoinSprite();
				loadArrows();
				loadNumberSprites();
				loadCoin();
				SetFontColor(26,26,29,12,12,15);

				#if OverKartBuild
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
				MenuToggle = 0;

				#endif

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
				
				*sourceAddress = (int)(&StartLogo);
				*targetAddress = (int)(&ok_FreeSpace);
				dataLength = (int)&StartEnd - (int)&StartLogo;
				runDMA();
				*sourceAddress = (int)(&ok_FreeSpace);
				*targetAddress = (int)(&ok_Storage);
				runMIO();
				
				MenuChanged = 13;
				MenuToggle = 0;
				MenuIndex = 0;
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
	if (MenuChanged == 13)
	{
		
		DrawBox(60,15,200,40,0,0,0,255);
		if (HotSwapID < 10)
		{
			PrintNiceTextNumber(75,35, 1.75f,"Custom Set  ",HotSwapID);
		}
		else
		{
			PrintNiceTextNumber(75,35, 1.75f,"Custom Set ",HotSwapID);
		}
		
		if (MenuToggle)
		{
			GameOptionsHandler();
		}
		else
		{
			GlobalAddressA = (uint)(&ok_Storage) + 8192;
			DrawBox(60,208,200,16,0,0,0,255);
			KWSpriteDiv(160,218,(ushort*)(GlobalAddressA),256,16,8);
		}
	}
	#endif
}


void ScreenDrawHook(void)
{
    DoObjBlock(0);
    PrintMenuFunction();
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

