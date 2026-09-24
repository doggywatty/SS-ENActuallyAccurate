if (linkedWorm != noone)
{
	with (linkedWorm)
		instance_destroy();
}

if (ds_list_find_index(global.SaveRoom, bumpID) == -1)
{
	create_particle(xorigin + (sprite_width / 2), yorigin + (sprite_height / 2), spr_bangEffect);
	
	repeat (2)
		create_baddiedebris();
	
	ds_list_add(global.SaveRoom, bumpID);
}
