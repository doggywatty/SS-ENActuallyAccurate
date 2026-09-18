if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	with (instance_create(x + (32 * image_xscale), y + (32 * image_yscale), obj_baddieDead))
		sprite_index = spr_milkblock_dead;
	
	camera_shake_add(20, 40);
	event_play_oneshot("event:/SFX/enemies/killingblow", x, y);
	ds_list_add(global.SaveRoom, id);
}
