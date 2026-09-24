if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	var rep = 3 + round(sprite_width / 16);
	
	repeat (rep)
		create_debris(bbox_xrange, bbox_yrange, spr_confecticage_debris);
	
	event_play_oneshot("event:/SFX/general/breakglass", x, y);
	ds_list_add(global.SaveRoom, id);
}
