for (var i = -1; i < gamepad_get_device_count(); i++)
{
	var _index = scr_button_pressed(i);
	if (_index != -2 && _index != global.PlayerInputDevice)
	{
		showtext = false;
		global.PlayerInputDevice = _index;
		scr_setTransfoTip(global.TransfoState);
		show_debug_message($"Changed Device to Index {_index}");
		
		for (var j = 0; j < gamepad_get_device_count(); j++)
		{
			if (gamepad_is_connected(j))
				gamepad_set_vibration(j, 0, 0);
		}
		
		if disconnectScreen
		{
			disconnectScreen = false;
			queueDisconnectScreen = false;
			with obj_pause
			{
				alarm[0] = 3;
				alarm[1] = 1;
				key_jump = false;
			}
		}
	}
}

if queueDisconnectScreen
{
	event_user(0);
	exit;
}

if (global.PlayerInputDevice > -1 && !gamepad_is_connected(global.PlayerInputDevice))
{
	queueDisconnectScreen = true;
	show_debug_message("Lost Device global.PlayerInputDevice. Queued Unsafe Disconnect Screen.");
}
