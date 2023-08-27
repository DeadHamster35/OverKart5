#ifndef OK64STRUCT_H_
#define OK64STRUCT_H_



typedef struct RaceOptions{
     char GameMode, StatsMode, GPMode, CupMode, ItemMode, AIMode, ExploreMode, FlycamMode; //8
} RaceOptions;

typedef struct BattleOptions{
     char GameMode, MirrorMode, PAD1, PAD2, PAD3, PAD4, PAD5, PAD6;
} BattleOptions;


typedef struct RenderOptions{
     char AudioMode, ScreenMode, AliasMode, SplitMode, DrawMode, Platform, DisplayFPS, InputMode;
     char DetailMode, CullMode, PAD2, PAD3, PAD4, PAD5, PAD6, PAD7;
} RenderOptions;

typedef struct LevelOptions{
     char ScaleXMode, ScaleYMode, ScaleZMode, MirrorX, MirrorY, MirrorZ, PAD4, PAD5;
} LevelOptions;

typedef struct SaveData{
     RaceOptions    GameSettings;
     RenderOptions  RenderSettings;    
     BattleOptions  BattleSettings; 
     LevelOptions   LevelSettings;
     bool           TENNES;
     char           SaveVersion;     
     char           PAD[458];
} SaveData;

#endif