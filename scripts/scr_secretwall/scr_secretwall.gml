//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGP
function scr_secrettiles_add(_secret_tile)
{
	if (object_index != obj_secretwall)
		return false;
	
	if (is_undefined(_secret_tile))
		return false;
	
	for (var i = 0; i < argument_count; i++)
	{
		var arg = argument[i];
		var layer_id = layer_get_id(arg);
		layer_set_visible(layer_id, false);
		array_push(layerArray, layer_id);
	}
	
	var func = function(_layer_id1, _layer_id2)
	{
		return layer_get_depth(_layer_id2) - layer_get_depth(_layer_id1);
	};
	
	array_sort(layerArray, func);
	return true;
}

function add_secrettiles(_secret_tile)
{
	global.secret_layers = [];
	
	for (var i = 0; i < argument_count; i++)
	{
		var arg = argument[i];
		var layerid = layer_get_id(arg);
		layer_set_visible(layerid, false);
		var name = layer_get_name(layerid);
		
		if (layer_exists(argument[i]))
		{
			array_push(global.secret_layers, 
			{
				nm: name,
				id: layerid,
				alpha: 1,
				surf: noone
			});
		}
	}
	
///PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDIN
	var _f = function(_layer_id1, _layer_id2)
	{
		return -(layer_get_depth(_layer_id1.nm) - layer_get_depth(_layer_id2.nm));
	};
	
	array_sort(global.secret_layers, _f);
	return true;
}
