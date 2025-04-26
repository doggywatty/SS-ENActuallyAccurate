kill_sounds([activeSFX]);

with obj_pause
{
    fmod_studio_event_instance_set_parameter_by_name(pauseMusic, "state", 0, false);
    alarm[0] = 3;
    alarm[1] = 1;
    key_jump = false;
}

with obj_mainfileselect
    alarm[1] = 1;

if changedAnyOption
{
	with obj_hudManager
		saveAlpha = 10;
}