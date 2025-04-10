function scr_button_pressed(_buttonkey)
{
    if ((keyboard_check_pressed(vk_anykey) || input_get("jump").pressed) && !keyboard_check_pressed(vk_f1))
        return -1;
    else if (gamepad_is_connected(_buttonkey))
    {
        if (gamepad_button_check(_buttonkey, gp_face1) || gamepad_button_check(_buttonkey, gp_start))
            return _buttonkey;
    }
    return -2;
}
