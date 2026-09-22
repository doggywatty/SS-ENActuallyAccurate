function event_instance_isplaying(_event_path)
{
	return fmod_studio_event_instance_get_playback_state(_event_path) == FMOD_STUDIO_PLAYBACK_STATE.PLAYING;
}

function event_instance_exists(_event_path)
{
	return fmod_studio_event_description_get_instance_count(_event_path) > 0;
}

function event_play_oneshot(_event_path = "", _x = undefined, _y = undefined, _z = 0)
{
	var _id = fmod_createEventInstance(_event_path);
	fmod_studio_event_instance_start(_id);
	
	if (!is_undefined(_x) && !is_undefined(_y))
		fmod_event_set3DPosition(_id, _x, _y, _z);
	
	fmod_studio_event_instance_release(_id);
	return _id;
}

function event_play_oneshot_ext(_event_path = "", _x = undefined, _y = undefined, _z = 0)
{
	var _id = fmod_createEventInstance(_event_path);
	fmod_studio_event_instance_start(_id);
	
	if (!is_undefined(_x) && !is_undefined(_y))
		fmod_event_set3DPosition(_id, _x, _y, _z);
	
	ds_list_add(global.FMOD_OneShotList, 
	{
		id: _id,
		name: _event_path,
		one_shot: true
	});
	return _id;
}

function event_play_multiple(_event_path = "", _x = undefined, _y = undefined, _z = 0)
{
	event_play_oneshot(_event_path, _x, _y, _z);
}

function fmod_quick3D(_event_path, _x = x, _y = y, arg3 = 0)
{
	if (event_instance_isplaying(_event_path))
		fmod_event_set3DPosition(_event_path, _x, _y, arg3);
}

function kill_sounds(_event_snd)
{
	if (is_array(_event_snd))
	{
		for (var i = 0; i < array_length(_event_snd); i++)
		{
			var snd = _event_snd[i];
			fmod_studio_event_instance_stop(snd, true);
			fmod_studio_event_instance_release(snd);
		}
	}
	else
	{
		fmod_studio_event_instance_stop(_event_snd, true);
		fmod_studio_event_instance_release(_event_snd);
	}
}

function kill_sound_list(_event_snd)
{
	if (is_array(_event_snd))
	{
		for (var i = 0; i < array_length(_event_snd); i++)
		{
			var snd_id = _event_snd[i];
			
			for (var p = 0; p < ds_list_size(global.FMOD_OneShotList); p++)
			{
				var entry = ds_list_find_value(global.FMOD_OneShotList, p);
				
				if (entry != noone && !is_undefined(entry) && entry.id == snd_id)
				{
					kill_sounds(snd_id);
					ds_list_delete(global.FMOD_OneShotList, p);
					p--;
				}
			}
		}
	}
	else
	{
		var snd_id = _event_snd;
		
		for (var p = 0; p < ds_list_size(global.FMOD_OneShotList); p++)
		{
			var entry = ds_list_find_value(global.FMOD_OneShotList, p);
			
			if (entry != noone && !is_undefined(entry) && entry.id == snd_id)
			{
				kill_sounds(snd_id);
				ds_list_delete(global.FMOD_OneShotList, p);
			}
		}
	}
}
