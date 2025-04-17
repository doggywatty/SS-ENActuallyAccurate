if !global.gamePauseState
	global.ScrollOffset++;
for (var i = 0; i < array_length(layerArray); i++)
{
	if (layerArray[i] != undefined)
	{
		with layerArray[i]
		{
			x = xstart;
			y = ystart;
			x += xShift;
			y += yShift;
			if (!is_undefined(ds_map_find_value(global.ParallaxMap, id)))
				script_execute_ext(ds_map_find_value(global.ParallaxMap, id).func, ds_map_find_value(global.ParallaxMap, id).args);
			else if (!is_undefined(ds_map_find_value(global.ParallaxMap, layerName)))
				script_execute_ext(ds_map_find_value(global.ParallaxMap, layerName).func, ds_map_find_value(global.ParallaxMap, layerName).args);
			
			xShift += hspeed;
			yShift += vspeed;
			xprevious = layer_get_x(id);
			yprevious = layer_get_y(id);
			layer_x(id, x);
			layer_y(id, y);
			if isBackground
			{
				var bg_id = layer_background_get_id_fixed(id);
				var bg_sprite = layer_background_get_sprite(bg_id);
				image_index = wrap(image_index + image_speed, 0, sprite_get_number(bg_sprite));
				layer_background_index(bg_id, image_index);
			}
		}
	}
}

if (get_panic() && global.lapcount)
{
	visualCooldown--;
	if !visualCooldown
	{
		createLapDeco();
		visualCooldown = irandom_range(30, 120);
	}
}
