#ifndef OK64STRUCT_H_
#define OK64STRUCT_H_



typedef struct GameOptions{
     char GameMode, StatsMode, MirrorMode, GPMode, CupMode, AIMode, PAD, PAD2; //8
} GameOptions;

typedef struct ModOptions{
     char PracticeMode, FlycamMode, InputMode, DetailMode, ItemMode, PAD, PAD2, PAD3; //8
} ModOptions;

typedef struct RenderOptions{
     char AudioMode, ScreenMode, AliasMode, SplitMode, DrawMode, TempoMode, DisplayFPS, PAD2;
} RenderOptions;

typedef struct SaveData{
     GameOptions    GameSettings;
     ModOptions     ModSettings;
     RenderOptions  RenderSettings;     
     bool           TENNES;
     char           SaveVersion;
     char           PAD[478];
} SaveData;

#endif