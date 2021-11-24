#include "../Library/MainInclude.h"
#include "OKInclude.h"
#include "data/ModelData/ModelData.h"
struct OKCollisionSphere CoinCollision[2];


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
	GlobalAddressA = *(long*)(&InputObject);
	GlobalAddressB = (long)&RedCoin;
	//UpdateObjectVelocity(Object);
	objectPosition[0] = *(float*)(GlobalAddressA + 24);
	objectPosition[1] = *(float*)(GlobalAddressA + 28);
	objectPosition[2] = *(float*)(GlobalAddressA + 32);

	objectAngle[0] = *(short*)(GlobalAddressA + 16);
	objectAngle[1] = *(short*)(GlobalAddressA + 18);
	objectAngle[2] = *(short*)(GlobalAddressA + 20);
	*(short*)(GlobalAddressA + 18) += DEG1 * 3;


	DrawGeometryScale(objectPosition,objectAngle,GlobalAddressB, 0.10);

}

int RedCoinCollide(void *Car, void *Coin)
{
	GlobalAddressA = *(long*)(&Coin);
	objectPosition[0] = *(float*)(GlobalAddressA + 24);
	objectPosition[1] = *(float*)(GlobalAddressA + 28);
	objectPosition[2] = *(float*)(GlobalAddressA + 32);
	int playerID = (*(long*)&Car - (long)&g_PlayerStructTable) / 0xDD8;
	if ((CollisionSphere(Car,Coin) == 1) && (playerID == 0))
	{
		*targetAddress = 0x353500FF;
		deleteObjectBuffer(Coin);
		NAPlyTrgStart(playerID, 0x49008017);  //coin sfx
		CoinCount++;
		if (CoinCount != 8)
		{
			playrandmCharacterSFX(playerID);
		}
		SetAnimMusicNote(playerID);
		ChangeMaxSpeed(playerID, 2);
	}
	if (CoinCount == 8)
	{
		SetStar(Car,playerID);
		NAPlyTrgStart(playerID, 0x1900F103);  //goal in sfx
		CoinCount++;
	}

	return(0);
}


int CollideObject(void *Camera, void *Object)
{
	return RedCoinCollide(Camera,Object);
	objectIndex = (short)((*(long*)(*(long*)(&Object)) >> 16) & 0x0000FFFF);
	switch (objectIndex)
	{
		case 47:
		{
			return RedCoinCollide(Camera,Object);

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
void RedCoinChallenge(long PathOffset)
{
	
	*(uint*)(0x80650000) = PathOffset;
	*(uint*)(0x80650004) = (uint)&CoinPositions;
	GlobalShortD = 1;
	if (g_mirrorMode == 1)
	{
		GlobalShortD = -1;
	}
	for (int currentCoin = 0; currentCoin < 8; currentCoin++)
	{		
		objectPosition[0] = (float)*(short*)(PathOffset);
		objectPosition[1] = (float)*(short*)(PathOffset + 2);		
		objectPosition[2] = (float)*(short*)(PathOffset + 4);

		objectPosition[0] = objectPosition[0] * GlobalShortD;
		CreateObject(objectPosition,47);
		PathOffset += 8;
	}
}
