function scr_gamecaptions(_room = room)
{
	var game_caption = undefined;
	switch _room
	{
		case rm_preinitializer:
		case rm_initializer:
			game_caption = "winname_init";
			break;
		case rm_startupLogo:
			game_caption = "winname_logos";
			break;
		case rm_disclaimer:
			game_caption = "winname_disclaimer";
			break;
		case rm_introVideo:
			game_caption = "winname_intro";
			break;
		case rm_mainmenu:
			game_caption = "winname_fileselect";
			break;
		case rm_devroom:
			game_caption = "winname_devroom";
			break;
		case rm_titlecard:
			game_caption = "winname_titlecard";
			break;
		case rank_room:
			game_caption = "winname_rank";
			break;
		case rm_credits:
			game_caption = "winname_credit";
			break;
		case hub_paintstudio:
			game_caption = "winname_hub";
			break;
		case hub_demohallway:
		case hub_molassesB:		
			game_caption = "winname_hub";
			break;
		case hub_molasses:
			game_caption = "winname_hub";
			break;
		case hub_mindpalace:
			game_caption = "winname_mind";
			break;
		case tutorial_1:
			game_caption = "winname_tutorial";
			break;			
		case entryway_1:
			game_caption = "winname_entryway";
			break;
		case steamy_1:
			game_caption = "winname_cotton";
			break;
		case mineshaft_1:
			game_caption = "winname_mines";
			break;
		case mountain_intro:
			game_caption = "Sky High Exhibition Night!";
			break;
		case molasses_1:
			game_caption = "winname_swamp";
			break;
		case cafe_1:
			game_caption = "Early Morning Sugary Spire";
			break;
	}
	if instance_exists(obj_titlecard)
		game_caption = "winname_titlecard";
	if lang_key_exists(game_caption)
		return lang_get(game_caption);
	else
		return game_caption;
}

function scr_roomnames(_room = room)
{
	var room_name = "NO ROOMNAME FOUND-1265";
	switch _room
	{
		case rm_missing:
			room_name = "romname_missing";
			break;
		case hub_paintstudio:
			room_name = "romname_mainhub";
			break;
		case hub_demohallway:
			room_name = "romname_hallway";
			break;
		case hub_molasses:
			room_name = "romname_molasses";
			break;
		default:
			room_name = "NO ROOMNAME FOUND-1265";
			break;
	}
	if lang_key_exists(room_name)
		return lang_get(room_name);
	else
		return room_name;
}
