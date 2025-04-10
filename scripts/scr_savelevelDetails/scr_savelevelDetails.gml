function scr_savelevelDetails(_leveldetails = true)
{
	var all_confecti = global.MallowFollow && global.ChocoFollow && global.CrackFollow && global.WormFollow && global.CandyFollow;
	global.rank = "d";
	if (global.Collect >= global.srank)
	{
		if (!global.ComboLost && global.secretfound > 2 && global.lapcount >= 1 && global.Treasure)
			global.rank = "p";
		else
			global.rank = "s";
	}
	else
	{
		var ranks = ["a", "b", "c"];
		var rank_cutoffs = [global.arank, global.brank, global.crank];
		for (var i = 0; i < array_length(ranks); i++)
		{
			if (global.Collect >= rank_cutoffs[i])
			{
				global.rank = ranks[i];
				break;
			}
		}
	}
	
	var level_sec = 0;
	with obj_gametimer
	{
		saveTime();
		level_sec = addTime([global.LevelFrames], [global.LevelSeconds], [global.LevelMinutes]);
	}
	
	ini_open(global.SaveFileName);
	ini_update_stat("Game", string($"damage_{scr_getCharacterPrefix(global.playerCharacter)}"), global.HurtCounter);
	global.HurtMilestone = global.HurtCounter;
	ini_update_stat("Time", string(global.InternalLevelName), level_sec, true);
	for (var i = 0; i < 3; i++)
		ini_update_stat("Secret", string(global.InternalLevelName) + string(i + 1), global.SecretsFound[i]);
	
	ini_update_stat("Treasure", string(global.InternalLevelName), global.Treasure);
	var _score = real(ini_read_string("Highscore", string(global.InternalLevelName), "0"));
	ini_update_stat("Highscore", string(global.InternalLevelName), global.Collect);
	if (global.Collect > _score)
		global.NewHighScore = true;
	else
		global.NewHighScore = false;
	
	ini_update_stat("Laps", string(global.InternalLevelName), global.lapcount);
	ini_update_stat("Confecti", string(global.InternalLevelName) + "1", global.MallowFollow);
	ini_update_stat("Confecti", string(global.InternalLevelName) + "2", global.ChocoFollow);
	ini_update_stat("Confecti", string(global.InternalLevelName) + "3", global.CrackFollow);
	ini_update_stat("Confecti", string(global.InternalLevelName) + "4", global.WormFollow);
	ini_update_stat("Confecti", string(global.InternalLevelName) + "5", global.CandyFollow);
	if (global.InternalLevelName == "tutorial")
	{
		ini_update_stat("Misc", "completedtutorial", true);
		if (!ini_read_real("Misc", "lapunlockall", false) && level_sec <= 90)
		{
			ini_write_real("Misc", "lapunlockall", true);
			scr_queueToolTipPrompt(lang_get("prompt_lap_unlockall"));
		}
	}
	
	if (rank_checker(global.rank) > rank_checker(ini_read_string("Ranks", string(global.InternalLevelName), "none")))
		ini_write_string("Ranks", string(global.InternalLevelName), global.rank);
	ini_close();
	obj_hudManager.saveAlpha = 10;
	if _leveldetails
	{
		fmod_studio_event_instance_start(global.RankMusicInst);
		fmod_studio_event_instance_set_paused(global.RankMusicInst, false);
		var rank_as_num = clamp(5 - rank_checker(), 0, 5);
		fmod_studio_event_instance_set_parameter_by_name(global.RankMusicInst, "state", rank_as_num, true);
	}
}

function ini_update_stat(_section, _key, _str, _stat_state = false)
{
	var val = ini_read_string(_section, _key, 0);
	if _stat_state
	{
		if (val > _str || val == 0)
			ini_write_string(_section, _key, _str);
		exit;
	}
	if (val < _str)
		ini_write_string(_section, _key, _str);
}

function confecti_count_level(_conf_level)
{
	var confecti_count = 0;
	ini_open(global.SaveFileName);
	for (var i = 1; i < 6; i++)
	{
		var c = string(_conf_level) + string(i);
		if (ini_read_string("Confecti", c, 0) == 1)
			confecti_count++;
	}
	ini_close();
	return confecti_count;
}
