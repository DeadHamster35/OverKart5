#ifndef OK64STRUCT_H_
#define OK64STRUCT_H_



typedef struct RaceOptions{
     char GameMode, StatsMode, MirrorMode, GPMode, CupMode, ItemMode, AIMode, PAD2; //8
} RaceOptions;

typedef struct BattleOptions{
     char GameMode, MirrorMode, PAD1, PAD2, PAD3, PAD4, PAD5, PAD6;
} BattleOptions;


typedef struct RenderOptions{
     char AudioMode, ScreenMode, AliasMode, SplitMode, DrawMode, Platform, DisplayFPS, InputMode;
     char DetailMode, PAD, PAD2, PAD3, PAD4, PAD5, PAD6, PAD7;
} RenderOptions;

typedef struct SaveData{
     RaceOptions    GameSettings;
     RenderOptions  RenderSettings;    
     BattleOptions  BattleSettings; 
     bool           TENNES;
     char           SaveVersion;
     char           PAD[470];
} SaveData;

#endif