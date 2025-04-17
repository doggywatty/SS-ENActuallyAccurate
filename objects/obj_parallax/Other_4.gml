createSubLayers();
set_layer_depths();
safe_layer_set_depth("Backgrounds_foreground", -50);
safe_layer_set_depth("Backgrounds_foregroundLow", -50);
layerNum = 0;
assetNum = 0;
asset_sprites = 0;
layerArray = [];

for (var a = layer_get_all(), i = 0, z = 0; i < array_length(a); i++)
{
	var _lay = a[i];
	var _n = layer_get_name(_lay);
	var back_id = layer_background_get_id_fixed(_lay);
	if (back_id != -1 && layer_get_visible(_lay))
	{
		if (!(string_pos("Foregrounds", _n) != 0))
			safe_layer_set_depth(_lay, layer_get_depth(_lay) + 1000);
		else
			safe_layer_set_depth(_lay, min(layer_get_depth(_lay), -50));
		layerArray[z++] = 
		{
			id: _lay,
			layerName: _n,
			isBackground: true,
			image_speed: layer_background_get_speed(back_id),
			image_index: layer_background_get_index(back_id),
			x: layer_get_x(_lay),
			y: layer_get_y(_lay),
			xstart: layer_get_x(_lay),
			ystart: layer_get_y(_lay),
			xprevious: layer_get_x(_lay),
			yprevious: layer_get_y(_lay),
			hspeed: layer_get_hspeed(_lay),
			vspeed: layer_get_vspeed(_lay),
			xShift: global.ScrollOffset * layer_get_hspeed(_lay),
			yShift: global.ScrollOffset * layer_get_vspeed(_lay)
		};
		layer_background_speed(back_id, 0);
	}
	var asset_id = layer_asset_get_id(_lay);
	if (asset_id != -1 && layer_get_visible(_lay))
	{
		var q = layer_get_all_sprites(_lay);
		for (var o = 0; o < array_length(q); o++)
		{
			var _sp = q[o];
			if (_n == "Assets_Lang")
			{
				trace("Parallax :: Found Lang Layer");
				var _sn = layer_sprite_get_sprite(_sp);
				var _ls = lang_get_sprite(_sn);
				if (_sn != _ls)
				{
					trace("Parallax :: Replaced Sprite: ", sprite_get_name(_sn));
					layer_sprite_change(_sp, _ls);
				}
			}
			var _parallax_value = undefined;
			if (!is_undefined(ds_map_find_value(global.ParallaxMap, _lay)))
				_parallax_value = ds_map_find_value(global.ParallaxMap, _lay).args;
			else if (!is_undefined(ds_map_find_value(global.ParallaxMap, _n)))
				_parallax_value = ds_map_find_value(global.ParallaxMap, _n).args;
			else
				break;
			var original_x = layer_sprite_get_x(_sp);
			var new_x = (original_x - (original_x * _parallax_value[0])) + ((global.CameraViewWidth / 4) * _parallax_value[0]);
			var original_y = layer_sprite_get_y(_sp);
			var new_y = (original_y - (original_y * _parallax_value[1])) + ((global.CameraViewHeight / 4) * _parallax_value[1]);
			layer_sprite_x(_sp, new_x);
			layer_sprite_y(_sp, new_y);
		}
		layerArray[z++] = 
		{
			id: _lay,
			layerName: _n,
			isBackground: false,
			image_speed: 0,
			image_index: 0,
			x: layer_get_x(_lay),
			y: layer_get_y(_lay),
			xstart: layer_get_x(_lay),
			ystart: layer_get_y(_lay),
			xprevious: layer_get_x(_lay),
			yprevious: layer_get_y(_lay),
			hspeed: layer_get_hspeed(_lay),
			vspeed: layer_get_vspeed(_lay),
			xShift: global.ScrollOffset * layer_get_hspeed(_lay),
			yShift: global.ScrollOffset * layer_get_vspeed(_lay)
		};
	}
}
lapDecoBag = [];
ds_list_clear(lapDeco);
if (get_panic() && global.lapcount && !instance_exists(global.cutsceneManager))
{
	repeat (irandom_range(7, 12))
		createLapDeco(true);
}
