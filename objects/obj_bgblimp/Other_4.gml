if (ds_list_find_index(global.SaveRoom, id) != -1)
	instance_destroy();

if (get_panic() && ds_list_find_index(global.SaveRoom, id) == -1)
	ds_list_add(global.SaveRoom, id);
