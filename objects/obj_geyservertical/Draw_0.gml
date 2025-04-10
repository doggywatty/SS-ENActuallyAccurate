if global.showcollisions && global.DebugVisuals
{
	var last_color = draw_get_color();
	draw_set_color(c_red);
	draw_rectangle(x, bbox_top, x + 3, bbox_top + 3, false);
	draw_set_color(c_blue);
	draw_rectangle(x, obj_parent_player.y, x + 3, obj_parent_player.y + 3, false);
	draw_set_color(last_color);
}
