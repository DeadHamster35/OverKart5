#include "../Library/MainInclude.h"
#include "OKInclude.h"


//practiceHack Variables//
/*
char GlobalCharA;  //DpadInput
short GlobalCharD;  //Cpad Input
char GlobalCharB;   L/R Button
char MenuOverflow;   A/B Buttons
*/




char SplitTimerToggle, SplitTimerToggleSave = 0x00;
float SaveTimer, SplitTimer = 0;

short SplitStartMarker,SplitEndMarker = 0;
/*
static char itemSwap = 0x00;
static char resetToggle = 0x00;



*/

void splitFunc()
{
	if (SplitTimerToggle == 0x01)
	{
		if (g_progressValue < SplitStartMarker)
		{
			g_gameTimer = 0;
		}
		if (g_progressValue >= SplitStartMarker)
		{
			SplitTimerToggle = 0x02;
		}
	}
	if (SplitTimerToggle == 0x02)
	{
		if (g_progressValue >= SplitEndMarker)
		{
			SplitTimer = g_gameTimer;
			SplitTimerToggle = 0x03;
		}
	}
	if (SplitTimerToggle == 0x03)
	{
		g_gameTimer = SplitTimer;
	}

}




void modCheck()
{
	if (SaveGame.RenderSettings.AudioMode != AudioLanguage)
	{
		AudioLanguage = SaveGame.RenderSettings.AudioMode;
		if (AudioLanguage == 0)
		{
			*(long*)(&g_RawAudio + 1) = *(long*)&ok_USAudio;
			*(long*)(&g_RawAudio + 2) = 0x24C3F0;
			*(long*)(&g_InstrumentTable + 1) = *(long*)(&ok_USAudio + 1);
			*(long*)(&g_InstrumentTable + 2) = 0x44D0;

		}
		else
		{
			
			*(long*)(&g_RawAudio + 1) = (long)&JP_Audio;
			*(long*)(&g_RawAudio + 2) = 0x24C580;
			*(long*)(&g_InstrumentTable + 1) = (long)&JP_Bank;
			*(long*)(&g_InstrumentTable + 2) = 0x4540;
		}		
		InitMKCode();
	}
	if (SaveGame.GameSettings.MirrorMode > 0x00)
	{
		g_ScreenFlip = 0x0001;
	}

	ScaleXMode = SaveGame.LevelSettings.ScaleXMode;
	ScaleYMode = SaveGame.LevelSettings.ScaleYMode;
	ScaleZMode = SaveGame.LevelSettings.ScaleZMode;

	if ((SaveGame.GameSettings.AIMode > 0x00) && (g_gameMode != GAMEMODE_TT))
	{
		aiSetup();
	}
	//gameMode[1] handled in Menu

	if (SaveGame.RenderSettings.ScreenMode > 0x00)
	{
		if ((g_ScreenSplitA != 0) && (SaveGame.RenderSettings.SplitMode == 0x00))
		{
			g_aspectRatio = 3.5;
		}
		else
		{
			g_aspectRatio = 1.77778;
		}
	}
	else
	{
		if ((g_ScreenSplitA != 0) && (g_playerCount == 2))
		{
			g_aspectRatio = 2.6666667;
		}
		else
		{
			g_aspectRatio = 1.333334;
		}
	}
	
	if (SaveGame.RenderSettings.AliasMode > 0x00)
	{
		antialiasToggle = 0x00013016;
		antialiasToggleB = 0x00013016;
	}
	else
	{
		antialiasToggle = 0x00003216;
		antialiasToggleB = 0x00003216;
	}
	//SaveGame.RenderSettings.SplitMode 3D racers;
	if (SaveGame.RenderSettings.SplitMode > 0x00)
	{
		if (g_playerCount == 0x02)
		{
			g_ScreenSplitA = 2;
			g_ScreenSplitB = 2;
		}
	}

	if (SaveGame.GameSettings.ItemMode == IM_NONE)
	{
		g_ItemSetFlag = 0;
	}
	else
	{
		g_ItemSetFlag = 1;
	}





}

void saveState()
{
	//simpleObjects
	dataLength = 0x2BC0;
	*targetAddress = (long)(&ok_SaveState);
	*sourceAddress = (long)(&g_SimpleObjectArray);
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//dynamicObjects
	*targetAddress += dataLength;
	dataLength = 0x1E140;
	*sourceAddress = (long)(&g_DynamicObjects);
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//playerData
	*targetAddress += dataLength;
	dataLength = 0x6EC0;
	*sourceAddress = (long)(&g_PlayerStructTable);
	ramCopy(*targetAddress, *sourceAddress, dataLength);


	//courseOBJ
	*targetAddress += dataLength;
	dataLength = 0x840;
	*sourceAddress = (long)(&g_CourseObstacle);
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//camera data
	*targetAddress += dataLength;
	dataLength = 0x2E0;
	*sourceAddress = (long)(&g_CameraTable);
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//lap timers
	*targetAddress += dataLength;
	dataLength = 0x210;
	*sourceAddress = (long)(&g_hudStruct);
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//Player Timers
	*targetAddress += dataLength;
	dataLength = 0x20;
	*sourceAddress = (long)(&g_GameLapTable);
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//Trials Time
	*targetAddress += dataLength;
	dataLength = 0x70;
	*sourceAddress = (long)(&g_TrialTime);
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	SaveTimer = g_gameTimer;
	SplitTimerToggleSave = SplitTimerToggle;
}

void loadState()
{
	//simpleObjects
	dataLength = 0x2BC0;
	*sourceAddress = (long)(&ok_SaveState);
	*targetAddress = (long)(&g_SimpleObjectArray);
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//dynamicObjects
	*sourceAddress += dataLength;
	dataLength = 0x1E140;
	*targetAddress = (long)(&g_DynamicObjects);
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//playerData
	*sourceAddress += dataLength;
	dataLength = 0x6EC0;
	*targetAddress = (long)(&g_PlayerStructTable);
	ramCopy(*targetAddress, *sourceAddress, dataLength);


	//courseOBJ
	*sourceAddress += dataLength;
	dataLength = 0x840;
	*targetAddress = (long)(&g_CourseObstacle);
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//camera data
	*sourceAddress += dataLength;
	dataLength = 0x2E0;
	*targetAddress = (long)(&g_CameraTable);
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//lap timers
	*sourceAddress += dataLength;
	dataLength = 0x210;
	*targetAddress = (long)(&g_hudStruct);
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//Player Timers
	*sourceAddress += dataLength;
	dataLength = 0x20;
	*targetAddress = (long)(&g_GameLapTable);
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//Trials Time
	*sourceAddress += dataLength;
	dataLength = 0x70;
	*targetAddress = (long)(&g_TrialTime);
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	g_gameTimer = SaveTimer;
	SplitTimerToggle = SplitTimerToggleSave;
}



void drawInputDisplay()
{
	
	GlobalUShortA = 0x8000;
	/*
	if ( ((GlobalController[0]->ButtonHeld & BTN_L) == BTN_L) && ((GlobalController[0]->ButtonHeld & BTN_R) == BTN_R) )
	{
		if((GlobalController[0]->ButtonHeld & BTN_DUP) == BTN_DUP)
		{
			ControllerInputY--;
		}
		if((GlobalController[0]->ButtonHeld & BTN_DDOWN) == BTN_DDOWN)
		{
			ControllerInputY++;
		}
		if((GlobalController[0]->ButtonHeld & BTN_DLEFT) == BTN_DLEFT)
		{
			ControllerInputX--;
		}
		if((GlobalController[0]->ButtonHeld & BTN_DRIGHT) == BTN_DRIGHT)
		{
			ControllerInputX++;
		}
	}
	*/

	GraphPtr = FillRect1ColorF(GraphPtr,
	ControllerInputX, ControllerInputY, ControllerInputX + 43, ControllerInputY + 16, //x1, y1, x2, y2
	0, 0, 0, 128); //r, g, b, a


	for(int i=0; i<16; i++)
	{
		if(names[i][0])
		{
			InputColor[0] = colors[i][0];
			InputColor[1] = colors[i][1];
			InputColor[2] = colors[i][2];

			if (p1Button & GlobalUShortA)
			{
				InputColor[3] = 255;
			}
			else
			{
				InputColor[3] = 64;
			}
			AnalogInput[0] = ControllerInputX + (coords[i][0] * 6);
			AnalogInput[1] = ControllerInputY + (coords[i][1] * 5);

			GraphPtr = FillRect1ColorF(GraphPtr,
				AnalogInput[0] + 1 , AnalogInput[1] + 1, AnalogInput[0]+6, AnalogInput[1]+5, //x1, y1, x2, y2
				InputColor[0], InputColor[1], InputColor[2], InputColor[3]); //r, g, b, a

		}
			GlobalUShortA >>= 1;
	}
	for(int i=0; i<4; i++)
	{
		if(stickNames[i][0])
		{
			InputColor[0] = stickColor[i][0];
			InputColor[1] = stickColor[i][1];
			InputColor[2] = stickColor[i][2];

			if (p1Button & GlobalUShortA)
			{
				InputColor[3] = 255;
			}
			else
			{
				InputColor[3] = 32;
			}
			AnalogInput[0] = ControllerInputX + (stickCoord[i][0] * 6);
			AnalogInput[1] = ControllerInputY + (stickCoord[i][1] * 5);

			GraphPtr = FillRect1ColorF(GraphPtr,
				AnalogInput[0] + 1 , AnalogInput[1] + 1, AnalogInput[0]+6, AnalogInput[1]+5, //x1, y1, x2, y2
				InputColor[0], InputColor[1], InputColor[2], InputColor[3]); //r, g, b, a

		}
		GlobalUShortA >>= 1;
	}


	InputColor[0] = stickColor[4][0];
	InputColor[1] = stickColor[4][1];
	InputColor[2] = stickColor[4][2];
	InputColor[3] = 255;
	
	AnalogInput[0] = ControllerInputX + ((stickCoord[4][0] * 6) + (player1inputX / 127.0f * 6));
	AnalogInput[1] = ControllerInputY + ((stickCoord[4][1] * 5) + (player1inputY / -127.0f * 5));

	GraphPtr = FillRect1ColorF(GraphPtr,
		AnalogInput[0] + 1 , AnalogInput[1] + 1, AnalogInput[0]+6, AnalogInput[1]+5, //x1, y1, x2, y2
		InputColor[0], InputColor[1], InputColor[2], InputColor[3]); //r, g, b, a

}



void rotateCamera(float inputAngle)
{
	
	FlyCamDirection -= (inputAngle / 360.0) * 65535.0;
	FlyCamRadian = (((float)FlyCamDirection / 65535) * 360) * 0.0174533;

	/*
	FlyCamLook[0][0] = GlobalCamera[0]->lookat_pos[0] - GlobalCamera[0]->camera_pos[0];
	FlyCamLook[1][0] = GlobalCamera[0]->lookat_pos[2] - GlobalCamera[0]->camera_pos[2];

	FlyCamLook[0][1] = FlyCamLook[0][0] * cosF(FlyCamRadian) - FlyCamLook[1][0] * sinF(FlyCamRadian);
	FlyCamLook[1][1] = FlyCamLook[0][0] * sinF(FlyCamRadian) + FlyCamLook[1][0] * cosF(FlyCamRadian);

	GlobalCamera[0]->lookat_pos[0] = GlobalCamera[0]->camera_pos[0] + FlyCamLook[0][1];
	GlobalCamera[0]->lookat_pos[2] = GlobalCamera[0]->camera_pos[2] + FlyCamLook[1][1] + 0.01;
	*/
	GlobalCamera[0]->lookat_pos[0] = (float)(GlobalCamera[0]->camera_pos[0] + 80 * sinF(FlyCamRadian));
	GlobalCamera[0]->lookat_pos[2] = (float)(GlobalCamera[0]->camera_pos[2] + 80 * cosF(FlyCamRadian));

	
}


void moveCamera(int inputDistance)
{
	FlyCamRadian = (((float)FlyCamDirection / 65535) * 360) * 0.0174533;

	GlobalCamera[0]->camera_pos[0] = (float)(GlobalCamera[0]->camera_pos[0] + inputDistance * sinF(FlyCamRadian));
	GlobalCamera[0]->camera_pos[2] = (float)(GlobalCamera[0]->camera_pos[2] + inputDistance * cosF(FlyCamRadian));

	GlobalCamera[0]->lookat_pos[0] = (float)(GlobalCamera[0]->lookat_pos[0] + inputDistance * sinF(FlyCamRadian));
	GlobalCamera[0]->lookat_pos[2] = (float)(GlobalCamera[0]->lookat_pos[2] + inputDistance * cosF(FlyCamRadian));
}

void moveCameraTilt(int inputDistance, int tilt)
{
	FlyCamRadian = (((float)FlyCamDirection / 65535) * 360) * 0.0174533 + tilt;
	if (tilt > 0)
	{
		if (FlyCamRadian > 360)
		FlyCamRadian -= 360;
	}
	else
	{
		if (FlyCamRadian < 0)
		FlyCamRadian += 360;
	}


	FlyCamRadian = (int)FlyCamRadian * -0.0174533;
	GlobalCamera[0]->camera_pos[0] = (float)(GlobalCamera[0]->camera_pos[0] + inputDistance * sinF(FlyCamRadian));
	GlobalCamera[0]->camera_pos[2] = (float)(GlobalCamera[0]->camera_pos[2] + inputDistance * cosF(FlyCamRadian));

	GlobalCamera[0]->lookat_pos[0] = (float)(GlobalCamera[0]->lookat_pos[0] + inputDistance * sinF(FlyCamRadian));
	GlobalCamera[0]->lookat_pos[2] = (float)(GlobalCamera[0]->lookat_pos[2] + inputDistance * cosF(FlyCamRadian));
}

//SaveGame.ModSettings.PracticeMode is > 0 then
void practiceHack()
{
	
	GlobalCharA = (d_Input & 0x0F);	 //Dpad
	GlobalCharB = (p_Input & 0xF0) >> 4;  //LR Trigger
	GlobalCharC = (d_Input & 0xF0) >> 4;  //AB Button
	GlobalCharD = (p_Input & 0x0F);  //Cpad
	if (SaveGame.GameSettings.GameMode == 3)
	{
		
		if (SplitTimerToggle > 0x00)
		{
			splitFunc();

		}
		if (GlobalCharD == 0x02)
		{
			g_player1LocationY = g_player1LocationY + 3;
			g_player1SpeedY = 0;
			GraphPtr = FillRect1ColorF(GraphPtr, 23, 43, 120, 53, 0, 0,0, 175);
			loadFont();
			printString(5,25, "FLYING");
		}
		switch(GlobalController[0]->ButtonPressed)
		{
			case(BTN_DLEFT):
			{
				SaveStateCourseID = ((HotSwapID * 0x10) + g_courseID + 1);
				saveState();
				break;
			}
			case(BTN_DRIGHT):
			{
				if (SaveStateCourseID == ((HotSwapID * 0x10) + g_courseID + 1))
				{
					loadState();
				}
				break;
			}
			case(BTN_DUP):
			{
				*(int*)(0x8007AC54) = 0;
				g_gameLapPlayer1 = 0x00;
				GlobalHud[0]->goalsw = 0x00;
				GlobalHud[0]->lapcnt = 0x00;				
				GlobalHud[0]->item = 0;
				GlobalHud[0]->sp_item = 0;
				g_gameTimer = 90;
				GlobalPlayer[0].item = 0;				
				RouletteStart(0,14);
				*(int*)(0x8007AC54) = 0x10400009;
				break;
			}
			case(BTN_DDOWN):
			{
				short* PositionArray = (short*)GetRealAddress(PathTable[g_courseID][0]);
				GlobalPlayer[0].position[0] = (float)PositionArray[0];
				GlobalPlayer[0].position[1] = (float)PositionArray[1];
				GlobalPlayer[0].position[2] = (float)PositionArray[2];
				GlobalPlayer[0].direction[1] = 0x8000;
				break;
			}
	
		}
	}
	/*
	if (SaveGame.ModSettings.FlycamMode == 1)
	{

		if ((GlobalController[0]->ButtonPressed & BTN_CLEFT) == BTN_CLEFT)
		{
			FlyCamDirection = GlobalCamera[0]->camera_direction[1];
			FlyCamSectionCheck = g_player1Section;
			FlyCamViewCheck = g_player1View;
			dataLength = 0x20;
			if (FlyCamToggle == 0)
			{
				FlyCamToggle = 1;
				
				
				*(uint*)(0x802A5C98) = 0;
				*(uint*)(0x8001EE98) = 0x03E00008;
				*(uint*)(0x80291154) = 0x3C040000 | ((uint)(&FlyCamSection) >> 16);
				*(uint*)(0x80291164) = 0x84840000 | ((uint)(&FlyCamSection) & 0xFFFF);
				GlobalFloatC = GlobalPlayer[0].offsetsize;
				GlobalPlayer[0].offsetsize = 0.001;

				*(uint*)(0x800382DC) = 0x03E00008;
				*(uint*)(0x800382E0) = 0;
				
				*sourceAddress = (int)0x8018CAB0;
				*targetAddress = (int)&ok_FreeCamBackup;
				runRAM();
				*sourceAddress = (int)&ok_FreeCam;
				FlyCamBackupPosition[0] = GlobalPlayer[0].position[0];
				FlyCamBackupPosition[1] = GlobalPlayer[0].position[1];
				FlyCamBackupPosition[2] = GlobalPlayer[0].position[2];
				
			}
			else
			{
				FlyCamToggle = 0;

				//
				*(uint*)(0x802A5C98) = 0x0C01636D;
				*(uint*)(0x8001EE98) = 0x27BDFFC8;
				*(uint*)(0x80291154) = 0x01E72021;
				*(uint*)(0x80291164) = 0x2484FFFC;

				*(uint*)(0x800382DC) = 0x3C02800E;
				*(uint*)(0x800382E0) = 0x8C42C52C;
				GlobalPlayer[0].offsetsize = GlobalFloatC;
				*sourceAddress = (int)&ok_FreeCamBackup;
			}
			*targetAddress = (int)0x8018CAB0;
			runRAM();
			
		}

		if (FlyCamToggle > 0)
		{
			if ((GlobalController[0]->ButtonHeld & BTN_L) == BTN_L)
			{
				loadFont();
				printStringNumber(5,25, "SECTION-", FlyCamSectionCheck);
				printStringNumber(5,35, "VIEW-", FlyCamViewCheck);
				printStringNumber(5,45, "SPEED-", FlyCamSpeed);
				printFloat(0,75,(float)(FlyCamSpeed * (float)((float)GlobalController[0]->AnalogY / 100)));
				
				switch(GlobalController[0]->ButtonPressed)
				{
					
					case BTN_DDOWN:
					{
						if (FlyCamSpeed > 5)
						{
							FlyCamSpeed = FlyCamSpeed - 5;
						}
						else
						{
							if (FlyCamSpeed > 1)
							{
								FlyCamSpeed = FlyCamSpeed - 1;
							}
						}
						break;
					}

					case BTN_DUP:
					{
						if (FlyCamSpeed < 5)
						{
							FlyCamSpeed = FlyCamSpeed + 1;
						}
						else
						{							
							FlyCamSpeed = FlyCamSpeed + 5;							
						}
						break;
					}
				}

			}	
			else
			{	
				GlobalPlayer[0].position[0] = FlyCamBackupPosition[0];
				GlobalPlayer[0].position[1] = FlyCamBackupPosition[1];
				GlobalPlayer[0].position[2] = FlyCamBackupPosition[2];
				switch(GlobalController[0]->ButtonPressed)
				{
					case BTN_DLEFT:
					{
						if (FlyCamSectionCheck > 1)
						{
							FlyCamSectionCheck--;
						}
						break;
					}
					case BTN_DRIGHT:
					{
						FlyCamSectionCheck++;
						break;
					}
				
				}
				switch(GlobalController[0]->ButtonHeld)
				{
					case BTN_DUP:
					{
						GlobalCamera[0]->lookat_pos[1] += (FlyCamSpeed);
						break;
					}
					case BTN_DDOWN:
					{
						GlobalCamera[0]->lookat_pos[1] -= (FlyCamSpeed);
						break;
					}
				}
				if ((GlobalController[0]->AnalogHeld & BTN_DRIGHT) == BTN_DRIGHT)
				{
					rotateCamera((float)(FlyCamSpeed * 0.5 * (float)((float)GlobalController[0]->AnalogX / 100)));
				}
				else if ((GlobalController[0]->AnalogHeld & BTN_DLEFT) == BTN_DLEFT)
				{
					rotateCamera((float)(FlyCamSpeed * 0.5 * (float)((float)GlobalController[0]->AnalogX / 100)));
				}
				
				if (FlyCamPilot == 1)
				{
					moveCamera(FlyCamSpeed);
				}
				else
				{
					if ((GlobalController[0]->ButtonHeld & BTN_A) == BTN_A)
					{
						moveCamera(2 * FlyCamSpeed);
					}
					if ((GlobalController[0]->ButtonHeld & BTN_B) == BTN_B)
					{
						moveCamera(-2 * FlyCamSpeed);
					}
				}				
				if (((GlobalController[0]->AnalogHeld & BTN_DDOWN) == BTN_DDOWN) || ((GlobalController[0]->AnalogHeld & BTN_DUP) == BTN_DUP))
				{					
					GlobalCamera[0]->lookat_pos[1] += (float)(FlyCamSpeed * 1 * (float)((float)GlobalController[0]->AnalogY / 100));
					GlobalCamera[0]->camera_pos[1] += (float)(FlyCamSpeed * 1 * (float)((float)GlobalController[0]->AnalogY / 100));
				}

			}
		}

		if(g_ScreenFlip == 1)
		{
			GlobalUShortA=(ushort)FlyCamDirection;
			if(GlobalUShortA< DEG1 * 45)     FlyCamViewCheck=2;          
			else if(GlobalUShortA<DEG1 * 135)     FlyCamViewCheck=3;          
			else if(GlobalUShortA<DEG1 * 225)     FlyCamViewCheck=0;          
			else if(GlobalUShortA<DEG1 * 315)     FlyCamViewCheck=1;          
			else      FlyCamViewCheck=2;          
		}
		else
		{
			GlobalUShortA=(ushort)FlyCamDirection;
			if(GlobalUShortA<DEG1 * 45)     FlyCamViewCheck=2;          
			else if(GlobalUShortA<DEG1 * 135)     FlyCamViewCheck=1;          
			else if(GlobalUShortA<DEG1 * 225)     FlyCamViewCheck=0;          
			else if(GlobalUShortA<DEG1 * 315)     FlyCamViewCheck=3;          
			else      FlyCamViewCheck=2;          
		}

		FlyCamSection = ((FlyCamSectionCheck - 1) * 4) + FlyCamViewCheck;
		

	
	}
	*/





	//devmode

	if (MapModeCheck == 1)
	{
		printMap(MapMode);

		if ((GlobalController[0]->ButtonHeld & BTN_R) == BTN_R)
		{
			if ((GlobalController[0]->ButtonPressed & BTN_DDOWN) == BTN_DDOWN)
			{
				if (MapMode < 2)
				{
					MapMode++;
				}
			}
			if ((GlobalController[0]->ButtonPressed & BTN_DUP) == BTN_DUP)
			{
				if (MapMode > 0)
				{
					MapMode--;
				}
			}
		}
		else
		{
			switch(MapMode)
			{
				case 0:
				{
					//map

					switch(GlobalController[0]->ButtonHeld)
					{

						case BTN_DRIGHT :
						{
							g_mapX++;
							break;
						}


						case BTN_DLEFT :
						{

							g_mapX--;
							break;
						}

						case BTN_DUP :
						{
							g_mapY++;
							break;
						}

						case BTN_DDOWN :
						{
							g_mapY--;
							break;
						}
					}

					break;
				}



				case 1:
				{
					//map
					switch(GlobalController[0]->ButtonHeld)
					{

						case BTN_DRIGHT :
						{
							g_startX++;
							break;
						}


						case BTN_DLEFT :
						{

							g_startX--;
							break;
						}

						case BTN_DUP :
						{
							g_startY++;
							break;
						}

						case BTN_DDOWN :
						{
							g_startY--;
							break;
						}
					}


					break;

				}



				case 2:
				{
					//map
					switch(GlobalController[0]->ButtonHeld)
					{

						case BTN_DRIGHT :
						{
							g_mapScale = g_mapScale + .0001;
							break;
						}


						case BTN_DLEFT :
						{

							g_mapScale = g_mapScale - .0001;
							break;
						}

						case BTN_DUP :
						{
							g_mapScale = g_mapScale + .00001;
							break;
						}

						case BTN_DDOWN :
						{
							g_mapScale = g_mapScale - .00001;
							break;
						}
					}

					break;
				}

			}
		}
	}

}


void FlycamInit()
{
	for (int Pass = 0; Pass < 20; Pass++)
	{
		*(uint*)(&ok_FreeCam + Pass) = 0xFF00FF00;
	}
}