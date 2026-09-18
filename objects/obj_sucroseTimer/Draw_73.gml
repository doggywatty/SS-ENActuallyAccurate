if (bg_flash > 0)
{
	draw_set_alpha(bg_flash);
	draw_rectangle_color(camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]), camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]), c_white, c_white, c_white, c_white, 0);
	draw_set_alpha(1);
}
