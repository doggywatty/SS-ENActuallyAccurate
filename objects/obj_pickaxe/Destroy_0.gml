if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	for (var i = 0; i < sprite_get_number(spr_pickaxeDebris); i++)
	{
		var d = create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_pickaxeDebris, 0);
		d.image_index = i;
	}
	
	create_particle(x, y, spr_bangEffect);
	ds_list_add(global.SaveRoom, id);
}
