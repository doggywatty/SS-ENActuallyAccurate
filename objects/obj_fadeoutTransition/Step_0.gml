var load_finished = loaded && unloaded && lang_flushed;
if (fadealpha > 1 && load_finished && !fadein)
{
	fadein = 1;
	var _hub_exit = false;
	var _id = id;
	if instance_exists(obj_parent_player)
	{
		var target_room = obj_parent_player.targetRoom;
		if (goToHub == true)
		{
			global.InternalLevelName = "none";
			target_room = obj_parent_player.hubRoom;
			obj_parent_player.hubTransition = true;
			_hub_exit = !global.CompletedLevel;
		}
		
		if (room_exists(target_room))
		{
			show_debug_message("Fadeout Transition: goToHub: " + string(goToHub) + ", room: " + room_get_name(target_room));
			room_goto_fixed(target_room);
		}
		else
		{
			room_goto_fixed(rm_missing);
			show_debug_message("Room \"" + $"{string(target_room)}" + "\" does not exist. Sent Player to \"rm_missing\"");
		}
	}
	
	if (room == rm_preinitializer)
		room_goto_fixed(rm_initializer);
	if levelStart
		scr_levelSet();
	if secretRoom
		global.RoomIsSecret = true;
	
	if (_hub_exit)
	{
	}
}

if (fadein == 0)
	fadealpha += fadespeed;
if load_finished
{
	if (fadein == 1)
		fadealpha -= fadespeed;
	if (fadein == 1 && fadealpha < 0)
		instance_destroy();
	if (fadein == 0 && fadealpha > 1)
	{
		if (instance_exists(obj_titlecard))
			instance_destroy(obj_titlecard);
	}
}
if (!load_finished && titleCard && !fadein)
	fadealpha = 0;
