if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	var rep = 3 + round(sprite_width / 32);
	repeat rep
	{
		create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_bigdebris, 0.35);
		create_destroyable_smoke(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), array_get_any(smokeColor));
	}
	
	event_play_multiple("event:/SFX/general/breakblock", x, y);
	ds_list_add(global.SaveRoom, id);
}
