#include "../Library/MainInclude.h"
#include "OKInclude.h"
#include "data/ModelData/ModelData.h"


void DrawPerScreen(Camera* LocalCamera)
{
	if (scrollLock)
	{	
		#if OverKartBuild
			int CurrentPlayer = (*(long*)&LocalCamera - (long)&g_Camera1) / 0xB8;
			DrawCheat3D(CurrentPlayer);
		#endif
		
		if(HotSwapID > 0)
		{
			DrawOKObjects(LocalCamera, SaveGame.GameSettings.FlycamMode);
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
					DrawGameFlags(LocalCamera);
					DrawGameBase(LocalCamera);
					
					break;
				}
				case BTL_SOCCER:
				{
					DrawGameFlags(LocalCamera);
					break;
				}
			}
		}
		else
		{
			
		}
		
	}
	
}




void loadCoin()
{
	
	*sourceAddress = (int)(&RCSpriteROM);
	*targetAddress = (int)(&ok_FreeSpace);
	dataLength = 0x204;
	runDMA();
	*sourceAddress = (int)(&ok_FreeSpace);
	*targetAddress = (int)(&ok_RedCoinSprite);
	runMIO();
	
}

void DropCoins(int PlayerIndex)
{
	IFrames[PlayerIndex] = 90;
	objectPosition[0] = GlobalPlayer[PlayerIndex].position[0]; 
	objectPosition[1] = GlobalPlayer[PlayerIndex].position[1];
	objectPosition[2] = GlobalPlayer[PlayerIndex].position[2];

	for (int ThisCoin = 0; ThisCoin < CoinCount[PlayerIndex]; ThisCoin++)
	{
		objectVelocity[0] = -2 + (MakeRandomLimmit(4));
		objectVelocity[1] = 4;
		objectVelocity[2] = -2 + (MakeRandomLimmit(4));
		MakeAlignVector(objectVelocity,(GlobalPlayer[PlayerIndex].direction[1]));
		MasterCreateObject(objectPosition, objectAngle, objectVelocity, 48, 3.0); //motion coin
		ChangeMaxSpeed(PlayerIndex, -3);
	}
	CoinCount[PlayerIndex] = 0;
}



//OVERWRITE CHECKHIT IN LIBRARY
void CheckHit(int PlayerIndex, int HitType)
{
	if (SaveGame.GameSettings.GameMode == 2)
	{
		//3Challenge
		DropCoins(PlayerIndex);
	}
	if (g_gameMode == GAMEMODE_BATTLE)
	{
		DropFlag(PlayerIndex);
	}
}




//Balanced Item Sets
char BalancedItemSetA[] =
{
	ib_banana,
	ib_banana,
	ib_banana,
	ib_banana,
	ib_bananas,
	ib_kinoko1,
	ib_kinoko1,
	ib_kinoko2,
	ib_gkame,
	ib_gkame,
	ib_imbox,
	ib_imbox,
	ib_imbox,
	ib_imbox,
	ib_tellesa,
	ib_tellesa,
};

char BalancedItemSetB[] =
{
	ib_banana,
	ib_banana,
	ib_bananas,
	ib_bananas,
	ib_gskame,
	ib_gskame,
	ib_rkame,
	ib_rkame,
	ib_rskame,
	ib_kinoko2,
	ib_kinoko2,
	ib_kinoko3,
	ib_gkame,
	ib_imbox,
	ib_tellesa,
	ib_tellesa,
};

char BalancedItemSetC[] =
{
	ib_gskame,
	ib_gskame,
	ib_gskame,
	ib_rskame,
	ib_rskame,
	ib_rskame,
	ib_kinoko3,
	ib_kinoko3,
	ib_kinokoc,
	ib_kinokoc,
	ib_star,
	ib_thunder,
	ib_tkame,
	ib_tkame,
	ib_tkame,
	ib_tkame,
};


char BalancedItemSetD[] =
{
	ib_rskame,
	ib_rskame,
	ib_rskame,
	ib_rskame,
	ib_star,
	ib_star,
	ib_star,
	ib_star,
	ib_star,
	ib_star,
	ib_star,
	ib_star,
	ib_thunder,
	ib_thunder,
	ib_kinokoc,
	ib_kinokoc,
};




void ItemboxCollideCheck(Player* Car, Object* Target)
{
	int PlayerID = (*(long*)&Car - (long)&g_PlayerStructTable) / 0xDD8;
	if (CollisionSphere(Car, Target))
	{
		Target->sparam = 3;
		Target->flag = EXISTOBJ;
		Target->counter = 0;
			
		if (Car->flag & IS_PLAYER)
		{
			if (Target->bump.dummy != 0)
			{
				RouletteStart(PlayerID, Target->bump.dummy);
			}
			else
			{
				switch (SaveGame.GameSettings.ItemMode)
				{
					case IM_DEFAULT:
					{
						RouletteStart(PlayerID, 0);
						break;
					}

					case IM_RANDOM:
					{
						GlobalShortA = MakeRandomLimmit(14);
						if (GlobalShortA < 14)
						{
							GlobalShortA += 1;
						}
						RouletteStart(PlayerID, GlobalShortA);
						break;
					}

					case IM_BALANCE:
					{
						switch (Car->rank)
						{
							case 0:
							{
								GlobalShortA = 	BalancedItemSetA[MakeRandomLimmit(16)];
								break;
							}
							case 1:
							case 2:
							{
								GlobalShortA = 	BalancedItemSetB[MakeRandomLimmit(16)];
								break;
							}
							case 3:
							case 4:
							case 5:
							{
								GlobalShortA = 	BalancedItemSetC[MakeRandomLimmit(16)];
								break;
							}
							case 6:
							case 7:
							{
								GlobalShortA = 	BalancedItemSetD[MakeRandomLimmit(16)];
								break;
							}
						}
						RouletteStart(PlayerID, GlobalShortA);
						break;
					}
					
				}
			}
			
		}
	}
	else
	{
		if (Target->sparam == 0)
		{
			Target->sparam = 1;
			Target->flag = EXISTOBJ;
		}
	}

}



void Draw3DRacer(uint ModelAddress, uint Player)
{
	
	if (SaveGame.RenderSettings.SplitMode == 0)
	{
		spriteKillA = 0x27BDFFA0;
		spriteKillB = 0xAFBF;
		spriteKillC = 0x27BDFFE8;
		spriteKillD = 0xAFBF;
	}
	else
	{
		
		spriteKillA = 0x03E00008;
		spriteKillB = 0x2400;
		spriteKillC = 0x03E00008;
		spriteKillD = 0x2400;
		

		GlobalUIntA = (uint)(&g_PlayerStructTable);
		objectPosition[0] = GlobalPlayer[Player].direction[0];
		objectPosition[1] =  GlobalPlayer[Player].direction[1] +  GlobalPlayer[Player].sterrangle;
		objectPosition[2] = GlobalPlayer[Player].direction[2];
		objectAngle[2] = baseTurn + addTurn;
		objectAngle[0] = 0x3FFF - *(short*)(GlobalUIntA + 518) * 2;
		objectAngle[1] = *(short*)(GlobalUIntA + 80) * -2;

		DrawGeometryScale(GlobalPlayer[Player].position,objectAngle,ModelAddress, 0.08);
	}
	
	
}



void DisplayObject(void *Car, Object *InputObject)
{
	
	switch (InputObject->category)
	{
		case (47):
		{
			
			GlobalAddressB = (long)RedCoin_GFX;
			objectPosition[0] = InputObject->position[0];
			objectPosition[1] = InputObject->position[1];
			objectPosition[2] = InputObject->position[2];

			
			InputObject->angle[1] += DEG1 * 3;
			objectAngle[0] = InputObject->angle[0];
			objectAngle[1] = InputObject->angle[1];
			objectAngle[2] = InputObject->angle[2];


			DrawGeometryScale(objectPosition,objectAngle,GlobalAddressB, 0.10f);
			break;
		}
		case 48:
		{
			GlobalAddressB = (long)GoldCoin_GFX;
			UpdateObjectGravity(InputObject);
			UpdateObjectVelocity(InputObject);
			
			UpdateObjectFrictionScale(InputObject,0.5);
			UpdateObjectBump(InputObject);
			
			if(InputObject->bump.distance_zx < 0)
			{
				InputObject->velocity[1] = 0;
			}
			
			objectPosition[0] = InputObject->position[0];
			objectPosition[1] = InputObject->position[1] - 5.0f;
			objectPosition[2] = InputObject->position[2];

			
			InputObject->angle[1] += DEG1 * 3;
			objectAngle[0] = InputObject->angle[0];
			objectAngle[1] = InputObject->angle[1];
			objectAngle[2] = InputObject->angle[2];


			DrawGeometryScale(objectPosition,objectAngle,GlobalAddressB, 0.125f);
			break;
		}
		case 49:
		{
			GlobalAddressB = (long)GoldCoin_GFX;
			objectPosition[0] = InputObject->position[0];
			objectPosition[1] = InputObject->position[1] - 5.0f;
			objectPosition[2] = InputObject->position[2];

			
			InputObject->angle[1] += DEG1 * 3;
			objectAngle[0] = InputObject->angle[0];
			objectAngle[1] = InputObject->angle[1];
			objectAngle[2] = InputObject->angle[2];


			DrawGeometryScale(objectPosition,objectAngle,GlobalAddressB, 0.125f);
			break;
		}
	}

}

int RedCoinCollide(Player *Car, Object *Coin)
{
	int PlayerID = (*(long*)&Car - (long)&g_PlayerStructTable) / 0xDD8;
	if (TestCollideSphere(Car->position,Car->radius,Coin->position,6.0))
	{
		deleteObjectBuffer(Coin);
		NAPlyTrgStart(PlayerID, 0x49008017);  //coin sfx
		CoinCount[PlayerID]++;
		if (CoinCount[PlayerID] != 8)
		{
			playrandmCharacterSFX(PlayerID);
		}
		SetAnimMusicNote(PlayerID);
	}
	if (CoinCount[PlayerID] == 8)
	{
		SetStar(Car,PlayerID);
		NAPlyTrgStart(PlayerID, 0x1900F103);  //goal in sfx
		CoinCount[PlayerID]++;
	}

	return(0);
}


int GoldCoinCollide(Player *Car, Object *Coin)
{
	int PlayerID = (*(long*)&Car - (long)&g_PlayerStructTable) / 0xDD8;
	if (IFrames[PlayerID] == 0)
	{
		if (CoinCount[PlayerID] < 10)
		{	
			if (TestCollideSphere(Car->position,Car->radius,Coin->position,7.0))
			{
				deleteObjectBuffer(Coin);
				NAPlyTrgStart(PlayerID, 0x49008017);  //coin sfx
				CoinCount[PlayerID]++;
				playrandmCharacterSFX(PlayerID);
				
				SetAnimMusicNote(PlayerID);
				ChangeMaxSpeed(PlayerID, 3);
			}
		}
	}
	return(0);
}


void CollideObject(Player *Car, Object *Target)
{
	switch (Target->category)
	{
		case 12:
		{
			ItemboxCollideCheck(Car,Target);
			break;
		}
		case 47:
		{
			RedCoinCollide(Car,Target);

			break;
		}
		case 48:
		case 49:
		{
			GoldCoinCollide(Car,Target);

			break;
		}
		default:
		{
			return;
			break;
		}
	}
	
}
void RedCoinChallenge(long CoinOffset)
{
	GlobalShortD = 1;
	if (g_ScreenFlip == 1)
	{
		GlobalShortD = -1;
	}
	for (int currentCoin = 0; currentCoin < 8; currentCoin++)
	{		
		objectPosition[0] = (float)*(short*)(CoinOffset);
		objectPosition[1] = (float)*(short*)(CoinOffset + 2);		
		objectPosition[2] = (float)*(short*)(CoinOffset + 4);

		objectPosition[0] = objectPosition[0] * GlobalShortD;
		CreateObject(objectPosition,47);
		CoinOffset += 8;
	}
}


void PlaceSIBox(long BoxOffset)
{
	GlobalShortD = 1;
	if (g_ScreenFlip == 1)
	{
		GlobalShortD = -1;
	}
	Marker *BoxArray = (Marker*)(BoxOffset);
	for (int CurrentBox = 0; CurrentBox < 8; CurrentBox++)
	{		
		if (BoxArray[CurrentBox].Position[0] == -32768)
		{
			return;
		}
		objectPosition[0] = (float)BoxArray[CurrentBox].Position[0];
		objectPosition[1] = (float)BoxArray[CurrentBox].Position[1];
		objectPosition[2] = (float)BoxArray[CurrentBox].Position[2];

		objectPosition[0] = objectPosition[0] * GlobalShortD;
		CreateObject(objectPosition,43);
	}
}


void GoldCoinChallenge(uint PathOffset, int CoinCount)
{
	GlobalShortD = 1;
	if (g_ScreenFlip == 1)
	{
		GlobalShortD = -1;
	}
	GlobalIntB = (g_pathLength / CoinCount);
	Marker* Path = (Marker*)(PathOffset);
	objectAngle[0] = 0;
	objectAngle[1] = 0;
	objectAngle[2] = 0;
	for (int currentCoin = 0; currentCoin < CoinCount; currentCoin++)
	{		
		objectPosition[0] = (float)Path[currentCoin * GlobalIntB].Position[0];
		objectPosition[1] = (float)Path[currentCoin * GlobalIntB].Position[1] + 5;
		objectPosition[2] = (float)Path[currentCoin * GlobalIntB].Position[2];
		MasterCreateObject(objectPosition, objectAngle, objectVelocity, 49, 2.0);  //static coin
	}
}
