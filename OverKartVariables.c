#include "../Library/MainInclude.h"
#include "OKInclude.h"


//Menu



SaveData SaveGame;

char* gameMode = (char*)&SaveGame.GameSettings;
char* renderMode = (char*)&SaveGame.RenderSettings;
char* battleMode = (char*)&SaveGame.BattleSettings;
char* cheatMode = (char*)&SaveGame.CheatSettings;
char* mapMode = (char*)&SaveGame.LevelSettings;
int LoadedProgress;


short LastMenuID = 0;


uint PrintLog[99];
uint PrintCount;

float AnalogInput[2];

int ItemChance[8];
//
//

//PracticeHack

int FlyCamPosition[3];

char GenericInput, MiniMapMode = 0, FlyCamToggle, FlyCamCheck;
short FlyCamSection, FlyCamSectionCheck;
short FlyCamView, FlyCamViewCheck;
short FlyCamPilot,FlyCamDirection;
float FlyCamBackupPosition[3];
float FlyCamRadian;
float FlyCamLook[2][2];
int LocalInput[2];
int InputColor[4];

short FlyCamSpeed = 5;



short colors[][3] = {
	{  0, 192, 255}, //A: blue
	{  0, 255,   0}, //B: green
	{255, 255, 255}, //Z: white
	{255,   0,   0}, //Start: red
	{192, 192, 192}, {192, 192, 192}, //up, down
	{192, 192, 192}, {192, 192, 192}, //left, right
	{  0,   0,   0}, {  0,   0,   0}, //unused
	{255, 255, 255}, {255, 255, 255}, //L, R
	{255, 255,   0}, {255, 255,   0}, //C up, down
	{255, 255,   0}, {255, 255,   0}  //C left, right
};
short coords[][2] = {
	{3, 1}, //A
	{3, 2}, //B
	{5, 1}, //Z
	{3, 0}, //start
	{1, 0}, {1, 2}, {0, 1}, {2, 1}, //d-pad
	{0, 0}, {0, 0}, //unused
	{4, 0}, //L
	{6, 0}, //R
	{5, 0}, //C up
	{5, 2}, //C down
	{4, 1}, //C left
	{6, 1}  //C right
};
short stickColor[][3] = {
	{192, 192, 192},
	{192, 192, 192},
	{192, 192, 192},
	{192, 192, 192},
	{255, 255, 255}
};
short stickCoord[][2] = {
	{1, 0}, //U
	{1, 2}, //D
	{0, 1}, //L
	{2, 1}, //R
	{1, 1} //stick
};

short ControllerInputX = 247;
short ControllerInputY = 215;




// Variables Draw3DRacer
short baseTurn, addTurn = 0;
//
//



int SaveStateCourseID;
int pageLimit[] = {8,9,6,5,3};  // GAME - RENDER - MAP - CUP EDITOR  -  BATTLE

__attribute__((aligned(16)))
OKPanel RacePanel, BattlePanel, RenderPanel, MapPanel;
__attribute__((aligned(16)))
OKOption OKGameOptions[8];
__attribute__((aligned(16)))
OKOption OKRenderOptions[9];
__attribute__((aligned(16)))
OKOption OKMapOptions[6];

__attribute__((aligned(16)))
OKMenu GameOKMenu;

__attribute__((aligned(16)))
uint StartLogoRAM, BackdropRAM, Splash3DRAM, MenuIconsRAM;
__attribute__((aligned(16)))
int battleLimits[] = {2,2,2};
__attribute__((aligned(16)))
int battleChar[][3] = {{7,3,6}, {3,2}};


__attribute__((aligned(16)))
char *menuNames[] = {"Game Options", "Render Options","Map Options", "Cup Editor"};	
__attribute__((aligned(16)))
int menuChar[] = {12,14,11,10};

__attribute__((aligned(16)))
char *gameOptions[] = {
	"Game Mode", 
	"Racer Stats", 
	"GP Always Advance", 
	"All Cup", 
	"Items",
	"Multiplayer",
	"Explorer Mode",
	"Flycam Mode"
};

__attribute__((aligned(16)))
char *gameParameters[][4] = {
	{"Default", "Red Coin", "Gold Coin", "Practice"}, 
	{"Classic", "Equal", "Enhanced", ""}, 
	{"Off" , "On", "", ""}, 
	{"Off" , "On", "", ""}, 
	{"Default","Random","Balanced", "None"},
	{"Classic" , "Bots 2-4", "Bots 3+4", "Bot 4"},
	{"Off" , "On", "", ""},	
	{"Off" , "On", "", ""}
};

__attribute__((aligned(16)))
int gameLimits[] = {
	3,
	2,
	2,
	2,
	4,
	4,
	2,
	2
};
__attribute__((aligned(16)))
int gameChar[][4] = {
	{7,8,9,8}, 
	{7,5,8,0},
	{3,2,0,0}, 
	{3,2,0,0}, 
	{7,6,8,4},
	{7,8,8,5},
	{3,2,0,0},	
	{3,2,0,0}
};


__attribute__((aligned(16)))
char *battleOptions[] = {"Game Mode", "Mirror Mode", "Flycam"};
__attribute__((aligned(16)))
char *battleParameters[][3] = {{"Default", "CTF", "Soccer"}, {"Off" , "On"}, {"Off" , "On"}};


__attribute__((aligned(16)))
char *renderOptions[] = { 
	"Audio Mode", 
	"Widescreen", 
	"Anti-Alias",  
	"Screen Split", 
	"Draw Dist.", 
	"Game Tempo",
	"Cull Mode", 
	"Show FPS", 
	"Input Disp.",
	"Detail Disp."
};
__attribute__((aligned(16)))
char *renderParameters[][3] = {
	{"USA", "JP", ""},  
	{"Off" , "On", ""}, 
	{"Off" , "On", ""},  
	{"Horizontal", "Vertical", ""}, 
	{"Default","Extended", ""}, 
	{"Console","Emulator", ""},  
	{"LLE","HLE",""},
	{"Off" , "On", ""},
	{"Off" , "On", ""},
	{"Off" , "On", "Shortcut"}
};

__attribute__((aligned(16)))
int renderLimits[] = {
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	3
};
__attribute__((aligned(16)))
int renderChar[][3] = {
	{3,2,0}, 
	{3,2,0}, 
	{3,2,0}, 
	{10,8,0}, 
	{7,8,0}, 
	{7,8,0},
	{3,3,0},
	{3,2,0},
	{3,2,0},
	{3,2,8} 
};


__attribute__((aligned(16)))
char *mapOptions[] = { 
	"X Scale", 
	"Y Scale", 
	"Z Scale", 
	"X Mirror", 
	"Y Mirror", 
	"Z Mirror"
};
__attribute__((aligned(16)))
char *mapParameters[][7] = {
	{"0.0", "0.5", "1.0", "1.5", "2.0", "2.5", "3.0"},
	{"0.0", "0.5", "1.0", "1.5", "2.0", "2.5", "3.0"},
	{"0.0", "0.5", "1.0", "1.5", "2.0", "2.5", "3.0"},
	{"Off" , "On","","","","",""}, 
	{"Off" , "On","","","","",""},  
	{"Off" , "On","","","","",""}
};

__attribute__((aligned(16)))
int mapLimits[] = {
	7,
	7,
	7,
	2,
	2,
	2
};
__attribute__((aligned(16)))
int mapChar[][7] = {
	{3,3,3,3,3,3,3}, 
	{3,3,3,3,3,3,3}, 
	{3,3,3,3,3,3,3}, 
	{3,2,0,0,0,0,0}, 
	{3,2,0,0,0,0,0}, 
	{3,2,0,0,0,0,0} 
};



//InputDisplay Variables
__attribute__((aligned(16)))
char *names[] = {
	"A", "B", "Z", "S",
	"U", "D", "L", "R", // draw d-pad
	"", "", //unused bits
	"L", "R",
	"U", "D", "L", "R" //C buttons
};
__attribute__((aligned(16)))
char *stickNames[] = {
	"U", "D", "L", "R","S"
};
