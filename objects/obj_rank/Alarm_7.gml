event = 1;
if global.rank == "c" || global.rank == "d"
    fmod_studio_event_instance_set_parameter_by_name(global.RankMusicInst, "state", 11, true);
else
    fmod_studio_event_instance_set_parameter_by_name(global.RankMusicInst, "state", 10, true);
