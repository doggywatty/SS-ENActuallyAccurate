function scr_checkanygamepad(_device)
{
	var gpButtons = [
		gp_face1, gp_face2, gp_face3, gp_face4, gp_shoulderl, gp_shoulderlb, gp_shoulderr,
		gp_shoulderrb, gp_select, gp_start, gp_stickl, gp_stickr, gp_padu, gp_padd, gp_padl,
		gp_padr, gp_axislh, gp_axislv, gp_axisrv, gp_axisrh
	];
	for (var i = 0; i < array_length(gpButtons); i++)
	{
		if (gamepad_button_check_pressed(_device, gpButtons[i]))
			return gpButtons[i];
	}
	return -4;
}

function scr_check_joysticks(_device, _axisInd = 0.5)
{
	var sticks = [gp_axislh, gp_axislv, gp_axisrh, gp_axisrv];
	for (var i = 0; i < array_length(sticks); i++)
	{
		var val = gamepad_axis_value(_device, sticks[i]);
		if (val > _axisInd)
			return sticks[i];
		if (val < -_axisInd)
			return sticks[i];
	}
	return -4;
}

function scr_checkanystick(_device, _axisInd = 0.5)
{
	var sticks = [gp_axislh, gp_axislv, gp_axisrh, gp_axisrv];
	for (var i = 0; i < array_length(sticks); i++)
	{
		var val = gamepad_axis_value(_device, sticks[i]);
		if (val > _axisInd || val < -_axisInd)
			return true;
	}
	return false;
}

function scr_checksuperjump()
{
	var disabled = global.option_sjump_gp;
	if (global.PlayerInputDevice < 0)
		disabled = global.option_sjump_key;
	return (disabled && key_up) || key_superjump;
}

function scr_checkgroundpound()
{
	var disabled = global.option_groundpound_gp;
	if (global.PlayerInputDevice < 0)
		disabled = global.option_groundpound_key;
	return (disabled && key_down2) || key_groundpound;
}

function scr_input_init_sprites()
{
	if !variable_global_exists("input_icons")
		global.input_icons = ds_map_create();
	scr_input_icon_add(["UNSET"], spr_key_empty, 0);
	scr_input_icon_add(["NONE"], spr_key_special, 0);
	scr_input_icon_add([vk_space], spr_key_special, 1);
	scr_input_icon_add([vk_up], spr_key_special, 2);
	scr_input_icon_add([vk_right], spr_key_special, 3);
	scr_input_icon_add([vk_down], spr_key_special, 4);
	scr_input_icon_add([vk_left], spr_key_special, 5);
	scr_input_icon_add([vk_shift, vk_lshift, vk_rshift], spr_key_special, 6);
	scr_input_icon_add([vk_control, vk_lcontrol, vk_rcontrol], spr_key_special, 7);
	scr_input_icon_add([vk_alt, vk_lalt, vk_ralt], spr_key_special, 8);
	scr_input_icon_add([vk_escape], spr_key_special, 9);
	scr_input_icon_add([vk_enter], spr_key_special, 10);
	scr_input_icon_add([vk_backspace], spr_key_special, 11);
	scr_input_icon_add([vk_capslock], spr_key_special, 12);
	scr_input_icon_add([vk_tab], spr_key_special, 13);
	
	scr_input_icon_add([gp_axislh, gp_axislv], spr_key_controller, 18);
	scr_input_icon_add([gp_axisrh, gp_axisrv], spr_key_controller, 19);
	scr_input_icon_add([gp_stickl], spr_key_controller, 18);
	scr_input_icon_add([gp_stickr], spr_key_controller, 19);
	scr_input_icon_add([gp_face1], spr_key_controller, 8);
	scr_input_icon_add([gp_face3], spr_key_controller, 9);
	scr_input_icon_add([gp_face4], spr_key_controller, 10);
	scr_input_icon_add([gp_face2], spr_key_controller, 11);
	scr_input_icon_add([gp_padu], spr_key_controller, 0);
	scr_input_icon_add([gp_padd], spr_key_controller, 1);
	scr_input_icon_add([gp_padr], spr_key_controller, 2);
	scr_input_icon_add([gp_padl], spr_key_controller, 3);
	scr_input_icon_add([gp_start], spr_key_controller, 17);
	scr_input_icon_add([gp_select], spr_key_controller, 16);
	scr_input_icon_add([gp_shoulderlb], spr_key_controller, 12);
	scr_input_icon_add([gp_shoulderrb], spr_key_controller, 13);
	scr_input_icon_add([gp_shoulderl], spr_key_controller, 14);
	scr_input_icon_add([gp_shoulderr], spr_key_controller, 15);
}

function scr_input_icon_add(_Input, _sprite, _ind_ico)
{
	for (var i = 0; i < array_length(_Input); i++)
	{
		var input = _Input[i];
		ds_map_set(global.input_icons, input, [_sprite, _ind_ico]);
		trace("Added ", sprite_get_name(_sprite), $" (frame: {_ind_ico}) to input icon map for {input}.");
	}
}

function scr_input_get_actions(_inputKey)
{
	var inputArr = [];
	var use_gamepad = global.PlayerInputDevice >= 0;
	if (instance_exists(obj_option_keyconfig))
		use_gamepad = obj_option_keyconfig.gamepad;
	if (use_gamepad && !string_ends_with(_inputKey, "C"))
		_inputKey = string_concat(_inputKey, "C");
	var input = input_get(_inputKey);
	if is_undefined(input)
		return inputArr;
	if (!use_gamepad && array_length(input.keyInputs) > 0)
		inputArr = input.keyInputs;
	else if (use_gamepad && array_length(input.gpInputs) > 0)
		inputArr = input.gpInputs;
	return inputArr;
}

function scr_input_get_icon(_inputKey, _len = false)
{
	var result = [];
	var inputArr = scr_input_get_actions(_inputKey);
	var length = _len ? array_length(inputArr) : 1;
	if (array_length(inputArr) > 0)
	{
		for (var i = 0; i < length; i++)
		{
			var ico = ds_map_find_value(global.input_icons, array_get(inputArr, i));
			var iarr = [inputArr[i]];
			if !is_undefined(ico)
				array_push(result, array_concat(ico, iarr));
			else
				array_push(result, array_concat(ds_map_find_value(global.input_icons, "UNSET"), iarr));
		}
	}
	else
		result = [array_concat(ds_map_find_value(global.input_icons, "NONE"), [-1])];
	return _len ? result : result[0];
}

function get_control_sprite(_inputKey, _spr_ico = false)
{
	var _controller = global.PlayerInputDevice >= 0;
	switch _inputKey
	{
		case "forward":
			_inputKey = (obj_parent_player.xscale == -1) ? "left" : "right";
			break;
		case "backward":
			_inputKey = (obj_parent_player.xscale == 1) ? "left" : "right";
			break;
		case "dialogSJ":
			var _enabled = _controller ? global.option_sjump_gp : global.option_sjump_key;
			_inputKey = !_enabled ? "superjump" : "up";
			break;
		case "dialogGP":
			var _enabled = _controller ? global.option_groundpound_gp : global.option_groundpound_key;
			_inputKey = !_enabled ? "groundpound" : "down";
			break;
	}
	var icon = scr_input_get_icon(_inputKey);
	if _spr_ico
		return icon;
	var str = $"[{sprite_get_name(icon[0]) + ", " + string(floor(icon[1]))}]";
	if (icon[0] == spr_key_empty)
		str += $"[keyDrawFont]{scr_keyname(icon[2])}";
	return str;
}

function draw_control_sprite(_spr, _x, _y)
{
	var icon = get_control_sprite(_spr, true);
	var base = scribble($"[{sprite_get_name(icon[0])}, {floor(icon[1])}]").align(1, 1).blend(draw_get_color(), draw_get_alpha()).draw(_x, _y);
	if (icon[0] == spr_key_empty)
		scribble(string_copy(scr_keyname(icon[2]), 1, 3)).starting_format(font_get_name(global.keyDrawFont), 0).align(1, 1).blend(draw_get_color(), draw_get_alpha()).draw(_x + 16, _y);
	return base;
}
