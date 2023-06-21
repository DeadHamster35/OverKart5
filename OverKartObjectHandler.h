#ifndef OverKartObjectHandlerH
#define OverKartObjectHandlerH
#include "..\Library\MainInclude.h"
#include "OKInclude.h"
extern void DrawPerScreen(Camera* LocalCamera);
extern void loadCoin();
extern void DisplayObject(void *Car, Object *InputObject);
extern void RedCoinChallenge(long PathOffset);
extern void PlaceSIBox(long BoxOffset);
extern void GoldCoinChallenge(uint PathOffset, int CoinCount);
extern void CollideObject(Player* Car, Object* Target);
extern int RedCoinCollide(Player* Car, Object* Coin);
extern int GoldCoinCollide(Player* Car, Object* Coin);
#endif