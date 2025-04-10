scr_input_update();

if (global.PlayerInputDevice > -1 && gamepad_is_connected(global.PlayerInputDevice))
{
	if !global.controllerVibration
    {
        vibration1 = 0;
        vibrationDecay1 = 0;
    }
    if (vibrationDecay1 > 0)
        vibrationDecay1--;
    else if (vibration1 != 0)
    {
        vibration1 = 0;
        gamepad_set_vibration(global.PlayerInputDevice, vibration1, vibration1);
    }
}
