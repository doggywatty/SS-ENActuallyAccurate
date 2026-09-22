function layer_type_get_id(_layerid, _element_id)
{
	if (layer_exists(_layerid))
	{
		var layer_elements = layer_get_all_elements(_layerid);
		
		for (var i = 0; i < array_length(layer_elements); i++)
		{
			if (layer_get_element_type(layer_elements[i]) == _element_id)
				return layer_elements[i];
		}
	}
	
	return -1;
}

function layer_tilemap_get_id_fixed(_layerid)
{
	return layer_type_get_id(_layerid, layerelementtype_tilemap);
}

function layer_background_get_id_fixed(_layerid)
{
	return layer_type_get_id(_layerid, layerelementtype_background);
}

function layer_asset_get_id(_layerid)
{
	return layer_type_get_id(_layerid, layerelementtype_sprite);
}

function layer_get_all_sprites(_layerid)
{
	var temp_array = [];
	
	if (layer_exists(_layerid))
	{
		var a = layer_get_all_elements(_layerid);
		
		for (var i = 0; i < array_length(a); i++)
		{
			if (layer_get_element_type(a[i]) == layerelementtype_sprite)
				array_push(temp_array, a[i]);
		}
	}
	
	return temp_array;
}

function layer_get_all_instances(_layerid)
{
	var temp_array = [];
	
	if (layer_exists(_layerid))
	{
		var a = layer_get_all_elements(_layerid);
		
		for (var i = 0; i < array_length(a); i++)
		{
			if (layer_get_element_type(a[i]) == layerelementtype_instance)
				array_push(temp_array, a[i]);
		}
	}
	
	return temp_array;
}

function layer_change_background(_layer_bg_id, _spr)
{
	if (_layer_bg_id != _spr)
	{
		var a = layer_get_all();
		
		for (var i = 0; i < array_length(a); i++)
		{
			var back_id = layer_background_get_id_fixed(a[i]);
			
			if (layer_background_get_sprite(back_id) == _layer_bg_id)
				layer_background_sprite(back_id, _spr);
		}
	}
}

function layer_change_tileset(_layer_tile_id, _tileset)
{
	if (_layer_tile_id != _tileset)
	{
		var a = layer_get_all();
		
		for (var i = 0; i < array_length(a); i++)
		{
			var tile_id = layer_tilemap_get_id_fixed(a[i]);
			
			if (tilemap_get_tileset(tile_id) == _layer_tile_id)
				tilemap_tileset(tile_id, _tileset);
		}
	}
}
