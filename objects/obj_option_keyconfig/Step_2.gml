scr_getinput_menu();
var device_is_gamepad = global.PlayerInputDevice >= 0;
if exiting
{
	if (key_slap2 || key_start2)
	{
		exiting = false;
		exit;
	}
	if key_jump
	{
		switch select2
		{
			case 0:
				exiting = false;
				exit;
			case 1:
				restore_inputs();
			case 2:
				with obj_option_keyconfig
					instance_destroy();
				event_play_oneshot("event:/SFX/ui/confirm");
				exit;
		}
	}
	select2 += (key_down2 - key_up2);
	if (select2 < 0)
		select2 = 2;
	else if (select2 > 2)
		select2 = 0;
	exit;
}

var input_is_valid = number_in_range(selected, 0, array_length(inputs) - 1);
if (selected == -2)
{
	if gamepad
	{
		for (var i = 0; i < array_length(inputs); i++)
		{
			var input = inputs[i];
			input.name = string_concat(input.name, "C");
			input.isGP = true;
			input.create();
		}
	}
	selected = -1;
	reading = false;
	exit;	
}
else if !reading
{
	if (key_up2 && selected > 0)
	{
		selected--;
		event_play_oneshot("event:/SFX/ui/step");
	}
	if (key_down2 && selected < (array_length(inputs) - 1) && selected > -1)
	{
		selected++;
		event_play_oneshot("event:/SFX/ui/step");
	}
	if (selected == -1 && (key_right2 || key_down2))
		selected = 0;
	else if (-key_left2)
		selected = -1;
	input_is_valid = number_in_range(selected, 0, array_length(inputs) - 1);	
	if (key_jump && input_is_valid && gamepad == device_is_gamepad)
	{
		if (array_length(inputs[selected].currentInputs) < 9)
			reading = true;
	}
	
	if (!reading && ((key_jump && selected == -1) || key_slap2 || key_start2))
	{
		if !prompt_changes
		{
			with obj_option_keyconfig
				instance_destroy();
			event_play_oneshot("event:/SFX/ui/confirm");
			exit;
		}
		else
		{
			selected = -1;
			select2 = 0;
			exiting = true;
		}
		exit;		
	}
	
	if key_taunt2
	{
		if (input_is_valid && gamepad == device_is_gamepad)
		{
			var inp = inputs[selected].parentInput;
			if gamepad
				inp.gpInputs = [];
			else
				inp.keyInputs = [];
			
			input_save(inp);
			prompt_changes = true;
			inputs[selected].update();
		}
	}
	
	if keyboard_check_pressed(vk_f1)
	{
		scr_resetinput();
		for (var i = 0; i < array_length(inputs); i++)
		{
			var inp = input_get(inputs[i].name);
			inputs[i].parentInput = input_get(inputs[i].name);
			inputs[i].update();
		}
		prompt_changes = true;
	}
	
	for (var i = 0; i < array_length(inputs); i++)
	{
		var p = inputs[i].name;
		var optional = ["superjump", "superjumpC", "groundpound", "groundpoundC"];
		if !array_contains(optional, p)
		{
			var in = input_get(p);
			if ((!gamepad && array_length(in.keyInputs) < 1) || (gamepad && array_length(in.gpInputs) < 1))
				reading = true;
		}
	}
}
else
{
	if !input_is_valid
	{
		reading = false;
		exit;
	}
	
	var inp = inputs[selected].parentInput;
	var inpArr = [];
	if !gamepad
	{
		if (keyboard_check_pressed(vk_anykey) && keyboard_key != vk_f1)
		{
			inpArr = inp.keyInputs;
			if (!array_contains(inpArr, keyboard_key))
			{
				array_push(inpArr, keyboard_key);
				inp.keyInputs = inpArr;
				reading = false;
				input_save(inp);
			}
			else if (array_length(inpArr) > 0)
			{
				reading = false;
				input_save(inp);
			}
			
			prompt_changes = true;
			inputs[selected].update();
		}
	}
	else
	{
		if (keyboard_check_pressed(vk_anykey))
		{
			reading = false;
			exit;
		}
		
		var gpinput = scr_checkanygamepad(global.PlayerInputDevice);
		if (gpinput == -4)
			gpinput = scr_check_joysticks(global.PlayerInputDevice);
		if (gpinput != -4)
		{
			inpArr = inp.gpInputs;
			if (!array_contains(inpArr, gpinput))
			{
				array_push(inpArr, gpinput);
				inp.gpInputs = inpArr;
				reading = false;
				input_save(inp);
			}
			else if (array_length(inpArr) > 0)
			{
				reading = false;
				input_save(inp);
			}
			
			prompt_changes = true;
			inputs[selected].update();
		}
	}
}
