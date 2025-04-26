global.gameframe_default_cursor = global.DefaultCursor;

if (get_mouse_x_screen(0) != previousMouseX || get_mouse_y_screen(0) != previousMouseY)
{
	previousMouseX = get_mouse_x_screen(0);
	previousMouseY = get_mouse_y_screen(0);
	captionBuffer = 100;
}

if (captionBuffer > 0)
{
	global.gameframe_alpha = approach(global.gameframe_alpha, 1, 0.2);
	captionBuffer--;
	global.DefaultCursor = 0;
}
else
{
	global.gameframe_alpha = approach(global.gameframe_alpha, 0, 0.1);
	global.DefaultCursor = -1;
}

global.gameframe_can_input = global.gameframe_alpha >= 1;
