function get_mouse_x_screen(pos = 0)
{
	var mouse_xpos = device_mouse_x_to_gui(pos);
	var params = calculate_letterbox_params();
	return round((mouse_xpos - params.screen_x) / params.scale);
}

function get_mouse_y_screen(pos = 0)
{
	var mouse_ypos = device_mouse_y_to_gui(pos);
	var params = calculate_letterbox_params();
	return round((mouse_ypos - params.screen_y) / params.scale);
}

function get_mouse_x(pos = 0)
{
	var mouse_xpos = get_mouse_x_screen(pos);
	var camera_x = camera_get_view_x(view_camera[0]);
	var camera_width = camera_get_view_width(view_camera[0]);
	var gui_width = display_get_gui_width();
	var zoom_x = camera_width / gui_width;
	return round(camera_x + (mouse_xpos * zoom_x));
}

function get_mouse_y(pos = 0)
{
	var mouse_ypos = get_mouse_y_screen(pos);
	var camera_y = camera_get_view_y(view_camera[0]);
	var camera_height = camera_get_view_height(view_camera[0]);
	var gui_height = display_get_gui_height();
	var zoom_y = camera_height / gui_height;
	return round(camera_y + (mouse_ypos * zoom_y));
}