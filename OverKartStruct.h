#ifndef OK64STRUCT_H_
#define OK64STRUCT_H_



typedef struct RaceOptions{
     char GameMode, StatsMode, MirrorMode, GPMode, CupMode, AIMode, PAD, PAD2; //8
} RaceOptions;

typedef struct BattleOptions{
     char GameMode, MirrorMode, PAD1, PAD2, PAD3, PAD4, PAD5, PAD6;
} BattleOptions;

typedef struct ModOptions{
     char PracticeMode, FlycamMode, InputMode, DetailMode, ItemMode, PAD, PAD2, PAD3; //8
} ModOptions;

typedef struct RenderOptions{
     char AudioMode, ScreenMode, AliasMode, SplitMode, DrawMode, TempoMode, DisplayFPS, PAD2;
} RenderOptions;

typedef struct SaveData{
     RaceOptions    GameSettings;
     ModOptions     ModSettings;
     RenderOptions  RenderSettings;    
     BattleOptions  BattleSettings; 
     bool           TENNES;
     char           SaveVersion;
     char           PAD[470];
} SaveData;

#endif