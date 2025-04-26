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
{
	event_play_oneshot("event:/SFX/ui/step");
	pulseTimer = 3;
	deleteFileBuffer = 0;
}

if (deleteFileBuffer >= deleteFileBufferMax)
{
	event_play_oneshot("event:/SFX/general/explosion", 480, 270);
	ini_open("optionData.ini");
	ini_section_delete("Palettes");
	ini_close();
	with obj_option
		changedAnyOption = true;
	
	var save_path = ["saveData1_EN.ini", "saveData2_EN.ini", "saveData3_EN.ini"];
	for (var i = 0; i < 3; i++)
	{
		if (file_exists(save_path[i]))
		{
			ini_open(save_path[i]);
			ini_key_delete("Misc", $"playerPaletteIndex_{scr_getCharacterPrefix(Characters.Pizzelle)}");
			ini_close();
			with obj_mainfileselect
				filePalette[i] = 2;
		}
	}
	instance_destroy();
	exit;
}

if (key_jump && optionSelection == 1)
{
	pulseTimer = 3;
	deleteFileBuffer = 0;
	event_play_oneshot("event:/SFX/ui/menuBack");
	instance_destroy();
	exit;
}

if (key_slap2 || key_start2)
{
	event_play_oneshot("event:/SFX/ui/menuBack");
	instance_destroy();
	exit;
}

if !key_jump2
{
	deleteFileBuffer = 0;
	pulseTimer = 3;
}
else if (optionSelection == 0)
{
	deleteFileBuffer++;
	pulseTimer += max((deleteFileBuffer / (deleteFileBufferMax - 50)) * 0.5, 0.25);
}

pulseTimer = wrap(pulseTimer, 0, pulseTimerMax);
image_speed = max((deleteFileBuffer / (deleteFileBufferMax - 50)) * 0.65, 0.25);
if (image_speed <= 0)
	image_index = 0;
