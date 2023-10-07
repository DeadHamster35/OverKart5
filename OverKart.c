#include "../Library/MainInclude.h"
#include "OKInclude.h"
#include <stdio.h>

//OverKart6

extern unsigned short net[];

int DPRTester;
int RandomDPR;
short MapModeCheck = 0;
short LastMenuID = 0;
uint ROptionPressed = 0;


void DebugLog(uint Data)
{
	if (PrintCount >= 99)
	{
		PrintCount = 0;	
	}
	PrintLog[PrintCount] = Data;
	PrintCount++;

}

void loadLogo()
{

	
	
	//804CCB9C
	SetSegment(0x8,(int)(&ok_Logo));
	
	*sourceAddress = (int)(&LogoROM);
	*targetAddress = (int)(&ok_FreeSpace);
	dataLength = 0x38C0;
	runDMA();
	*sourceAddress = (int)(&ok_FreeSpace);
	*targetAddress = (int)(&ok_Logo);
	runMIO();

	g_NintendoLogoOffset = 0x08005A70;
	g_NintendoLogoBorder = 0x256B9478;
	
}


void SetMenuPanels(int SwitchMode)
{

	

	
	GameOKMenu.PanelAddress = (OKPanel*)(uint)&RacePanel;
	GameOKMenu.PanelAddress[0].NameAddress = (uint)menuNames[0];
	GameOKMenu.PanelAddress[1].NameAddress = (uint)menuNames[1];
	GameOKMenu.PanelAddress[2].NameAddress = (uint)menuNames[2];
	GameOKMenu.PanelAddress[0].NameLength = menuChar[0];
	GameOKMenu.PanelAddress[1].NameLength = menuChar[1];
	GameOKMenu.PanelAddress[2].NameLength = menuChar[2];
	
	GameOKMenu.PanelAddress[1].OptionCount = pageLimit[1];
	GameOKMenu.PanelAddress[2].OptionCount = pageLimit[2];
	
	GameOKMenu.PanelAddress[1].ParameterToggles = (char*)&renderMode[0];
	GameOKMenu.PanelAddress[2].ParameterToggles = (char*)&mapMode[0];
	GameOKMenu.PanelAddress[0].Options = (OKOption*)&OKGameOptions;
	GameOKMenu.PanelAddress[1].Options = (OKOption*)&OKRenderOptions;
	GameOKMenu.PanelAddress[2].Options = (OKOption*)&OKMapOptions;

	
	switch(SwitchMode)
	{
		case RACESWITCH:		
		{
			GameOKMenu.PanelAddress[0].OptionCount = pageLimit[0];
			GameOKMenu.PanelAddress[0].ParameterToggles = (char*)&gameMode[0];
			for (int ThisLoop = 0; ThisLoop < pageLimit[0]; ThisLoop++)
			{
				GameOKMenu.PanelAddress[0].Options[ThisLoop].ParameterCount = gameLimits[ThisLoop];
				GameOKMenu.PanelAddress[0].Options[ThisLoop].ParameterNames = (uint*)&gameParameters[ThisLoop][0];
				GameOKMenu.PanelAddress[0].Options[ThisLoop].ParameterLengths = (int*)&gameChar[ThisLoop];
				GameOKMenu.PanelAddress[0].Options[ThisLoop].OptionName = (uint)gameOptions[ThisLoop];
			}
			break;
		}
		case BATTLESWITCH:
		{
			GameOKMenu.PanelAddress[0].OptionCount = pageLimit[4];
			GameOKMenu.PanelAddress[0].ParameterToggles = (char*)&battleMode[0];

			for (int ThisLoop = 0; ThisLoop < pageLimit[4]; ThisLoop++)
			{
				GameOKMenu.PanelAddress[0].Options[ThisLoop].ParameterCount = battleLimits[ThisLoop];
				GameOKMenu.PanelAddress[0].Options[ThisLoop].ParameterNames = (uint*)&battleParameters[ThisLoop][0];
				GameOKMenu.PanelAddress[0].Options[ThisLoop].ParameterLengths = (int*)&battleChar[ThisLoop];
				GameOKMenu.PanelAddress[0].Options[ThisLoop].OptionName = (uint)battleOptions[ThisLoop];
			}
			break;
		}
	}
	for (int ThisLoop = 0; ThisLoop < pageLimit[1]; ThisLoop++)
	{
		GameOKMenu.PanelAddress[1].Options[ThisLoop].ParameterCount = renderLimits[ThisLoop];
		GameOKMenu.PanelAddress[1].Options[ThisLoop].ParameterNames = (uint*)&renderParameters[ThisLoop];
		GameOKMenu.PanelAddress[1].Options[ThisLoop].ParameterLengths = (int*)renderChar[ThisLoop];
		GameOKMenu.PanelAddress[1].Options[ThisLoop].OptionName = (uint)renderOptions[ThisLoop];
	}

	for (int ThisLoop = 0; ThisLoop < pageLimit[2]; ThisLoop++)
	{
		GameOKMenu.PanelAddress[2].Options[ThisLoop].ParameterCount = mapLimits[ThisLoop];
		GameOKMenu.PanelAddress[2].Options[ThisLoop].ParameterNames = (uint*)&mapParameters[ThisLoop];
		GameOKMenu.PanelAddress[2].Options[ThisLoop].ParameterLengths = (int*)mapChar[ThisLoop];
		GameOKMenu.PanelAddress[2].Options[ThisLoop].OptionName = (uint)mapOptions[ThisLoop];
	}
}
void okSetup(void)
{
	
	
	
	//ConsolePlatform = CheckPlatform();
	//EmulatorPlatform = CheckEmulator();	
	
	
	
	//8047CBA0
	loadLogo();
	loadArrows();
	loadHeaderOffsets();
	loadHudButtons();
	SetupFontF3D();
	
	loadEEPROM((uint)&SaveGame);
	CheckContPackMenu();
	

	
	dataLength = 8;
	*sourceAddress = (int)&g_MUSSequenceTable.pointer[3].address;
	*targetAddress = (int)&ok_Sequence;
	runRAM();

	*sourceAddress = (int)&g_MUSInstrumentTable.pointer[3];
	*targetAddress = (int)&ok_Instrument;
	runRAM();

	*sourceAddress = (int)&g_BombTable;
	*targetAddress = (int)&ok_Bomb;	
	dataLength = 0xA8;
	runRAM();
	
	

	
	loadBigFont();
	copyCourseTable(1);
	NopSplashCheckCode();
	//FlyCamInit();

	HotSwapID = 0;

    copyCourseTable(0);
	raceStatus = 0xFF;
	asm_SongA = 0x240E0001;
	asm_SongB = 0x240E0001;

	g_sfxPause = 0; //Just for Amped Up (To fix some mute sfx when pausing the game)
	hsGP = 0;
	MapModeCheck = 0;
	PrintCount = 0;
	//FlyCamSpeed = 5;
	//ok_Knowledge = (long)(&ok_Target);

	YFLIP = 0;
	ZFLIP = 0;
	
	//PlayerSelectSetup();

	
	*(long*)(&ok_USAudio) = g_MUSRawAudioTable.pointer[0].address;
	*(long*)(&ok_USAudio + 1) = g_MUSInstrumentTable.pointer[0].address;


	*(long*)(&ok_MRSong) = g_MUSSequenceTable.pointer[3].address;
	*(long*)(&ok_MRSong + 1) = g_MUSSequenceTable.pointer[3].length;
	
	FreeSpaceAddress = (int)&ok_Storage;
	SaveGame.TENNES = false;

	GameOKMenu.PanelCount = 3;
	
	SetMenuPanels(RACESWITCH);
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

	InitialCustomParticleBuffer();
	if (g_gameMode == GAMEMODE_BATTLE)
	{
		if (SaveGame.BattleSettings.GameMode == BTL_CTF)
		{
			PlaceFlags(BattleFlag, FlagModels, RedMushroom, MushroomModels, 1);
		}		
		if (SaveGame.BattleSettings.GameMode == BTL_SOCCER)
		{
			PlaceBalls(SoccerBall, RedMushroom, MushroomModels, 1);  //lol
		}

	}
	
	
	if ((SaveGame.GameSettings.StatsMode == 1) || (g_gameMode == GAMEMODE_TT))
	{
		checkStats(1);
	}
	else
	{
		checkStats(0);
	}

	if (g_gameMode == GAMEMODE_GP)
	{
		SetAIDifficulty(g_raceClass);
	}

	
	if (HotSwapID > 0)
	{
		if (g_gameMode != GAMEMODE_TT)
		{
			PlaceSIBox(GetRealAddress(0x06000668));
		}
		if (g_gameMode != GAMEMODE_BATTLE)
		{
			EmptyActionData();
		
			setSky();
			setWater();
			loadMinimap();	
		}
		if ((SaveGame.GameSettings.GameMode == 1))  
		{     
			//Red Coin Challenge   	
			RedCoinChallenge(GetRealAddress(0x06000620));
			CoinCount[0] = 0;
			CoinCount[1] = 0;
			CoinCount[2] = 0;
			CoinCount[3] = 0;
		}
		
		if ((SaveGame.GameSettings.GameMode == 2))  
		{      
			//Gold Coin Challenge  	
			
			
			GlobalIntA = (int)(8 * g_playerCount); // CoinCount
			
			if (GlobalIntA < 10)
			{
				GlobalIntA = 10;
			}
			GoldCoinChallenge(GetRealAddress(pathOffset), GlobalIntA);
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
		}
	}
	else
	{
		
		if ((SaveGame.GameSettings.GameMode == 2))  
		{      
			//Gold Coin Challenge  	
			
			
			GlobalIntA = (int)(8 * g_playerCount); // CoinCount
			
			if (GlobalIntA < 10)
			{
				GlobalIntA = 10;
			}


			if (g_courseID != 4)
			{
				GoldCoinChallenge(GetRealAddress(PathTable[g_courseID][0]), GlobalIntA);
			}
			else
			{
				GlobalIntA = (int)(GlobalIntA * 0.3f);
				GoldCoinChallenge(GetRealAddress(PathTable[g_courseID][0]), GlobalIntA);
				GoldCoinChallenge(GetRealAddress(PathTable[g_courseID][1]), GlobalIntA);
				GoldCoinChallenge(GetRealAddress(PathTable[g_courseID][2]), GlobalIntA);
				GoldCoinChallenge(GetRealAddress(PathTable[g_courseID][3]), GlobalIntA);
			}
			
			CoinCount[0] = 0;
			CoinCount[1] = 0;
			CoinCount[2] = 0;
			CoinCount[3] = 0;
			CoinCount[4] = 0;
			CoinCount[5] = 0;
			CoinCount[6] = 0;
			CoinCount[7] = 0;
		}
	}
	

}

void endRace()
{
	scrollLock = false;
	if (g_gameMode == GAMEMODE_GP)
	{		
		if (checkEndGame())
		{
			gpCourseIndex++;
			g_loadedcourseFlag = 0xF0;		
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




void ExecuteItemHook(Player* Car)
{
	if (g_gameMode != GAMEMODE_BATTLE)
	{
		ExecuteItem(Car);
	}
	{
		switch (SaveGame.BattleSettings.GameMode)
		{
			case BTL_BATTLE:
			{
				ExecuteItem(Car);
				break;
			}
			case BTL_CTF:
			{
				int PlayerID = (*(uint*)&Car - (uint)&g_PlayerStructTable) / 0xDD8;
				
				if (GlobalController[PlayerID]->ButtonPressed & BTN_Z)				
				{
					if (CheckExecuteItem(PlayerID))
					{
						ExecuteItem(Car);
					}
				}
				break;
			}
			case BTL_SOCCER:
			{
				int PlayerID = (*(uint*)&Car - (uint)&g_PlayerStructTable) / 0xDD8;
				
				if (GlobalController[PlayerID]->ButtonPressed & BTN_Z)
				{
					if (CheckExecuteItem(PlayerID))
					{
						ExecuteItem(Car);
					}
				}
				break;
			}
		}
	}
}


void CheckBattleCDown()
{
	
	switch (SaveGame.BattleSettings.GameMode)
	{
		case BTL_BATTLE:
		{
			break;
		}
		case BTL_CTF:
		{
			for (int ThisPlayer = 0; ThisPlayer < g_playerCount; ThisPlayer++)
			{
				if (GlobalController[ThisPlayer]->ButtonPressed & BTN_CDOWN)				
				{
					DropFlag(ThisPlayer);
				}
			}
			break;
		}
		case BTL_SOCCER:
		{
			for (int ThisPlayer = 0; ThisPlayer < g_playerCount; ThisPlayer++)
			{
			}
			break;
		}
	}
	
}



void gameCode(void)
{	
	#if(DEBUGBUILD==TRUE)
	{
		if(scrollLock)
		{

			loadFont();
			
			//OverKartHeader.ScrollROM
			for (int ThisList = 0; ThisList < 5; ThisList++)
			{
				printStringNumber(0, ThisList * 10, "", OverKartRAMHeader.ObjectList[ThisList].Flag);
			}
		}
	}
	#endif


	if(SaveGame.TENNES == 1)
	{
		KWSpriteDiv(256,120,(ushort*)&Pirate,512,240,4);
	}
	else
	{
		


		CheckIFrames();
		
		if (SaveGame.RenderSettings.Platform == 0)
		{
			//Console
			if (g_gameMode != GAMEMODE_TT)
			{
				DynamicTempo();
			}
			else
			{
				if (HotSwapID > 0)
				{
					StaticTempo(OverKartHeader.ManualTempo);
				}
				else
				{
					StaticTempo(2);
				}
			}
			
		}
		else
		{
			//emulator
			StaticTempo(2);
		}
		
		
		if (g_gameMode == GAMEMODE_BATTLE)
		{
			switch(SaveGame.BattleSettings.GameMode)
			{
				case BTL_BATTLE:
				{
					break;
				}
				case BTL_CTF:
				{							
					CaptureFlag();
					break;
				}
				case BTL_SOCCER:
				{
					CaptureBalls();
					break;
				}
			}
		}

		if (MapModeCheck || (SaveGame.GameSettings.GameMode == 3))
		{
			practiceHack();		
		}
		if (SaveGame.GameSettings.FlycamMode == 1)
		{
			RunFlyCam();
		}
		
		SurfaceExplorerMode = SaveGame.GameSettings.ExploreMode;

		if (SaveGame.RenderSettings.InputMode > 0x00)
		{
			drawInputDisplay();
		}

		if (SaveGame.RenderSettings.DetailMode > 0x00)
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

				//Dynamic WaveRace Water 
				runWaterVertex();
				LavaFloorRecoil();
				CheckPaths();
				
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


		if (g_startingIndicator == 1)
		{
				// Version 5 and Above.
			// Adds Scrolling Textures.
			// Adds Tranlucent Textures.

			if (raceStatus != 1)
			{
				raceStatus = 1;
				startRace();
				hsLabel = -1;
				MenuChanged = -1;
			}

			
			GlobalShortD = 0;
			
		}
		if (g_startingIndicator == 2)
		{
			raceStatus = 2;
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
					if ((g_gameMode == GAMEMODE_TT) && (GlobalIntA != 0))
					{
						printString( (140 - (GlobalIntA * 4)), 160, (char*)(&ok_SerialKey + 1));
						printStringNumber(76,170,"Base Version -",OverKartHeader.Version);
					}			
					if (g_gameMode == GAMEMODE_GP)
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

			
		}
		if (g_startingIndicator == 3)
		{
			raceStatus = 3;
			if ((SaveGame.GameSettings.GameMode == 2) && (HotSwapID > 0) && (g_menuMultiplayerSelection == 1))
			{
				DisplayCoinSprite();			
			}
			
			
		}
		
		if (g_startingIndicator == 5)
		{
			if (raceStatus != 5)
			{
				gpTotalTime += g_TrialTime;
				raceStatus = 5;
			}
			if (g_gameMode == GAMEMODE_GP)
			{
				printGPTime(gpTotalTime,30);
			}
		}

		if (g_startingIndicator == 6)
		{	
			raceStatus = 6;
		}

		if (g_startingIndicator == 7)
		{
			
			if (raceStatus != 7)
			{
				raceStatus = 7;	
				
				endRace();
			}
			
		}
		
		if(SaveGame.RenderSettings.DisplayFPS == 1)
		{
			DrawFPS(220,10);	
		}
		

		#ifndef CFLG_LapCounter
			DrawLapCounter();	
		#endif
	}
}
void resetMap()
{
	gpTotalTime = 0;
	gpCourseIndex = 0;
}


uint SearchJRK0()
{
	uint Address = 0x80000000;

	do 
	{
		if ( (*(uint*)(Address)) == 0x03400008)
		{
			return Address;
		}
		
		Address+=4;
	} while(Address < 0x80800000);
	
	return 0;
}
//
//
//



void allRun()
{
	MakeRandom();
	

	if (GlobalController[4]->ButtonPressed != 0)
	{
		MakeRandom();
	}

	if (SaveGame.RenderSettings.CullMode == 1)
	{
		//Emulator
		CullDL_Parameters = 0x0000000E;
	}
	else
	{
		//Console
		CullDL_Parameters = 0x00000140;
	}


	GlobalIntD = 0;
	ClockCycle[0] = osGetCount();
	CycleCount[0] = (ClockCycle[0] - OldCycle[0]);
	OldCycle[0] = ClockCycle[0];
	GlobalFrameCount++;

	switch (startupSwitch)
	{
		case 0:
		okSetup();
		break;

		case 1:
		
		if (((GlobalController[0]->ButtonHeld & BTN_L) == BTN_L) && ((GlobalController[0]->ButtonPressed & BTN_DDOWN) == BTN_DDOWN))
		{
			MapModeCheck = 1;	
		}
		break;
		
		case 2:
		modCheck();
		break;
	}
	
	
	gMatrixCount = 0;
	
	
	if ((HotSwapID == 0) || (OverKartHeader.BackgroundToggle == 1))
	{
		gBackgroundFlag = 1;
	}
	else
	{
		gBackgroundFlag = 0;
	}
	

	if (SaveGame.GameSettings.CupMode > 0x00)
	{

		asm_CupCount = 15;

		if ((g_startingIndicator >= 6) && (gpCourseIndex == 16))
		{
			g_NewSequenceMode = 1; //trophy sequence is brokens
			KBGNumber = 11;
		}
	}
	else
	{
		asm_CupCount = 3;

		if ((g_startingIndicator >= 6) && (gpCourseIndex == 4))
		{
			g_NewSequenceMode = 1; //trophy sequence is brokens
			KBGNumber = 11;
		}
	}
	SetWeather3D(OverKartHeader.SkyType == 3);
	SetWaterType((char)OverKartHeader.WaterType);
	
	if (SYSTEM_Region == 0x01)
	{
		if (HotSwapID > 0)
		{
			if (g_gameMode != GAMEMODE_BATTLE)
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
		case 6:
		{
			if (MenuChanged != 6)
			{
				LastMenuID = MenuChanged;
				MenuChanged = 6;
			}
			GameOptionsHandler(4);
			break;
		}
		case 8:
		{
			if (MenuChanged != 8)
			{
				LastMenuID = MenuChanged;
				MenuChanged = 8;
			}
			break;
		}
		case 10:
		{			
			scrollLock = false;
			g_startingIndicator = 0;
			if (MenuChanged != 10)
			{	
				//MenuToggle = 0;
				LastMenuID = MenuChanged;
				MenuChanged = 10;
				
				MenuIndex = 0;
				loadCoinSprite();
				loadArrows();
				loadNumberSprites();
				loadCoin();
				
				
				//SetFontColor(26,26,29,12,12,15);ok_sto
				

				#if OverKartBuild
				MenuAngle[2] = -20;
				MenuAngle[3] = 0;

				*sourceAddress = (int)(&StartLogo);
				*targetAddress = (int)(&ok_FreeSpace);
				dataLength = (int)&StartEnd - (int)&StartLogo;
				runDMA();
				*sourceAddress = (int)(&ok_FreeSpace);
				*targetAddress = (int)(&ok_Storage);
				StartLogoRAM = (int)(&ok_Storage);
				GlobalAddressA = runMIO();

				*sourceAddress = (int)(&BackDrop);
				*targetAddress = (int)(&ok_FreeSpace);
				dataLength = (int)&BackDropEnd - (int)&BackDrop;
				runDMA();
				*sourceAddress = (int)(&ok_FreeSpace);
				*targetAddress = GlobalAddressA;
				BackdropRAM = GlobalAddressA;
				GlobalAddressA = runMIO();
				
				*sourceAddress = (int)(&Splash3D);
				*targetAddress = (int)(&ok_FreeSpace);
				dataLength = (int)&Splash3DEnd - (int)&Splash3D;
				runDMA();
				*sourceAddress = (int)(&ok_FreeSpace);
				*targetAddress = GlobalAddressA;
				Splash3DRAM = GlobalAddressA;
				GlobalAddressA = runMIO();
				
				SetSegment(0xA, Splash3DRAM);
				
				GlobalUIntB = (uint)GlobalAddressA;
				#endif

				
				startupSwitch = 2;

				#if ProtectMode
					SaveGame.TENNES = DPR();
					DPRSave();
				#endif

				if ((SaveGame.SaveVersion != 7) && (SaveGame.SaveVersion != 99))
				{
					SaveGame.SaveVersion = 7;	
					for (int This = 0; This < 8; This++)
					{
						renderMode[This] = 0;
						gameMode[This] = 0;
						mapMode[This] = 0;
						battleMode[This] = 0;
					}
					for (int This = 8; This < 16; This++)
					{
						renderMode[This]  = 0;
					}
					SaveGame.RenderSettings.AliasMode = 1;
					SaveGame.RenderSettings.Platform = 1;
					SaveGame.RenderSettings.CullMode = 1;
					
					SaveGame.LevelSettings.ScaleXMode = 2;
					SaveGame.LevelSettings.ScaleYMode = 2;
					SaveGame.LevelSettings.ScaleZMode = 2;
				}
			}
			break;
		}
		
		case 11:
		{
			if (MenuChanged != 11)
			{
				menuScreenB = 3; //resets mode selection to start screen.
				LastMenuID = MenuChanged;
				MenuChanged = 11;
				//MenuToggle = 0;
				
				/*
				*sourceAddress = (int)(&MenuIconsROM);
				*targetAddress = (int)(&ok_FreeSpace);
				dataLength = (int)&MenuIconsEnd - (int)&MenuIconsROM;
				runDMA();
				*sourceAddress = (int)(&ok_FreeSpace);
				*targetAddress = (int)(&ok_Storage);
				MenuIconsRAM = (int)(&ok_Storage);
				GlobalAddressA = runMIO();
				*/
				*sourceAddress = (int)(&ROptionROM);
				*targetAddress = (int)(&ok_FreeSpace);
				dataLength = (int)&ROptionEnd - (int)&ROptionROM;
				runDMA();
				*sourceAddress = (int)(&ok_FreeSpace);
				*targetAddress = (int)(&ok_Storage);
				MenuIconsRAM = (int)(&ok_Storage);
				GlobalAddressA = runMIO();

				saveEEPROM((uint)&SaveGame);
			}
			
			scrollLock = false;
			g_startingIndicator = 0;
			HotSwapID = 0;
			copyCourseTable(0);
			break;
		}
		case 12:
		{
			
			if (MenuChanged != 12)
			{					
				//MenuToggle = 0;
				if (g_gameMode == GAMEMODE_BATTLE)
				{
					SetMenuPanels(BATTLESWITCH);
				}
				else
				{
					SetMenuPanels(RACESWITCH);
				}

				//PlayerSelectMenuBefore();
				MenuProgress[0] = 0;
				MenuProgress[1] = 0;
				MenuProgress[2] = 0;
				MenuProgress[3] = 0;

				LastMenuID = MenuChanged;
				MenuChanged = 12;   
				//menuScreenC = 0;       
			}
			scrollLock = false;
			HotSwapID = 0;
			copyCourseTable(0);
			break;
		}			
		case 13:
		{
			scrollLock = false;
			g_startingIndicator = 0;
			if (MenuChanged != 13)
			{
				//MenuToggle = 0;

				LastMenuID = MenuChanged;
				MenuChanged = 13;
				
				
				//PlayerSelectMenuAfter();

				
				//
				//
				//reload the R options graphic 
				*sourceAddress = (int)(&ROptionROM);
				*targetAddress = (int)(&ok_FreeSpace);
				dataLength = (int)&ROptionEnd - (int)&ROptionROM;
				runDMA();
				*sourceAddress = (int)(&ok_FreeSpace);
				*targetAddress = (int)(&ok_Storage);
				MenuIconsRAM = (int)(&ok_Storage);
				GlobalAddressA = runMIO();
				// finish loading Press R graphic
				//
				//

				MenuIndex = 0;
				resetMap();
				setAlwaysAdvance();				
				HotSwapID = 0;
				copyCourseTable(0);
				setPreviews();
				previewRefresh();
				setBanners();
				hsLabel = -1;
				courseValue = -1;
				
			}				
		


			
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
	loadFont();
	printStringNumber(0,0,"",KBGNumber);
	ClockCycle[1] = osGetCount();
	CycleCount[1] = (ClockCycle[1] - OldCycle[1]);     
	OldCycle[1] = ClockCycle[1];

	#if(DEBUGBUILD==TRUE)
	{
		loadFont();
		
		
		printStringUnsignedHex(0,10,"7",(uint)7);
		
	}
	#endif
	if(SaveGame.RenderSettings.DisplayFPS == 1)
	{
		DrawFPS(220,10);	
	}
	
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
		return;
	}
	#endif
	switch (MenuChanged)
	{
		case 6:
		{
			//Draw OptionsMenu
			
			if (MenuIndex < GameOKMenu.PanelCount)
			{
				ModularMenu((OKMenu*)&GameOKMenu);
				
				if (MenuIndex == 2)  //filthy hack
				{
					KWSprite(240,22,16,16,(ushort*)&lit_arrowsprite_r);
				}
			}
			else
			{
				CourseMenu(175);
			}
			break;
		}
		case 8:
		{
			//logo
			
			if (DEBUGBUILD)
			{
				loadFont();
				printStringUnsignedHex(0,0,"PRINTLOG", (uint)&PrintLog);
			}
			
			break;
		}
		case 10:
		{
			//title screen
			DrawBox(102,130,120,38, 0, 0, 0, 200);

			if (SaveGame.RenderSettings.CullMode == 0)
			{
				PrintBigText(128, 131, 0.6f, "LLE MODE" );
			}
			else
			{
				PrintBigText(128, 131, 0.6f, "HLE MODE" );
			}
			if (SaveGame.RenderSettings.Platform == 0)
			{
				PrintBigText(115, 149, 0.6f, "N64 CONSOLE" );
			}
			else
			{
				PrintBigText(128, 149, 0.6f, "EMULATOR" );
			}
			
			if (TitleSwitch == 0)
			{
				GlobalIntA = 140;
			}
			else
			{
				GlobalIntA = 158;
			}
			KWSprite(235,GlobalIntA,16,16,(ushort*)&lit_arrowsprite_r);
			KWSprite(95,GlobalIntA,16,16,(ushort*)&lit_arrowsprite_l);

			
			loadFont();
			printString(0,200,VersionString);

			break;

		}
		case 11:
		{
			DrawGameSelect();
			break;
			if (!MenuToggle)
			{
				//Press R for Options Message
				GlobalAddressA = (uint)(StartLogoRAM) + 8192;
				DrawBox(65,200,190,16,0,0,0,175);
				KWSpriteDiv(160,210,(ushort*)(GlobalAddressA),256,16,8);
			}
			break;
		}
		case 12:
		{
			DrawPlayerSelect(SaveGame.GameSettings.StatsMode);
			break;
			if (!MenuToggle)
			{
				//Press R for Options Message
				GlobalAddressA = (uint)(StartLogoRAM) + 8192;
				DrawBox(65,200,190,16,0,0,0,175);
				KWSpriteDiv(160,210,(ushort*)(GlobalAddressA),256,16,8);
			}
			break;

		}
		case 13:
		{
			DrawMapSelect();
			break;

		}
	}
	FadeMain();
}


void ScreenDrawHook(void)
{
	
	DoObjBlock(0);
	PrintMenuFunction();
}