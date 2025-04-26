global.GameLevelMap = ds_map_create();
global.InternalLevelName = "none";
function scr_defineTitleCard(_img_ind, _music = "event:/music/w1/entryway_titlecard", _x = -4, _y = -4) constructor
{
	image_index = _img_ind;
	music = _music;
	x = _x;
	y = _y;
}

function scr_defineLevel(_levelWorld, _internalName, _visualName, _firstRoom, _groupArr = [], _sRankRequirement = 20000, _titleCardInfo = -4, _isBoss = false)
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

function scr_gotoLevel(_level)
{
	var level_info = ds_map_find_value(global.GameLevelMap, _level);
	var first_room = level_info.firstRoom;
	global.texturesToLoad = array_concat(global.texturesToLoad, level_info.groupArr);
	global.InternalLevelName = level_info.internalName;
	global.LevelFirstRoom = first_room;
	global.srank = level_info.sRankRequirement;
	global.arank = global.srank / 2;
	global.brank = global.arank / 2;
	global.crank = global.brank / 2;
}

function scr_defineLevelMenuTune(_note)
{
	var note_array = [];
	switch _note
	{
		default:
			note_array = [
				MusicNote.CS6, MusicNote.GS6, MusicNote.CS7, MusicNote.CS6, MusicNote.GS6, MusicNote.CS7,
				MusicNote.CS6, MusicNote.GS6, MusicNote.CS6, MusicNote.GS6, MusicNote.CS7, MusicNote.CS6,
				MusicNote.GS6, MusicNote.CS7, MusicNote.CS6, MusicNote.GS6, MusicNote.C6, MusicNote.G6,
				MusicNote.C7, MusicNote.C6, MusicNote.G6, MusicNote.C7, MusicNote.C6, MusicNote.G6,
				MusicNote.C6, MusicNote.G6, MusicNote.C7, MusicNote.C6, MusicNote.C7, MusicNote.G6,
				MusicNote.C6, MusicNote.G6
			];
			break;
		case "tutorial":
			note_array = [
				MusicNote.D5, MusicNote.DS5, MusicNote.E5, MusicNote.C6, MusicNote.E5, MusicNote.C6,
				MusicNote.E5, MusicNote.C6, MusicNote.C6, MusicNote.D6, MusicNote.DS6, MusicNote.E6,
				MusicNote.C6, MusicNote.D6, MusicNote.E6, MusicNote.B5, MusicNote.D6, MusicNote.C6,
				MusicNote.D5, MusicNote.DS5, MusicNote.E5, MusicNote.C6, MusicNote.E5, MusicNote.C6,
				MusicNote.E5, MusicNote.C6, MusicNote.A5, MusicNote.G5, MusicNote.FS5, MusicNote.A5,
				MusicNote.C6, MusicNote.E6, MusicNote.D6, MusicNote.C6, MusicNote.A5, MusicNote.D6
			];
			break;
		case "entryway":
			note_array = [
				MusicNote.FS5, MusicNote.A5, MusicNote.B5, MusicNote.CS6, MusicNote.B5, MusicNote.A5,
				MusicNote.FS5, MusicNote.D5, MusicNote.A5, MusicNote.B5, MusicNote.CS6, MusicNote.B5,
				MusicNote.E6, MusicNote.CS6, MusicNote.FS5, MusicNote.A5, MusicNote.B5, MusicNote.CS6,
				MusicNote.E6, MusicNote.A6, MusicNote.B6, MusicNote.B6, MusicNote.A6, MusicNote.B6,
				MusicNote.CS7, MusicNote.D7, MusicNote.CS7, MusicNote.FS6
			];
			break;
		case "steamy":
			note_array = [
				MusicNote.D6, MusicNote.F6, MusicNote.A6, MusicNote.AS6, MusicNote.GS6, MusicNote.A6,
				MusicNote.GS6, MusicNote.F6, MusicNote.D6, MusicNote.C6, MusicNote.F6, MusicNote.A6,
				MusicNote.AS6, MusicNote.GS6, MusicNote.A6, MusicNote.F7, MusicNote.E7, MusicNote.D7,
				MusicNote.AS5, MusicNote.D6, MusicNote.F6, MusicNote.A6, MusicNote.F6, MusicNote.GS6,
				MusicNote.G6, MusicNote.F6, MusicNote.AS5, MusicNote.A5, MusicNote.CS6, MusicNote.E6,
				MusicNote.G6, MusicNote.E6, MusicNote.A6, MusicNote.G6, MusicNote.F6, MusicNote.D6
			];
			break;
		case "mineshaft":
			note_array = [
				MusicNote.C6, MusicNote.D6, MusicNote.DS6, MusicNote.D6, MusicNote.B5, MusicNote.GS5,
				MusicNote.G5, MusicNote.F5, MusicNote.DS5, MusicNote.F5, MusicNote.GS5, MusicNote.C6,
				MusicNote.DS6, MusicNote.GS6, MusicNote.G6, MusicNote.F6, MusicNote.DS6, MusicNote.D6,
				MusicNote.DS6, MusicNote.D6, MusicNote.C6, MusicNote.DS6, MusicNote.D6, MusicNote.C6,
				MusicNote.DS6, MusicNote.D6, MusicNote.G5, MusicNote.DS6, MusicNote.D6, MusicNote.B5,
				MusicNote.G5, MusicNote.GS5, MusicNote.G5, MusicNote.F5, MusicNote.G5, MusicNote.GS5,
				MusicNote.DS5, MusicNote.C5, MusicNote.GS5, MusicNote.DS5, MusicNote.C5, MusicNote.GS5,
				MusicNote.DS5, MusicNote.GS5, MusicNote.GS5, MusicNote.DS6, MusicNote.D6, MusicNote.G6
			];
			break;
		case "molasses":
			note_array = [
				MusicNote.CS5, MusicNote.CS6, MusicNote.B5, MusicNote.GS5, MusicNote.FS5, MusicNote.E5,
				MusicNote.E5, MusicNote.E5, MusicNote.FS5, MusicNote.E5, MusicNote.GS5, MusicNote.FS5,
				MusicNote.CS5, MusicNote.CS5, MusicNote.E5, MusicNote.E5, MusicNote.FS5, MusicNote.CS5,
				MusicNote.GS5, MusicNote.B5, MusicNote.CS6, MusicNote.CS6, MusicNote.GS5, MusicNote.FS5,
				MusicNote.GS5, MusicNote.FS5, MusicNote.E5, MusicNote.FS5, MusicNote.GS5, MusicNote.CS5,
				MusicNote.CS5, MusicNote.E5, MusicNote.E5, MusicNote.GS5, MusicNote.CS6, MusicNote.B5,
				MusicNote.CS6, MusicNote.E6
			];
			break;
	}
	return note_array;
}

global.MenuNoteArray = scr_defineLevelMenuTune("none");
global.MenuNoteArraySelect = 0;
