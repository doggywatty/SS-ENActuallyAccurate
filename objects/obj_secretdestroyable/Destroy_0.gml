if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	sprite_get_destroyable_smoke(debrisSprite);
	var rep = 2;
	repeat rep
	{
		if (place_meeting(x, y, obj_secretPortal) || instance_exists(obj_secretfound))
			create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_secretGoopDebris);
		else
			create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), debrisSprite, 0.35);
	}
	
	create_destroyable_smoke(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), array_get_any(smokeColor));
	
	if (room != hub_mindpalace)
		event_play_multiple("event:/SFX/general/breakblock", x, y);
	else
		event_play_multiple("event:/SFX/general/wormKill", x, y);
	
	ds_list_add(global.SaveRoom, id);
}

for (var i = 0; i < array_length(tiles); i++)
	scr_destroy_tile(tiles[i]);

scr_destroy_nearby_tiles();
