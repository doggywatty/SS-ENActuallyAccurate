var _type = ds_map_find_value(async_load, "type");
if (_type == "video_start")
{
	updateVolume();
	displayVideo = true;
	alarm[1] = -1;
	show_debug_message("Video Loaded.");	
}
else if (_type == "video_end")
{
	if displayVideo
	{
		event_user(0);
		video_close();
	}
	show_debug_message("Video Finished.");	
}
