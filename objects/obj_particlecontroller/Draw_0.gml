for (var i = 0; i < ds_list_size(global.particleList); i++)
{
	var b = ds_list_find_value(global.particleList, i);
	with b
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

if (!obj_hudManager.visible || !obj_camera.visible)
	exit;

for (var i = 0; i < ds_list_size(global.collectParticleList); i++)
{
	var b = ds_list_find_value(global.collectParticleList, i);
	with b
	{
		if usePalette
			pal_swap_set(spr_collect_palette, paletteSelect, false);
		
		draw_sprite_ext(sprite_index, image_index, x + camera_get_view_x(view_camera[0]), y + camera_get_view_y(view_camera[0]), 1, 1, 0, c_white, 1);
		if (usePalette)
			pal_swap_reset();
	}
}
