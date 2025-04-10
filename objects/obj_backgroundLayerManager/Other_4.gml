global.BgInstanceLayerOffset = room_height + 960;
for (var i = 0; i < ds_list_size(global.BgInstancesList); i++)
{
	with (ds_list_find_value(global.BgInstancesList, i))
	{
		show_debug_message($"{id}:{object_get_name(object_index)} | {layer_get_name(layer)}");
		inBackgroundLayer = true;
		ystart -= global.BgInstanceLayerOffset;
		y -= global.BgInstanceLayerOffset;
		yprevious -= global.BgInstanceLayerOffset;
	}
}
