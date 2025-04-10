scr_collision();
scr_conveyorBeltKinematics();
var soundtest_check = instance_exists(obj_soundTest) && obj_soundTest.pauseStatus;
fmod_studio_event_instance_set_paused(songInst, soundtest_check);
if (event_instance_isplaying(songInst))
	fmod_quick3D(songInst);
if (playerID.sprite_index != spr_player_PZ_idle_breakdance && playerID.sprite_index != spr_player_PZ_walk_breakdance)
	instance_destroy();
