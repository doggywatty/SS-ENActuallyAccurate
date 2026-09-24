if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	for (var i = 0; i < sprite_get_number(spr_pickaxeDebris); i++)
	{
		var d = create_debris(bbox_xrange, bbox_yrange, spr_pickaxeDebris, 0);
		d.image_index = i;
	}
	
	create_particle(x, y, spr_bangEffect);
	ds_list_add(global.SaveRoom, id);
}
