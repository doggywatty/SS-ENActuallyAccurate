if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	instance_create(x + (sprite_width / 2), y + (sprite_height / 2), obj_bangEffect);
	var rep = 3 + round(sprite_width / 16);
	repeat rep
		create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_metaldebrishard);
	camera_shake_add(20, 40);
	event_play_oneshot("event:/SFX/general/breakmetal", x, y);
	ds_list_add(global.SaveRoom, id);
}
