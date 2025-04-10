function scr_secrettiles_add(_secretTile)
{
	if (object_index != obj_secretwall)
		return false;
	if is_undefined(_secretTile)
		return false;
	
	for (var i = 0; i < argument_count; i++)
	{
		var arg = argument[i];
		var layer_id = layer_get_id(arg);
		layer_set_visible(layer_id, false);
		array_push(layerArray, layer_id);
	}
	
	var func = function(_layerId1, _layerId2)
	{
		return layer_get_depth(_layerId2) - layer_get_depth(_layerId1);
	};
	
	array_sort(layerArray, func);
	return true;
}

function add_secrettiles(_secretTile)
{
	global.secret_layers = [];
	for (var i = 0; i < argument_count; i++)
	{
		var arg = argument[i];
		var layerid = layer_get_id(arg);
		layer_set_visible(layerid, false);
		var name = layer_get_name(layerid);
		if layer_exists(argument[i])
		{
			array_push(global.secret_layers, 
			{
				nm: name,
				id: layerid,
				alpha: 1,
				surf: -4
			});
		}
	}
	
	var _f = function(_layerId1, _layerId2)
	{
		return -(layer_get_depth(_layerId1.nm) - layer_get_depth(_layerId2.nm));
	};
	
	array_sort(global.secret_layers, _f);
	return true;
}
