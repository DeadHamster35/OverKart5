extern struct OKCollisionSphere CoinCollision[2];
extern void loadCoin();
extern void DisplayObject(void *Car, Object *InputObject);
extern void RedCoinChallenge(long PathOffset);

extern int CollideObject(void* Car, void* Coin);
extern int RedCoinCollide(void* Car, void* Coin);