#ifndef OverKartH
#define OverKartH
#include "..\Library\MainInclude.h"
#include "OKInclude.h"
#include "Build.h"
extern void grayscale();
extern short MapModeCheck;
extern short LastMenuID;
extern uint ROptionPressed;

    #if OverKartBuild

    extern void CheatSetup();
    extern bool CheckCheat();
    extern void DrawCheatMenu();
    extern void CheatMenuHandler();
    extern void ApplyCheats();
    extern void LoadCheatData();
    extern void DrawCheat3D();
    
    #endif


#endif
