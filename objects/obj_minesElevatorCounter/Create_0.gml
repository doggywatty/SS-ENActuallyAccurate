count = 0;
depth = 4;
t = 0;
drawSurface = -4;
minerPaletteColors = [
	[ [248, 0, 0], [96, 0, 0] ], [ [200, 0, 144], [80, 32, 80] ],
	[ [152, 48, 0], [80, 24, 16] ], [ [0, 160, 32], [0, 56, 32] ],
	[ [48, 64, 88], [24, 32, 40] ], [ [136, 168, 200], [48, 64, 88] ],
	[ [248, 192, 0], [48, 120, 0] ], [ [255, 170, 131], [160, 56, 0] ]
];
colorID = irandom_range(0, 5);
gnome_sprite = [spr_minesElevatorCutscene, spr_minesElevatorCutscene_dark];
gnome_index = 0;
pizzelle_sprite = [spr_minesElevatorCutscenePizzelle, spr_minesElevatorCutscenePizzelle_dark];
pizzelle_index = 0;
eyes_sprite = [spr_minesElevatorCutscenePizzelle_eyes, spr_minesElevatorCutscenePizzelle_eyes_dark];
eyes_index = 0;
minerPaletteIndex = 0;

var miner_palette_rng = irandom(1000);
if (miner_palette_rng < 800)
	minerPaletteIndex = floor(miner_palette_rng / 200);
else if (miner_palette_rng < 1000)
	minerPaletteIndex = 4 + floor((miner_palette_rng - 800) / 80);
else
	minerPaletteIndex = 7;

elevator_music = fmod_createEventInstance("event:/music/w1/mines_elevator");
elevator_ambiance = fmod_createEventInstance("event:/SFX/elevator/ambiance");
fmod_studio_event_instance_start(elevator_ambiance);
fmod_studio_event_instance_start(elevator_music);
alarm[0] = 60;
dark = false;
