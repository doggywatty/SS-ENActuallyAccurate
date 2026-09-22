global.GameLevelMap = ds_map_create();
global.InternalLevelName = "none";

function scr_defineTitleCard(_img_ind, _music = "event:/music/w1/entryway_titlecard", _x = -4, _y = -4) constructor
{
	image_index = _img_ind;
	music = _music;
	x = _x;
	y = _y;
}

function scr_defineLevel(_levelWorld, _internalName, _visualName, _firstRoom, _groupArr = [], _sRankRequirement = 20000, _titleCardInfo = noone, _isBoss = false)
{
	ds_map_add(global.GameLevelMap, _internalName, 
	{
		internalName: _internalName,
		levelWorld: _levelWorld,
		visualName: _visualName,
		groupArr: _groupArr,
		firstRoom: _firstRoom,
		sRankRequirement: _sRankRequirement,
		titleCardInfo: _titleCardInfo,
		isBoss: _isBoss
	});
}

scr_defineLevel(0, "demohub", "Demo 2 Hub", hub_demohallway);
scr_defineLevel(0, "tutorial", "Tutorial", tutorial_1);
scr_defineLevel(0, "entryway", "Crunchy Construction", entryway_1, ["Entryway"], 16500, new scr_defineTitleCard(0, "event:/music/w1/entryway_titlecard", 37, 42));
scr_defineLevel(0, "steamy", "Cottontown", steamy_1, ["Cottontown"], 22500, new scr_defineTitleCard(1, "event:/music/w1/cottontown_titlecard", 37, 498));
scr_defineLevel(0, "mineshaft", "Sugarshack Mines", mineshaft_1, ["Mines"], 21500, new scr_defineTitleCard(2, "event:/music/w1/mines_titlecard", 37, 498));
scr_defineLevel(0, "molasses", "Molasses Swamp", molasses_1, ["Molasses", "geyserwaves"], 19000, new scr_defineTitleCard(3, "event:/music/w2/molasses_titlecard", 37, 498));
scr_defineLevel(0, "boss_pizzahead", "Boss 1", rm_missing, [], 20000, true);
scr_defineLevel(1, "fudge", "Mt. Fudgetop", mountain_intro, ["Fudgetop"]);
scr_defineLevel(1, "molasses", "Molasses Swamp", molasses_1, ["Molasses"]);
scr_defineLevel(1, "cafe", "Chocoa Cafe", cafe_1, ["Cafe"]);
scr_defineLevel(1, "boss_pizzabro", "Boss 2", rm_missing);

function scr_gotoLevel(arg0)
{
	var level_info = ds_map_find_value(global.GameLevelMap, arg0);
	var first_room = level_info.firstRoom;
	global.texturesToLoad = array_concat(global.texturesToLoad, level_info.groupArr);
	global.InternalLevelName = level_info.internalName;
	global.LevelFirstRoom = first_room;
	global.srank = level_info.sRankRequirement;
	global.arank = global.srank / 2;
	global.brank = global.arank / 2;
	global.crank = global.brank / 2;
}

enum Note
{
	C0 = 12,
	Cs0 = 13,
	D0 = 14,
	Ds0 = 15,
	E0 = 16,
	F0 = 17,
	Fs0 = 18,
	G0 = 19,
	Gs0 = 20,
	A0 = 21,
	As0 = 22,
	B0 = 23,
	C1 = 24,
	Cs1 = 25,
	D1 = 26,
	Ds1 = 27,
	E1 = 28,
	F1 = 29,
	Fs1 = 30,
	G1 = 31,
	Gs1 = 32,
	A1 = 33,
	As1 = 34,
	B1 = 35,
	C2 = 36,
	Cs2 = 37,
	D2 = 38,
	Ds2 = 39,
	E2 = 40,
	F2 = 41,
	Fs2 = 42,
	G2 = 43,
	Gs2 = 44,
	A2 = 45,
	As2 = 46,
	B2 = 47,
	C3 = 48
}

function scr_defineLevelMenuTune(_note)
{
	var note_array = [];
	
	switch (_note)
	{
		default:
			note_array = [Note.D1, Note.A1, Note.D2, Note.D1, Note.A1, Note.D2, Note.D1, Note.A1, Note.D1, Note.A1, Note.D2, Note.D1, Note.A1, Note.D2, Note.D1, Note.A1, Note.Cs1, Note.Gs1, Note.Cs2, Note.Cs1, Note.Gs1, Note.Cs2, Note.Cs1, Note.Gs1, Note.Cs1, Note.Gs1, Note.Cs2, Note.Cs1, Note.Cs2, Note.Gs1, Note.Cs1, Note.Gs1];
			break;
		case "tutorial":
			note_array = [Note.Ds0, Note.E0, Note.F0, Note.Cs1, Note.F0, Note.Cs1, Note.F0, Note.Cs1, Note.Cs1, Note.Ds1, Note.E1, Note.F1, Note.Cs1, Note.Ds1, Note.F1, Note.C1, Note.Ds1, Note.Cs1, Note.Ds0, Note.E0, Note.F0, Note.Cs1, Note.F0, Note.Cs1, Note.F0, Note.Cs1, Note.As0, Note.Gs0, Note.G0, Note.As0, Note.Cs1, Note.F1, Note.Ds1, Note.Cs1, Note.As0, Note.Ds1];
			break;
		case "entryway":
			note_array = [Note.G0, Note.As0, Note.C1, Note.D1, Note.C1, Note.As0, Note.G0, Note.Ds0, Note.As0, Note.C1, Note.D1, Note.C1, Note.F1, Note.D1, Note.G0, Note.As0, Note.C1, Note.D1, Note.F1, Note.As1, Note.C2, Note.C2, Note.As1, Note.C2, Note.D2, Note.Ds2, Note.D2, Note.G1];
			break;
		case "steamy":
			note_array = [Note.Ds1, Note.Fs1, Note.As1, Note.B1, Note.A1, Note.As1, Note.A1, Note.Fs1, Note.Ds1, Note.Cs1, Note.Fs1, Note.As1, Note.B1, Note.A1, Note.As1, Note.Fs2, Note.F2, Note.Ds2, Note.B0, Note.Ds1, Note.Fs1, Note.As1, Note.Fs1, Note.A1, Note.Gs1, Note.Fs1, Note.B0, Note.As0, Note.D1, Note.F1, Note.Gs1, Note.F1, Note.As1, Note.Gs1, Note.Fs1, Note.Ds1];
			break;
		case "mineshaft":
			note_array = [Note.Cs1, Note.Ds1, Note.E1, Note.Ds1, Note.C1, Note.A0, Note.Gs0, Note.Fs0, Note.E0, Note.Fs0, Note.A0, Note.Cs1, Note.E1, Note.A1, Note.Gs1, Note.Fs1, Note.E1, Note.Ds1, Note.E1, Note.Ds1, Note.Cs1, Note.E1, Note.Ds1, Note.Cs1, Note.E1, Note.Ds1, Note.Gs0, Note.E1, Note.Ds1, Note.C1, Note.Gs0, Note.A0, Note.Gs0, Note.Fs0, Note.Gs0, Note.A0, Note.E0, Note.Cs0, Note.A0, Note.E0, Note.Cs0, Note.A0, Note.E0, Note.A0, Note.A0, Note.E1, Note.Ds1, Note.Gs1];
			break;
		case "molasses":
			note_array = [Note.D0, Note.D1, Note.C1, Note.A0, Note.G0, Note.F0, Note.F0, Note.F0, Note.G0, Note.F0, Note.A0, Note.G0, Note.D0, Note.D0, Note.F0, Note.F0, Note.G0, Note.D0, Note.A0, Note.C1, Note.D1, Note.D1, Note.A0, Note.G0, Note.A0, Note.G0, Note.F0, Note.G0, Note.A0, Note.D0, Note.D0, Note.F0, Note.F0, Note.A0, Note.D1, Note.C1, Note.D1, Note.F1];
			break;
	}
	
	return note_array;
}

global.MenuNoteArray = scr_defineLevelMenuTune("none");
global.MenuNoteArraySelect = 0;
