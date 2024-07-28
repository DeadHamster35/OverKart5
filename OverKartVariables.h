#ifndef OverKartVariablesH
#define OverKartVariablesH
#include "..\Library\MainInclude.h"
#include "OKInclude.h"
//Menuoksetup


#define RACESWITCH		0
#define BATTLESWITCH	1


#define IM_DEFAULT 	0
#define IM_RANDOM 	1
#define IM_BALANCE	2
#define IM_NONE		3


extern SaveData SaveGame;
extern OKMenu   GameOKMenu;
extern OKPanel RacePanel, BattlePanel, MapPanel, RenderPanel;
extern OKOption OKGameOptions[];
extern OKOption OKMapOptions[];
extern OKOption OKRenderOptions[];


extern uint StartLogoRAM, BackdropRAM, Splash3DRAM, MenuIconsRAM;

extern char* gameMode;
extern char* renderMode;
extern char* battleMode;
extern char* cheatMode;
extern char* mapMode;

extern int LoadedProgress;


extern short LastMenuID;

extern uint CartridgeStatus;
extern uint PrintLog[];
extern uint PrintCount;

extern char *menuNames[];
extern int menuChar[];

extern char *gameOptions[];
extern char *gameParameters[][4];
extern int gameLimits[];
extern int mapLimits[];
extern int gameChar[][4];
extern int mapChar[][7];
extern int battleLimits[];
extern int battleChar[][3];


extern char *renderOptions[];
extern char *renderParameters[][3];
extern char *mapParameters[][7];
extern char *battleOptions[];
extern char *mapOptions[];
extern char *battleParameters[][3];
extern int renderLimits[];
extern int renderChar[][3];
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
extern char GenericInput, MiniMapMode;
extern short FlyCamSpeed;



//InputDisplay Variables
extern char *names[];
extern short colors[][3];
extern short coords[][2];
extern char *stickNames[];
extern short stickColor[][3];
extern short stickCoord[][2];
extern short ControllerInputX, ControllerInputY;


// Variables Draw3DRacer
extern short baseTurn, addTurn;


//OKCustom Objects





#endif