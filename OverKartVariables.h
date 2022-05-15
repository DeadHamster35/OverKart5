#ifndef OverKartVariablesH
#define OverKartVariablesH
#include "..\Library\MainInclude.h"
#include "OKInclude.h"
//Menuoksetup


#define RACESWITCH		0
#define BATTLESWITCH	1



#define BTL_BATTLE 	0
#define BTL_CTF		1
#define	BTL_SOCCER	2


extern SaveData SaveGame;
extern OKMenu   GameOKMenu;
extern OKMenu   TitleOKMenu;
extern OKPanel RacePanel, BattlePanel, ModPanel, RenderPanel;
extern OKOption OKGameOptions[];
extern OKOption OKModOptions[];
extern OKOption OKRenderOptions[];


extern char* gameMode;
extern char* modMode;
extern char* renderMode;
extern char* battleMode;

extern int LoadedProgress;

extern char *menuNames[];
extern int menuChar[];

extern char *gameOptions[];
extern char *gameParameters[][4];
extern int gameLimits[];
extern int gameChar[][4];
extern int battleLimits[];
extern int battleChar[][3];

extern char *modOptions[];
extern char *modParameters[][14];
extern int modLimits[];
extern int modChar[][14];

extern char *renderOptions[];
extern char *renderParameters[][2];
extern char *battleOptions[];
extern char *battleParameters[][3];
extern int renderLimits[];
extern int renderChar[][2];
extern int SaveStateCourseID;
extern int pageLimit[];

extern float AnalogInput[2];

//PracticeHack

extern int FlyCamPosition[];
extern float FlyCamRadian;
extern float FlyCamHeight;
extern short FlyCamSection, FlyCamSectionCheck;
extern short FlyViewSection, FlyCamViewCheck;
extern float FlyCamBackupPosition[3];
extern char FlyCamToggle, FlyCamCheck;
extern short FlyCamPilot;
extern short FlyCamDirection;
extern float FlyCamLook[2][2];
extern int LocalInput[2];
extern int InputColor[4];
extern char GenericInput, MapMode;
extern short FlyCamSpeed;



//InputDisplay Variables
extern char *names[];
extern char colors[][3];
extern char coords[][2];
extern char *stickNames[];
extern char stickColor[][3];
extern char stickCoord[][2];
extern short ControllerInputX, ControllerInputY;


// Variables Draw3DRacer
extern short baseTurn, addTurn;


//OKCustom Objects





#endif