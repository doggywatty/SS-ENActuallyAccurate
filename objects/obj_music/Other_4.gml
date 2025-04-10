var sfxreverb_rooms = [hub_mindpalace, hub_mindvault];
fmod_studio_system_set_parameter_by_name("sfxReverb", array_contains(sfxreverb_rooms, room), false);

if !global.panic
{
	var target_room_music = ds_map_find_value(global.RoomMusicMap, room);
	if !is_undefined(target_room_music) && is_struct(target_room_music)
	{
		var previous_room_music = global.RoomMusic;
		if (is_undefined(previous_room_music) || previous_room_music.eventName != target_room_music.eventName)
		{
			fmod_studio_event_instance_start(target_room_music.musicInst);
			fmod_studio_event_instance_set_paused(target_room_music.musicInst, false);
			
			if !is_undefined(previous_room_music)
			{
				fmod_studio_event_instance_stop(previous_room_music.musicInst, true);
				if !is_undefined(previous_room_music.secretMusicInst)
					fmod_studio_event_instance_stop(previous_room_music.secretMusicInst, true);
			}
			
			global.RoomMusic = target_room_music;
			with global.RoomMusic
			{
				if !is_undefined(musicFunc)
					musicFunc(room, musicInst, secretMusicInst);
				fmod_studio_event_instance_set_callback(musicInst, FMOD_STUDIO_EVENT_CALLBACK.TIMELINE_BEAT);
			}
		}
	}
	
	if instance_exists(obj_gummyharry)
	{
		fmod_studio_event_instance_start(global.HarryMusicInst);
		fmod_studio_event_instance_set_paused(global.HarryMusicInst, false);
		fmod_studio_system_set_parameter_by_name("pillarfade", 0, true);
	}
	else
		fmod_studio_event_instance_stop(global.HarryMusicInst, true);
}

if (global.RoomIsSecret)
{
	currentSecretStatus = true;
	if !is_undefined(global.RoomMusic) && !is_undefined(global.RoomMusic.secretMusicInst)
	{
		fmod_studio_event_instance_start(global.RoomMusic.secretMusicInst);
		var music_timeline_percent = fmod_studio_event_instance_get_timeline_position(global.RoomMusic.musicInst) / fmod_getEventLength(global.RoomMusic.eventName);
		var secret_pos = music_timeline_percent * fmod_getEventLength(global.RoomMusic.secretEventName);
		fmod_studio_event_instance_set_timeline_position(global.RoomMusic.secretMusicInst, secret_pos);
		fmod_studio_event_instance_set_paused(global.RoomMusic.musicInst, true);
		fmod_studio_event_instance_set_paused(global.RoomMusic.secretMusicInst, false);
		fmod_studio_event_instance_set_callback(global.RoomMusic.secretMusicInst, FMOD_STUDIO_EVENT_CALLBACK.TIMELINE_BEAT);
	}
	
	if global.panic
	{
		fmod_studio_event_instance_set_paused(global.EscapeMusicInst, true);
		fmod_studio_event_instance_set_callback(global.EscapeMusicInst, FMOD_STUDIO_EVENT_CALLBACK.NESTED_TIMELINE_BEAT);
	}
}

if (room == rank_room)
	stop_music();
