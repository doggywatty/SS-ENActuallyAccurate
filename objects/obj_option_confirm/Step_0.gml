scr_getinput_menu();
if (inputBuffer > 0)
{
	scr_input_varinit();
	inputBuffer--;
}

var old_selection = optionSelection;
optionSelection += (key_right2 + key_left2);
optionSelection = clamp(optionSelection, 0, 1);
if (optionSelection != old_selection)
	event_play_oneshot("event:/SFX/ui/step");
if key_jump
{
	if (optionSelection == 1)
	{
		resetFunc(previousValue);
		event_play_oneshot("event:/SFX/ui/menuBack");
		instance_destroy();
		exit;
	}
	else
	{
		confirmFunc(previousValue);
		event_play_oneshot("event:/SFX/ui/menuSelect");
		instance_destroy();
		exit;
	}
}
else if (key_slap2 || key_start2)
{
	resetFunc(previousValue);
	event_play_oneshot("event:/SFX/ui/menuBack");
	instance_destroy();
	exit;
}

if (timeWait-- < 0)
{
	resetFunc(previousValue);
	event_play_oneshot("event:/SFX/ui/menuBack");
	instance_destroy();
	exit;
}
