if (get_panic() && global.lapcount)
{
	for (var i = 0; i < ds_list_size(lapDeco); i++)
	{
		var b = ds_list_find_value(lapDeco, i);
		with b
			draw_sprite_ext(sprite_index, image_index, drawx, drawy, 1, 1, 0, c_white, 1);
	}
}
