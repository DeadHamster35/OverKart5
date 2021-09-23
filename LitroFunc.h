#ifndef LitroFuncH
#define LitroFuncH
#include "..\Library\MainInclude.h"
#include "OKInclude.h"
extern void loadCoinSprite();
extern void loadArrows();
extern void loadNumberSprites();
//extern void loadAlpacaSprite();
//extern void loadHeartSprite();
extern void loadTitleMenuFrame();
extern void setAlwaysAdvance();
extern void ShowMusicNoteAnim(int playerIndex);
extern void AddTopSpeed(int SpeedGain);
extern void resetMenuUpdateTimers();

extern void setZoomLevel(int Zoom);
#endif