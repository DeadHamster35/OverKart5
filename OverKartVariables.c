#include "../Library/MainInclude.h"
#include "OKInclude.h"


//Menu



SaveData SaveGame;
char* gameMode = (char*)&SaveGame.GameSettings;
char* modMode = (char*)&SaveGame.ModSettings;
char* renderMode = (char*)&SaveGame.RenderSettings;

int LoadedProgress;
int menuChar[] = {12,11,14,10};
int cupChar[] = {12,10,8,11};
int courseChar[] = {13,14,13,17,12,15,18,13,13,12,13,15,11,12,13,10,10,11,17,9};

int gameLimits[] = {3,1,1,1,1,1,1};
int gameChar[][4] = {{7,10,8,9}, {7,5} ,{3,2}, {3,2}, {3,2}, {3,2}, {7,4}};

int modLimits[] = {2,1,1,2};
int modChar[][14] = {{3,2,3,3}, {3,2}, {3,2}, {3,2,8}, {7,3,3,3,3,3,3,3,3,6,10,10,4,8}};

int renderLimits[] = {1,1,1,1,1};
int renderChar[][2] = { {3,2}, {3,2}, {10,8}, {7,8}, {7,8}};
int SaveStateCourseID;
int pageLimit[] = {7,4,5,5};  // GAME - MOD - RENDER - CUP EDITOR


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
float FlyCamRadian;
float FlyCamLook[2][2];
int LocalInput[2];
int InputColor[4];

short FlyCamSpeed = 5;



char *menuNames[] = {"Game Options", "Mod Options","Render Options","Cup Editor"};
char *cupNames[] = {"Mushroom Cup","Flower Cup","Star Cup","Special Cup"};
char *courseNames[] = {"Mario Raceway", "Choco Mountain", "Bowser Castle", "Banshee Boardwalk","Yoshi Valley", "Frappe Snowland", "Koopa Troopa Beach", "Royal Raceway",
"Luigi Raceway", "Moo Moo Farm", "Toad Turnpike","Kalimari Desert","Sherbet Land","Rainbow Road","Wario Stadium", "Block Fort", "Skyscraper", "Double Deck", "DK Jungle Parkway","Big Donut"};

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



char *gameOptions[] = {"Game Mode", "Racer Stats", "Audio Mode", "Mirror Mode", "GP Always Advance", "All Cup", "Multiplayer"};
char *gameParameters[][4] = {{"Default", "Time Trial", "Red Coin", "Gold Coin"}, {"Classic", "Equal"}, {"USA", "JP"}, {"Off" , "On"}, {"Off" , "On"}, {"Off" , "On"}, {"Classic" , "Bots"} };

char *modOptions[] = {"Practice Mode", "Flycam", "Input Display", "Details", "Force Items"};
char *modParameters[][14] = {{"Off", "On", "Map", "Dev"}, {"Off" , "On"}, {"Off" , "On"}, {"Off","On","Shortcut"},
{"Default","8th","7th","6th","5th","4th","3rd","2nd","1st","Banana","3 G. Shell", "3 R. Shell", "Star", "3 Shroom"}
};

char *renderOptions[] = {"Widescreen", "Anti-Alias",  "Screen Split", "Draw Dist.", "Game Tempo"};
char *renderParameters[][2] = { {"Off" , "On"}, {"Off" , "On"},  {"Horizontal", "Vertical"}, {"Default","Extended"}, {"Console","Emulator"}};

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
