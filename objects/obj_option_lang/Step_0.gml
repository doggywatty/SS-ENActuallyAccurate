scr_getinput_menu();
if (inputBuffer > 0)
{
	scr_input_varinit();
	inputBuffer--;
}

var select_move = key_left2 + key_right2;
optionSelectionH += select_move;
optionSelectionH = wrap(optionSelectionH, 0, array_length(global.langFiles) - 1);
if (key_slap2 || key_start2 || key_jump)
{
	event_play_oneshot("event:/SFX/ui/menuBack");
	with obj_option
		option_goto(backMenu, backOption);
	instance_destroy();
	exit;
}

if (optionSelectionH != oldOptionSelectionH)
{
	inputBuffer = 2;
	event_play_oneshot("event:/SFX/ui/menuSelect");
	oldOptionSelectionH = optionSelectionH;
	var f = global.langFiles[optionSelectionH];
	if (f != $"{global.langName}.txt")
	{
		scr_lang_set_file(f);
		with obj_screen
			alarm[2] = 1;
		global.langUpdated = true;
		quick_write_option("Settings", "lang", global.langName);
		trace("Current language: ", lang_get("language"));
	}
	
	var is_left = select_move <= -1;
	with (menuArrow[is_left ? 0 : 1])
		offSet = is_left ? -5 : 5;
}

for (var i = 0; i < array_length(menuArrow); i++)
{
	with (menuArrow[i])
		offSet = approach(offSet, 0, 1);
}
