if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	var rep = 3 + round(sprite_width / 16);
	
	repeat (rep)
		create_debris(bbox_xrange, bbox_yrange, spr_waferdestroyable_debris);
	
	event_play_multiple("event:/SFX/general/breakblock", xorigin + (sprite_width / 2), yorigin + (sprite_height / 2));
	ds_list_add(global.SaveRoom, id);
}
