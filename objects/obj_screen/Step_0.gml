fmod_studio_system_set_parameter_by_name("focus", global.unfocusedMute ? window_has_focus() : 1, true);
if (gameframe_mouse_in_window() && (device_mouse_x_to_gui(0) != previousMouseX || device_mouse_y_to_gui(0) != previousMouseY))
{
    previousMouseX = device_mouse_x_to_gui(0);
    previousMouseY = device_mouse_y_to_gui(0);
    captionBuffer = 100;
}

if (captionBuffer > 0)
{
    global.gameframe_alpha = approach(global.gameframe_alpha, 1, 0.2);
    captionBuffer--;
}
else
    global.gameframe_alpha = approach(global.gameframe_alpha, 0, 0.1);

global.gameframe_can_input = global.gameframe_alpha >= 1;
gameframe_update();
