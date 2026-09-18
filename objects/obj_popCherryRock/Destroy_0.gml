if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	instance_create(x + (sprite_width / 2) + random_range(-3, 3), y + (sprite_height / 4) + random_range(-3, 3), obj_bombExplosionHarmful);
	ds_list_add(global.SaveRoom, id);
}
