#ifndef OverKartObjectHandlerH
#define OverKartObjectHandlerH
#include "..\Library\MainInclude.h"
#include "OKInclude.h"
extern struct OKCollisionSphere CoinCollision[2];
extern void loadCoin();
extern void DisplayObject(void *Car, Object *InputObject);
extern void RedCoinChallenge(long PathOffset);

extern int CollideObject(void* Camera, void* Object);
extern int RedCoinCollide(void* Car, void* Coin);
#endif