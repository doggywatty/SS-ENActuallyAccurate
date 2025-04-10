var cur_music_inst = musicArray[currentSelection].eventInstance;
if (savedSelection != currentSelection)
{
	fmod_studio_event_instance_stop(musicArray[savedSelection].eventInstance, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
	savedSelection = currentSelection;
}

if !event_instance_isplaying(cur_music_inst)
	fmod_studio_event_instance_start(cur_music_inst);

fmod_studio_event_instance_set_paused(cur_music_inst, !pauseStatus);
fmod_studio_system_set_parameter_by_name("special", specialToggle, false);
musicPlaying = pauseStatus && (musicArray[currentSelection].eventPath != "event:/music/Soundtest/painterMixtape" || specialToggle);
