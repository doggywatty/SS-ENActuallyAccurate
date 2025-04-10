if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	sprite_get_destroyable_smoke(debrisSprite);
	var rep = 3 + round(sprite_width / 32);
	repeat rep
	{
		create_destroyable_smoke(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), array_get_any(smokeColor));
		
		if (place_meeting(x, y, obj_secretPortal) || instance_exists(obj_secretfound))
			create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_secretGoopDebris);
		else
			create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), debrisSprite, 0.35);
	}
	
	create_particle((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), spr_bangEffect);
	camera_shake_add(20, 40);
	event_play_oneshot("event:/SFX/general/breakmetal", x, y);
	ds_list_add(global.SaveRoom, id);
}

for (var i = 0; i < array_length(tiles); i++)
	scr_destroy_tile(tiles[i]);

scr_destroy_nearby_tiles();
