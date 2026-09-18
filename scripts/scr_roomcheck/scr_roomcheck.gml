function is_preGame(arg0 = room)
{
	var special_rooms = [rm_preinitializer, rm_initializer, rm_startupLogo, rm_introVideo, rm_mainmenu, rm_credits, rm_titlecard, rm_disclaimer];
	return array_contains(special_rooms, arg0);
}

function scr_roomcheck(arg0 = room)
{
	var special_rooms = [rm_initializer, rm_preinitializer, rm_startupLogo, rm_devroom, rm_introVideo, rank_room, timesuproom, rm_mainmenu, rm_credits, rm_titlecard, rm_disclaimer, rm_blank];
	return !array_contains(special_rooms, arg0);
}

function is_hub(arg0 = room)
{
	var hub_rooms = [hub_soundTest, hub_demohallway, hub_paintstudio, hub_molasses, hub_mindpalace, hub_mindvault, rm_credits];
	return array_contains(hub_rooms, arg0);
}

function is_tutorial(arg0 = room)
{
	var tut_rooms = [tutorial_1, tutorial_2, tutorial_3, tutorial_4, tutorial_5];
	return array_contains(tut_rooms, arg0);
}
