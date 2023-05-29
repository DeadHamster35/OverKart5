#include "../Library/MainInclude.h"
#include "OKInclude.h"

//OverKart6

extern unsigned short net[];

int DPRTester;
int RandomDPR;
short MapModeCheck = 0;
short LastMenuID = 0;
uint ROptionPressed = 0;


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
	GameOKMenu.PanelAddress[0].NameLength = menuChar[0];
	GameOKMenu.PanelAddress[1].NameLength = menuChar[1];
	
	GameOKMenu.PanelAddress[1].OptionCount = pageLimit[1];
	
	GameOKMenu.PanelAddress[1].ParameterToggles = (char*)&renderMode[0];
	GameOKMenu.PanelAddress[0].Options = (OKOption*)&OKGameOptions;
	GameOKMenu.PanelAddress[1].Options = (OKOption*)&OKRenderOptions;

	
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
}
void okSetup(void)
{
	
	
	
	ConsolePlatform = CheckPlatform();
	EmulatorPlatform = CheckEmulator();	
	
	
	
	//8047CBA0
	loadLogo();
	loadArrows();
	loadHeaderOffsets();
	loadHudButtons();
	SetupFontF3D();
	
	loadEEPROM((uint)&SaveGame);
	CheckContPackMenu();
	

	
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
	
	

	
	loadBigFont();
	copyCourseTable(1);
	NopSplashCheckCode();
	//FlyCamInit();
	HotSwapID = 0;
	raceStatus = 0xFF;
	asm_SongA = 0x240E0001;
	asm_SongB = 0x240E0001;

	g_sfxPause = 0; //Just for Amped Up (To fix some mute sfx when pausing the game)
	hsGP = 0;
	MapModeCheck = 0;
	//FlyCamSpeed = 5;
	//ok_Knowledge = (long)(&ok_Target);

	
	
	//PlayerSelectSetup();

	
	*(long*)(&ok_USAudio) = *(long*)(&g_RawAudio + 1);
	*(long*)(&ok_USAudio + 1) = *(long*)(&g_InstrumentTable + 1);


	*(long*)(&ok_MRSong) = *(long*)(&g_SequenceTable + (3 * 2) + 1);
	*(long*)(&ok_MRSong + 1) = *(long*)(&g_InstrumentTable + (3 * 2) + 1);
	
	
	
	FreeSpaceAddress = (int)&ok_Storage;
	SaveGame.TENNES = false;

	GameOKMenu.PanelCount = 2;
	
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

	if (HotSwapID > 0)
	{
		if (g_gameMode != GAMEMODE_GP)
		{
			gpCourseIndex = 0;
		}
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
		}
	}
	

}

void endRace()
{
	if (g_gameMode == GAMEMODE_GP)
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
		loadFont();
		//OverKartHeader.ScrollROM
		printStringUnsignedHex(0,0,"OBJTYPE", (uint)&OverKartRAMHeader.ObjectTypeList);
		printStringUnsignedHex(0,10,"OBJ", (uint)&OverKartRAMHeader.ObjectList);
		printStringUnsignedHex(0,20,"OKRAM", (uint)&OverKartRAMHeader);
		printStringNumber(0,30,"TCNT", OverKartRAMHeader.ObjectTypeCount);
		printStringNumber(0,40,"OCNT", OverKartRAMHeader.ObjectCount);


		if (GlobalController[0]->ButtonPressed & BTN_DUP)
		{
			RouletteStart(0,7);
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
		DynamicTempo();
		
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


		if (g_startingIndicator == 0x01)
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
			if (g_gameMode == GAMEMODE_GP)
			{
				printGPTime(gpTotalTime,30);
			}
		}

		if (g_startingIndicator == 0x07)
		{
			raceStatus = 0x07;
			endRace();
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
		
		if ((GlobalController[0]->ButtonPressed & BTN_L) == BTN_L)
		{
			MapModeCheck = 1;
		}
		break;
		
		case 2:
		modCheck();
		break;
	}
	
	
	gMatrixCount = 0;
	
	

	gBackgroundFlag = 1;

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
			
			if (g_courseID == 0x14)
			{
				g_player1ScreenWidth = 0x0240;
			}

			
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

				if ((SaveGame.SaveVersion != 3) && (SaveGame.SaveVersion != 99))
				{
					SaveGame.SaveVersion = 3;	
					for (int This = 0; This < 8; This++)
					{
						renderMode[This] = 0;
						gameMode[This] = 0;
						battleMode[This] = 0;
					}
					for (int This = 8; This < 16; This++)
					{
						renderMode[This]  = 0;
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
				stockASM();
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
	
	ClockCycle[1] = osGetCount();
	CycleCount[1] = (ClockCycle[1] - OldCycle[1]);     
	OldCycle[1] = ClockCycle[1];

	#if(DEBUGBUILD==TRUE)
	{
		loadFont();
		printStringUnsignedHex(0,0,"SFC", (uint)&OverKartHeader.SurfaceMapPosition);
		printStringUnsignedHex(0,10,"SVW", (uint)&OverKartHeader.SectionViewPosition);
		printStringUnsignedHex(0,20,"SXLU", (uint)&OverKartHeader.XLUSectionViewPosition);
		
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
			
			if (MenuIndex < 2)
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