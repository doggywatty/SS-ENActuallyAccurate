if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	var rep = 3 + round(sprite_width / 16);
	repeat rep
		create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_confecticage_debris);
	event_play_oneshot("event:/SFX/general/breakglass", x, y);
	ds_list_add(global.SaveRoom, id);
}
