if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	event_play_multiple("event:/SFX/general/collect", x, y);
	
	with (instance_create(0, 540 + sprite_get_height(spr_caferank1), obj_caferank))
		collect = 400;
	
	instance_destroy(obj_milkblock);
	global.CafeDrawer.dunk = true;
	ds_list_add(global.SaveRoom, id);
}

sprite_index = spr_milkgoal_filled;
