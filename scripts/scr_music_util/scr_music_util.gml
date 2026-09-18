function set_volume_options(arg0 = global.masterVolume, arg1 = global.musicVolume, arg2 = global.soundVolume)
{
	fmod_studio_system_set_parameter_by_name("masterVolume", arg0, true);
	fmod_studio_system_set_parameter_by_name("musicVolume", arg1, true);
	fmod_studio_system_set_parameter_by_name("sfxVolume", arg2, true);
}

function stop_music(arg0 = true)
{
	if (!is_undefined(global.RoomMusic))
	{
		fmod_studio_event_instance_stop(global.RoomMusic.musicInst, arg0);
		fmod_studio_event_instance_stop(global.RoomMusic.secretMusicInst, arg0);
	}
	
	fmod_studio_event_instance_stop(global.HarryMusicInst, arg0);
	fmod_studio_event_instance_stop(global.EscapeMusicInst, arg0);
}
