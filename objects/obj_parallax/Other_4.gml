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
	var _ptype = _n;
	var _args = [];
	var _len = string_length(_ptype) - 1;
	for (var _p1 = _len; _p1 > 1; _p1--)
	{
		var _chr1 = string_char_at(_ptype, _p1);
		var _chr2 = string_char_at(_ptype, _p1 + 1);
		if (string_digits(_chr1) != "" && _chr2 == "_")
		{
			_args = string_split(string_lower(string_copy(_ptype, _p1, _len)), "_");
			_ptype = string_copy(_ptype, 1, _p1);
			_p1 = 0;
		}
	}
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
			parallaxType: _ptype,			
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
			yShift: global.ScrollOffset * layer_get_vspeed(_lay),
			argArr: _args
		};
		layer_background_speed(back_id, 0);
	}
	var asset_id = layer_asset_get_id(_lay);
	if (asset_id != -1 && layer_get_visible(_lay))
	{
		var q = layer_get_all_sprites(_lay);
		if (array_contains(_args, "lang") || array_contains(_args, "Lang"))
		{
			trace("Parallax :: Found Lang Layer");
			for (var r = 0; r < array_length(q); r++)
			{
				var _sp = q[r];
				var _sn = layer_sprite_get_sprite(_sp);
				var _ls = lang_get_sprite(_sn);
				if global.langUpdated
				{
					var _ky = lang_get_sprite_key(_sn);
					_ls = lang_get_sprite(_ky);
				}				
				if (_sn != _ls)
				{
					trace("Parallax :: Replaced Sprite: ", sprite_get_name(_sn));
					layer_sprite_change(_sp, _ls);
				}
			}
		}
		
		for (var o = 0; o < array_length(q); o++)
		{
			var _sp = q[o];			
			var _parallax_value = undefined;
			if (!is_undefined(ds_map_find_value(global.ParallaxMap, _lay)))
				_parallax_value = ds_map_find_value(global.ParallaxMap, _lay).args;
			else if (!is_undefined(ds_map_find_value(global.ParallaxMap, _ptype)))
				_parallax_value = ds_map_find_value(global.ParallaxMap, _ptype).args;
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
			parallaxType: _ptype,			
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
			yShift: global.ScrollOffset * layer_get_vspeed(_lay),
			argArr: _args
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
