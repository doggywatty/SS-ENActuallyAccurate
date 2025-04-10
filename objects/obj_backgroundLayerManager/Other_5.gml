if (layer_get_target_room() == room)
	exit;

ds_list_clear(global.BgInstancesList);
layer_set_target_room(global.NextRoom);

for (var i = 0; i < array_length(global.BgInstanceLayers); i++)
{
	var _arr = layer_get_all_instances(global.BgInstanceLayers[i]), z = 0;
	while (z < array_length(_arr))
		ds_list_add(global.BgInstancesList, layer_instance_get_instance(_arr[z++]));
}

layer_reset_target_room();
