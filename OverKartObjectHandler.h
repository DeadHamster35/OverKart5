#ifndef OverKartObjectHandlerH
#define OverKartObjectHandlerH
#include "..\Library\MainInclude.h"
#include "OKInclude.h"
extern void loadCoin();
extern void DisplayObject(void *Car, Object *InputObject);
extern void RedCoinChallenge(long PathOffset);
extern void GoldCoinChallenge(uint PathOffset);
extern int CollideObject(void* Camera, void* Object);
extern int RedCoinCollide(Player* Car, Object* Coin);
extern int GoldCoinCollide(Player* Car, Object* Coin);
#endif