fmod_studio_event_instance_stop(global.RankMusicInst, false);
global.InternalLevelName = "none";
instance_create(x, y, obj_fadeoutTransition, 
{
	levelStart: true,
	goToHub: true
});
alarm[0] = -1;
alarm[1] = -1;
alarm[2] = -1;
alarm[3] = -1;
alarm[5] = -1;
