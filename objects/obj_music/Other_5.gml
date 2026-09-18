if (!currentSecretStatus)
	exit;

if (!is_undefined(global.RoomMusic))
{
	fmod_studio_event_instance_stop(global.RoomMusic.secretMusicInst, true);
	
	if (!global.panic)
	{
		fmod_studio_event_instance_set_paused(global.RoomMusic.musicInst, false);
		fmod_studio_event_instance_set_callback(global.RoomMusic.musicInst, (4096 << 0));
	}
}

if (global.panic)
{
	fmod_studio_event_instance_set_paused(global.EscapeMusicInst, false);
	fmod_studio_event_instance_set_callback(global.EscapeMusicInst, (262144 << 0));
}

currentSecretStatus = false;
global.RoomIsSecret = false;
