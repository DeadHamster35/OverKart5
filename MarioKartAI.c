#include "../Library/MainInclude.h"
#include "OKInclude.h"

/*
char GlobalCharA; CPU STY
char GlobalCharB; FORCE CPU
char MenuOverflow; START BOOST
*/



void fastAI()
{
     switch(g_raceClass)
     {
          case 0x00:
          {
               GlobalFloatA = 498.0;
               break;
          }
          case 0x01:
          {
               GlobalFloatA = 518.0;
               break;
          }
          case 0x02:
          {
               GlobalFloatA = 530.0;
               break;
          }
     }

     if ((g_startingIndicator < 0x03) && (GlobalCharC == 0x00))
     {
          GlobalCharC = 0x01;
     }
     if ((g_startingIndicator == 0x03) && (GlobalCharC == 0x01))
     {
          GlobalCharC = 0x00;
          switch(g_playerCount)
          {
               case 0x01 :
               {
                    boost2 = 0x02;
                    boost3 = 0x02;
                    boost4 = 0x02;
                    break;
               }
               case 0x02 :
               {
                    boost2 = 0x02;
                    break;
               }
               case 0x03 :
               {
                    boost2 = 0x02;
                    boost3 = 0x02;
                    break;
               }
               case 0x04 :
               {
                    boost2 = 0x02;
                    boost3 = 0x02;
                    boost4 = 0x02;
                    break;
               }
          }
     }
     if (g_gameTimer > 5.0)
     {
          switch(g_playerCount)
          {
               case 0x01 :
               {
                    cpu2Speed = GlobalFloatA;
                    cpu3Speed = GlobalFloatA;
                    cpu4Speed = GlobalFloatA;

                    break;
               }
               case 0x02 :
               {
                    cpu2Speed = GlobalFloatA;

                    break;
               }
               case 0x03 :
               {
                    cpu2Speed = GlobalFloatA;
                    cpu3Speed = GlobalFloatA;

                    break;
               }
               case 0x04 :
               {
                    cpu2Speed = GlobalFloatA;
                    cpu3Speed = GlobalFloatA;
                    cpu4Speed = GlobalFloatA;

                    break;
               }
          }

     }
}




void aiSetup()
{
     switch (SaveGame.GameSettings.AIMode)
	{
          case 0:
          {
               return;
               break;
          }
          case 1:
          {
               player2OK = 0X01;
               player3OK = 0x01;
               player4OK = 0x01;
               break;
          }
          case 2:
          {
               player3OK = 0x01;
               player4OK = 0x01;
               break;
          }
          case 3:
          {
               player4OK = 0x01;
               break;
          }
		
	}
     if ((g_startingIndicator >= 3) && (g_startingIndicator < 7))
     {
          for (int ThisPlayer = SaveGame.GameSettings.AIMode; ThisPlayer < 4; ThisPlayer++)
          {
               if (*GlobalLap[ThisPlayer] < 3)
               {
                    GlobalPlayer[ThisPlayer].flag = 0x9000;
               }
          }
     }

}


short RubberCheck[4] = {10, 20, 25, 28};  //doubles for distance and speed

char RubberChar[8];
void RubberBandMan(int EnemyID, Player* EnemyKart)
{
     if (scrollLock)
     {         
          short ThisIndex = (short)g_playerPathPointTable[EnemyID];
          short TargetIndex = (short)g_playerPathPointTable[g_EnemyTargetPlayer];
          
          if (EnemyKart->speed < SPEED_KM(RubberCheck[g_raceClass]))
          {
               AccelOn(EnemyKart);
               RubberChar[EnemyID] = 0;
               return;
          }

          if (g_GameLapTable[EnemyID] < g_GameLapTable[g_EnemyTargetPlayer])
          {
               AccelOn(EnemyKart);
               RubberChar[EnemyID] = 1;
               return;
          }

          if (g_GameLapTable[EnemyID] == g_GameLapTable[g_EnemyTargetPlayer])
          {
               if (ThisIndex < TargetIndex + RubberCheck[g_raceClass])
               {    
                    AccelOn(EnemyKart);
                    RubberChar[EnemyID] = 2;
                    return;
               }
               else
               {
                    AccelOff(EnemyKart, 1);
                    RubberChar[EnemyID] = 3;
                    return;
               }
          }

          if (g_GameLapTable[EnemyID] > g_GameLapTable[g_EnemyTargetPlayer])
          {
               if (ThisIndex < RubberCheck[g_raceClass])
               {    
                    AccelOn(EnemyKart);
                    RubberChar[EnemyID] = 4;
                    return;
               }
               else
               {
                    AccelOff(EnemyKart, 1);
                    RubberChar[EnemyID] = 5;
                    return;
               }
          }
     }
}

short DifficultyCurve[4] = {0,5,10,12};
void SetAIDifficulty(int Difficulty)
{
     for (int ThisPlayer = g_playerCount; ThisPlayer < 8; ThisPlayer++)
     {
          GlobalPlayer[ThisPlayer].acc_maxcount += DifficultyCurve[Difficulty];
     }
}