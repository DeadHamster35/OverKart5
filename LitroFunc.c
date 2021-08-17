#include "../library/SubProgram.h"
#include "../library/SharedFunctions.h"
#include "../library/OKHeader.h"

#include "../library/OKExternal.h"
#include "../library/LibraryVariables.h"
#include "../library/MarioKartObjects.h"
#include "../library/MarioKart3D.h"
#include "../library/GameVariables/NTSC/OKassembly.h"
#include "../library/GameVariables/NTSC/GameOffsets.h"
#include "../RawAssets/ModelData/ModelData.h"
#include "OverKartVariables.h"

int loopCount = 1;


void loadArrows()
{
	*sourceAddress = (int)(&ArrowsSpriteROM);
	*targetAddress = (int)(&ok_FreeSpace);
	dataLength = 0x200;
	runDMA();
	*sourceAddress = (int)(&ok_FreeSpace);
	*targetAddress = (int)(&lit_arrowsSprite);
	runMIO();
}

void loadCoinSprite()
{
	*sourceAddress = (int)(&RCSpriteROM);
	*targetAddress = (int)(&ok_FreeSpace);
	dataLength = 0x204;
	runDMA();
	*sourceAddress = (int)(&ok_FreeSpace);
	*targetAddress = (int)(&ok_menucoinsprite);
	runMIO();
}

void loadNumberSprites()
{
	*sourceAddress = (int)(&NumbersSpriteROM);
	*targetAddress = (int)(&ok_FreeSpace);
	dataLength = 0x470;
	runDMA();
	*sourceAddress = (int)(&ok_FreeSpace);
	*targetAddress = (int)(&lit_numberSprite);
	runMIO();
}
/*
void loadAlpacaSprite()
{
	*sourceAddress = (int)(&AlpacaSpriteROM);
	*targetAddress = (int)(&ok_FreeSpace);
	dataLength = 0x240;
	runDMA();
	*sourceAddress = (int)(&ok_FreeSpace);
	*targetAddress = (int)(&lit_alpacasprite);
	runMIO();
}

void loadHeartSprite()
{
	*sourceAddress = (int)(&HeartSpriteROM);
	*targetAddress = (int)(&ok_FreeSpace);
	dataLength = 0x80;
	runDMA();
	*sourceAddress = (int)(&ok_FreeSpace);
	*targetAddress = (int)(&lit_heartsprite);
	runMIO();
}
*/
void loadTitleMenuFrame()
{
	*sourceAddress = (int)(&TitleMenuFrameROM);
	*targetAddress = (int)(&ok_FreeSpace);
	dataLength = 0x790;
	runDMA();
	*sourceAddress = (int)(&ok_FreeSpace);
	*targetAddress = (int)(&lit_titleFrame);
	runMIO();
}

void setAlwaysAdvance()
{
	if (gameMode[3] == 1)
	{
       	g_placedBadGPadvance = 0x00;
	}
	else
	{
       	g_placedBadGPadvance = 0x10;
	}
}

void ShowMusicNoteAnim(int playerIndex)
{
	GlobalAddressA = (long)(&g_PlayerStructTable);
	*(char*)(GlobalAddressA + (0xDD8 * playerIndex) + 0xB7) |= 32;
}

void AddTopSpeed(int SpeedGain)
{
	short TopSpeedAdd = ((int)SpeedGain);
	g_P1TopSpeed += (TopSpeedAdd);
}

void resetMenuUpdateTimers()
{
	g_menuUpdateTimer1 = 0;
	g_menuUpdateTimer2 = 0;
	g_menuUpdateTimer3 = 0;
	g_menuUpdateTimer4 = 0;
}



void setZoomLevel(int Zoom)
{
	g_zoomLevelPlayer1 = Zoom;
	g_zoomLevelPlayer2 = Zoom;
	g_zoomLevelPlayer3 = Zoom;
	g_zoomLevelPlayer4 = Zoom;
}

/*
void drawAlpacaAnim(int OffsetX, int OffsetY)
{
    loadAlpacaSprite();
    loadHeartSprite();

    KWSprite((int)OffsetX,(int)OffsetY,32,32,(short*)&lit_alpacasprite);

	if (loopCount == 1)
	{
        if (GlobalFrameChar <= 31) 
        {
            KWSprite((int)OffsetX-18-((char)GlobalFrameChar/4),(int)OffsetY+5-((char)GlobalFrameChar/3),16,16,(short*)&lit_heartsprite);
            KWSprite((int)OffsetX-11-((char)GlobalFrameChar/5),(int)OffsetY-6-((char)GlobalFrameChar/4),16,16,(short*)&lit_heartsprite);
            KWSprite((int)OffsetX-4+((char)GlobalFrameChar/4),(int)OffsetY-9-((char)GlobalFrameChar/5),16,16,(short*)&lit_heartsprite);
        }
        if (GlobalFrameChar == 31)
        {
			loopCount++;
		}
	return;
	}

	if (loopCount == 2)
	{
        if (GlobalFrameChar <= 31) 
        {
            KWSprite((int)OffsetX-18+((char)GlobalFrameChar/8),(int)OffsetY+5-((char)GlobalFrameChar/2),16,16,(short*)&lit_heartsprite);
            KWSprite((int)OffsetX-11-((char)GlobalFrameChar/4),(int)OffsetY+0-((char)GlobalFrameChar/5),16,16,(short*)&lit_heartsprite);
            KWSprite((int)OffsetX-5-((char)GlobalFrameChar/2),(int)OffsetY-8-((char)GlobalFrameChar/3),16,16,(short*)&lit_heartsprite);
        }
        if (GlobalFrameChar == 31)
        {
			loopCount++;
		}
	return;
	}

	if (loopCount == 3)
	{
        if (GlobalFrameChar <= 31)  
        {
            KWSprite((int)OffsetX-18+((char)GlobalFrameChar/5),(int)OffsetY+7-((char)GlobalFrameChar/4),16,16,(short*)&lit_heartsprite);
            KWSprite((int)OffsetX-14+((char)GlobalFrameChar/7),(int)OffsetY-1-((char)GlobalFrameChar/2),16,16,(short*)&lit_heartsprite);
            KWSprite((int)OffsetX-5+((char)GlobalFrameChar/2),(int)OffsetY-8-((char)GlobalFrameChar/3),16,16,(short*)&lit_heartsprite);
        }
        if (GlobalFrameChar == 31)
        {
			loopCount = 1;
		}
	return;
	}
}

*/
/*
void checkSurface(void *Camera)
{
	int playerIndex = (*(long*)&Camera - (long)&g_PlayerStructTable) / 0xDD8;

//	int Player1 = (char)(g_surfaceCheckP1) - 0xF9;

//	if (g_surfaceCheckP1 > 0)
//	{

		GlobalAddressA = (long)(&g_PlayerStructTable);
		*(char*)(GlobalAddressA + (0xDD8 * playerIndex) + 0xB7) |= 32;

//	}

// 
	int playerIndex = (*(long*)&Camera - (long)&g_PlayerStructTable) / 0xDD8;

	for(playerIndex = 0; playerIndex < 8; playerIndex++)
	{
			long baba = (long)(&g_PlayerStructTable) + (0xDD8 * playerIndex) + 0xF9;
		GlobalAddressA = (long)(&g_PlayerStructTable);
		*(char*)(GlobalAddressA + (0xDD8 * playerIndex) + 0xB7) |= 32;
    
		switch (baba)
		{
			case 0x01:
			{
			    loadAlpacaSprite();
			    KWSprite(100,100,32,32,(short*)&lit_alpacasprite);

				break;
			}
			case 0x02:
			{
			    loadAlpacaSprite();
			    KWSprite(120,120,32,32,(short*)&lit_alpacasprite);

				break;
			}
			default:
			{
				break;
			}
		}
			if (baba != 1)
			{
			    loadAlpacaSprite();
			    KWSprite(100,100,32,32,(short*)&lit_alpacasprite);
			}
			else
			{
			}
	}
//	
}

*/
