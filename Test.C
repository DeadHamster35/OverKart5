

#include "../Library/MainInclude.h"
#include "OKInclude.h"
typedef struct SubClassA
{
    short  Range;
    short  Viewcone;
    float  MaxSpeed;
} SubClassA;
typedef struct SubClassB
{
    int    PathAddress;
    short  PathCount;
    short  Direction;
} SubClassB;

typedef union SubClassUnion
{
    SubClassA   ClassA;
    SubClassB   ClassB;
} SubClassUnion;

typedef struct OKObjectType
{
    SVector         Position;
    SVector         Hitbox;
    UInt            OKModelAddress;
    short           BehaviorType, CollisionType;
    SubClassUnion   SubClassData;
} OKObjectType;

void ThisFunc()
{
    OKObjectType ThisType = (OKObjectType*)(0x80400000);
}
