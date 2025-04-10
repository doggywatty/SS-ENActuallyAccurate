function scr_painterdemodialogue()
{
	var secret_count = 0;
	var levels = ["entryway", "steamy", "mineshaft", "molasses"];
	var molasses_secrets = 0;
	ini_open(global.SaveFileName);
	for (var i = 0; i < array_length(levels); i++)
	{
		for (var j = 0; j < 3; j++)
		{
			var secret_collected = ini_read_real("Secret", levels[i] + string(j + 1), 0) ? 1 : 0;
			secret_count += secret_collected;
			if (levels[i] == "molasses")
				molasses_secrets += secret_collected;
		}
	}
	ini_close();
	
	var info_arr = [];
	talk_sound = "event:/SFX/hub/painterThink";
	var dialogue_key;
	if (room == hub_molasses)
	{
		if scr_check_completion()
		{
			dialogue_key = "demopainter_molasses_sleeping";
			idle = spr_painteridle7;
			speak = spr_painteridle7;
			talk_sound = -4;
		}
		else if (molasses_secrets >= 3)
		{
			if irandom(1) == 0
			{
				dialogue_key = "demopainter_molasses_gotsecrets_a";
				idle = spr_painteridle;
				speak = spr_painteridle;
			}
			else
			{
				dialogue_key = "demopainter_molasses_gotsecrets_b";
				idle = spr_painteridle5;
				speak = spr_painteridle5;
				talk_sound = "event:/SFX/hub/painterThinkHappy";
			}
		}
		else
		{
			dialogue_key = "demopainter_molasses";
			idle = spr_painteridle6;
			speak = spr_painteridle6;
			array_push(info_arr, scr_getDialogIcon("INK"));
			talk_sound = "event:/SFX/hub/painterThinkSad";
		}
	}
	else if secret_count == 0
	{
		if global.NewFile
		{
			dialogue_key = "demopainter_newfile";
			idle = spr_painteridle1;
			speak = spr_painteridle1;
			array_push(info_arr, scr_getDialogIcon("INK"));
			talk_sound = "event:/SFX/hub/painterThinkAngry";
		}
		else
		{
			dialogue_key = "demopainter_nosecrets";
			idle = spr_painteridle1;
			speak = spr_painteridle1;
			array_push(info_arr, scr_getDialogIcon("INK"));
			talk_sound = "event:/SFX/hub/painterThinkAngry";
		}
	}
	else if (secret_count > 0 && secret_count < 3)
	{
		dialogue_key = "demopainter_fewsecrets";
		idle = spr_painteridle1;
		speak = spr_painteridle1;
		talk_sound = "event:/SFX/hub/painterThinkAngry";
		array_push(info_arr, scr_getDialogIcon("INK"));
	}
	else if (secret_count < 6)
	{
		dialogue_key = "demopainter_3secrets";
		idle = spr_painteridle2;
		speak = spr_painteridle3;
		talk_sound = "event:/SFX/hub/painterThinkAngry";
		array_push(info_arr, scr_getDialogIcon("INK"));
	}
	else if (secret_count < 9)
	{
		dialogue_key = "demopainter_6secrets";
		idle = spr_painteridle;
		speak = spr_painteridle;
	}
	else if (secret_count < 12)
	{
		dialogue_key = "demopainter_9secrets";
		idle = spr_painteridle4;
		speak = spr_painteridle4;
	}
	else if (secret_count == 12)
	{
		dialogue_key = "demopainter_allsecrets";
		idle = spr_painteridle5;
		speak = spr_painteridle5;
		array_push(info_arr, scr_getDialogIcon("INK"));
	}
	else
		dialogue_key = "demopainter_invalidsecrets";
	if (dialogue_key != "demopainter_newfile" && dialogue_key != "demopainter_invalidsecrets" && global.UseOfftopic && irandom(2) == 0 && room != hub_molasses)
	{
		if (global.SaveMinutes >= 60)
		{
			if secret_count == 12
			{
				dialogue_key = "demopainter_overtimeallsecrets";
				idle = spr_painteridle5;
				speak = spr_painteridle5;
				talk_sound = "event:/SFX/hub/painterThinkHappy";
			}
			else
			{
				dialogue_key = "demopainter_overtimenotallsecrets";
				idle = spr_painteridle2;
				speak = spr_painteridle3;
				talk_sound = "event:/SFX/hub/painterThinkAngry";
				array_push(info_arr, scr_getDialogIcon("INK"));
			}
		}
		
		if ((current_month == 12 && current_day == 31 && current_year == 2024) || (current_month == 1 && current_day == 1 && current_year == 2025))
		{
			dialogue_key = "demopainter_newyears";
			idle = spr_painteridle_newyears;
			speak = spr_painteridle_newyears;
			talk_sound = "event:/SFX/hub/painterThinkAngry";
		}
		else if (current_month == 2 && current_day == 14)
		{
			dialogue_key = "demopainter_valentines";
			idle = spr_painteridle2;
			speak = spr_painteridle3;
			talk_sound = "event:/SFX/hub/painterThinkSad";
		}
	}
	return lang_get(dialogue_key, info_arr);
}
