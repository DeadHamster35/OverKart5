#include "../Library/MainInclude.h"
#include "OKInclude.h"


//Menu



SaveData SaveGame;

char* gameMode = (char*)&SaveGame.GameSettings;
char* modMode = (char*)&SaveGame.ModSettings;
char* renderMode = (char*)&SaveGame.RenderSettings;
char* battleMode = (char*)&SaveGame.BattleSettings;

int LoadedProgress;


float AnalogInput[2];

int ItemChance[8];
//
//

//PracticeHack

int FlyCamPosition[3];

char GenericInput, MapMode = 0, FlyCamToggle, FlyCamCheck;
short FlyCamSection, FlyCamSectionCheck;
short FlyCamView, FlyCamViewCheck;
short FlyCamPilot,FlyCamDirection;
float FlyCamBackupPosition[3];
float FlyCamRadian;
float FlyCamLook[2][2];
int LocalInput[2];
int InputColor[4];

short FlyCamSpeed = 5;



char colors[][3] = {
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
char coords[][2] = {
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
char stickColor[][3] = {
	{192, 192, 192},
	{192, 192, 192},
	{192, 192, 192},
	{192, 192, 192},
	{255, 255, 255}
};
char stickCoord[][2] = {
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
int pageLimit[] = {6,4,7,5,2};  // GAME - MOD - RENDER - CUP EDITOR  -  BATTLE

OKPanel RacePanel, BattlePanel, ModPanel, RenderPanel;
OKOption OKGameOptions[6];
OKOption OKModOptions[4];
OKOption OKRenderOptions[7];

OKMenu GameOKMenu;


uint StartLogoRAM, BackdropRAM, Splash3DRAM, MenuIconsRAM;

int menuChar[] = {12,11,14,10};
int gameLimits[] = {4,3,2,2,2,2};
int gameChar[][4] = {{7,12,8,9}, {7,5,8} ,{3,2}, {3,2}, {3,2}, {7,4}};

int battleLimits[] = {3,2};
int battleChar[][3] = {{7,3,6}, {3,2}};

int modLimits[] = {2,2,2,2};
int modChar[][14] = {{3,2,3,3}, {3,2}, {3,2}, {3,2,8}, {7,3,3,3,3,3,3,3,3,6,10,10,4,8}};

int renderLimits[] = {2,2,2,2,2,2,2};
int renderChar[][2] = {{3,2}, {3,2}, {3,2}, {10,8}, {7,8}, {7,8}, {3,2} };



char *menuNames[] = {"Game Options", "Mod Options","Render Options","Cup Editor"};	

char *gameOptions[] = {"Game Mode", "Racer Stats", "Mirror Mode", "GP Always Advance", "All Cup", "Multiplayer"};
char *gameParameters[][4] = {{"Default", "OK64 T.Trial", "Red Coin", "Gold Coin"}, {"Classic", "Equal", "Enhanced"}, {"Off" , "On"}, {"Off" , "On"}, {"Off" , "On"}, {"Classic" , "Bots"} };

char *battleOptions[] = {"Game Mode", "Mirror Mode"};
char *battleParameters[][3] = {{"Default", "CTF", "Soccer"}, {"Off" , "On"}};


char *modOptions[] = {"Practice Mode", "Flycam", "Input Display", "Details", "Force Items"};
char *modParameters[][14] = {{"Off", "On", "Map", "Dev"}, {"Off" , "On"}, {"Off" , "On"}, {"Off","On","Shortcut"},
{"Default","8th","7th","6th","5th","4th","3rd","2nd","1st","Banana","3 G. Shell", "3 R. Shell", "Star", "3 Shroom"}
};



char *renderOptions[] = { "Audio Mode", "Widescreen", "Anti-Alias",  "Screen Split", "Draw Dist.", "Game Tempo", "Show FPS"};
char *renderParameters[][2] = {{"USA", "JP"},  {"Off" , "On"}, {"Off" , "On"},  {"Horizontal", "Vertical"}, {"Default","Extended"}, {"Console","Emulator"},  {"Off" , "On"}};


//InputDisplay Variables
char *names[] = {
	"A", "B", "Z", "S",
	"U", "D", "L", "R", // draw d-pad
	"", "", //unused bits
	"L", "R",
	"U", "D", "L", "R" //C buttons
};

char *stickNames[] = {
	"U", "D", "L", "R","S"
};
