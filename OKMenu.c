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

          if (modMode[3] == 1)
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
                         if (modMode[3] == 1)
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
                         if (modMode[3] == 1)
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
                         if (modMode[3] == 1)
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
               if ((loop == 2) && (modMode[3] == 2))
               {
                    printOffsetB = printOffsetB + 8;
               }
               printOffsetA = 48;

               if ((modMode[3] == 1) | (loop == 3))
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
               if ((modMode[3] == 1) | (loop == 3))
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
     
     if (modMode[0] == 0x01)
     {
          GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0] + 18, MenuPosition[1] + 18, MenuPosition[0] + (12 * 8) + 19, MenuPosition[1] + 28, 0, 0,0, 175);
          loadFont();

          printString(MenuPosition[0],MenuPosition[1], "Practice  ON");

     }     
     if (modMode[4] > 0)
     {
          GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0] + 18, MenuPosition[1] + 18, MenuPosition[0] + (11 * 8) + 19, MenuPosition[1] + 28, 0, 0,0, 175);
          loadFont();

          printString(MenuPosition[0],MenuPosition[1], "Force Items");
     }
     else if (gameMode[6] > 0x00)
     {

          switch (gameMode[6])
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
     else if ((gameMode[1] == 1) & (gameMode[0] != 1))
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
          switch(MenuIntA)  //CurrentPage
          {
               case 0:
               {
                    if (gameMode[MenuIntB-1 + GlobalCharC] > 0) //currentParameter  //menuOverflowIndex
                    {
                         gameMode[MenuIntB-1 + GlobalCharC]--;
                    }
                    break;
               }
               case 1:
               {
                    if (modMode[MenuIntB-1 + GlobalCharC] > 0) //currentParameter  //menuOverflowIndex
                    {
                         modMode[MenuIntB-1 + GlobalCharC]--;
                    }
                    break;
               }
               case 2:
               {
                    if (renderMode[MenuIntB-1 + GlobalCharC] > 0) //currentParameter  //menuOverflowIndex
                    {
                         renderMode[MenuIntB-1 + GlobalCharC]--;
                    }
                    break;
               }
               case 3:
               {
                    if (MenuIntB == 1) //currentParameter
                    {
                         if (MenuIntC > 0)  //cupSelect
                         {
                              MenuIntC--;
                         }
                    }
                    if (MenuIntB > 1) //currentParameter
                    {
                         if (SYSTEM_Region == 0x00)
                         {
                              GlobalAddressA = (cup_PAL + (MenuIntC * 8) + ((MenuIntB - 2) * 2));
                         }
                         else
                         {
                              GlobalAddressA = (cup_NTSC + (MenuIntC * 8) + ((MenuIntB - 2) * 2));
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
          switch(MenuIntA)  //CurrentPage
          {
               case 0:
               {
                    if (gameMode[MenuIntB-1 + GlobalCharC] < gameLimits[MenuIntB-1 + GlobalCharC]) //currentParameter  //menuOverflowIndex
                    {
                         gameMode[MenuIntB-1 + GlobalCharC]++;
                    }
                    break;
               }
               case 1:
               {
                    if (modMode[MenuIntB-1 + GlobalCharC] < modLimits[MenuIntB-1 + GlobalCharC]) //currentParameter  //menuOverflowIndex
                    {
                         modMode[MenuIntB-1 + GlobalCharC]++;
                    }
                    break;
               }
               case 2:
               {
                    if (renderMode[MenuIntB-1 + GlobalCharC] < renderLimits[MenuIntB-1 + GlobalCharC]) //currentParameter  //menuOverflowIndex
                    {
                         renderMode[MenuIntB-1 + GlobalCharC]++;
                    }
                    break;
               }
               case 3:
               {
                    if (MenuIntB == 1) //currentParameter
                    {
                         if (MenuIntC < 3)  //cupSelect
                         {
                              MenuIntC++;
                         }
                    }
                    if (MenuIntB > 1) //currentParameter
                    {
                         if (SYSTEM_Region == 0x00)
                         {
                              GlobalAddressA = (cup_PAL + (MenuIntC * 8) + ((MenuIntB - 2) * 2));
                         }
                         else
                         {
                              GlobalAddressA = (cup_NTSC + (MenuIntC * 8) + ((MenuIntB - 2) * 2));
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


void printMenu()
{

     

     
     DrawBox(50,10,220,116,0,0,0,175);
//     GraphPtr = FillRect1ColorF(GraphPtr, 50, 10, 270, 126, 0, 0,0, 175);
     
     DrawBox(48,8,2,119,255,0,0,255);
     DrawBox(270,8,2,119,255,0,0,255);
     DrawBox(50,8,220,2,255,0,0,255);
     DrawBox(50,125,220,2,255,0,0,255);
     /*
     GraphPtr = FillRect1ColorF(GraphPtr, 48, 8, 50, 127, 255, 0,0, 255);
     GraphPtr = FillRect1ColorF(GraphPtr, 270, 8, 272, 127, 255, 0,0, 255);
     GraphPtr = FillRect1ColorF(GraphPtr, 50, 8, 270, 10, 255, 0,0, 255);
     GraphPtr = FillRect1ColorF(GraphPtr, 50, 125, 270, 127, 255, 0,0, 255);
     */
    DrawBox(60,32,200,1,0,0,0,255);
     //GraphPtr = FillRect1ColorF(GraphPtr, 60, 32, 260, 33, 0, 0,0, 255);



     if (MenuIntA == 3)   //CurrentPage
     {
          if (MenuIntB == 0) //currentParameter
          {
               MenuPosition[0] = 157 - ((menuChar[MenuIntA]) * 4);
               GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0], 19, MenuPosition[0] + (menuChar[MenuIntA] * 8), 29, 200, 0, 0, 200);
          }
          else if (MenuIntB == 1) //currentParameter
          {
               MenuPosition[0] = 155 - ((cupChar[MenuIntC]) * 4);
               GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0], 41, MenuPosition[0] + (cupChar[MenuIntC] * 8), 51, 0, 200, 0, 200);
          }
          else
          {
               if (SYSTEM_Region == 0x00)
               {
                    GlobalAddressA = (cup_PAL + (MenuIntC * 8) + ((MenuIntB - 2) * 2));
               }
               else
               {
                    GlobalAddressA = (cup_NTSC + (MenuIntC * 8) + ((MenuIntB - 2) * 2));
               }
               short *l_courseID = (short *)GlobalAddressA;
               MenuPosition[0] = 157 - ((courseChar[(long)*l_courseID]) * 4);
               MenuPosition[1] = ((MenuIntB - 1) * 14) + 44;
               GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0], MenuPosition[1], MenuPosition[0] + (courseChar[(long)*l_courseID] * 8), MenuPosition[1]+11, 0, 0, 200, 200);
          }
     }
     else
     {
          if (MenuIntB == 0) //currentParameter
          {
               MenuPosition[0] = 157 - ((menuChar[MenuIntA]) * 4);
               GraphPtr = FillRect1ColorF(GraphPtr, MenuPosition[0], 19, MenuPosition[0] + (menuChar[MenuIntA] * 8), 29, 200, 0, 0, 200);
          }
          else
          {
               MenuPosition[1] = MenuIntB * 18 + 33;
              if (GlobalCharB < 29)  
               {
                    KWSprite(57,MenuPosition[1]+2,16,16,(ushort*)&lit_red_selecter);
               }
          }
     }
     
     SetFontColor(26,26,29,12,12,15);
     loadFont();

     LoopValue = 0;
     MenuPosition[0] = 138 - (menuChar[MenuIntA] * 4);
     
     
     
     printString(MenuPosition[0],0,menuNames[MenuIntA]);
     
     MenuPosition[1] = 30;
     
     
     
     switch(MenuIntA)    //CurrentPage
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
               MenuPosition[0] = 135 - (cupChar[MenuIntC] * 4);
               printString(MenuPosition[0],22,cupNames[MenuIntC]);
               MenuPosition[1] = 40;
               do{
                    if (SYSTEM_Region == 0x00)
                    {
                         GlobalAddressA = (cup_PAL + (MenuIntC * 8) + LoopValue * 2);
                    }
                    else
                    {
                         GlobalAddressA = (cup_NTSC + (MenuIntC * 8) + LoopValue * 2);
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


     
     
     if (ConsolePlatform)
     {
          GlobalIntA = 12;
          GlobalIntB = 200;
          printString(GlobalIntA*2,GlobalIntB - 5,"N64 ");
     }
     else
     {
          if (EmulatorPlatform)
          {               
               printString(0,195,"PROJECT64");               
          }
          else
          {
               printString(16,195,"MUPEN");
          }
     }
        

     printString(0,205,"BUILD 5.0");






     
     if (MenuIntA != 3)    //CurrentPage
     {
          if (pageLimit[MenuIntA] > 4)
          {
               if (GlobalCharC == 0)  //menuOverflowIndex
               {
                    if (GlobalCharB < 15)  //used for blinking down arrow
                    {
                         KWSprite(161,117,16,16,(ushort*)&lit_arrowsprite_d);
                    }
               }
               else
               {
                    if (GlobalCharB < 15)  //used for blinking up arrow
                    {
                         KWSprite(161,40,16,16,(ushort*)&lit_arrowsprite_u);
                    }
               }
          }
          if (pageLimit[MenuIntA] > 5)
          {

               if (GlobalCharC == 1)  //menuOverflowIndex
               {
                    if (GlobalCharB < 15)  //used for blinking down arrow
                    {
                         KWSprite(161,117,16,16,(ushort*)&lit_arrowsprite_d);
                    }
               }          
          }
     }
     if (MenuIntA > 0)  //used for left arrow
     {
          KWSprite(80,22,16,16,(ushort*)&lit_arrowsprite_l);
     }
     if (MenuIntA < 3)  //used for right arrow
     {
          KWSprite(240,22,16,16,(ushort*)&lit_arrowsprite_r);
     }

     
     g_mlogoY = 0x00000075;
     g_mflagID = 0;
     g_mpressstartID = 0;
     g_mracewayTime = 0;

}



void titleMenu(void)
{
     
     if (!GlobalBoolA)
     {
          GlobalBoolA = true;
          loadCoinSprite();
          loadArrows();
          loadNumberSprites();
	     loadCoin();
     }
     
     


     if (GlobalCharB > 30)  //used for blinking menu +
     {
          GlobalCharB = 0;
     }
     else
     {
          GlobalCharB++;  //used for blinking menu +
     }


     if(titleDemo > 4)
     {
          titleDemo = 4;   //This is a timer that runs at the title screen. Locking at 4 Prevents the demo courses from being displayed.
     }
     

     // Reset the MenuButtonHeld timer. This is set to 0x01 when a button is held down.
     // Used for advancing menu when direction is held.
     GlobalShortA = 0;
     if (GlobalController[4]->ButtonHeld > 0)
     {
          GlobalShortA = GlobalController[4]->ButtonHeld;
     }
     else if (GlobalController[4]->AnalogHeld > 0)
     {
          GlobalShortA = GlobalController[4]->AnalogHeld;
     }
     else
     {          
          MenuButtonHeld = 0;
          ButtonTimer = 0;  //Button Held Timer
     }

     ButtonTimer = ButtonTimer + 1;  //Button Held Timer          
     if (ButtonTimer >= 9)
     {    
          MenuButtonHeld = 0;
          ButtonTimer = 0;  //Button Held Timer               
     }

     if ((titleDemo > 3) && (menuScreenB <= 0x03))
     {

          
          //MenuButtonHeld is set to 0x01 when a button is held down.
          if(MenuButtonHeld != 1)
          {
               
               // Uses the Control Stick or Dpad to switch through the menu.
               switch(GlobalShortA)
               {
                    //Increase the current menu Parameter by 1
                    case BTN_DRIGHT :
                    {
                         MenuButtonHeld = 1;
                         if (MenuIntB > 0) //currentParameter
                         {
                              swapParameter(1);
                              playSound(0x49008000);
                         }
                         else
                         {
                              if (MenuIntA < 3)
                              {
                                   MenuIntA++;
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
                         MenuButtonHeld = 1;
                         if (MenuIntB > 0) //currentParameter
                         {
                              swapParameter(0);
                              playSound(0x49008000);
                         }
                         else
                         {
                              if (MenuIntA > 0)
                              {
                                   MenuIntA--;
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
                         MenuButtonHeld = 1;
                         if (MenuIntB + GlobalCharC < pageLimit[MenuIntA]) //currentParameter
                         {
                              if ((MenuIntB == 4) && (MenuIntA < 3))
                              {
                                   GlobalCharC++;
                              }
                              else
                              {
                                   MenuIntB++; //currentParameter
                              }
                              playSound(0x4900801C);
                         }
                         break;

                         //
                    }
                    //Move backward to previous option
                    case BTN_DUP :
                    {
                         MenuButtonHeld = 1;
                         if (MenuIntB + GlobalCharC > 0) //currentParameter
                         {
                              if ((MenuIntB == 1) && (MenuIntA < 3) && (GlobalCharC > 0))
                              {
                                   GlobalCharC--;
                              }
                              else
                              {
                                   MenuIntB--; //currentParameter
                              }
                              playSound(0x4900801C);
                         }
                         break;
                    }


               }
               // End of menu Dpad code.


          }
     }
     

     // Now print the menu using the menuFlag and parameterFlag options above.
     if ((gameMode[1] == 1) || (gameMode[0] == 1))
     {
          checkStats(1);
     }
     else
     {
          checkStats(0);
     }
     printMenu();

     
     //
     //
     //
     // End of TITLE MENU code

     // This handles the FASTRESET hack in the Dpad Menu g_InGame




}