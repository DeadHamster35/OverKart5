#include "../Library/MainInclude.h"
#include "OKInclude.h"

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
