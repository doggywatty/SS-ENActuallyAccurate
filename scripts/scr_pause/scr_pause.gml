function scr_pause_instances(_instance = false)
{
	var dont_pause = [
		obj_pause, obj_fmod, obj_music, obj_screen, obj_rpc, obj_localizer,
		obj_gametimer, obj_inputController
	];
	musicReverb = fmod_studio_system_get_parameter_by_name("musicReverb");
	sfxReverb = fmod_studio_system_get_parameter_by_name("sfxReverb");
	if _instance
	{
		if !is_undefined(global.RoomMusic)
		{
			roomMusicPause = fmod_studio_event_instance_get_paused(global.RoomMusic.musicInst);
			if !is_undefined(global.RoomMusic.secretMusicInst)
				secretPause = fmod_studio_event_instance_get_paused(global.RoomMusic.secretMusicInst);
		}
		escapeMusicPause = fmod_studio_event_instance_get_paused(global.EscapeMusicInst);
		fmod_event_setPause_all(true);
	}
	ds_list_clear(pausedInstances);
	for (var i = 0; i < instance_count; i++)
	{
		var me = instance_find(-3, i);
		if (instance_exists(me) && !array_contains(dont_pause, me.object_index))
			ds_list_add(pausedInstances, me);
	}
	instance_deactivate_all(true);
	for (var p = 0; p < array_length(dont_pause); p++)
		instance_activate_object(dont_pause[p]);
}

function scr_unpause_instances(_instance = false)
{
	fmod_studio_system_set_parameter_by_name("musicReverb", musicReverb, true);
	fmod_studio_system_set_parameter_by_name("sfxReverb", sfxReverb, true);
	if _instance
	{
		fmod_event_setPause_all(false);
		if !is_undefined(global.RoomMusic)
		{
			fmod_studio_event_instance_set_paused(global.RoomMusic.musicInst, roomMusicPause);
			if !is_undefined(global.RoomMusic.secretMusicInst)
				fmod_studio_event_instance_set_paused(global.RoomMusic.secretMusicInst, secretPause);
		}
		fmod_studio_event_instance_set_paused(global.EscapeMusicInst, escapeMusicPause);
		with obj_soundTest
		{
			var cur_music_inst = musicArray[currentSelection].eventInstance;
			fmod_studio_event_instance_set_paused(cur_music_inst, !pauseStatus);
		}
	}
	for (var i = 0; i < ds_list_size(pausedInstances); i++)
	{
		var _id = ds_list_find_value(pausedInstances, i);
		instance_activate_object(_id);
		with _id
		{
			if (instance_exists(self) && variable_instance_exists(id, "mySoundArray"))
			{
				for (var s = 0; s < array_length(mySoundArray); s++)
				{
					var snd_id = mySoundArray[s];
					fmod_studio_event_instance_set_paused(snd_id, false);
				}
			}
		}
	}
	ds_list_clear(pausedInstances);
}
