var _type = ds_map_find_value(async_load, "type");
if (_type == "video_start")
{
	video_set_volume((!global.unfocusedMute || window_has_focus()) ? real_volume : 0);
	displayVideo = true;
}
else if (_type == "video_end")
{
	if displayVideo
	{
		event_user(0);
		video_close();
	}
}
