if (surface_exists(pauseSurface))
	surface_free(pauseSurface);

pausecount = -1;

if (room != rank_room && !is_hub())
{
	global.gamePauseState = 0;
	fmod_event_setPause_all(false);
	scr_unpause_instances(true);
	fmod_event_stop_all(true);
	room_goto_fixed(rm_void);
	instance_destroy(obj_fadeoutTransition);
	instance_destroy(obj_cutsceneManager);
	with obj_parent_player
		state = States.actor;
	with (instance_create(x, y, obj_fadeoutTransition, 
	{
		levelStart: true,
		goToHub: true
	}))
		fadealpha = 1;
	
	global.UseOfftopic = true;
}
else if is_hub()
{
	global.gamePauseState = 0;
	fmod_event_setPause_all(false);
	scr_unpause_instances(true);
	fmod_event_stop_all(true);
	with obj_gametimer
		saveTime();
	scr_levelSet();
	global.InternalLevelName = "none";
	room_goto_fixed(rm_mainmenu);
	instance_destroy(obj_cutsceneManager);
	
	with obj_parent_player
	{
		scr_characterSprite();
		state = States.titlescreen;
		targetDoor = "A";
	}
	
	with instance_create(x, y, obj_fadeoutTransition)
	{
		fadealpha = 1.5;
		fadein = true;
	}
}
else
	event_play_oneshot("event:/SFX/ui/confirm");
