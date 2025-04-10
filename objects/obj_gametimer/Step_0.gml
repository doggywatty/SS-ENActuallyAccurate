if !global.gamePauseState
	global.CurrentTime += (delta_time / power(10, 3));
if (room != rm_mainmenu && room != rm_introVideo && room != rm_startupLogo && room != rm_disclaimer && room != rm_credits)
{
	in_level = !instance_exists(obj_startGate) && room != rm_titlecard && string_copy(room_get_name(room), 1, 3) != "hub" && !is_hub();
	stop_timer = room == rank_room || instance_exists(obj_endlevelfade) || (room == hub_mindpalace || room == hub_mindvault);
	freeze_timer = (global.gamePauseState || global.freezeframe || (instance_exists(obj_parent_player)
	&& obj_parent_player.state == States.frozen) || (room == hub_mindpalace || room == hub_mindvault))
	&& !global.option_speedrun_timer;
	if !freeze_timer
	{
		global.SaveFrames++;
		if (global.SaveFrames >= 60)
		{
			global.SaveSeconds++;
			global.SaveFrames -= 60;
		}
		if (global.SaveSeconds >= 60)
		{
			global.SaveMinutes++;
			global.SaveSeconds -= 60;
		}
	}
	
	if (in_level && !stop_timer && !freeze_timer)
	{
		global.LevelFrames++;
		if (global.LevelFrames >= 60)
		{
			global.LevelSeconds++;
			global.LevelFrames -= 60;
		}
		if (global.LevelSeconds >= 60)
		{
			global.LevelMinutes++;
			global.LevelSeconds -= 60;
		}
	}
	else if (!freeze_timer && !stop_timer)
	{
		global.LevelFrames = 0;
		global.LevelSeconds = 0;
		global.LevelMinutes = 0;
	}
}
