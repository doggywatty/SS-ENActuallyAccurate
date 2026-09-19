//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGP
function scr_secrettiles_add(arg0)
{
	if (object_index != obj_secretwall)
		return false;
	
	if (is_undefined(arg0))
		return false;
	
	for (var i = 0; i < argument_count; i++)
	{
		var arg = argument[i];
		var layer_id = layer_get_id(arg);
		layer_set_visible(layer_id, false);
		array_push(layerArray, layer_id);
	}
	
	var func = function(arg0, arg1)
	{
		return layer_get_depth(arg1) - layer_get_depth(arg0);
	};
	
	array_sort(layerArray, func);
	return true;
}

function add_secrettiles(arg0)
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
	
	//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDING
	var _f = function(arg0, arg1)
	{
		return -(layer_get_depth(arg0.nm) - layer_get_depth(arg1.nm));
	};
	
	array_sort(global.secret_layers, _f);
	return true;
}
