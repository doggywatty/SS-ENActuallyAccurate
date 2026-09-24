if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	sprite_get_destroyable_smoke(debrisSprite);
	var rep = 3 + round(sprite_width / 32);
	
	repeat (rep)
	{
		create_destroyable_smoke(bbox_xrange, bbox_yrange, array_get_any(smokeColor));
		
		if (place_meeting(x, y, obj_secretPortal) || instance_exists(obj_secretfound))
			create_debris(bbox_xrange, bbox_yrange, spr_secretGoopDebris);
		else
			create_debris(bbox_xrange, bbox_yrange, debrisSprite, 0.35);
	}
	
	if (room != hub_mindpalace)
		event_play_multiple("event:/SFX/general/breakblock", xorigin + (sprite_width / 2), yorigin + (sprite_height / 2));
	else
		event_play_multiple("event:/SFX/general/wormKill", xorigin + (sprite_width / 2), yorigin + (sprite_height / 2));
	
	ds_list_add(global.SaveRoom, id);
}

for (var i = 0; i < array_length(tiles); i++)
	scr_destroy_tile(tiles[i]);

scr_destroy_nearby_tiles();
