#include "../Library/MainInclude.h"
#include "OKInclude.h"


//practiceHack Variables//
/*
char GlobalCharA;  //DpadInput
short GlobalCharD;  //Cpad Input
char GlobalCharB;   L/R Button
char GlobalCharC;   A/B Buttons
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
	if (gameMode[2] != AudioLanguage)
	{
		AudioLanguage = gameMode[2];
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
	if (gameMode[3] > 0x00)
	{
			g_mirrorMode = 0x0001;
	}
	if (gameMode[6] > 0x00)
	{
		aiSetup();
	}
	//gameMode[1] handled in Menu

	if (renderMode[0] > 0x00)
	{
		if ((g_playerCount == 0x02) & (renderMode[2] == 0x00))
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
		if (g_playerCount == 0x02)
		{
			g_aspectRatio = 2.6666667;
		}
		else
		{
			g_aspectRatio = 1.333334;
		}
	}
	/*
	if (renderMode[1] > 0x00)
	{
		antialiasToggle = 0x00013016;
		antialiasToggleB = 0x00013016;
	}
	else
	{
		antialiasToggle = 0;
		antialiasToggleB = 0;
	}
	*/
	//renderMode[2] 3D racers;
	if (renderMode[2] > 0x00)
	{
		if (g_playerCount == 0x02)
		{
			g_screenSplitA = 2;
			g_ScreenSplitB = 2;
		}
	}
	if (renderMode[4] > 0x00)
	{
		TempoBool = 1;
	}
	else
	{
		TempoBool = 0;
	}




	//modMode[0] and modMode[2] handled in gameCode function.
	if (modMode[4] > 0x00)
	{
		if (modMode[4] < 0x09)
		{
			asm_itemJump1B = (0x84A5 | (itemChanceLo + 2));
			asm_itemJump2B = (0x84A5 | (itemChanceLo + 2));
			asm_itemJump1A = (0x3C05 | itemChanceHi);
			asm_itemJump2A = (0x3C05 | itemChanceHi);
			GlobalAddressA = (long)(&ok_ItemTable);
			for (int currentPlayer = 0; currentPlayer < 8; currentPlayer++)
			{
				*(long*)(&GlobalAddressA) = *(long*)(&g_playerPosition1 + currentPlayer);
				GlobalAddressA += 4;
			}
			for (int currentPlayer = 0; currentPlayer < g_playerCount; g_playerCount++)
			{
				*(long*)(&GlobalAddressA) = 8 - modMode[4];
				GlobalAddressA += 4;
			}
		}
	}
	else
	{
		asm_itemJump1B = 0x84A543BA;
		asm_itemJump2B = 0x84A543BA;
		asm_itemJump1A = 0x3C058016;
		asm_itemJump2A = 0x3C058016;
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

//modmode[0] is > 0 then
void practiceHack()
{
	GlobalCharA = (d_Input & 0x0F);	 //Dpad
	GlobalCharB = (p_Input & 0xF0) >> 4;  //LR Trigger
	GlobalCharC = (d_Input & 0xF0) >> 4;  //AB Button
	GlobalCharD = (p_Input & 0x0F);  //Cpad
	if (modMode[0] == 1)
	{
		
		if (SplitTimerToggle > 0x00)
		{
			splitFunc();

		}
		if (GlobalCharA == 0x00)
		{
			ButtonHeld = 0x00;
		}
		// D-Pad Hacks.
		if (GlobalCharD == 0x02)
		{
			g_player1LocationY = g_player1LocationY + 3;
			g_player1SpeedY = 0;
			GraphPtr = FillRect1ColorF(GraphPtr, 23, 43, 120, 53, 0, 0,0, 175);
	          loadFont();
	          printString(5,25, "FLYING");
		}
		/*
		if (ButtonHeld == 0x00)
		{
			if (GlobalCharB == 0x02)
			{
				switch(GlobalCharA)
				{

					// End Split hack.
					case 0x01 :
					{

						ButtonHeld = 1;
						SplitEndMarker = g_progressValue;

						break;
					}

					//Start Split hack.
					case 0x02 :
					{

						ButtonHeld = 1;
						SplitStartMarker = g_progressValue;
						break;
					}

					// Turn Off Split Timer
					case 0x04 :
					{
						SplitTimerToggle = 0x00;

						ButtonHeld = 1;
						break;
					}

					// Turn on Split Timer
					case 0x08 :
					{
						SplitTimerToggle = 0x01;

						break;
					}
				}
			}
			else
			{
				switch(GlobalCharA)
				{

					// Load Position hack.
					case 0x01 :
					{
						if (SaveStateCourseID == ((HotSwapID * 0x10) + g_courseID + 1))
						{
							ButtonHeld = 1;
							loadState();
						}
						break;
					}

					// Save Position hack.

					case 0x02 :
					{

						ButtonHeld = 1;
						SaveStateCourseID = ((HotSwapID * 0x10) + g_courseID + 1);
						saveState();
						break;
					}

					// Reset Timer and Lap Hack
					case 0x04 :
					{
						g_gameLapPlayer1 = 0x00;
						g_lapCheckA = 0x00;
						g_lapCheckB = 0x00;

						g_gameTimer = 90;
						//GIVE PLAYER TRIPLE MUSHROOM

						ButtonHeld = 1;
						break;
					}

					//FASTRESET Hack
					case 0x08 :
					{
						
						g_resetToggle = 0x01;
						ButtonHeld = 1;

						break;
					}
				}
			}
		}
		*/
		switch(GlobalController[0]->ButtonPressed)
		{
			case(BTN_DLEFT):
			{
				GlobalStat.SlipAngle[0][1] -= 0.1;
				break;
			}
			case(BTN_DRIGHT):
			{
				GlobalStat.SlipAngle[0][1] += 0.1;
				break;
			}
			case(BTN_DUP):
			{

				objectPosition[0] = GlobalPlayer[0].position[0];
				objectPosition[1] = GlobalPlayer[0].position[1];
				objectPosition[2] = GlobalPlayer[0].position[2];
				objectAngle[0] = 0;
				objectAngle[1] = 0;
				objectAngle[2] = 0;
				objectVelocity[0] = 0;
				objectVelocity[1] = 0;
				objectVelocity[2] = 0;
				MakeAlignVector(objectVelocity, (GlobalPlayer[0].direction[1] + GlobalPlayer[0].slipang));
				MasterCreateObject(objectPosition,objectAngle, objectVelocity,47,2);
			}
			case(BTN_DDOWN):
			{
				short* PositionArray = (short*)GetRealAddress(PathTable[g_courseID][0]);
				GlobalPlayer[0].position[0] = (float)PositionArray[0];
				GlobalPlayer[0].position[1] = (float)PositionArray[1];
				GlobalPlayer[0].position[2] = (float)PositionArray[2];
			}
	
		}
	}


	if (modMode[1] == 1)
	{
		
		
		/*
		if ((FlyCamPosition[0] == 0) && (FlyCamPosition[1] == 0))
		{
			FlyCamPosition[0] = g_player1LocationX;
			FlyCamPosition[1] = g_player1LocationY;
			FlyCamPosition[2] = g_player1LocationZ;
		}
		else
		{
			g_player1LocationX = FlyCamPosition[0];
			g_player1LocationY = FlyCamPosition[1];
			g_player1LocationZ = FlyCamPosition[2];
		}
		*/
		
	
			

		if ((GlobalController[0]->ButtonPressed & BTN_R) == BTN_R)
		{
			
			dataLength = 0x20;
			if (FlyCamToggle == 0)
			{
				*sourceAddress = (int)&ok_FreeCamBackup;
				g_mapY -= 150;
				g_mapX += 95;
				
				FlyCamToggle = 1;
			}
			else if (FlyCamToggle == 1)
			{
				FlyCamToggle = 2;
			}
			else if (FlyCamToggle == 2)
			{
				*sourceAddress = (int)0x8018CAB0;
				*targetAddress = (int)&ok_FreeCamBackup;
				runRAM();
				*sourceAddress = (int)&ok_FreeCam;
				g_mapY += 150;
				g_mapX -= 75;

				FlyCamToggle = 0;
			}
			*targetAddress = (int)0x8018CAB0;
			runRAM();
			
		}


		if (FlyCamToggle == 0)
		{
			if (FlyCamCheck != 0)
			{
				FlyCamCheck = 0;				
			}
			*(int*)(0x8001EE98) = 0x27BDFFC8;
			*(int*)(0x80291154) = 0x01E72021;
			*(int*)(0x80291164) = 0x2484FFFC;

			*(int*)(0x800382DC) = 0x3C02800E;
			*(int*)(0x800382E0) = 0x8C42C52C;

			FlyCamDirection = GlobalCamera[0]->camera_direction[1];
			FlyCamSectionCheck = g_player1Section;
			FlyCamViewCheck = g_player1View;
		}
		else if (FlyCamToggle == 1)
		{
			FlyCamCheck = 1;
			*(int*)(0x8001EE98) = 0x03E00008;
			*(uint*)(0x80291154) = 0x3C040000 | ((uint)(&FlyCamSection) >> 16);
			*(uint*)(0x80291164) = 0x84840000 | ((uint)(&FlyCamSection) & 0xFFFF);

			*(int*)(0x800382DC) = 0x3C02800E;
			*(int*)(0x800382E0) = 0x8C42C52C;
		}
		else if (FlyCamToggle == 2)
		{
			FlyCamCheck = 2;
			*(int*)(0x8001EE98) = 0x03E00008;
			*(uint*)(0x80291154) = 0x3C040000 | ((uint)(&FlyCamSection) >> 16);
			*(uint*)(0x80291164) = 0x84840000 | ((uint)(&FlyCamSection) & 0xFFFF);


			*(int*)(0x800382DC) = 0x03E00008;
			*(int*)(0x800382E0) = 0;
		}

		if (FlyCamToggle > 0)
		{
			if ((GlobalController[0]->ButtonHeld & BTN_L) == BTN_L)
			{
				loadFont();
				printStringNumber(5,25, "SECTION-", FlyCamSectionCheck);
				printStringNumber(5,35, "VIEW-", FlyCamViewCheck);
				printStringNumber(5,45, "SPEED-", FlyCamSpeed);
				printStringNumber(5,55,"StickX-", GlobalController[0]->AnalogX);
				printStringNumber(5,65,"StickY-", GlobalController[0]->AnalogY);
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
						
						ButtonHeld = 1;
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
						ButtonHeld = 1;
						break;
					}
				}

				if (((GlobalController[0]->AnalogHeld & BTN_DDOWN) == BTN_DDOWN) || ((GlobalController[0]->AnalogHeld & BTN_DUP) == BTN_DUP))
				{
					
				}

			}	
			else
			{	
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
					case BTN_CLEFT:
					{
						if (FlyCamPilot == 0)
						{
							FlyCamPilot = 1;
						}
						else
						{
							FlyCamPilot = 0;
						}
						break;
					}
				
				}
				switch(GlobalController[0]->ButtonHeld)
				{
					case BTN_DUP:
					{
						GlobalCamera[0]->lookat_pos[1] += (FlyCamSpeed / 2);
						break;
					}
					case BTN_DDOWN:
					{
						GlobalCamera[0]->lookat_pos[1] -= (FlyCamSpeed / 2);
						break;
					}
				}
				if ((GlobalController[0]->AnalogHeld & BTN_DRIGHT) == BTN_DRIGHT)
				{
					rotateCamera((float)(FlyCamSpeed / 2 * (float)((float)GlobalController[0]->AnalogX / 100)));

					if (FlyCamPilot == 1)
					{
						moveCamera(FlyCamSpeed);
					}
					else
					{
						if ((GlobalController[0]->ButtonHeld & BTN_A) == BTN_A)
						{
							moveCamera(FlyCamSpeed);
						}
						if ((GlobalController[0]->ButtonHeld & BTN_B) == BTN_B)
						{
							moveCamera(-1 * FlyCamSpeed);
						}
					}
				}
				else if ((GlobalController[0]->AnalogHeld & BTN_DLEFT) == BTN_DLEFT)
				{
					rotateCamera((float)(FlyCamSpeed / 2 * (float)((float)GlobalController[0]->AnalogX / 100)));

					if (FlyCamPilot == 1)
					{
						moveCamera(FlyCamSpeed);
					}
					else
					{
						if ((GlobalController[0]->ButtonHeld & BTN_A) == BTN_A)
						{
							moveCamera(FlyCamSpeed);
						}
						if ((GlobalController[0]->ButtonHeld & BTN_B) == BTN_B)
						{
							moveCamera(-1 * FlyCamSpeed);
						}
					}
				}
				else
				{
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
					
				}
				
				if (((GlobalController[0]->AnalogHeld & BTN_DDOWN) == BTN_DDOWN) || ((GlobalController[0]->AnalogHeld & BTN_DUP) == BTN_DUP))
				{
					GlobalCamera[0]->camera_pos[1] += (float)(FlyCamSpeed / 3 * (float)((float)GlobalController[0]->AnalogY / 100));
					GlobalCamera[0]->lookat_pos[1] += (float)(FlyCamSpeed / 3 * (float)((float)GlobalController[0]->AnalogY / 100));
				}
			}
		}

		if(g_mirrorMode == 1)
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






	//devmode

	if (modMode[0] == 2)
	{
		printMap(MapMode);
		if (GlobalCharA == 0x00)
		{
			ButtonHeld = 0x00;
		}
		if (GlobalCharB == 0x01)
		{

			switch(GlobalCharA)
			{
				case 0x08 :
				{
					if (MapMode > 0 && ButtonHeld == 0)
					{
						MapMode--;
						ButtonHeld = 1;
					}
					break;
				}

				case 0x04 :
				{
					if (MapMode < 3 && ButtonHeld == 0)
					{
						MapMode++;
						ButtonHeld = 1;
					}
					break;
				}
			}
		}
		else
		{
			ButtonHeld = 0;
			switch(MapMode)
			{
				case 0:
				{
					//map

					switch(GlobalCharA)
					{

						case 0x01 :
						{
							g_mapX++;
							break;
						}


						case 0x02 :
						{

							g_mapX--;
							break;
						}

						case 0x04 :
						{
							g_mapY++;
							break;
						}

						case 0x08 :
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
					switch(GlobalCharA)
					{

						case 0x01 :
						{
							g_startX++;
							break;
						}


						case 0x02 :
						{

							g_startX--;
							break;
						}

						case 0x04 :
						{
							g_startY++;
							break;
						}

						case 0x08 :
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
					switch(GlobalCharA)
					{

						case 0x01 :
						{
							g_mapScale = g_mapScale + .0001;
							break;
						}


						case 0x02 :
						{

							g_mapScale = g_mapScale - .0001;
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