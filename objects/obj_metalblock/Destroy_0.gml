if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	var rep = 3 + round(sprite_width / 32);
	
	repeat (rep)
	{
		create_destroyable_smoke(bbox_xrange, bbox_yrange, array_get_any(smokeColor));
		
		if (place_meeting(x, y, obj_secretPortal))
			create_debris(bbox_xrange, bbox_yrange, spr_secretGoopDebris);
		else
			create_debris(bbox_xrange, bbox_yrange, debrisSprite, 0.35);
	}
	
	create_particle(xorigin + (sprite_width / 2), yorigin + (sprite_height / 2), spr_bangEffect);
	camera_shake_add(20, 40);
	event_play_oneshot("event:/SFX/general/breakmetal", x, y);
	ds_list_add(global.SaveRoom, id);
}
