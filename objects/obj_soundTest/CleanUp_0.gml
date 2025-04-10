var cur_music = musicArray[currentSelection];
fmod_studio_event_instance_stop(cur_music.eventInstance, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
fmod_studio_system_set_parameter_by_name("special", 0, true);

for (var i = 0; i < array_length(musicArray); i++)
	fmod_studio_event_instance_release(musicArray[i]);
