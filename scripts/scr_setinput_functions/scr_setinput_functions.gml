function p1Vibration(val1, val2)
{
	with obj_inputController
	{
		if global.controllerVibration
		{
			vibration1 = val1 / 100;
			vibrationDecay1 = val2;
		}
		else
		{
			vibration1 = 0;
			vibrationDecay1 = 0;
		}
	}
	gamepad_set_vibration(global.PlayerInputDevice, obj_inputController.vibration1, obj_inputController.vibration1);
}

function scr_initinput()
{

}

function scr_resetinput()
{
	var deadzoneSettings = [];
    deadzoneSettings[Deadzones.Master] = ["deadzoneMaster", 0.4];
    deadzoneSettings[Deadzones.Vertical] = ["deadzoneVertical", 0.5];
    deadzoneSettings[Deadzones.Horizontal] = ["deadzoneHorizontal", 0.5];
    deadzoneSettings[Deadzones.Press] = ["deadzonePress", 0.5];
    deadzoneSettings[Deadzones.SJump] = ["deadzoneSJump", 0.8];
    deadzoneSettings[Deadzones.Crouch] = ["deadzoneCrouch", 0.65];
	ini_open("optionData.ini");
	ini_section_delete("Control");
	
	for (var i = 0; i < array_length(deadzoneSettings); i++)
	{
		var set = deadzoneSettings[i];
		ini_write_real("Settings", set[0], set[1]);
		global.deadzones[i] = set[1];
	}
	
	ini_close();
	scr_input_create();
}

function scr_input_create()
{
	if !variable_global_exists("input_map")
		global.input_map = ds_map_create();
	
	if !variable_global_exists("stickpressed")
	{
		global.stickpressed = ds_map_create();
		var stickarr = [gp_axislh, gp_axislv, gp_axisrh, gp_axisrv];
		stickarr = array_concat(stickarr, stickarr);
		
		for (var i = 0; i < array_length(stickarr); i++)
		{
			var s = string(stickarr[i]);
			if (i >= ((array_length(stickarr) / 2) - 1))
				s += "_inv";
			ds_map_set(global.stickpressed, s, false);
		}
	}
	
	ini_open("optionData.ini");
	scr_input_ini_read("up", false, [vk_up]);
	scr_input_ini_read("down", false, [vk_down]);
	scr_input_ini_read("left", false, [vk_left]);
	scr_input_ini_read("right", false, [vk_right]);
	scr_input_ini_read("jump", false, [ord("Z")]);
	scr_input_ini_read("slap", false, [ord("X")]);
	scr_input_ini_read("taunt", false, [ord("C")]);
	scr_input_ini_read("shoot", false, [ord("A")]);
	scr_input_ini_read("attack", false, [vk_shift]);
	scr_input_ini_read("superjump", false, []);
	scr_input_ini_read("groundpound", false, []);
	scr_input_ini_read("start", false, [vk_escape]);
	scr_input_ini_read("special", false, [ord("V")]);
	scr_input_ini_read("menuup", false, [vk_up]);
	scr_input_ini_read("menudown", false, [vk_down]);
	scr_input_ini_read("menuleft", false, [vk_left]);
	scr_input_ini_read("menuright", false, [vk_right]);
	scr_input_ini_read("menuconfirm", false, [ord("Z"), vk_space]);
	scr_input_ini_read("menuback", false, [ord("X")]);
	scr_input_ini_read("menudelete", false, [ord("C")]);
	scr_input_ini_read("upC", true, [gp_padu, gp_axislv], true, true);
	scr_input_ini_read("downC", true, [gp_padd, gp_axislv], true, false);
	scr_input_ini_read("leftC", true, [gp_padl, gp_axislh], true, true);
	scr_input_ini_read("rightC", true, [gp_padr, gp_axislh], true, false);
	scr_input_ini_read("jumpC", true, [gp_face1], true);
	scr_input_ini_read("slapC", true, [gp_face3], true);
	scr_input_ini_read("tauntC", true, [gp_face4], true);
	scr_input_ini_read("shootC", true, [gp_face2], true);
	scr_input_ini_read("attackC", true, [gp_shoulderr, gp_shoulderrb], true);
	scr_input_ini_read("superjumpC", true, [], true);
	scr_input_ini_read("groundpoundC", true, [], true);
	scr_input_ini_read("startC", true, [gp_start], true);
	scr_input_ini_read("specialC", true, [gp_shoulderlb], true);
	scr_input_ini_read("menuupC", true, [gp_padu, gp_axislv], true, true);
	scr_input_ini_read("menudownC", true, [gp_padd, gp_axislv], true, false);
	scr_input_ini_read("menuleftC", true, [gp_padl, gp_axislh], true, true);
	scr_input_ini_read("menurightC", true, [gp_padr, gp_axislh], true, false);
	scr_input_ini_read("menuconfirmC", true, [gp_face1], true);
	scr_input_ini_read("menubackC", true, [gp_face3, gp_face2], true);
	scr_input_ini_read("menudeleteC", true, [gp_face4], true);
	ini_close();
}

function input_get(_key)
{
	return ds_map_find_value(global.input_map, _key);
}

function input_save(_key)
{
	var gpCheck = false;
	var key = string_replace(_key.name, "C", "");
	
	if (string_length(key) < string_length(_key.name))
		gpCheck = true;
	
	var str = "";
	if !gpCheck
	{
		for (var i = 0; i < array_length(_key.keyInputs); i++)
		{
			if str == ""
				str = _key.keyInputs[i];
			else
				str = string_concat(str, ",", _key.keyInputs[i]);
		}
		_key.keyLen = array_length(_key.keyInputs);
	}
	else
	{
		for (var i = 0; i < array_length(_key.gpInputs); i++)
		{
			if str == ""
				str = _key.gpInputs[i];
			else
				str = string_concat(str, ",", _key.gpInputs[i]);
		}
		_key.gpLen = array_length(_key.gpInputs);
	}
	
	trace($"Trace input_save: {_key.name} = {str}");
	ini_open("optionData.ini");
	ini_write_string("Control", _key.name, str);
	ini_close();
}

function scr_input_add(_key, val)
{
	val.keyLen = array_length(val.keyInputs);
	val.gpLen = array_length(val.gpInputs);
	ds_map_set(global.input_map, _key, val);
}

function scr_input_ini_read(inputkey, statement, arr, statement1 = false, statement2 = false)
{
	var _inp = ini_read_string("Control", inputkey, "");
	var inputs = [];
	var inputStrings = string_split(_inp, ",");
	
	if _inp == ""
		inputs = arr;
	else
	{
		for (var i = 0; i < array_length(inputStrings); i++)
			array_push(inputs, real(inputStrings[i]));
	}
	
	show_debug_message($"loaded input {inputkey}: {inputs}");
	scr_input_add(inputkey, new Input(inputkey, statement ? [] : inputs, statement ? inputs : [], statement1, statement2));
}

function scr_setinput_init()
{
	ini_open("optionData.ini");
    global.deadzones[Deadzones.Master] = ini_read_real("Settings", "deadzoneMaster", 0.4);
    global.deadzones[Deadzones.Vertical] = ini_read_real("Settings", "deadzoneVertical", 0.5);
    global.deadzones[Deadzones.Horizontal] = ini_read_real("Settings", "deadzoneHorizontal", 0.5);
    global.deadzones[Deadzones.Press] = ini_read_real("Settings", "deadzonePress", 0.5);
    global.deadzones[Deadzones.SJump] = ini_read_real("Settings", "deadzoneSJump", 0.8);
    global.deadzones[Deadzones.Crouch] = ini_read_real("Settings", "deadzoneCrouch", 0.65);
	ini_close();
	scr_input_init_sprites();
}

function scr_gpinput_isaxis(_gpkey)
{
	var axes = [gp_axisrh, gp_axisrv, gp_axislv, gp_axislh];
	if array_contains(axes, _gpkey)
		return true;
	return false;
}

function scr_input_update(_devinput = -1)
{
	var dz = global.deadzones[Deadzones.Master];
	gamepad_set_axis_deadzone(_devinput, dz);
	var keys = ds_map_keys_to_array(global.input_map);
	
	for (var i = 0; i < array_length(keys); i++)
		ds_map_find_value(global.input_map, array_get(keys, i)).update(object_index);
	
	scr_input_stickpressed_update();
}

function scr_input_stickpressed(_inputstick)
{
	var s = string(_inputstick);
	return ds_map_find_value(global.stickpressed, s) == StickPressed.Pressed;
}

function scr_input_stickpressed_update(inputdevice = global.PlayerInputDevice, deadzone = global.deadzones[Deadzones.Master])
{
	var sticks = [gp_axislh, gp_axislv, gp_axisrh, gp_axisrv];
	sticks = array_concat(sticks, sticks);
	
	for (var i = 0; i < array_length(sticks); i++)
	{
		var s = string(sticks[i]);
		var inv = false;
		
		if (i >= ((array_length(sticks) / 2) - 1))
		{
			s += "_inv";
			inv = true;
		}
		
		var val = gamepad_axis_value(inputdevice, sticks[i]);
		var pressState = ds_map_find_value(global.stickpressed, s);
        if (pressState == StickPressed.Pressed && !((!inv && val >= deadzone) || (inv && val <= -deadzone)))
            ds_map_set(global.stickpressed, s, StickPressed.Released);
        if (pressState == StickPressed.JustPressed)
            ds_map_set(global.stickpressed, s, StickPressed.Pressed);
	}
}

function scr_checkdeadzone(gpinput, kinput, player)
{
	var dz = global.deadzones[Deadzones.Press];
    switch gpinput
    {
        case gp_axislh:
        case gp_axisrh:
            dz = global.deadzones[Deadzones.Horizontal];
            break;
        case gp_axislv:
        case gp_axisrv:
            dz = global.deadzones[Deadzones.Vertical];
            break;
    }
    if player.object_index == obj_parent_player
    {
        switch kinput
        {
            case "upC":
                if player.state == States.Sjumpprep
                    dz = global.deadzones[Deadzones.SJump];
                break;
            case "downC":
                if player.state == States.crouch
                    dz = global.deadzones[Deadzones.Crouch];
				break;
		}
	}
	return dz;
}

function Input(_inputname, _keyInputs, _gpInputs, _gpInputDeadzone = 0, _gpAxisInvert = false) constructor
{
	static update = function(_inputname)
	{
		if (global.PlayerInputDevice < 0)
		{
			checkheld(_inputname);
			checkpressed(_inputname);
			checkreleased(_inputname);
		}
		else
		{
			checkheldC(_inputname);
			checkpressedC(_inputname);
			checkreleasedC(_inputname);
		}
	};
	
	static checkheld = function(_inputname)
	{
		for (var i = 0; i < keyLen; i++)
		{
			if (keyboard_check(keyInputs[i]))
			{
				held = true;
				exit;
			}
		}
		held = false;
	};
	
	static checkheldC = function(_inputname)
	{
		for (var i = 0; i < gpLen; i++)
		{
			if (scr_gpinput_isaxis(gpInputs[i]))
			{
				var dz = scr_checkdeadzone(gpInputs[i], name, _inputname);
				if ((!gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) >= dz)
				|| (gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) <= -dz))
				{
					held = true;
					exit;
				}
			}
			else if (gamepad_button_check(global.PlayerInputDevice, gpInputs[i]))
			{
				held = true;
				exit;
			}
		}
		held = false;
	};
	
	static checkpressed = function(_inputname)
	{
		for (var i = 0; i < keyLen; i++)
		{
			if (global.PlayerInputDevice != -1)
				break;
			if (keyboard_check_pressed(keyInputs[i]))
			{
				pressed = true;
				exit;
			}
		}
		pressed = false;
	};
	
	static checkpressedC = function(_inputname)
	{
		for (var i = 0; i < gpLen; i++)
		{
			if (scr_gpinput_isaxis(gpInputs[i]))
			{
				var stickstr = string(gpInputs[i]);
				if (gpAxisInvert)
					stickstr += "_inv";
				
				var dz = scr_checkdeadzone(gpInputs[i], name, _inputname);
				if (!scr_input_stickpressed(stickstr) && ((!gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) >= dz) || (gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) <= -dz)))
				{
					pressed = true;
					ds_map_set(global.stickpressed, stickstr, StickPressed.JustPressed);
					exit;
				}
			}
			else if (gamepad_button_check_pressed(global.PlayerInputDevice, gpInputs[i]))
			{
				pressed = true;
				exit;
			}
		}
		pressed = false;
	};
	
	static checkreleased = function(_inputname)
	{
		for (var i = 0; i < keyLen; i++)
		{
			if (keyboard_check_released(keyInputs[i]))
			{
				released = true;
				exit;
			}
		}
		released = false;
	};
	
	static checkreleasedC = function(_inputname)
	{
		for (var i = 0; i < gpLen; i++)
		{
			if (scr_gpinput_isaxis(gpInputs[i]))
			{
				var stickstr = string(gpInputs[i]);
				if (gpAxisInvert)
					stickstr += "_inv";
				
				var dz = scr_checkdeadzone(gpInputs[i], name, _inputname);
				if ((!gpAxisInvert && !scr_input_stickpressed(stickstr)
				&& gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) <= dz)
				|| (gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) >= -dz))
				{
					released = true;
					exit;
				}
			}
			else if (gamepad_button_check_released(global.PlayerInputDevice, gpInputs[i]))
			{
				released = true;
				exit;
			}
		}
		released = false;
	};
	
	static clear_input = function()
	{
		held = false;
		pressed = false;
		released = false;
		return self;
	};
	
	name = _inputname;
	held = false;
	pressed = false;
	released = false;
	keyInputs = _keyInputs;
	gpInputs = _gpInputs;
	gpInputDeadzone = _gpInputDeadzone;
	gpAxisInvert = _gpAxisInvert;
	stickpressed = false;
	keyLen = 0;
	gpLen = 0;
}
