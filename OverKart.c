#include "../Library/MainInclude.h"
#include "OKInclude.h"
#include <stdio.h>

//OverKart6

extern unsigned short net[];

int DPRTester;
int RandomDPR;
short MapModeCheck = 0;
uint ROptionPressed = 0;


void loadLogo()
{

	
	
	//804CCB9C
	SetSegment(0x8,(int)(&ok_Logo));
	
	*sourceAddress = (int)(&LogoROM);
	*targetAddress = (int)(&ok_FreeSpace);
	dataLength = 0x4000;
	runDMA();
	*sourceAddress = (int)(&ok_FreeSpace);
	*targetAddress = (int)(&ok_Logo);
	runMIO();

	g_NintendoLogoOffset = 0x080052A0;
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
	
	
	
	
				
	
	//8047CBA0
	loadLogo();
	loadArrows();
	loadHeaderOffsets();
	loadHudButtons();
	SetupFontF3D();
	
	loadEEPROM((uint)&SaveGame);
	CheckContPackMenu();
	
	#if OverKartBuild
		CheatSetup();
	#endif
	
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
	
	SetFontColor(255,255,255,75,75,75);

	g_sfxPause = 0; //Just for Amped Up (To fix some mute sfx when pausing the game)
	HotSwapGP = 0;
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
	SaveGame.TENNES = true;

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
	
	

	#if OverKartBuild
	{
		LoadCheatData();
	}				
	#endif

	setZoomLevel(1); // (All races start zoomed out)
	g_loadedcourseFlag = 0xF0;
	InitialCustomParticleBuffer();
    SetLapIndex();
	
	
	if ((SaveGame.GameSettings.StatsMode == 1) || (g_gameMode == GAMEMODE_TT))
	{
		checkStats(1);
	}
	else
	{
		checkStats(0);
	}

	if ((g_gameMode == GAMEMODE_GP) || ((g_gameMode == GAMEMODE_VS) && (SaveGame.GameSettings.AIMode > 0)) )
	{
		SetAIDifficulty(g_raceClass);
	}

	
	if (HotSwapID > 0)
	{
		if ((g_gameMode != GAMEMODE_TT) && (g_gameMode != GAMEMODE_BATTLE))
		{
			PlaceSIBox(GetRealAddress(0x06000668));
		}
		if (g_gameMode != GAMEMODE_BATTLE)
		{
			EmptyActionData();
		}
		
		setSky();
		setWater();
		loadMinimap();	
		
		if (g_gameMode != GAMEMODE_BATTLE)
		{	
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
	else
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
				
				//if (GlobalController[PlayerID]->ButtonPressed & BTN_Z)				
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


short HighCamAngle, HighCamDistance = 35;
void QuickCamCode(Camera* LocalCamera, Player* LocalPlayer)
{
	return;
	LocalPlayer->status = LocalPlayer->status|(0x000A);
	objectPosition[0] = 0;
	objectPosition[1] = 0;
	objectPosition[2] = HighCamDistance;

	MakeAlignVector(objectPosition, HighCamAngle);

	if (GlobalController[0]->ButtonHeld & BTN_DLEFT)
	{
		HighCamAngle+=DEG1;
	}
	if (GlobalController[0]->ButtonHeld & BTN_DRIGHT)
	{
		HighCamAngle-=DEG1;
	}
	if (GlobalController[0]->ButtonHeld & BTN_DUP)
	{
		HighCamDistance--;
	}
	if (GlobalController[0]->ButtonHeld & BTN_DDOWN)
	{
		HighCamDistance++;
	}

	for (int ThisVector = 0; ThisVector < 3; ThisVector++)
	{
		LocalCamera->camera_pos[ThisVector] = LocalPlayer->position[ThisVector] + objectPosition[ThisVector];	
		LocalCamera->lookat_pos[ThisVector] = LocalPlayer->position[ThisVector];			            
	}
	LocalCamera->camera_pos[1] += 20;
}


void SetBattle()
{
	if (g_gameMode == GAMEMODE_BATTLE)
	{
		TeamMode = SaveGame.BattleSettings.TeamBattle;
		
		switch (SaveGame.BattleSettings.GameMode)
		{
			case BTL_BATTLE:
			{
				SlayerInit();
				SetBalloonTeams();
				break;
			}
			case BTL_CTF:
			{
				PlaceFlags((uint)&BattleFlag_Red_GFX, FlagModels, (uint)&BattleMushroom_Red_GFX, MushroomModels, 1);
				SetBalloonTeams();
				break;
			}
			case BTL_SOCCER:
			{
				//PlaceBalls(SoccerBall, RedMushroom, MushroomModels, 1);  //lol
			}
		}
	}
}
void gameCode(void)
{	
	#if OverKartBuild
	{
		ApplyCheats();
	}
	#endif


	#if(DEBUGBUILD)
	{
		if (GlobalController[0]->ButtonHeld & BTN_DLEFT)
		{
			*GlobalLap[0] = 2;
		}
	}
	#endif
    
    loadFont();
    printStringNumber(10,40,"",GlobalScreen[0]->camera_point);
    printStringNumber(10,50,"",CurrentPathID[0]);
    printStringNumber(10,60,"",*GlobalPath[0]);
    uint* PathOffsets = (uint*)&pathOffset; 
    Marker* PathData = (Marker*)(GetRealAddress(PathOffsets[CurrentPathID[0]]));
    printStringNumber(50,60,"", PathData[*GlobalPath[0]].Group);

    printStringNumber(10,70,"",OverKartHeader.PathTrigger[0]);
    printStringNumber(30,70,"",OverKartHeader.PathTrigger[1]);
    printStringNumber(50,70,"",OverKartHeader.PathTrigger[2]);
    printStringNumber(70,70,"",OverKartHeader.PathTrigger[3]);

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
				DisplayGameScore();
				break;
			}
			case BTL_SOCCER:
			{
				CaptureBalls();
				DisplayGameScore();
				break;
			}
		}
		CheckBattleCDown();
	}

	if (MapModeCheck || (SaveGame.GameSettings.GameMode == 3))
	{
		practiceHack();		
	}
	
	if (g_gameMode != GAMEMODE_BATTLE)
	{
		if (SaveGame.GameSettings.FlycamMode == 1)
		{
			RunFlyCam();
		}
	}

	
	if (g_gameMode == GAMEMODE_BATTLE)
	{
		if (SaveGame.BattleSettings.Flycam == 1)
		{
			RunFlyCam();
		}
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
			SetBattle();
			raceStatus = 1;
			startRace();
			hsLabel = -1;
			MenuChanged = -1;
		}

		
		GlobalShortD = 0;
		
	}
	if (g_startingIndicator == 2)
	{
		if (raceStatus != 2)
		{
			raceStatus = 2;			
		}
		
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

}
void resetMap()
{
	gpTotalTime = 0;
	gpCourseIndex = 0;
}


ushort PiracyCountdown = 0;



void allRun()
{


	
	//Emulator Only ForceHack
	//SaveGame.RenderSettings.Platform = 1;
	//SaveGame.RenderSettings.CullMode = 1;
	//Emulator ForceHack

	
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

	BattleGametype = SaveGame.BattleSettings.GameMode;


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
	
	
	//gMatrixCount = 0;
	
	
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

	}
	else
	{
		#if(DEBUGBUILD)
		{
			asm_CupCount = 0;
		}
		#else
		{
			asm_CupCount = 3;
		}
		#endif
		
	}


	//still doesn't work
	//lol whatever honestly
	
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
		#if OverKartBuild
			case 99:
			{
				if (MenuChanged != 99)
				{
					LastMenuID = MenuChanged;
					MenuChanged = 99;
				}

				
				CheatMenuHandler();

				
				break;
			}

			case 98:
			{
				if (MenuChanged != 98)
				{
					*sourceAddress = (int)(&Pirate);
					*targetAddress = (int)(&ok_FreeSpace);
					dataLength = (int)&PirateEnd - (int)&Pirate;
					runDMA();
					*sourceAddress = (int)(&ok_FreeSpace);
					*targetAddress = (int)(&ok_Storage);
					runMIO();
					PiracyCountdown = 60;

					MenuChanged = 98;
				}

				

				if (PiracyCountdown <= 0)
				{
					
					if (GlobalController[4]->ButtonPressed)
					{	
						SpriteBtnStart(200,120,0.5f,true);
						KBGNumber = 10;
						KBGNumberNext = 10;
						KBGChange = 1;
						SetFadeOutTaData();
					}
					else
					{
						SpriteBtnStart(200,120,0.5f,false);
					}
				}
				else
				{
					PiracyCountdown--;
				}
				break;

			}
		#endif
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
			#if OverKartBuild
			if (SaveGame.TENNES == true)
			{
				SaveGame.TENNES = false;
				KBGNumber = 98;
				KBGNumberNext = 98;
				KBGChange = 1;
				SetFadeOutTaData();
				break;
			}
			#endif
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

				*sourceAddress = (int)(&Splash3D);
				*targetAddress = (int)(&ok_FreeSpace);
				dataLength = (int)&Splash3DEnd - (int)&Splash3D;
				runDMA();
				*sourceAddress = (int)(&ok_FreeSpace);
				*targetAddress = (int)(&ok_Storage);
				Splash3DRAM = *targetAddress;
				GlobalAddressA = runMIO();
				
				SetSegment(0x8, Splash3DRAM);

				*sourceAddress = (int)(&MenuIconsROM);
				*targetAddress = (int)(&ok_FreeSpace);
				dataLength = (int)&MenuIconsEnd - (int)&MenuIconsROM;
				runDMA();
				*sourceAddress = (int)(&ok_FreeSpace);
				*targetAddress = GlobalAddressA;
				MenuIconsRAM = GlobalAddressA;
				GlobalAddressA = runMIO();
				
				#endif

				
				startupSwitch = 2;



				if ((SaveGame.SaveVersion != 8) && (SaveGame.SaveVersion != 99))
				{
					SaveGame.SaveVersion = 8;	
					SaveGame.Initial = 0;
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

					#if ProtectMode
						//SaveGame.TENNES = DPR();
						//DPRSave();
					#endif
					
				}

				scrollLock = false;
				g_startingIndicator = 0;
				break;
			}
			break;
		}
		
		case 11:
		{
			if (MenuChanged != 11)
			{
				NaSeqStart(2);
				menuScreenB = 3; //resets mode selection to start screen.
				LastMenuID = MenuChanged;
				MenuChanged = 11;
				SaveGame.Initial = 1;
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

				scrollLock = false;
				g_startingIndicator = 0;
				//HotSwapID = 0;
				saveEEPROM((uint)&SaveGame);
			}
			
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
					
				scrollLock = false;
				HotSwapID = 0;
				copyCourseTable(0);   
			}
			break;
		}			
		case 13:
		{
			
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

				scrollLock = false;
				g_startingIndicator = 0;
				
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
	ClockCycle[1] = osGetCount();
	CycleCount[1] = (ClockCycle[1] - OldCycle[1]);     
	OldCycle[1] = ClockCycle[1];

    
    

	if(SaveGame.RenderSettings.DisplayFPS == 1)
	{
		DrawFPS(220,10);	
	}
	
	switch (MenuChanged)
	{
		#if OverKartBuild
		case 99:
		{
			//Draw Cheats Menu
			DrawCheatMenu();
			break;
		}
		case 98:
		{
			KWSpriteDiv(256,120,(ushort*)&ok_Storage,512,240,4);
			break;
		}
		#endif
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
			
			break;
		}
		case 10:
		{
			//title screen
			
			
			
			DrawBox(102,150,120,38, 0, 0, 0, 200);
			
			if (SaveGame.RenderSettings.CullMode == 0)
			{
				PrintBigText(128, 151, 0.6f, "LLE MODE" );
			}
			else
			{
				PrintBigText(128, 151, 0.6f, "HLE MODE" );
			}
			if (SaveGame.RenderSettings.Platform == 0)
			{
				PrintBigText(115, 169, 0.6f, "N64 CONSOLE" );
			}
			else
			{
				PrintBigText(128, 169, 0.6f, "EMULATOR" );
			}
				
			
			if (TitleSwitch == 0)
			{
				GlobalIntA = 160;
			}
			else
			{
				GlobalIntA = 178;
			}
			KWSprite(235,GlobalIntA,16,16,(ushort*)&lit_arrowsprite_r);
			KWSprite(95,GlobalIntA,16,16,(ushort*)&lit_arrowsprite_l);

				
			
		
			#if OverKartBuild
     		KWTexture2DRGBA32PT(160,70,0,0.95f,(uchar*)MenuIconsRAM,(void*)(&V256x12832B), 256, 128, 256, 4);
            #endif
			
			
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


void ClearFramebufferCheck()
{
    if (g_ClearCFBFlag)
    {
        g_ClearFramebuffer();
    }
}