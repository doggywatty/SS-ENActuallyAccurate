if (state == States.normal)
{
	var txt = hub_array[selected][1];
	var yy = string_height(txt);
	var length = array_length(hub_array);
	draw_set_halign(fa_center);
	draw_set_font(global.fontDefault);
	if !surface_exists(surface2)
		surface2 = surface_create(480, 240);
	
	surface_set_target(surface2);
	draw_sprite_tiled(bg_menuTile, -1, drawx++, drawy++);
	yy = 40;
	for (var i = 0; i < length; i++)
	{
		txt = hub_array[i][1];
		var c = (selected == i) ? c_white : c_gray;
		draw_text_color(240, yy + ScrollY, txt, c, c, c, c, 1);
		yy += 60;
	}
	
	gpu_set_blendmode(bm_subtract);
	draw_sprite(spr_elevatorfadeoff, -1, 0, 0);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	draw_surface(surface2, 240, 150);
}
else if (state == States.titlescreen)
{
	draw_sprite_tiled(bg_menuTile, -1, drawx++, drawy++);
	draw_set_font(global.fontDefault);
	draw_set_halign(fa_center);
	var msg = "I CANT DRAW! \nPUT A CUTSCENE HERE";
	draw_text(480 + random_range(1, -1), 270 - (string_height(msg) / 2), msg);
}
