function scr_saveinit()
{
	video_close();	
    ini_open(global.SaveFileName);
    global.SaveSeconds = ini_read_real("Game", "seconds", 0);
    global.SaveMinutes = ini_read_real("Game", "minutes", 0);
    global.HurtCounter = ini_read_real("Game", $"damage_{scr_getCharacterPrefix(Characters.Pizzelle)}", 0);
    global.HurtMilestone = global.HurtCounter;
    global.PlayerPaletteIndex = ini_read_real("Misc", $"playerPaletteIndex_{scr_getCharacterPrefix(Characters.Pizzelle)}", 2);
	global.GLOBAL_FUN = ini_read_real("Game", "FUN", -4);
	if (global.GLOBAL_FUN <= -4)
	{
		global.GLOBAL_FUN = irandom_range(0, 100);
		ini_write_real("Game", "FUN", global.GLOBAL_FUN);
	}
	var cur_version = ini_read_real("SaveFormat", "version", 0);
	if (cur_version > 1)
		show_debug_message($"WARNING: {global.SaveFileName} Version: {cur_version} is higher than game's expected {global.SaveFileName} version: {1}. Tomfoolery afoot.");
	if (!ini_section_exists("SaveFormat") || !ini_key_exists("SaveFormat", "version") || cur_version < 1)
	{
		show_debug_message($"ALERT: Updating {global.SaveFileName} version... {cur_version} to {1}");
		ini_write_real("SaveFormat", "version", 1);
	}
    ini_close();
    with obj_achievementTracker
        event_user(0);
}

