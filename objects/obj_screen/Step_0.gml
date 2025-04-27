gameframe_update();
var _w = window_get_width();
var _h = window_get_height();
if (!gameframe_is_minimised() && (_w < 400 || _h < 225))
{
	if (!mouse_check_button(mb_left))
	{
		window_set_size(max(_w, 400), max(_h, 225));
		window_center();
	}
}

for (var i = 0; i < ds_list_size(bgSpriteOld); i++)
{
	with (ds_list_find_value(bgSpriteOld, i))
	{
		image_alpha = approach(image_alpha, 0, 0.1);
		if (image_alpha <= 0)
			ds_list_delete(other.bgSpriteOld, i);
	}
}
