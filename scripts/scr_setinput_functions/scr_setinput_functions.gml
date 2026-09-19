enum StickPressState
{
	released = 0,
	triggered = 1,
	pressed = 2
}

function p1Vibration(arg0, arg1)
{
	with (obj_inputController)
	{
		if (global.controllerVibration)
		{
			vibration1 = arg0 / 100;
			vibrationDecay1 = arg1;
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
	ini_open("optionData.ini");
	ini_section_delete("Control");
	ini_close();
	scr_input_create();
}

function scr_input_create()
{
	if (!variable_global_exists("input_map"))
		global.input_map = ds_map_create();
	
	if (!variable_global_exists("stickpressed"))
	{
		global.stickpressed = ds_map_create();
		var stickarr = [32785, 32786, 32787, 32788];
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
	scr_input_ini_read("up", false, [38]);
	scr_input_ini_read("down", false, [40]);
	scr_input_ini_read("left", false, [37]);
	scr_input_ini_read("right", false, [39]);
	scr_input_ini_read("jump", false, [90]);
	scr_input_ini_read("slap", false, [88]);
	scr_input_ini_read("taunt", false, [67]);
	scr_input_ini_read("shoot", false, [65]);
	scr_input_ini_read("attack", false, [16]);
	scr_input_ini_read("superjump", false, []);
	scr_input_ini_read("groundpound", false, []);
	scr_input_ini_read("start", false, [27]);
	scr_input_ini_read("special", false, [86]);
	scr_input_ini_read("menuup", false, [38]);
	scr_input_ini_read("menudown", false, [40]);
	scr_input_ini_read("menuleft", false, [37]);
	scr_input_ini_read("menuright", false, [39]);
	scr_input_ini_read("menuconfirm", false, [90, 32]);
	scr_input_ini_read("menuback", false, [88]);
	scr_input_ini_read("menudelete", false, [67]);
	scr_input_ini_read("upC", true, [32781, 32786], true, true);
	scr_input_ini_read("downC", true, [32782, 32786], true, false);
	scr_input_ini_read("leftC", true, [32783, 32785], true, true);
	scr_input_ini_read("rightC", true, [32784, 32785], true, false);
	scr_input_ini_read("jumpC", true, [32769], true);
	scr_input_ini_read("slapC", true, [32771], true);
	scr_input_ini_read("tauntC", true, [32772], true);
	scr_input_ini_read("shootC", true, [32770], true);
	scr_input_ini_read("attackC", true, [32774, 32776], true);
	scr_input_ini_read("superjumpC", true, [], true);
	scr_input_ini_read("groundpoundC", true, [], true);
	scr_input_ini_read("startC", true, [32778], true);
	scr_input_ini_read("specialC", true, [32775], true);
	scr_input_ini_read("menuupC", true, [32781, 32786], true, true);
	scr_input_ini_read("menudownC", true, [32782, 32786], true, false);
	scr_input_ini_read("menuleftC", true, [32783, 32785], true, true);
	scr_input_ini_read("menurightC", true, [32784, 32785], true, false);
	scr_input_ini_read("menuconfirmC", true, [32769], true);
	scr_input_ini_read("menubackC", true, [32771, 32770], true);
	scr_input_ini_read("menudeleteC", true, [32772], true);
	ini_close();
}

function input_get(arg0)
{
	return ds_map_find_value(global.input_map, arg0);
}

function input_save(arg0)
{
	var gpCheck = false;
	var key = string_replace(arg0.name, "C", "");
	
	if (string_length(key) < string_length(arg0.name))
		gpCheck = true;
	
	var str = "";
	
	if (!gpCheck)
	{
		for (var i = 0; i < array_length(arg0.keyInputs); i++)
		{
			if (str == "")
				str = arg0.keyInputs[i];
			else
				str = string_concat(str, ",", arg0.keyInputs[i]);
		}
		
		arg0.keyLen = array_length(arg0.keyInputs);
	}
	else
	{
		for (var i = 0; i < array_length(arg0.gpInputs); i++)
		{
			if (str == "")
				str = arg0.gpInputs[i];
			else
				str = string_concat(str, ",", arg0.gpInputs[i]);
		}
		
		arg0.gpLen = array_length(arg0.gpInputs);
	}
	
	trace($"Trace input_save: {arg0.name} = {str}");
	ini_open("optionData.ini");
	ini_write_string("Control", arg0.name, str);
	ini_close();
}

function scr_input_add(arg0, arg1)
{
	arg1.keyLen = array_length(arg1.keyInputs);
	arg1.gpLen = array_length(arg1.gpInputs);
	ds_map_set(global.input_map, arg0, arg1);
}

function scr_input_ini_read(arg0, arg1, arg2, arg3 = false, arg4 = false)
{
	var _inp = ini_read_string("Control", arg0, "");
	var inputs = [];
	var inputStrings = string_split(_inp, ",");
	
	if (_inp == "")
	{
		inputs = arg2;
	}
	else
	{
		for (var i = 0; i < array_length(inputStrings); i++)
			array_push(inputs, real(inputStrings[i]));
	}
	
	show_debug_message($"loaded input {arg0}: {inputs}");
	scr_input_add(arg0, new Input(arg0, arg1 ? [] : inputs, arg1 ? inputs : [], arg3, arg4));
}

function scr_setinput_init()
{
	ini_open("optionData.ini");
	global.deadzones[Deadzone.master] = ini_read_real("Settings", "deadzoneMaster", 0.4);
	global.deadzones[Deadzone.vertical] = ini_read_real("Settings", "deadzoneVertical", 0.5);
	global.deadzones[Deadzone.horizontal] = ini_read_real("Settings", "deadzoneHorizontal", 0.5);
	global.deadzones[Deadzone.press] = ini_read_real("Settings", "deadzonePress", 0.5);
	global.deadzones[Deadzone.sjump] = ini_read_real("Settings", "deadzoneSJump", 0.8);
	global.deadzones[Deadzone.crouch] = ini_read_real("Settings", "deadzoneCrouch", 0.65);
	ini_close();
	scr_input_init_sprites();
}

function scr_gpinput_isaxis(arg0)
{
	var axes = [32787, 32788, 32786, 32785];
	
	if (array_contains(axes, arg0))
		return true;
	
	return false;
}

function scr_input_update(arg0 = -1)
{
	var dz = global.deadzones[Deadzone.master];
	gamepad_set_axis_deadzone(arg0, dz);
	var keys = ds_map_keys_to_array(global.input_map);
	
	for (var i = 0; i < array_length(keys); i++)
	{
		(ds_map_find_value(global.input_map, array_get(keys, i))).update(object_index);
	}
	
	scr_input_stickpressed_update();
}

function scr_input_stickpressed(arg0)
{
	var s = string(arg0);
	return ds_map_find_value(global.stickpressed, s) == StickPressState.pressed;
}

function scr_input_stickpressed_update(arg0 = global.PlayerInputDevice, arg1 = global.deadzones[Deadzone.master])
{
	var sticks = [32785, 32786, 32787, 32788];
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
		
		var val = gamepad_axis_value(arg0, sticks[i]);
		var pressState = ds_map_find_value(global.stickpressed, s);
		
		if (pressState == StickPressState.pressed && !((!inv && val >= arg1) || (inv && val <= -arg1)))
			ds_map_set(global.stickpressed, s, StickPressState.released);
		
		if (pressState == StickPressState.triggered)
			ds_map_set(global.stickpressed, s, StickPressState.pressed);
	}
}

function scr_checkdeadzone(arg0, arg1, arg2)
{
	var dz = global.deadzones[Deadzone.press];
	
	switch (arg0)
	{
		case 32785:
		case 32787:
			dz = global.deadzones[Deadzone.horizontal];
			break;
		case 32786:
		case 32788:
			dz = global.deadzones[Deadzone.vertical];
			break;
	}
	
	if (arg2.object_index == obj_parent_player)
	{
		switch (arg1)
		{
			case "upC":
				if (arg2.state == states.chainsaw)
					dz = global.deadzones[Deadzone.sjump];
				
				break;
			case "downC":
				if (arg2.state == states.facestomp)
					dz = global.deadzones[Deadzone.crouch];
				
				break;
		}
	}
	
	return dz;
}

function Input(arg0, arg1, arg2, arg3 = 0, arg4 = false) constructor
{
	static update = function(arg0)
	{
		if (global.PlayerInputDevice < 0)
		{
			checkheld(arg0);
			checkpressed(arg0);
			checkreleased(arg0);
		}
		else
		{
			checkheldC(arg0);
			checkpressedC(arg0);
			checkreleasedC(arg0);
		}
	};
	
	static checkheld = function(arg0)
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
	
	static checkheldC = function(arg0)
	{
		for (var i = 0; i < gpLen; i++)
		{
			if (scr_gpinput_isaxis(gpInputs[i]))
			{
				var dz = scr_checkdeadzone(gpInputs[i], name, arg0);
				
				if ((!gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) >= dz) || (gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) <= -dz))
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
	
	static checkpressed = function(arg0)
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
	
	static checkpressedC = function(arg0)
	{
		for (var i = 0; i < gpLen; i++)
		{
			if (scr_gpinput_isaxis(gpInputs[i]))
			{
				var stickstr = string(gpInputs[i]);
				
				if (gpAxisInvert)
					stickstr += "_inv";
				
				var dz = scr_checkdeadzone(gpInputs[i], name, arg0);
				
				if (!scr_input_stickpressed(stickstr) && ((!gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) >= dz) || (gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) <= -dz)))
				{
					pressed = true;
					ds_map_set(global.stickpressed, stickstr, StickPressState.triggered);
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
	
	static checkreleased = function(arg0)
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
	
	static checkreleasedC = function(arg0)
	{
		for (var i = 0; i < gpLen; i++)
		{
			if (scr_gpinput_isaxis(gpInputs[i]))
			{
				var stickstr = string(gpInputs[i]);
				
				if (gpAxisInvert)
					stickstr += "_inv";
				
				var dz = scr_checkdeadzone(gpInputs[i], name, arg0);
				
				if ((!gpAxisInvert && !scr_input_stickpressed(stickstr) && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) <= dz) || (gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) >= -dz))
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
	
	name = arg0;
	held = false;
	pressed = false;
	released = false;
	keyInputs = arg1;
	gpInputs = arg2;
	gpInputDeadzone = arg3;
	gpAxisInvert = arg4;
	stickpressed = false;
	keyLen = 0;
	gpLen = 0;
}
