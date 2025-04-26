function window_get_active_displays()
{
	window_get_active_displays();
	var wx = window_get_x();
	var wy = window_get_y();
	var ww = window_get_width();
	var wh = window_get_height();
	var display_data = window_get_visible_rects(wx, wy, wx + ww, wy + wh);
	return array_length(display_data) / 8;
}