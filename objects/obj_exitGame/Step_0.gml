scr_getinput_menu();
var old_selection = optionSelection;
optionSelection += (key_right2 + key_left2);
optionSelection = clamp(optionSelection, 0, 1);
if (optionSelection != old_selection)
	event_play_oneshot("event:/SFX/ui/step");
if (key_jump)
{
	if (optionSelection == 1)
	{
		instance_destroy();
		exit;
	}
	else
		game_end();
}
else if (key_slap2 || key_start2)
	instance_destroy();
