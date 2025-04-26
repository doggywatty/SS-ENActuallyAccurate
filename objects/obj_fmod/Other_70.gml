if (ds_map_find_value(async_load, "type") == "win_media_playback")
	global.MediaIsPlaying = ds_map_find_value(async_load, "win_media_playback_status");