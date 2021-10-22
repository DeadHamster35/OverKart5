#ifndef OverKartVariablesH
#define OverKartVariablesH
#include "..\Library\MainInclude.h"
#include "OKInclude.h"
//Menu


extern SaveData SaveGame;
extern char* gameMode;
extern char* modMode;
extern char* renderMode;

extern char *menuNames[];
extern int menuChar[];
extern char *cupNames[];
extern int cupChar[];
extern char *courseNames[];
extern int courseChar[];

extern char *gameOptions[];
extern char *gameParameters[][3];
extern int gameLimits[];
extern int gameChar[][3];

extern char *modOptions[];
extern char *modParameters[][14];
extern int modLimits[];
extern int modChar[][14];

extern char *renderOptions[];
extern char *renderParameters[][2];
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