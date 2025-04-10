var ev_type = ds_map_find_value(async_load, "event_type");
if (ev_type == "DiscordReady")
{
	global.DiscordInitialized = true;
	np_setpresence_timestamps(date_current_datetime(), 0, 0);
}
