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
	//
	//
	*sourceAddress = (int)(&RCSpriteROM);
	*targetAddress = (int)(&ok_FreeSpace);
	dataLength = 0x204;
	runDMA();
	*sourceAddress = (int)(&ok_FreeSpace);
	*targetAddress = (int)(&ok_RedCoinSprite);
	runMIO();
}



void DisplayObject(void *Car, Object *InputObject)
{
	//camera goes unused but is passed by the game's internal function

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
	*tempPointer = PathOffset;
	*sourceAddress = (long)&CoinPositions;
	*targetAddress = (long)&objectPosition;
	for (int currentCoin = 0; currentCoin < 8; currentCoin++)
	{		
		CoinPositions[currentCoin][0] = *(short*)(PathOffset);
		CoinPositions[currentCoin][1] = *(short*)(PathOffset + 2);
		CoinPositions[currentCoin][2] = *(short*)(PathOffset + 4);
		
		if (CoinPositions[currentCoin][0] == 0xFFFF8000)
		{
			if (currentCoin < 7)
			{
				return; //if there's not 8 coins don't run the function.
			}
			else
			{
				break;
			}
		}
		PathOffset = PathOffset + 8;
	}

	//two loops for above return; ensure 8 coins.

	for (int currentCoin = 0; currentCoin < 8; currentCoin++)
	{
		objectPosition[0] = (float)CoinPositions[currentCoin][0];		
		objectPosition[1] = (float)CoinPositions[currentCoin][1];
		objectPosition[2] = (float)CoinPositions[currentCoin][2];
		CreateObject(objectPosition,47);
	}

}
