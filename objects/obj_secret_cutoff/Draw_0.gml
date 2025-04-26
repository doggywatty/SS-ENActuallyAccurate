for (var i = 0; i < trueYscale; i++)
{
	var _x = x + lengthdir_x(32 * i, image_angle - 90);
	var _y = y + lengthdir_y(32 * i, image_angle - 90);
	if (showCutoff[i])
	{
		draw_sprite_ext(sprite_index, imageIndexArray[i], _x, _y, image_xscale, image_yscale, image_angle, c_white, 1);
		draw_sprite_ext(spr_secretTile_cutoffOverlay, imageIndexArray[i], _x, _y, image_xscale, image_yscale, image_angle, c_white, 0.3);
	}
	if (global.DebugVisuals == 1)
	{
		draw_set_font(font_console);
		draw_text_color(_x, _y, $"Index: {imageIndexArray[i]}; Show: {showCutoff[i]}", c_white, c_white, c_white, c_white, 1);
	}
}
