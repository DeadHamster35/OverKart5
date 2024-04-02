#include "../Library/MainInclude.h"
#include "OKInclude.h"


uint SetLimit = 2;

void loadPosition()
{
     switch(g_playerCount)
     {
          case 0x01 :
          {
               MenuPosition[0] = 5;
               MenuPosition[1] = 15;
               break;
          }
          case 0x02 :
          {
               MenuPosition[0] = 90;
               MenuPosition[1] = 97;
               break;
          }
          case 0x03 :
          {
               MenuPosition[0] = 170;
               MenuPosition[1] = 200;
               break;
          }
          case 0x04 :
          {
               MenuPosition[0] = 90;
               MenuPosition[1] = 97;
               break;
          }
     }
}

void printDetails()
{
     if (g_playerCount == 1)
     {
          MenuPosition[0] = 58;
          MenuPosition[1] = 175;
          GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0] + 18, MenuPosition[1] + 18, MenuPosition[0] + 185, MenuPosition[1] + 58, 0, 0, 0, 175);
          loadFont();


          printString(MenuPosition[0],MenuPosition[1],"X:");
          printString(MenuPosition[0],MenuPosition[1]+10,"Y:");
          printString(MenuPosition[0],MenuPosition[1]+20,"Z:");
          printString(MenuPosition[0],MenuPosition[1]+30,"A:");

          if (SaveGame.RenderSettings.DetailMode == 1)
          {
               printString(MenuPosition[0]+87,MenuPosition[1]," SX:");
               printString(MenuPosition[0]+87,MenuPosition[1]+10," SY:");
               printString(MenuPosition[0]+87,MenuPosition[1]+20," SZ:");
          }
          else
          {
               printString(MenuPosition[0]+87,MenuPosition[1]," LA:");
               printString(MenuPosition[0]+87,MenuPosition[1]+10," LS:");
               printString(MenuPosition[0]+87,MenuPosition[1]+20," PG:");
          }


          printString(MenuPosition[0]+87,MenuPosition[1]+30," SA:");


          for(int loop = 0; loop < 4; loop++)
          {
               switch  (loop)
               {
                    case 0x00:
                    {
                         wholeNumber = (int) g_player1LocationX;
                         decimalNumber = (int) ((g_player1LocationX - wholeNumber) * 1000);
                         break;
                    }
                    case 0x01:
                    {
                         wholeNumber = (int) g_player1LocationY;
                         decimalNumber = (int) ((g_player1LocationY - wholeNumber) * 1000);
                         break;
                    }
                    case 0x02:
                    {
                         wholeNumber = (int) g_player1LocationZ;
                         decimalNumber = (int) ((g_player1LocationZ - wholeNumber) * 1000);
                         break;
                    }
                    case 0x03:
                    {
                         float playerAngle = (((float)g_player1LocationA / 65536) * 360);
                         wholeNumber = playerAngle;
                         decimalNumber = (int) ((playerAngle - wholeNumber) * 1000);
                         break;
                    }

               }
               if (decimalNumber < 0)
               {
                    decimalNumber = decimalNumber * -1;
               }

               if (wholeNumber > 0)
               {
                    printOffsetD = wholeNumber;
               }
               else
               {
                    printOffsetD = wholeNumber * -1;
               }
               if (printOffsetD >= 10)
               {
                    if (printOffsetD >= 100)
                    {
                         if (printOffsetD >= 1000)
                         {

                              printOffsetB = 8;
                         }
                         else
                         {
                         printOffsetB = 16;
                         }
                    }
                    else
                    {
                    printOffsetB = 24;
                    }
               }
               else
               {
                    printOffsetB = 32;
               }
               if (wholeNumber >= 0)
               {
                    printOffsetB = printOffsetB + 8;
               }

               printOffsetA = 56;

               if (decimalNumber < 100)
               {
                    printStringNumber(MenuPosition[0]+printOffsetA-4,MenuPosition[1],"",0);
                    printOffsetC = 8;
               }
               else
               {
                    printOffsetC = 0;
               }



               printStringNumber(MenuPosition[0]+printOffsetB,MenuPosition[1],"",wholeNumber);
               printString(MenuPosition[0]+printOffsetA,MenuPosition[1],".");
               printStringNumber(MenuPosition[0]+printOffsetA-4+printOffsetC,MenuPosition[1],"",decimalNumber);
               MenuPosition[1] = MenuPosition[1] + 10;
               //
               //
          }


          MenuPosition[0] = MenuPosition[0] + 87;
          MenuPosition[1] = 175;
          for(int loop = 0; loop < 4; loop++)
          {
               switch  (loop)
               {
                    case 0x00:
                    {
                         if (SaveGame.RenderSettings.DetailMode == 1)
                         {
                              wholeNumber = (int) g_player1SpeedX;
                              decimalNumber = (int) ((g_player1SpeedX - wholeNumber) * 1000);
                         }
                         else
                         {
                              wholeNumber = (int) g_lakituSurface;
                         }

                         break;
                    }
                    case 0x01:
                    {
                         if (SaveGame.RenderSettings.DetailMode == 1)
                         {
                              wholeNumber = (int) g_player1SpeedY;
                              decimalNumber = (int) ((g_player1SpeedY - wholeNumber) * 1000);
                         }
                         else
                         {
                              wholeNumber = (int) g_lakituStatus;
                         }

                         break;
                    }
                    case 0x02:
                    {
                         if (SaveGame.RenderSettings.DetailMode == 1)
                         {
                              wholeNumber = (int) g_player1SpeedZ;
                              decimalNumber = (int) ((g_player1SpeedZ - wholeNumber) * 1000);
                         }
                         else
                         {
                              wholeNumber = (int) g_progressValue;
                         }

                         break;
                    }
                    case 0x03:
                    {
                         wholeNumber = (int) g_player1SpeedA;
                         decimalNumber = (int) ((g_player1SpeedA - wholeNumber) * 1000);
                         break;
                    }
               }
               if (decimalNumber < 0)
               {
                    decimalNumber = decimalNumber * -1;
               }


               if (wholeNumber > 0)
               {
                    printOffsetD = wholeNumber;
               }
               else
               {
                    printOffsetD = wholeNumber * -1;
               }
               if (printOffsetD >= 10)
               {
                    if (printOffsetD >= 100)
                    {
                         printOffsetB = 8;
                    }
                    else
                    {
                    printOffsetB = 16;
                    }
               }
               else
               {
                    printOffsetB = 24;
               }
               if (wholeNumber >= 0)
               {
                    printOffsetB = printOffsetB + 8;
               }
               if ((loop == 2) && (SaveGame.RenderSettings.DetailMode == 2))
               {
                    printOffsetB = printOffsetB + 8;
               }
               printOffsetA = 48;

               if ((SaveGame.RenderSettings.DetailMode == 1) | (loop == 3))
               {
                    if (decimalNumber < 100)
                    {
                         printStringNumber(MenuPosition[0]+printOffsetA-4,MenuPosition[1],"",0);
                         printOffsetC = 8;
                    }
                    else
                    {
                         printOffsetC = 0;
                    }
               }

               printStringNumber(MenuPosition[0]+printOffsetB,MenuPosition[1],"",wholeNumber);
               if ((SaveGame.RenderSettings.DetailMode == 1) | (loop == 3))
               {
                    printString(MenuPosition[0]+printOffsetA,MenuPosition[1],".");
                    printStringNumber(MenuPosition[0]+printOffsetA-4+printOffsetC,MenuPosition[1],"",decimalNumber);
               }
               MenuPosition[1] = MenuPosition[1] + 10;
               //
               //
          }


     }

}

void printAnticheat()
{
     loadPosition();
     
     if (SaveGame.GameSettings.GameMode == 3)
     {
          GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0] + 18, MenuPosition[1] + 18, MenuPosition[0] + (12 * 8) + 19, MenuPosition[1] + 28, 0, 0,0, 175);
          loadFont();

          printString(MenuPosition[0],MenuPosition[1], "Practice  ON");
          MenuPosition[1] +=10;
     }     
     
     if (SaveGame.GameSettings.ItemMode > 0)
     {
          GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0] + 18, MenuPosition[1] + 18, MenuPosition[0] + (11 * 8) + 19, MenuPosition[1] + 28, 0, 0,0, 175);
          loadFont();

          printString(MenuPosition[0],MenuPosition[1], "Force Items");
          MenuPosition[1] +=10;
     }
     else if (SaveGame.GameSettings.AIMode > 0x00)
     {

          switch (SaveGame.GameSettings.AIMode)
          {
               // PRACTICE BUILD overlay text.
               case 0x01 :
               {
                    GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0] + 18, MenuPosition[1] + 18, MenuPosition[0] + (10 * 8) + 19, MenuPosition[1] + 28, 0, 0,0, 175);
                    loadFont();
                    printString(MenuPosition[0],MenuPosition[1], "Versus CPU");
                    break;
               }
               case 0x02 :
               {
                    GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0] + 18, MenuPosition[1] + 18, MenuPosition[0] + (9 * 8) + 19, MenuPosition[1] + 28, 0, 0,0, 175);
                    loadFont();
                    printString(MenuPosition[0],MenuPosition[1], "Debug CPU");
                    break;
               }
          }
          MenuPosition[1] +=10;
     }
     else if ((SaveGame.GameSettings.StatsMode == 1) && (HotSwapID == 0) )
     {
          GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0] + 18, MenuPosition[1] + 18, MenuPosition[0] + (11 * 8) + 19, MenuPosition[1] + 28, 0, 0,0, 175);
          loadFont();
          printString(MenuPosition[0],MenuPosition[1], "Force Stats");
          MenuPosition[1] +=10;
     }



}


void CheckMenuButton (short PlayerIndex)
{
     if (ButtonHolding[PlayerIndex] == true)
     {
          if ((GlobalController[PlayerIndex]->ButtonHeld == 0) && (GlobalController[PlayerIndex]->AnalogHeld == 0))
          {
               MenuButtonHeld[PlayerIndex] = 0;
               ButtonHolding[PlayerIndex] = false;
               ButtonTimer[PlayerIndex] = 0;
               
          }
          else
          {
               ButtonTimer[PlayerIndex] = ButtonTimer[PlayerIndex] + 1;  //Button Held Timer          
               if (ButtonTimer[PlayerIndex] >= 15)
               {                      
                    ButtonHolding[PlayerIndex] = false;
                    ButtonTimer[PlayerIndex] = 0;  //Button Held Timer               
               }
          }
     }
     else
     {
          if (GlobalController[PlayerIndex]->ButtonHeld > 0)
          {
               MenuButtonHeld[PlayerIndex] = GlobalController[PlayerIndex]->ButtonHeld;
               if (GlobalController[PlayerIndex]->ButtonPressed == 0)
               {
                    ButtonHolding[PlayerIndex] = true;
               }
          }
          else
          {
               if (GlobalController[PlayerIndex]->AnalogHeld > 0)
               {
                    MenuButtonHeld[PlayerIndex] = GlobalController[PlayerIndex]->AnalogHeld;
                    if (GlobalController[PlayerIndex]->AnalogPressed == 0)
                    {
                         ButtonHolding[PlayerIndex] = true;
                    }
               }
               else
               {          
                    MenuButtonHeld[PlayerIndex] = 0;
                    ButtonHolding[PlayerIndex] = false;
                    ButtonTimer[PlayerIndex] = 0;  //Button Held Timer
               }
          }
     }
}

void swapParameter(OKMenu OptionsMenu, int directionIndex)
{
     
     //if directionIndex == 0, swap down;
     //if directionIndex == 1, swap up;

     if(directionIndex == 0) 
     {
          if(OptionsMenu.PanelAddress[MenuIndex].ParameterToggles[ParameterIndex - 1 + MenuOverflow] > 0)
          {
               OptionsMenu.PanelAddress[MenuIndex].ParameterToggles[ParameterIndex - 1 + MenuOverflow]--;
               playSound(0x49008000);
               return;
          }          
     }
     else if(OptionsMenu.PanelAddress[MenuIndex].ParameterToggles[ParameterIndex - 1+ MenuOverflow] < OptionsMenu.PanelAddress[MenuIndex].Options[ParameterIndex - 1+ MenuOverflow].ParameterCount - 1) 
     {
          OptionsMenu.PanelAddress[MenuIndex].ParameterToggles[ParameterIndex - 1 + MenuOverflow]++;
          playSound(0x49008000);
          return;
     }
     
     
     playSound(0x49008002);
}

void GameOptionsHandler(short PlayerIndex)
{
     CheckMenuButton(PlayerIndex);
          
     //MenuButtonHeld is set to 0x01 when a button is held down.
     if(ButtonHolding[PlayerIndex] == false)
     {
          
          // Uses the Control Stick or Dpad to switch through the menu.
          switch(MenuButtonHeld[PlayerIndex])
          {
               //Increase the current menu Parameter by 1
              case BTN_DRIGHT :
               {
                    ButtonHolding[PlayerIndex] = true;
                    if (ParameterIndex > 0) //currentParameter
                    {
                         if (MenuIndex < GameOKMenu.PanelCount)
                         {
                              swapParameter(GameOKMenu,1);
                         }
                         else
                         {
                              if (ParameterIndex == 1) //currentParameter
                              {
                                   if (MenuCup < 3)  //cupSelect
                                   {
                                        MenuCup++;
                                   }
                              }
                              else
                              {
                                   if (SYSTEM_Region == 0x00)
                                   {
                                        GlobalAddressA = (cup_PAL + (MenuCup * 8) + ((ParameterIndex - 2) * 2));
                                   }
                                   else
                                   {
                                        GlobalAddressA = (cup_NTSC + (MenuCup * 8) + ((ParameterIndex - 2) * 2));
                                   }

                                   short *l_courseID = (short *)GlobalAddressA;

                                   if (*l_courseID < 19)
                                   {
                                        *l_courseID = *l_courseID + 1;
                                        copyCourseTable(1);
                                   }
                              }
                         }
                    }
                    else
                    {
                         if (MenuIndex < GameOKMenu.PanelCount)
                         {
                              MenuIndex++;
                              MenuOverflow = 0;
                              playSound(0x49008001);
                         }
                         else
                         {
                              playSound(0x49008002);
                         }
                    }
                    break;

               }
               //Decrease the current menu Parameter by 1
               case BTN_DLEFT :
               {
                    ButtonHolding[PlayerIndex] = true;
                    if (ParameterIndex > 0) //currentParameter
                    {
                         if (MenuIndex < GameOKMenu.PanelCount)
                         {
                              swapParameter(GameOKMenu,0);
                         }
                         else
                         {
                              if (ParameterIndex == 1) //currentParameter
                              {
                                   if (MenuCup > 0)  //cupSelect
                                   {
                                        MenuCup--;
                                   }
                              }
                              else
                              {
                                   if (SYSTEM_Region == 0x00)
                                   {
                                        GlobalAddressA = (cup_PAL + (MenuCup * 8) + ((ParameterIndex - 2) * 2));
                                   }
                                   else
                                   {
                                        GlobalAddressA = (cup_NTSC + (MenuCup * 8) + ((ParameterIndex - 2) * 2));
                                   }
                                   short *l_courseID = (short *)GlobalAddressA;
                                   if (*l_courseID > 0)
                                   {
                                        *l_courseID = *l_courseID - 1;
                                        copyCourseTable(1);
                                   }
                              }
                         }
                    }
                    else
                    {
                         if (MenuIndex > 0)
                         {
                              MenuIndex--;
                              MenuOverflow = 0;
                              playSound(0x49008001);
                         }
                         else
                         {
                              playSound(0x49008002);
                         }
                    }
                    break;

               }
               //Move forward to next option
               case BTN_DDOWN :
               {
                    ButtonHolding[PlayerIndex] = true;
                    if (MenuIndex < GameOKMenu.PanelCount)
                    {
                         GlobalIntA = GameOKMenu.PanelAddress[MenuIndex].OptionCount;
                    }
                    else
                    {
                         GlobalIntA = 4; //cup editor
                    }
                    if (ParameterIndex + MenuOverflow < GlobalIntA) //currentParameter
                    {
                         if ((ParameterIndex == 7) && (MenuIndex < GameOKMenu.PanelCount))
                         {
                              MenuOverflow++;
                         }
                         else
                         {
                              ParameterIndex++; //currentParameter
                         }
                         playSound(0x4900801C);
                    }
                    break;

                    //
               }
               //Move backward to previous option
               case BTN_DUP :
               {
                    ButtonHolding[PlayerIndex] = true;
                    if (ParameterIndex + MenuOverflow > 0) //currentParameter
                    {
                         if ((ParameterIndex == 1) && (MenuIndex < GameOKMenu.PanelCount) && (MenuOverflow > 0))
                         {
                              MenuOverflow--;
                         }
                         else
                         {
                              ParameterIndex--; //currentParameter
                         }
                         playSound(0x4900801C);
                    }
                    break;
               }

          }
          // End of menu Dpad code.


     }

}

void TitleMenuHandler(short PlayerIndex)
{
     CheckMenuButton(PlayerIndex);
     //MenuButtonHeld is set to 0x01 when a button is held down.
     if(ButtonHolding[PlayerIndex] == false)
     {
          
          // Uses the Control Stick or Dpad to switch through the menu.
          switch(MenuButtonHeld[PlayerIndex])
          {
               //Increase the current menu Parameter by 1
               case BTN_DRIGHT :
               {
                    ButtonHolding[PlayerIndex] = true;
                    if (ParameterIndex > 0) //currentParameter
                    {
                         if (MenuIndex < 2)
                         {
                              swapParameter(GameOKMenu,1);
                         }
                         else
                         {
                              if (ParameterIndex == 1) //currentParameter
                              {
                                   if (MenuCup < 3)  //cupSelect
                                   {
                                        MenuCup++;
                                   }
                              }
                              else
                              {
                                   if (SYSTEM_Region == 0x00)
                                   {
                                        GlobalAddressA = (cup_PAL + (MenuCup * 8) + ((ParameterIndex - 2) * 2));
                                   }
                                   else
                                   {
                                        GlobalAddressA = (cup_NTSC + (MenuCup * 8) + ((ParameterIndex - 2) * 2));
                                   }

                                   short *l_courseID = (short *)GlobalAddressA;

                                   if (*l_courseID < 19)
                                   {
                                        *l_courseID = *l_courseID + 1;
                                        copyCourseTable(1);
                                   }
                              }
                         }
                    }
                    else
                    {
                         if (MenuIndex < 4)
                         {
                              MenuIndex++;
                              MenuOverflow = 0;
                              playSound(0x49008001);
                         }
                         else
                         {
                              playSound(0x49008002);
                         }
                    }
                    break;

               }
               //Decrease the current menu Parameter by 1
               case BTN_DLEFT :
               {
                    ButtonHolding[PlayerIndex] = true;
                    if (ParameterIndex > 0) //currentParameter
                    {
                         if (MenuIndex < 2)
                         {
                              swapParameter(GameOKMenu,0);
                         }
                         else
                         {
                              if (ParameterIndex == 1) //currentParameter
                              {
                                   if (MenuCup > 0)  //cupSelect
                                   {
                                        MenuCup--;
                                   }
                              }
                              else
                              {
                                   if (SYSTEM_Region == 0x00)
                                   {
                                        GlobalAddressA = (cup_PAL + (MenuCup * 8) + ((ParameterIndex - 2) * 2));
                                   }
                                   else
                                   {
                                        GlobalAddressA = (cup_NTSC + (MenuCup * 8) + ((ParameterIndex - 2) * 2));
                                   }
                                   short *l_courseID = (short *)GlobalAddressA;
                                   if (*l_courseID > 0)
                                   {
                                        *l_courseID = *l_courseID - 1;
                                        copyCourseTable(1);
                                   }
                              }
                         }


                    }
                    else
                    {
                         if (MenuIndex > 0)
                         {
                              MenuIndex--;
                              MenuOverflow = 0;
                              playSound(0x49008001);
                         }
                         else
                         {
                              playSound(0x49008002);
                         }
                    }
                    break;

               }
               //Move forward to next option
               case BTN_DDOWN :
               {
                    ButtonHolding[PlayerIndex] = true;
                    if (ParameterIndex + MenuOverflow < GameOKMenu.PanelAddress[MenuIndex].OptionCount) //currentParameter
                    {
                         if ((ParameterIndex == 4) && (MenuIndex < 3))
                         {
                              MenuOverflow++;
                         }
                         else
                         {
                              ParameterIndex++; //currentParameter
                         }
                         playSound(0x4900801C);
                    }
                    break;

                    //
               }
               //Move backward to previous option
               case BTN_DUP :
               {
                    ButtonHolding[PlayerIndex] = true;
                    if (ParameterIndex + MenuOverflow > 0) //currentParameter
                    {
                         if ((ParameterIndex == 1) && (MenuIndex < 3) && (MenuOverflow > 0))
                         {
                              MenuOverflow--;
                         }
                         else
                         {
                              ParameterIndex--; //currentParameter
                         }
                         playSound(0x4900801C);
                    }
                    break;
               }


          }
          // End of menu Dpad code.


     }

     
     

     //OptionsMenu(175,2,1);
}



void titleMenu()
{
     if (MenuBlink > 30)
     {
          MenuBlink = 0;
     }
     else
     {
          MenuBlink++;
     }
     if(titleDemo > 4)
     {
          titleDemo = 4;   //This is a timer that runs at the title screen. Locking at 4 Prevents the demo courses from being displayed.
     }

     
     g_mracewayTime = 0;

     #if OverKartBuild
          
          GlobalAddressA = 0x8018DABC;
          for (int Loop = 0; Loop < 4; Loop++)
          {
               *(uint*)(GlobalAddressA) = 0; 
               GlobalAddressA += 4;
          }          
          KWTexture2DRGBA32BL(64,64,0,1.0,(uchar*)(BackdropRAM),(void*)(&V256x12832B),256,128,256,4);
          KWTexture2DRGBA32BL(256,64,0,1.0,(uchar*)(BackdropRAM),(void*)(&V256x12832B),256,128,256,4);
          
          guPerspective(&gDynamicP->projection1,&PerspectiveValue, 45.0, 320/240, 100, 25000, 1.0f);
          gSPPerspNormalize(GraphPtrOffset++, PerspectiveValue);
          gSPMatrix(GraphPtrOffset++, K0_TO_PHYS((u32) &(gDynamicP->projection1)),G_MTX_PROJECTION|G_MTX_LOAD|G_MTX_NOPUSH);
          //gSPMatrix(GraphPtrOffset++, K0_TO_PHYS((u32) &(gDynamicP->viewing)),G_MTX_PROJECTION|G_MTX_MUL|G_MTX_NOPUSH);
          GULookAt(&gDynamicP->viewing,
               0, 0,0,
               0, 0,50000,
               0,1,0);
          
          LoadIdentAffineMtx(AffineMatrix);
          SetMatrix(AffineMatrix,0);
          
          /*
          guPerspective(&gDynamicP->projection1,&PerspectiveValue, 45.0, 320/240, 100, 50000, 1.0f);
          gSPPerspNormalize(*graphPointer, PerspectiveValue);
          gSPMatrix(*graphPointer, K0_TO_PHYS((u32) &(gDynamicP->projection1)),G_MTX_PROJECTION|G_MTX_LOAD|G_MTX_NOPUSH);
          GULookAt(&gDynamicP->viewing,
               0, 0,0,
               0, 0,100,
               0,1,0);
          gSPMatrix(*graphPointer, K0_TO_PHYS((u32) &(gDynamicP->viewing)),G_MTX_PROJECTION|G_MTX_MUL|G_MTX_NOPUSH);
          LoadIdentAffineMtx(AffineMatrix);
          SetMatrix(AffineMatrix,0);
          */
          


          objectPosition[0] = 0;
          objectPosition[1] = 0;
          objectPosition[2] = -200;
          objectAngle[0] = 0;
          objectAngle[1] = 0;
          objectAngle[2] = 0;

          //Segmented Address of title screen 3D logo is 0x0A000000
          DrawGeometryScale(objectPosition, objectAngle, 0x0A000000, 1.4);
          
          if ((GlobalController[0]->ButtonHeld & BTN_L) != BTN_L)
          {
               MenuAngle[0]++;
               
               MenuAngle[1]++;
               if (MenuAngle[1] > 79)
               {
                    MenuAngle[1] = 0;
               }

               if (MenuAngle[1] < 20)
               {
                    MenuAngle[2]++;
                    MenuAngle[3]--;
               }
               else if (MenuAngle[1] < 40)
               {
                    MenuAngle[2]++;
                    MenuAngle[3]++;
               }
               else if (MenuAngle[1] < 60)
               {
                    MenuAngle[2]--;
                    MenuAngle[3]++;
               }
               else
               {
                    MenuAngle[2]--;
                    MenuAngle[3]--;
               }

               g_mpressstartID = 0;
               g_mflagID = 0;
               g_NintendoLogoOffset = 0x0A000008;

               

               if (!MenuToggle)
               {               
                    objectPosition[0] = 0;
                    objectPosition[1] = 15;
                    objectPosition[2] = -120;
               }
               else
               {

                    objectPosition[0] = 0;
                    objectPosition[1] = -20;
                    objectPosition[2] = -120;
               }

               gSPDisplayList(GraphPtrOffset++, 0x0D0076F8)

               objectAngle[0] = 0;
               objectAngle[1] = (MenuAngle[2] * DEG1 / -5);
               objectAngle[2] = (MenuAngle[3] * DEG1 / 5);
               DrawGeometryScale(objectPosition, objectAngle, 0x0A000010, 0.35);


               if (!MenuToggle)
               {      
                    objectPosition[1] -= 20;      
                    objectPosition[2] -= 50;
               }
               else
               {
                    objectPosition[1] -= 35;
                    objectPosition[2] -= 55;
               }
               objectAngle[1] = 0;
               objectAngle[2] = MenuAngle[0] * -1 * DEG1;
               DrawGeometryScale(objectPosition, objectAngle, 0x0A000020, 0.45);
               
          }

     #endif




}




short CheckPlayerSelect(int TargetController, short Direction)
{
     short Target = PlayerCharacterSelect[TargetController];
     while (true)
     {
          GlobalBoolC = true;
          if (((Target + Direction) < 8) && ((Target + Direction) > -1))
          {
               Target += Direction;          
               for (int ThisController = 0; ThisController < g_playerCount; ThisController++)
               {
                    if (ThisController != TargetController)
                    {
                         if (PlayerCharacterSelect[ThisController] == Target)
                         {
                              GlobalBoolC = false;
                         }
                    }
               }
               if (GlobalBoolC)
               {
                    return Target;
               }
          }
          else
          {
               return -1;
          }
     }
}



void PlayerSelectSetup()
{

     
	*targetAddress = (long)&BackupPortraitTable;
	*sourceAddress = (long)&SelectPortraitTable;
	dataLength = 288;
	runRAM();
	

     asm_DispOBSubPSelCursor1[0] = 0x800A08C8;
	asm_DispOBSubPSelCursor1[1] = 0x800A08C8;
	asm_DispOBSubPSelCursor1[2] = 0x800A08C8;
	asm_DispOBSubPSelCursor1[3] = 0x800A08C8;
	
	
	PlayerSelectPositions[0].y -= 10;
	PlayerSelectPositions[1].y -= 10;
	PlayerSelectPositions[2].y -= 10;
	PlayerSelectPositions[3].y -= 10;
	
	*targetAddress = (long)&BackupNamePlateTable;
	*sourceAddress = (long)&SelectNamePlateTable;
	dataLength = 32;
	runRAM();
}

void PlayerSelectMenu(short StatsMode, short PlayerIndex)
{
     
     CheckMenuButton(PlayerIndex);
     GlobalIntC = *(int*)(long)(&PlayerOK);
     
     if ((KBGNumberNext) && (MenuBackup == 0))
     {
          KBGNumberNext = 0;
          
     }
     for (int ThisJump = 0; ThisJump < 8; ThisJump++)
     {
          jtbl_DispObjPsel[ThisJump] = 0x800A08C8;
     }

     *(int*)(long)&PlayerShowStats = 0;
     
     
     HotSwapID = 0;
     copyCourseTable(0);

	courseValue = -1;
     //stockASM();
     hsLabel = -1;

     asm_BlinkCheck = 0x1420000E;

     
     //
     if (MenuBackup == 0)
     {    
          if (StatsMode == 2)
          {
               SetEngine(CharacterConvert[PlayerCharacterSelect[PlayerIndex] + 1],PlayerEngineSelect[PlayerIndex]);
               SetSteering(CharacterConvert[PlayerCharacterSelect[PlayerIndex] + 1], PlayerSteerSelect[PlayerIndex]);
               
               if (MenuProgress[PlayerIndex] == 0)
               {
                    PlayerOK[PlayerIndex] = 0;
                    PlayerShowStats[PlayerIndex] = 0;
                    asm_DispOBSubPSelCursor1[PlayerIndex] = 0x800A08C8;
                    switch (MenuButtonHeld[PlayerIndex])
                    {
                         case BTN_DLEFT:
                         {    
                              if (CheckPlayerSelect(PlayerIndex,-1) != -1)
                              {
                                   playSound(0x49008001);
                                   PlayerCharacterSelect[PlayerIndex] = CheckPlayerSelect(PlayerIndex, -1);
                              }
                              asm_BlinkCheck = 0;
                              break;
                         }
                         case BTN_DRIGHT:
                         {
                              if (CheckPlayerSelect(PlayerIndex,1) != -1)
                              {
                                   playSound(0x49008001);
                                   PlayerCharacterSelect[PlayerIndex] = CheckPlayerSelect(PlayerIndex, 1);
                              }   
                              asm_BlinkCheck = 0;
                              break;
                         }
                         case BTN_A:
                         {
                              playSound(0x49008001);
                              MenuProgress[PlayerIndex]++;  
                              break;
                         }
                         case BTN_B:
                         {                              
                              SetFadeOutB();
                              *(int*)(long)&PlayerShowStats = 0;
                              MenuBackup = 1;
                              break;
                         }
                    }
               }
               else if (MenuProgress[PlayerIndex] == 1)
               {
                    PlayerOK[PlayerIndex] = 0;
                    PlayerShowStats[PlayerIndex] = 1;
                    asm_DispOBSubPSelCursor1[PlayerIndex] = 0x800A00FC;


                    switch (MenuButtonHeld[PlayerIndex])
                    {
                         case BTN_DLEFT:
                         {    
                              if ((int)PlayerEngineSelect[PlayerIndex] > 0)
                         {
                              playSound(0x49008001);
                              PlayerEngineSelect[PlayerIndex]--;                                   
                         }   
                              break;
                         }
                         case BTN_DRIGHT:
                         {
                              if ((int)PlayerEngineSelect[PlayerIndex] < 2)
                              {
                                   playSound(0x49008001);
                                   PlayerEngineSelect[PlayerIndex]++;                                   
                              }  
                              break;
                         }
                         case BTN_A:
                         {
                              playSound(0x49008001);
                              MenuProgress[PlayerIndex]++;        
                              break;
                         }
                         case BTN_B:
                         {                              
                              playSound(0x49008002);
                              MenuProgress[PlayerIndex]--;
                              break;
                         }
                    }
               }
               else if (MenuProgress[PlayerIndex] == 2)
               {
                    PlayerOK[PlayerIndex] = 0;
                    PlayerShowStats[PlayerIndex] = 1;
                    asm_DispOBSubPSelCursor1[PlayerIndex] = 0x800A00FC;



                    switch (MenuButtonHeld[PlayerIndex])
                    {
                         case BTN_DLEFT:
                         {    
                              if ((int)PlayerSteerSelect[PlayerIndex] > 0)
                              {
                                   playSound(0x49008001);
                                   PlayerSteerSelect[PlayerIndex]--;                                   
                              } 
                              break;
                         }
                         case BTN_DRIGHT:
                         {
                              if ((int)PlayerSteerSelect[PlayerIndex] < 2)
                              {
                                   playSound(0x49008001);
                                   PlayerSteerSelect[PlayerIndex]++;                                   
                              }   
                              break;
                         }
                         case BTN_A:
                         {
                              playSound(0x49008001);   
                              MenuProgress[PlayerIndex]++;
                              break;
                         }
                         case BTN_B:
                         {                              
                              playSound(0x49008002);
                              MenuProgress[PlayerIndex]--;
                              break;
                         }
                    }
               }
               else if (MenuProgress[PlayerIndex] == 3)
               {
                    PlayerShowStats[PlayerIndex] = 0;
                    if (PlayerOK[PlayerIndex] != 1)
                    {
                         PlayerOK[PlayerIndex] = 1;
                         int SoundOffset = (0x10 * CharacterConvert[(int)PlayerCharacterSelect[PlayerIndex] + 1]);
                         playSound(0x2900800e + SoundOffset);  
                    }
                    if ((MenuButtonHeld[PlayerIndex] & BTN_B) == BTN_B)
                    {    
                         playSound(0x49008002);
                         MenuProgress[PlayerIndex]--;
                    }
               }
               
          }
          else
          {
               
               switch (MenuProgress[PlayerIndex])
               {
                    case 0:
                    {
                         PlayerShowStats[PlayerIndex] = 1;
                         asm_DispOBSubPSelCursor1[PlayerIndex] = 0x800A08C8;
                         PlayerOK[PlayerIndex] = 0;

                         switch (MenuButtonHeld[PlayerIndex])
                         {
                              case BTN_DLEFT:
                              {    
                                   if (CheckPlayerSelect(PlayerIndex,-1) != -1)
                                   {
                                        playSound(0x49008001);
                                        PlayerCharacterSelect[PlayerIndex] = CheckPlayerSelect(PlayerIndex, -1);
                                   }
                                   asm_BlinkCheck = 0;
                                   break;
                              }
                              case BTN_DRIGHT:
                              {
                                   if (CheckPlayerSelect(PlayerIndex,1) != -1)
                                   {
                                        playSound(0x49008001);
                                        PlayerCharacterSelect[PlayerIndex] = CheckPlayerSelect(PlayerIndex, 1);
                                   }   
                                   asm_BlinkCheck = 0;
                                   break;
                              }
                              case BTN_A:
                              {
                                   playSound(0x49008001);
                                   MenuProgress[PlayerIndex]++;  
                                   break;
                              }
                              case BTN_B:
                              {                              
                                   SetFadeOutB();
                                   *(int*)(long)&PlayerShowStats = 0;
                                   MenuBackup = 1;
                                   break;
                              }
                         }

                         break;  
                    }
                    case 1:
                    {
                         PlayerShowStats[PlayerIndex] = 0;
                         if (PlayerOK[PlayerIndex] != 1)
                         {
                              PlayerOK[PlayerIndex] = 1;
                              int SoundOffset = (0x10 * CharacterConvert[(int)PlayerCharacterSelect[PlayerIndex] + 1]);
                              playSound(0x2900800e + SoundOffset);  
                         }
                         
                         asm_DispOBSubPSelCursor1[PlayerIndex] = 0x800A00FC;

                              
                         if ((MenuButtonHeld[PlayerIndex] & BTN_B) == BTN_B)
                         {    
                              playSound(0x49008002);
                              MenuProgress[PlayerIndex]--;
                         }
                         break;
                    }
               }
                          
          }          
     }
          
     GlobalBoolA = true;
     for (int ThisController = 0; ThisController < g_playerCount; ThisController++)
     {
          if (PlayerOK[ThisController] == 0)
          {
               GlobalBoolA = false;
          }
     }
     if (GlobalBoolA)
     {
          if (menuScreenC !=2)
          {
               menuScreenC = 2;
          }
          else
          {
               if ((MenuButtonHeld[PlayerIndex] & BTN_A) == BTN_A)
               {
                    playSound(0x49008000);
                    SetFadeOut(30);
               }
          }
     }


     if ((menuScreenC == 2) && ((MenuButtonHeld[PlayerIndex] & BTN_B) == BTN_B))
     {
          menuScreenC = 0;
          for (int ThisController = 0; ThisController < g_playerCount; ThisController++)
          {
               PlayerOK[ThisController] = 0;
               if (StatsMode == 2)
               {
                    MenuProgress[ThisController] = 1;
               }
               else
               {
                    MenuProgress[ThisController] = 0;
               }
          }
          asm_DispOBSubPSelCursor1[0] = 0x800A08C8;
          asm_DispOBSubPSelCursor1[1] = 0x800A08C8;
          asm_DispOBSubPSelCursor1[2] = 0x800A08C8;
          asm_DispOBSubPSelCursor1[3] = 0x800A08C8;
     }
     
     for (int CurrentHUD = 0; CurrentHUD < 32; CurrentHUD++)
     {
          if ((GlobalMenuHUD[CurrentHUD].kind >= KO_PSEL_MA) && (GlobalMenuHUD[CurrentHUD].kind <= KO_PSEL_KU))
          {
               GlobalMenuHUD[CurrentHUD].pattern = 4;               
          }
     }
}

void PlayerSelectMenuAfter()
{
     for (int ThisController = 0; ThisController < g_playerCount; ThisController++)
     {
          asm_DispOBSubPSelCursor1[ThisController] = 0x800A08C8;
          g_CharacterSelections[ThisController] = CharacterConvert[(int)PlayerCharacterSelect[ThisController] + 1];
          PlayerCharacterSelect[ThisController] = ThisController;
          MenuProgress[ThisController] = 0;
     }
}


void PlayerSelectMenuBefore()
{

     GlobalIntA = 160 - ((g_playerCount * 64 + ((g_playerCount - 1) * 6)) / 2);
     for (int ThisPlayer = 0; ThisPlayer < g_playerCount; ThisPlayer++)
     {
          PlayerSelectPositions[ThisPlayer].x = GlobalIntA;
          GlobalIntA += 70;
     }
     MenuBackup = 0;
     for (int ThisController = 0; ThisController < g_playerCount; ThisController++)
     {						
          PlayerCharacterSelect[ThisController] = ThisController;
          asm_DispOBSubPSelCursor1[ThisController] = 0x800A08C8;
     }
}
void MapSelectMenu(short PlayerIndex)
{
     
    
     if ((menuScreenA == 3) && (GlobalController[4]->ButtonPressed == BTN_A))
     {
          if (HotSwapID > 0)
          {
               hsTableSet();
          }
     }

     if (g_gameMode == GAMEMODE_BATTLE)
     {
          GlobalShortA = 4;
     }
     else
     {
          GlobalShortA = 1;
     }

     if (ROptionPressed != 0)
     {    
          if (ROptionPressed + 2 <= GlobalFrameCount)
          {
               ROptionPressed = 0;                 
               KBGNumber = 6;
               KBGNumberNext = 6;
               KBGChange = 1;
               SetFadeOutTaData();
          }
     }
     if ((GlobalController[PlayerIndex]->ButtonPressed & BTN_R) == BTN_R)
     {
          playSound(0x49009010);   
          ROptionPressed = GlobalFrameCount;
     }

     if (menuScreenA == GlobalShortA)
     {
          if ((GlobalController[PlayerIndex]->ButtonPressed & BTN_CLEFT) == BTN_CLEFT)
          {
               swapHS(0);
          }
          else if ((GlobalController[PlayerIndex]->ButtonPressed & BTN_CRIGHT) == BTN_CRIGHT)
          {
               if (HotSwapID < SetLimit)
               {
                    swapHS(1);
               }
               
          }
          LoadCustomHeader(courseValue + gpCourseIndex);
     }

     *(int*)(&PlayerOK) = 0;
     if (HotSwapID > 0)
     {
          courseValue = -1;
          gpCourseIndex = 0;
          switch(g_gameMode)
          {
               //GRAND PRIX

               case 0:
               {
                    courseValue = (g_cupSelect * 4);                    
                    break;
               }
               case 1:
               case 2:
               case 3:
               {
                    courseValue = (g_cupSelect * 4) + g_courseSelect;
                    break;
               }
          }
     }
     else
     {
          LoadCustomHeader(-1);
     }
     
}



char GameMenuIndex = 0;
#define PSMode 0
#define GSMode 1
#define CCMode 2
void DrawGameSelect()
{
     
     DrawBox(65,18,190,25,0,0,0,175);
     PrintBigText(90,16, 1.0f,"GAME SETUP");
     
     if (ROptionPressed > 0)
     {
          KWTexture2DRGBA(70, 200, 0, 1.0f, (uchar*)MenuIconsRAM + 0x1000, (void*)&V64x32, 64, 32, 64, 32);
     }
     else
     {
          KWTexture2DRGBA(70, 200, 0, 1.0f, (uchar*)MenuIconsRAM, (void*)&V64x32, 64, 32, 64, 32);
     }
     

     #ifndef CFLG_LapCounter



          //Player Count
          //Game Mode
          //CC Mode


          DrawBox(25,70,130,28,0,0,0,175);
          DrawBox(25,105,130,28,0,0,0,175);
          DrawBox(25,140,130,28,0,0,0,175);

          PrintBigText(38, 75, 0.6f, "Player Count");
          PrintBigText(53, 110, 0.6f, "Game Mode");
          PrintBigText(38, 145, 0.6f, "Engine Speed");
          

          
          DrawBox(160,50,140,130,0,0,0,175);


          
          //Draw MenuIcon
          switch (GameMenuIndex)
          {
               case PSMode:
               {
                    //Player Select Controller Icons
                    GlobalAddressA  = (MenuIconsRAM + MenuGFX_Controller_Offset);         
                    break;
               }
          }

          switch (g_playerCount)
          {
               case 1:
               {
                    KWTexture2DRGBA32PT(230,110,0,1.0,(uchar*)GlobalAddressA,(void*)(&V6432B),64,64,64,16);                         
                    break;
               }
               case 2:
               {
                    KWTexture2DRGBA32PT(215,110,0,1.0,(uchar*)GlobalAddressA,(void*)(&V6432B),64,64,64,16);
                    KWTexture2DRGBA32PT(245,110,0,1.0,(uchar*)GlobalAddressA,(void*)(&V6432B),64,64,64,16);
                    break;
               }
               case 3:
               {
                    
                    KWTexture2DRGBA32PT(215,90,0,1.0,(uchar*)GlobalAddressA,(void*)(&V6432B),64,64,64,16);
                    KWTexture2DRGBA32PT(245,90,0,1.0,(uchar*)GlobalAddressA,(void*)(&V6432B),64,64,64,16);
                    KWTexture2DRGBA32PT(230,130,0,1.0,(uchar*)GlobalAddressA,(void*)(&V6432B),64,64,64,16);
                    break;
               }
               case 4:
               {
                    KWTexture2DRGBA32PT(215,90,0,1.0,(uchar*)GlobalAddressA,(void*)(&V6432B),64,64,64,16);
                    KWTexture2DRGBA32PT(245,90,0,1.0,(uchar*)GlobalAddressA,(void*)(&V6432B),64,64,64,16);
                    KWTexture2DRGBA32PT(215,130,0,1.0,(uchar*)GlobalAddressA,(void*)(&V6432B),64,64,64,16);
                    KWTexture2DRGBA32PT(245,130,0,1.0,(uchar*)GlobalAddressA,(void*)(&V6432B),64,64,64,16);
                    break;
               }
          }
     #endif     

     
}
void DrawMapSelect()
{
     DrawBox(65,18,190,25,0,0,0,175);
     if (HotSwapID == 0)
     {
          PrintBigText(80,16, 0.9f,"Original Set");
     }
     else if (HotSwapID < 10)
     {
          PrintBigTextNumberNoGap(80,16, 0.9f,"Custom Set ",HotSwapID);
     }
     else
     {
          PrintBigTextNumberNoGap(80,16, 0.9f,"Custom Set",HotSwapID);
     }
     
     if (ROptionPressed > 0)
     {
          KWTexture2DRGBA(70, 200, 0, 1.0f, (uchar*)MenuIconsRAM + 0x1000, (void*)&V64x32, 64, 32, 64, 32);
     }
     else
     {
          KWTexture2DRGBA(70, 200, 0, 1.0f, (uchar*)MenuIconsRAM, (void*)&V64x32, 64, 32, 64, 32);
     }
     SpriteBtnCLeft(45,35,1.0,false);
     SpriteBtnCRight(279,35,1.0,false);
     
}
void DrawPlayerSelect(short StatsMode)
{
     
     DrawBox(65,18,190,25,0,0,0,175);
     PrintBigText(75,16, 0.9f,"Player Select");
     
     
     
     

     #ifndef CFLG_PlayerSelect


          for (int CurrentPlayer = 0; CurrentPlayer < g_playerCount; CurrentPlayer++)
          {	
               
                              
               //Set Portraits and Banner for Character Selected
               for (int ThisPortrait = 0; ThisPortrait < 8; ThisPortrait++)
               {
                    SelectPortraitTable[ThisPortrait].TextureOffset[CurrentPlayer] = BackupPortraitTable[ThisPortrait].TextureOffset[(int)PlayerCharacterSelect[CurrentPlayer]];
               }
               SelectNamePlateTable.TextureOffset[CurrentPlayer] = BackupNamePlateTable.TextureOffset[(int)PlayerCharacterSelect[CurrentPlayer]];	
               //

               
               jtbl_DispObjPsel[CurrentPlayer] = 0x800A01BC;
               
               //printStringNumber(5,5,"",(int)(GlobalStat.PowerDownRT[(int)CharacterConvert[(int)PlayerCharacterSelect[CurrentPlayer] +1]][7] * 1000));
               //printStringUnsignedHex(5,15,"",(int)(&GlobalStat.PowerDownRT[0][0]));
               if (PlayerShowStats[CurrentPlayer])
               {
                    //printStringNumber(5,5,"PlayerSelect",GlobalIntC);
                    GlobalIntA = PlayerSelectPositions[CurrentPlayer].x ;
                    GlobalIntB = PlayerSelectPositions[CurrentPlayer].y +76;
                    
                    if ((MenuProgress[CurrentPlayer] == 1) && (StatsMode == 2))
                    {
                         if (MenuFlash[CurrentPlayer] > 255)
                         {
                              MenuFlash[CurrentPlayer] = 0;
                         }
                         else
                         {
                              MenuFlash[CurrentPlayer]+=10;
                         }		
                         GraphPtr = FillRect1ColorF(GraphPtr,GlobalIntA - 1,GlobalIntB - 1,GlobalIntA + 66,GlobalIntB + 71,(int)MenuFlash[CurrentPlayer],(int)MenuFlash[CurrentPlayer],(int)MenuFlash[CurrentPlayer],255);	
                                   
                    }
                    GraphPtr = FillRect1ColorF(GraphPtr,GlobalIntA,GlobalIntB,GlobalIntA + 64,GlobalIntB + 69,0,0,0,255);	
                    
                    
                    
                    GlobalIntA = PlayerSelectPositions[CurrentPlayer].x + 3;
                    for (int ThisBox = 0; ThisBox < 6; ThisBox++)
                    {
                         
                         GlobalIntB = PlayerSelectPositions[CurrentPlayer].y + 88;
                         GraphPtr = FillRect1ColorF(GraphPtr,GlobalIntA,GlobalIntB,GlobalIntA + 8,GlobalIntB + 4,255,255,255,255);
                         GlobalIntB +=17;
                         GraphPtr = FillRect1ColorF(GraphPtr,GlobalIntA,GlobalIntB,GlobalIntA + 8,GlobalIntB + 4,255,255,255,255);
                         GlobalIntB +=17;
                         GraphPtr = FillRect1ColorF(GraphPtr,GlobalIntA,GlobalIntB,GlobalIntA + 8,GlobalIntB + 4,255,255,255,255);
                         GlobalIntB +=17;
                         GraphPtr = FillRect1ColorF(GraphPtr,GlobalIntA,GlobalIntB,GlobalIntA + 8,GlobalIntB + 4,255,255,255,255);
                         GlobalIntA += 10;
                    }
                    
                    

                    
                    
                    GlobalIntA = PlayerSelectPositions[CurrentPlayer].x + 3;
                    GlobalIntB = PlayerSelectPositions[CurrentPlayer].y +76;

                    GlobalIntB +=12;
                    if (StatsMode != 2)
                    {
                         GlobalIntC = 58 - (58 * 8 * (1 - (GlobalStat.AccelerationCount[g_raceClass][(int)CharacterConvert[(int)PlayerCharacterSelect[CurrentPlayer] + 1]] / GlobalStat.AccelerationCount[g_raceClass][6])));
                         
                         GraphPtr = FillRect1ColorF(GraphPtr,GlobalIntA,GlobalIntB + 1,GlobalIntA + GlobalIntC,GlobalIntB + 3,255,0,0,255);
                         GlobalIntB +=17;
                         GlobalIntC = 58 + (58 * (1 - (GlobalStat.PowerDownRT[(int)CharacterConvert[(int)PlayerCharacterSelect[CurrentPlayer] +1]][7] / GlobalStat.PowerDownRT[6][7])));
                         
                         GraphPtr = FillRect1ColorF(GraphPtr,GlobalIntA,GlobalIntB + 1,GlobalIntA + GlobalIntC,GlobalIntB + 3,0,255,0,255);
                         GlobalIntB +=17;
                         GlobalIntC = 58 * (GlobalStat.PowerBandAcceleration[(int)CharacterConvert[(int)PlayerCharacterSelect[CurrentPlayer] + 1]] / GlobalStat.PowerBandAcceleration[6]);
                         
                         GraphPtr = FillRect1ColorF(GraphPtr,GlobalIntA,GlobalIntB + 1,GlobalIntA + GlobalIntC,GlobalIntB + 3,0,0,255,255);
                         GlobalIntB +=17;
                         GlobalIntC = 58 + (58 * (1 - (GlobalStat.ProOffsetAngle[(int)CharacterConvert[(int)PlayerCharacterSelect[CurrentPlayer] + 1]] / GlobalStat.ProOffsetAngle[7])));
                         
                         GraphPtr = FillRect1ColorF(GraphPtr,GlobalIntA,GlobalIntB + 1,GlobalIntA + GlobalIntC,GlobalIntB + 3,255,0,0,255);
                    }
                    else
                    {
                         GlobalIntC = 58 - (58 * 8 * (1 - (GlobalStat.AccelerationCount[g_raceClass][(int)CharacterConvert[(int)PlayerCharacterSelect[CurrentPlayer] + 1]] / (float)(EngineSpeed[g_raceClass][2]))));
                         
                         GraphPtr = FillRect1ColorF(GraphPtr,GlobalIntA,GlobalIntB + 1,GlobalIntA + GlobalIntC,GlobalIntB + 3,255,0,0,255);
                         GlobalIntB +=17;
                         GlobalIntC = 58 + (58 * (1 - (GlobalStat.PowerDownRT[(int)CharacterConvert[(int)PlayerCharacterSelect[CurrentPlayer] +1]][7] /((float)EnginePowerDownRT[1][7] / 100))));
                         
                         GraphPtr = FillRect1ColorF(GraphPtr,GlobalIntA,GlobalIntB + 1,GlobalIntA + GlobalIntC,GlobalIntB + 3,0,255,0,255);
                         GlobalIntB +=17;
                         GlobalIntC = 29 + (29 * (GlobalStat.PowerBandAcceleration[(int)CharacterConvert[(int)PlayerCharacterSelect[CurrentPlayer] + 1]] /((float)PowerBand[1] / 10)));
                         
                         GraphPtr = FillRect1ColorF(GraphPtr,GlobalIntA,GlobalIntB + 1,GlobalIntA + GlobalIntC,GlobalIntB + 3,0,0,255,255);
                         GlobalIntB +=17;
                         GlobalIntC = 58 + (58 * (1 - (GlobalStat.ProOffsetAngle[(int)CharacterConvert[(int)PlayerCharacterSelect[CurrentPlayer] + 1]] /((float)SteerAngle[2] / 100))));
                         
                         GraphPtr = FillRect1ColorF(GraphPtr,GlobalIntA,GlobalIntB + 1,GlobalIntA + GlobalIntC,GlobalIntB + 3,255,0,0,255);					
                    }


                    
                    GlobalIntA = PlayerSelectPositions[CurrentPlayer].x;
                    GlobalIntB = PlayerSelectPositions[CurrentPlayer].y +76;

                    GlobalIntB -= 18;
                    GlobalIntA -= 16;
                    LoadFontF3D((uint)(&RedPaletteF3D));
                    printString(GlobalIntA,GlobalIntB,"Speed");
                    
                    GlobalIntB +=17;
                    LoadFontF3D((uint)(&GreenPaletteF3D));
                    printString(GlobalIntA,GlobalIntB,"Grip");
                    
                    GlobalIntB +=17;
                    LoadFontF3D((uint)(&BluePaletteF3D));
                    printString(GlobalIntA,GlobalIntB,"Boost");
                    
                    GlobalIntB +=17;               
                    LoadFontF3D((uint)(&RedPaletteF3D));
                    printString(GlobalIntA,GlobalIntB,"Steer");
                    
               }	
          }
     #endif
     
}



void GameSelectMenu(short PlayerIndex)
{
     CheckMenuButton(PlayerIndex);

     switch (MenuButtonHeld[PlayerIndex])
     {
          case BTN_DUP:
          {
               if (GameMenuIndex > 0)
               {
                    GameMenuIndex++;
                    playSound(0x49008000);
               }
               else
               {
                    playSound(0x49008002);
               }
          }
          case BTN_DDOWN:
          {
               if (GameMenuIndex < 2)
               {
                    GameMenuIndex++;
                    playSound(0x49008000);
               }
               else
               {
                    playSound(0x49008002);
               }
          }
     }
     switch (GameMenuIndex)
     {
          case PSMode:
          {
               //PlayerSelect
               switch (MenuButtonHeld[PlayerIndex])
               {
                    case BTN_DLEFT:
                    {
                         if (g_playerCount > 1)
                         {
                              g_playerCount--;
                              playSound(0x49008000);
                         }
                         else
                         {
                              playSound(0x49008002);
                         }
                         
                         break;
                    }
                    case BTN_DRIGHT:
                    {
                         if (g_playerCount < 4)
                         {
                              g_playerCount++;
                         }
                         playSound(0x49008000);
                         break;
                    }
               }
          }
     }
     return;
}



void PlayerSelectSwitch(OSContPad *pad,u16 i, u16 newbutton)
{
     if ((GlobalController[i]->ButtonPressed & BTN_R) == BTN_R)
     {
          MenuToggle = !MenuToggle;
     }     
     if (MenuToggle)
     {
		GameOptionsHandler(i);
     }
     else
     {
          PlayerSelectMenu(SaveGame.GameSettings.StatsMode, i);
     }
}

void MapSelectSwitch(OSContPad *pad,u16 i, u16 newbutton)
{
     
     MapSelectMenu(i);
     MSelController(pad,i,newbutton);
     
     
}

void GameSelectSwitch(OSContPad *pad,u16 i, u16 newbutton)
{
     if (ROptionPressed != 0)
     {    
          if (ROptionPressed + 2 <= GlobalFrameCount)
          {
               ROptionPressed = 0;                 
               KBGNumber = 6;
               KBGNumberNext = 6;
               KBGChange = 1;
               SetFadeOutTaData();
          }
     }
     if ((GlobalController[i]->ButtonPressed & BTN_R) == BTN_R)
     {
          playSound(0x49009010);   
          ROptionPressed = GlobalFrameCount;
     }
     else
     {
          //GameSelectMenu(i);
          GSelController(pad, i, newbutton);

     }
     
}

void DataMenuController(OSContPad *pad, u16 i, u16 NewButton)
{
     ROptionPressed = 0;
     if ((GlobalController[i]->ButtonPressed & BTN_B) == BTN_B)
     {
          KBGNumber = LastMenuID;
          KBGNumberNext = LastMenuID;
          KBGChange = 1;
          SetFadeOutB();
     }
}
int TitleSwitch;
void TitleMenuSwitch(OSContPad *pad,u16 i, u16 newbutton)
{
     
     if (SaveGame.Initial == 0)
     {
          if 
          ( 
               ((BTN_DLEFT == (GlobalController[i]->ButtonPressed & BTN_DLEFT)) || (BTN_DRIGHT == (GlobalController[i]->ButtonPressed & BTN_DRIGHT))) ||
               ((BTN_DLEFT == (GlobalController[i]->AnalogPressed & BTN_DLEFT)) || (BTN_DRIGHT == (GlobalController[i]->AnalogPressed & BTN_DRIGHT)))
          )
          {
               if (TitleSwitch == 0)
               {
                    if (SaveGame.RenderSettings.CullMode == 1)
                    {
                         SaveGame.RenderSettings.CullMode = 0;
                    }
                    else
                    {
                         SaveGame.RenderSettings.CullMode = 1;
                    }
               }
               else
               {
                    if (SaveGame.RenderSettings.Platform == 1)
                    {
                         SaveGame.RenderSettings.Platform = 0;
                    }
                    else
                    {
                         SaveGame.RenderSettings.Platform = 1;
                    }
               }
          }
          if 
          ( 
               ((BTN_DDOWN == (GlobalController[i]->ButtonPressed & BTN_DDOWN)) || (BTN_DUP == (GlobalController[i]->ButtonPressed & BTN_DUP))) ||
               ((BTN_DDOWN == (GlobalController[i]->AnalogPressed & BTN_DDOWN)) || (BTN_DUP == (GlobalController[i]->AnalogPressed & BTN_DUP)))
          )
          {
               
               if (TitleSwitch == 0)
               {
                    TitleSwitch = 1;
               }
               else
               {
                    TitleSwitch = 0;
               }
          }
     }
     
     
     TitleController(pad,i,newbutton);
     
};



void MiniMapDraw()
{    

     if (SaveGame.GameSettings.GameMode == 1)
     {
          int CoinCount = 0;
          for (int ThisObject = 0; ThisObject < 100; ThisObject++)
          {
               if (g_SimpleObjectArray[ThisObject].category == 47)
               {
                    
                    CoinCount++;
                    float fx = (float)(g_SimpleObjectArray[ThisObject].position[0]) * g_mapScale; //Scale object positions down to map size
                    float fz = (float)(g_SimpleObjectArray[ThisObject].position[2]) * g_mapScale;

                    //Player 1 Radar
                    short DrawX = g_mapX + *(short*)(0x8018D2F0) - (*(short*)(0x8018D2B0)/2) +  *(short*)(0x8018D2E0) + (short)fx;
                    short DrawY = g_mapY + *(short*)(0x8018D2F8) - (*(short*)(0x8018D2B8)/2) +  *(short*)(0x8018D2E8) + (short)fz;
                    //KWSprite(DrawX,DrawY,8,8,(ushort*)&RCIconMap);
                    //Player 2 Radar
                    //x = *(short*)(&g_mapX+0x1) + *(short*)(0x8018D2F0) - (*(short*)(0x8018D2B0)/2) +  *(short*)(0x8018D2E0) + (short)fx;
                    //y = *(short*)(&g_mapY+0x1) + *(short*)(0x8018D2F8) - (*(short*)(0x8018D2B8)/2) +  *(short*)(0x8018D2E8) + (short)fz;
                    KWSpriteScale(DrawX,DrawY,0.5,(ushort*)&RCIconMap,8,8);

                    if (CoinCount == 8)
                    {
                         break;
                    }
               }
               
          }
          
     }
     
     
     KWReturnViewport();
     KawanoDrawFinal();
}