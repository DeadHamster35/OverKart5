#include "../Library/MainInclude.h"
#include "OKInclude.h"
#include "data/ModelData/ModelData.h"




void DrawPerScreen(Camera* LocalCamera)
{
	if (scrollLock)
	{
		if(HotSwapID > 0)
		{
			DrawOKObjects(LocalCamera);
		}
		DrawGameFlags(LocalCamera);
	}
	
}


void loadCoin()
{
	SetSegment(8,(int)(&ok_ModelData));
	*sourceAddress = (int)(&ModelDataStart);
	*targetAddress = (int)(&ok_FreeSpace);
	dataLength = (int)ModelData_CompressedSize;
	runDMA();
	*sourceAddress = (int)(&ok_FreeSpace);
	*targetAddress = (int)(&ok_ModelData);
	runMIO();
	
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
		objectVelocity[0] = -3 + (MakeRandomLimmit(6));
		objectVelocity[1] = 12;
		objectVelocity[2] = -4 + (MakeRandomLimmit(8));
		MakeAlignVector(objectVelocity,(GlobalPlayer[PlayerIndex].direction[1]));
		MasterCreateObject(objectPosition, objectAngle, objectVelocity, 48, 3.0); //motion coin
		ChangeMaxSpeed(PlayerIndex, -3);
	}
	CoinCount[PlayerIndex] = 0;
}



//OVERWRITE CHECKHIT IN LIBRARY
void CheckHit(int PlayerIndex)
{
	if (SaveGame.GameSettings.GameMode == 2)
	{
		DropCoins(PlayerIndex);
	}
	if (g_gameMode == 3)
	{
		DropFlag(PlayerIndex);
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
			GlobalAddressB = (long)&RedCoin;
			objectPosition[0] = InputObject->position[0];
			objectPosition[1] = InputObject->position[1];
			objectPosition[2] = InputObject->position[2];

			
			InputObject->angle[1] += DEG1 * 3;
			objectAngle[0] = InputObject->angle[0];
			objectAngle[1] = InputObject->angle[1];
			objectAngle[2] = InputObject->angle[2];


			DrawGeometryScale(objectPosition,objectAngle,GlobalAddressB, 0.10);
			break;
		}
		case 48:
		{
			GlobalAddressB = (long)&GoldCoin;
			UpdateObjectGravity(InputObject);
			UpdateObjectVelocity(InputObject);
			
			UpdateObjectFrictionScale(InputObject,0.5);
			UpdateObjectBump(InputObject);
			
			if(InputObject->bump.distance_zx < 0)
			{
				InputObject->velocity[1] = 0;
			}
			
			objectPosition[0] = InputObject->position[0];
			objectPosition[1] = InputObject->position[1];
			objectPosition[2] = InputObject->position[2];

			
			InputObject->angle[1] += DEG1 * 3;
			objectAngle[0] = InputObject->angle[0];
			objectAngle[1] = InputObject->angle[1];
			objectAngle[2] = InputObject->angle[2];


			DrawGeometryScale(objectPosition,objectAngle,GlobalAddressB, 0.05);
			break;
		}
		case 49:
		{
			GlobalAddressB = (long)&GoldCoin;
			objectPosition[0] = InputObject->position[0];
			objectPosition[1] = InputObject->position[1];
			objectPosition[2] = InputObject->position[2];

			
			InputObject->angle[1] += DEG1 * 3;
			objectAngle[0] = InputObject->angle[0];
			objectAngle[1] = InputObject->angle[1];
			objectAngle[2] = InputObject->angle[2];


			DrawGeometryScale(objectPosition,objectAngle,GlobalAddressB, 0.05);
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
			if (TestCollideSphere(Car->position,Car->radius,Coin->position,6.0))
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


int CollideObject(Player *Car, Object *Target)
{
	
	objectIndex = (short)((*(long*)(*(long*)(&Target)) >> 16) & 0x0000FFFF);


	switch (objectIndex)
	{
		case 47:
		{
			return RedCoinCollide(Car,Target);

			break;
		}
		case 48:
		case 49:
		{
			return GoldCoinCollide(Car,Target);

			break;
		}
		default:
		{
			return 0;
			break;
		}
	}
	return -1;
	
}
void RedCoinChallenge(long CoinOffset)
{
	GlobalShortD = 1;
	if (g_mirrorMode == 1)
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


void GoldCoinChallenge(uint PathOffset)
{
	GlobalShortD = 1;
	if (g_mirrorMode == 1)
	{
		GlobalShortD = -1;
	}
	GlobalIntA = (int)(8 * g_playerCount); // CoinCount
	
	if (GlobalIntA < 10)
	{
		GlobalIntA = 10;
	}
	GlobalIntB = (g_pathLength / GlobalIntA);
	Marker* Path = (Marker*)(PathOffset);
	objectAngle[0] = 0;
	objectAngle[1] = 0;
	objectAngle[2] = 0;
	for (int currentCoin = 0; currentCoin < GlobalIntA; currentCoin++)
	{		
		objectPosition[0] = (float)Path[currentCoin * GlobalIntB].Position[0];
		objectPosition[1] = (float)Path[currentCoin * GlobalIntB].Position[1] + 5;
		objectPosition[2] = (float)Path[currentCoin * GlobalIntB].Position[2];
		MasterCreateObject(objectPosition, objectAngle, objectVelocity, 49, 1.0);  //static coin
	}
}
