if (ds_list_find_index(global.SaveRoom, id) != -1)
{
	sprite_index = spr_milkgoal_filled;
	instance_destroy(obj_dogMount);
}
