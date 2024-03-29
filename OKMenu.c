#include "../Library/MainInclude.h"
#include "OKInclude.h"

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

          if (SaveGame.ModSettings.DetailMode == 1)
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
                         if (SaveGame.ModSettings.DetailMode == 1)
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
                         if (SaveGame.ModSettings.DetailMode == 1)
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
                         if (SaveGame.ModSettings.DetailMode == 1)
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
               if ((loop == 2) && (SaveGame.ModSettings.DetailMode == 2))
               {
                    printOffsetB = printOffsetB + 8;
               }
               printOffsetA = 48;

               if ((SaveGame.ModSettings.DetailMode == 1) | (loop == 3))
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
               if ((SaveGame.ModSettings.DetailMode == 1) | (loop == 3))
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
     
     if (SaveGame.ModSettings.PracticeMode == 0x01)
     {
          GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0] + 18, MenuPosition[1] + 18, MenuPosition[0] + (12 * 8) + 19, MenuPosition[1] + 28, 0, 0,0, 175);
          loadFont();

          printString(MenuPosition[0],MenuPosition[1], "Practice  ON");

     }     
     if (SaveGame.ModSettings.ItemMode > 0)
     {
          GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0] + 18, MenuPosition[1] + 18, MenuPosition[0] + (11 * 8) + 19, MenuPosition[1] + 28, 0, 0,0, 175);
          loadFont();

          printString(MenuPosition[0],MenuPosition[1], "Force Items");
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
     }
     else if ((SaveGame.GameSettings.StatsMode == 1) && ((SaveGame.GameSettings.GameMode != 1) || (HotSwapID == 0)) )
     {
          GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0] + 18, MenuPosition[1] + 18, MenuPosition[0] + (11 * 8) + 19, MenuPosition[1] + 28, 0, 0,0, 175);
          loadFont();
          printString(MenuPosition[0],MenuPosition[1], "Force Stats");
     }



}


void swapParameter(int directionIndex)
{
     
     //if directionIndex == 0, swap down;
     //if directionIndex == 1, swap up;
     if (directionIndex == 0)
     {
          switch(MenuType)  //CurrentPage
          {
               case 0:
               {
                    if (gameMode[MenuIndex-1 + GlobalCharC] > 0) //currentParameter  //menuOverflowIndex
                    {
                         gameMode[MenuIndex-1 + GlobalCharC]--;
                    }
                    break;
               }
               case 1:
               {
                    if (modMode[MenuIndex-1 + GlobalCharC] > 0) //currentParameter  //menuOverflowIndex
                    {
                         modMode[MenuIndex-1 + GlobalCharC]--;
                    }
                    break;
               }
               case 2:
               {
                    if (renderMode[MenuIndex-1 + GlobalCharC] > 0) //currentParameter  //menuOverflowIndex
                    {
                         renderMode[MenuIndex-1 + GlobalCharC]--;
                    }
                    break;
               }
               case 3:
               {
                    if (MenuIndex == 1) //currentParameter
                    {
                         if (MenuCup > 0)  //cupSelect
                         {
                              MenuCup--;
                         }
                    }
                    if (MenuIndex > 1) //currentParameter
                    {
                         if (SYSTEM_Region == 0x00)
                         {
                              GlobalAddressA = (cup_PAL + (MenuCup * 8) + ((MenuIndex - 2) * 2));
                         }
                         else
                         {
                              GlobalAddressA = (cup_NTSC + (MenuCup * 8) + ((MenuIndex - 2) * 2));
                         }
                         short *l_courseID = (short *)GlobalAddressA;
                         if (*l_courseID > 0)
                         {
                              *l_courseID = *l_courseID - 1;
                              copyCourseTable(1);
                         }
                    }
                    break;
               }
               default:
               {
                    break;
               }


          }


     }
     else
     {
          switch(MenuType)  //CurrentPage
          {
               case 0:
               {
                    if (gameMode[MenuIndex-1 + GlobalCharC] < gameLimits[MenuIndex-1 + GlobalCharC]) //currentParameter  //menuOverflowIndex
                    {
                         gameMode[MenuIndex-1 + GlobalCharC]++;
                    }
                    break;
               }
               case 1:
               {
                    if (modMode[MenuIndex-1 + GlobalCharC] < modLimits[MenuIndex-1 + GlobalCharC]) //currentParameter  //menuOverflowIndex
                    {
                         modMode[MenuIndex-1 + GlobalCharC]++;
                    }
                    break;
               }
               case 2:
               {
                    if (renderMode[MenuIndex-1 + GlobalCharC] < renderLimits[MenuIndex-1 + GlobalCharC]) //currentParameter  //menuOverflowIndex
                    {
                         renderMode[MenuIndex-1 + GlobalCharC]++;
                    }
                    break;
               }
               case 3:
               {
                    if (MenuIndex == 1) //currentParameter
                    {
                         if (MenuCup < 3)  //cupSelect
                         {
                              MenuCup++;
                         }
                    }
                    if (MenuIndex > 1) //currentParameter
                    {
                         if (SYSTEM_Region == 0x00)
                         {
                              GlobalAddressA = (cup_PAL + (MenuCup * 8) + ((MenuIndex - 2) * 2));
                         }
                         else
                         {
                              GlobalAddressA = (cup_NTSC + (MenuCup * 8) + ((MenuIndex - 2) * 2));
                         }

                         short *l_courseID = (short *)GlobalAddressA;

                         if (*l_courseID < 19)
                         {
                              *l_courseID = *l_courseID + 1;
                              copyCourseTable(1);
                         }
                    }
                    break;
               }
               default:
               {
                    break;
               }
          }
     }


}


void OptionsMenu()
{

     

     
     DrawBox(50,10,220,116,0,0,0,175);
     
     DrawBox(48,8,2,119,255,0,0,255);
     DrawBox(270,8,2,119,255,0,0,255);
     DrawBox(50,8,220,2,255,0,0,255);
     DrawBox(50,125,220,2,255,0,0,255);
     DrawBox(60,32,200,1,0,0,0,255);


     if (MenuType == 3)   //CurrentPage
     {
          if (MenuIndex == 0) //currentParameter
          {
               MenuPosition[0] = 157 - ((menuChar[MenuType]) * 4);
               GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0], 19, MenuPosition[0] + (menuChar[MenuType] * 8), 29, 200, 0, 0, 200);
          }
          else if (MenuIndex == 1) //currentParameter
          {
               MenuPosition[0] = 155 - ((cupChar[MenuCup]) * 4);
               GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0], 41, MenuPosition[0] + (cupChar[MenuCup] * 8), 51, 0, 200, 0, 200);
          }
          else
          {
               if (SYSTEM_Region == 0x00)
               {
                    GlobalAddressA = (cup_PAL + (MenuCup * 8) + ((MenuIndex - 2) * 2));
               }
               else
               {
                    GlobalAddressA = (cup_NTSC + (MenuCup * 8) + ((MenuIndex - 2) * 2));
               }
               short *l_courseID = (short *)GlobalAddressA;
               MenuPosition[0] = 157 - ((courseChar[(long)*l_courseID]) * 4);
               MenuPosition[1] = ((MenuIndex - 1) * 14) + 44;
               GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0], MenuPosition[1], MenuPosition[0] + (courseChar[(long)*l_courseID] * 8), MenuPosition[1]+11, 0, 0, 200, 200);
          }
     }
     else
     {
          if (MenuIndex == 0) //currentParameter
          {
               MenuPosition[0] = 157 - ((menuChar[MenuType]) * 4);
               GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0], 19, MenuPosition[0] + (menuChar[MenuType] * 8), 29, 200, 0, 0, 200);
          }
          else
          {
               MenuPosition[1] = MenuIndex * 18 + 33;
              if (MenuBlink < 29)  
               {
                    KWSprite(57,MenuPosition[1]+2,16,16,(ushort*)&lit_red_selecter);
               }
          }
     }
     

     LoopValue = 0;
     MenuPosition[0] = 138 - (menuChar[MenuType] * 4);
     
     
     
     loadFont();
     
     
     printString(MenuPosition[0],0,menuNames[MenuType]);
     
     MenuPosition[1] = 30;
     
     
     
     switch(MenuType)    //CurrentPage
     {
          case 0:
          {
               do{
                    
                    printString(45,MenuPosition[1],gameOptions[LoopValue + (long)GlobalCharC]);
                    MenuPosition[0] = 200 - (gameChar[LoopValue+ (long)GlobalCharC][(long)gameMode[LoopValue + (long)GlobalCharC]] * 4);
                    printString(MenuPosition[0],MenuPosition[1],gameParameters[LoopValue+ (long)GlobalCharC][(long)gameMode[LoopValue + (long)GlobalCharC]]);
                    MenuPosition[1] = MenuPosition[1] + 18;
                    LoopValue++;
               } while (LoopValue < 4);
               break;
          }
          case 1:
          {
               do{
                    printString(45,MenuPosition[1],modOptions[LoopValue + (long)GlobalCharC]);
                    MenuPosition[0] = 200 - (modChar[LoopValue + (long)GlobalCharC][(long)modMode[LoopValue + (long)GlobalCharC]] * 4);
                    printString(MenuPosition[0],MenuPosition[1],modParameters[LoopValue + (long)GlobalCharC][(long)modMode[LoopValue + (long)GlobalCharC]]);
                    MenuPosition[1] = MenuPosition[1] + 18;
                    LoopValue++;
               } while (LoopValue < 4);
               break;
          }
          case 2:
          {
               do{
                    printString(45,MenuPosition[1],renderOptions[LoopValue + (long)GlobalCharC]);
                    MenuPosition[0] = 200 - (renderChar[LoopValue + (long)GlobalCharC][(long)renderMode[LoopValue + (long)GlobalCharC]] * 4);
                    printString(MenuPosition[0],MenuPosition[1],renderParameters[LoopValue + (long)GlobalCharC][(long)renderMode[LoopValue + (long)GlobalCharC]]);
                    MenuPosition[1] = MenuPosition[1] + 18;
                    LoopValue++;
               } while (LoopValue < 4);
               break;
          }
          case 3:
          {
               MenuPosition[0] = 135 - (cupChar[MenuCup] * 4);
               printString(MenuPosition[0],22,cupNames[MenuCup]);
               MenuPosition[1] = 40;
               do{
                    if (SYSTEM_Region == 0x00)
                    {
                         GlobalAddressA = (cup_PAL + (MenuCup * 8) + LoopValue * 2);
                    }
                    else
                    {
                         GlobalAddressA = (cup_NTSC + (MenuCup * 8) + LoopValue * 2);
                    }
                    short *l_courseID = (short *)GlobalAddressA;
                    MenuPosition[0] = 138 - (courseChar[(long)*l_courseID] * 4);
                    printString(MenuPosition[0],MenuPosition[1],courseNames[(long)*l_courseID]);
                    MenuPosition[1] = MenuPosition[1] + 14;
                    LoopValue++;
               } while (LoopValue < 4);
               break;
          }
          default:
          {
               break;
          }
          
     }


     
     






     
     if (MenuType != 3)    //CurrentPage
     {
          if (pageLimit[MenuType] > 4)
          {
               if (GlobalCharC == 0)  //menuOverflowIndex
               {
                    if (MenuBlink < 15)  //used for blinking down arrow
                    {
                         KWSprite(161,117,16,16,(ushort*)&lit_arrowsprite_d);
                    }
               }
               else
               {
                    if (MenuBlink < 15)  //used for blinking up arrow
                    {
                         KWSprite(161,40,16,16,(ushort*)&lit_arrowsprite_u);
                    }
               }
          }
          if (pageLimit[MenuType] > 5)
          {

               if (GlobalCharC == 1)  //menuOverflowIndex
               {
                    if (MenuBlink < 15)  //used for blinking down arrow
                    {
                         KWSprite(161,117,16,16,(ushort*)&lit_arrowsprite_d);
                    }
               }          
          }
     }
     if (MenuType > 0)  //used for left arrow
     {
          KWSprite(80,22,16,16,(ushort*)&lit_arrowsprite_l);
     }
     if (MenuType < 3)  //used for right arrow
     {
          KWSprite(240,22,16,16,(ushort*)&lit_arrowsprite_r);
     }

     
     

     

}



void RunOptionsMenu()
{

     if (ButtonHolding == true)
     {
          MenuButtonHeld = 0;
          ButtonTimer = ButtonTimer + 1;  //Button Held Timer          
          if (ButtonTimer >= 9)
          {    
               ButtonHolding = 0;
               ButtonTimer = 0;  //Button Held Timer               
          }
     }
     else
     {
          if (GlobalController[4]->ButtonHeld > 0)
          {
               MenuButtonHeld = GlobalController[4]->ButtonHeld;
               
          }
          else if (GlobalController[4]->AnalogHeld > 0)
          {
               MenuButtonHeld = GlobalController[4]->AnalogHeld;
               
          }
          else
          {          
               ButtonHolding = false;
               ButtonTimer = 0;  //Button Held Timer
          }
     }

     

          
          //MenuButtonHeld is set to 0x01 when a button is held down.
     if(ButtonHolding == false)
     {
          
          // Uses the Control Stick or Dpad to switch through the menu.
          switch(MenuButtonHeld)
          {
               //Increase the current menu Parameter by 1
               case BTN_DRIGHT :
               {
                    ButtonHolding = true;
                    if (MenuIndex > 0) //currentParameter
                    {
                         swapParameter(1);
                         playSound(0x49008000);
                    }
                    else
                    {
                         if (MenuType < 3)
                         {
                              MenuType++;
                              GlobalCharC = 0;
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
                    ButtonHolding = true;
                    if (MenuIndex > 0) //currentParameter
                    {
                         swapParameter(0);
                         playSound(0x49008000);
                    }
                    else
                    {
                         if (MenuType > 0)
                         {
                              MenuType--;
                              GlobalCharC = 0;
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
                    ButtonHolding = true;
                    if (MenuIndex + GlobalCharC < pageLimit[MenuType]) //currentParameter
                    {
                         if ((MenuIndex == 4) && (MenuType < 3))
                         {
                              GlobalCharC++;
                         }
                         else
                         {
                              MenuIndex++; //currentParameter
                         }
                         playSound(0x4900801C);
                    }
                    break;

                    //
               }
               //Move backward to previous option
               case BTN_DUP :
               {
                    ButtonHolding = true;
                    if (MenuIndex + GlobalCharC > 0) //currentParameter
                    {
                         if ((MenuIndex == 1) && (MenuType < 3) && (GlobalCharC > 0))
                         {
                              GlobalCharC--;
                         }
                         else
                         {
                              MenuIndex--; //currentParameter
                         }
                         playSound(0x4900801C);
                    }
                    break;
               }


          }
          // End of menu Dpad code.


     }

     // Now print the menu using the menuFlag and parameterFlag options above.
     if ((SaveGame.GameSettings.StatsMode == 1) || (SaveGame.GameSettings.GameMode == 1))
     {
          checkStats(1);
     }
     else
     {
          checkStats(0);
     }

     OptionsMenu();
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

     if ((GlobalController[0]->ButtonPressed & BTN_R) == BTN_R)
     {
          MenuToggle = !MenuToggle;
     }
     g_mracewayTime = 0;
     
     #if OverKartBuild
          
          GlobalAddressA = 0x8018DABC;
          for (int Loop = 0; Loop < 4; Loop++)
          {
               *(uint*)(GlobalAddressA) = 0; 
               GlobalAddressA += 4;
          }
          GlobalUIntA = ((uint)(&ok_Storage)) + 0x5000;
          KWTexture2DRGBA32BL(64,64,0,1.0,(uchar*)(GlobalUIntA),(void*)(&V256x12832B),256,128,256,4);
          KWTexture2DRGBA32BL(256,64,0,1.0,(uchar*)(GlobalUIntA),(void*)(&V256x12832B),256,128,256,4);
          
          guPerspective(&gDynamicP->projection1,&PerspectiveValue, 45.0, 320/240, 100, 50000, 1.0f);
          gSPPerspNormalize(*graphPointer, PerspectiveValue);
          *graphPointer +=8;
          gSPMatrix(*graphPointer, K0_TO_PHYS((u32) &(gDynamicP->projection1)),G_MTX_PROJECTION|G_MTX_LOAD|G_MTX_NOPUSH);
          *graphPointer +=8;
          GULookAt(&gDynamicP->viewing,
               0, 0,0,
               0, 0,100,
               0,1,0);
          gSPMatrix(*graphPointer, K0_TO_PHYS((u32) &(gDynamicP->viewing)),G_MTX_PROJECTION|G_MTX_MUL|G_MTX_NOPUSH);
          LoadIdentAffineMtx(AffineMatrix);
          SetMatrix(AffineMatrix,0);
          *graphPointer +=8;

          


          objectPosition[0] = 0;
          objectPosition[1] = 0;
          objectPosition[2] = -200;
          objectAngle[0] =0;
          objectAngle[1] = 0;
          objectAngle[2] = 0;
          DrawGeometryScale(objectPosition, objectAngle, 0x0A000000, 1.4);
          
          if (!CheckCheat())
          {
               if ((GlobalController[0]->ButtonHeld & BTN_L) != BTN_L)
               {
                    MenuAngle[0]++;
                    
                    if (MenuAngle[1] > 119)
                    {
                         MenuAngle[1] = 0;
                    }
                    else
                    {
                         MenuAngle[1]++;
                    }

                    if (MenuAngle[1] < 60)
                    {
                         MenuAngle[2]++;
                    }
                    else
                    {
                         MenuAngle[2]--;
                    }
                    if (MenuAngle[1] < 60)
                    {
                         MenuAngle[3]--;
                    }
                    else
                    {
                         MenuAngle[3]++;
                    }
                    
                    g_mpressstartID = 0;
                    g_mflagID = 0;
                    g_NintendoLogoOffset = 0x0A000008;

                    if (MenuToggle)
                    {
                         RunOptionsMenu();
                    }

                    if (!MenuToggle)
                    {               
                         objectPosition[0] = 0;
                         objectPosition[1] = 20;
                         objectPosition[2] = -120;
                    }
                    else
                    {

                         objectPosition[0] = 0;
                         objectPosition[1] = -20;
                         objectPosition[2] = -120;
                    }

                    gSPDisplayList(*graphPointer, 0x0D0076F8)
                    

                    *graphPointer +=8;

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
                         objectPosition[2] -= 50;
                    }
                    objectAngle[1] = 0;
                    objectAngle[2] = MenuAngle[0] * -1 * DEG1;
                    DrawGeometryScale(objectPosition, objectAngle, 0x0A000020, 0.3);
                    if (!MenuToggle)
                    {               
                         if (MenuBlink > 15)
                         {
                              KWSpriteDiv(160,180,(ushort*)(&ok_Storage),256,32,8);
                         }
                    }
               }
          }
     #else
          g_mpressstartID = 0;
          RunOptionsMenu();
     #endif
     // Reset the MenuButtonHeld timer. This is set to 0x01 when a button is held down.
     // Used for advancing menu when direction is held.

     
          


     

     

     /*
     loadFont();
     if (ConsolePlatform)
     {
          printString(24,190,"N64 ");
     }
     else
     {
          if (EmulatorPlatform)
          {               
               PROJECT64  ");               
          }
          else
          {
               printString(16,190,"MUPEN   ");
          }
     }
        

     printString(0,200,"BUILD 5.1   ");
     */
     




}