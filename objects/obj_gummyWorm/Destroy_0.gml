if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	create_particle(bbox_xrange, bbox_yrange, spr_parryeffect);
	create_debris(bbox_xrange, bbox_yrange, spr_gummywormdebrishead);
	create_debris(bbox_xrange, bbox_yrange, spr_gummywormdebristail);
	var rep = 3 + round(sprite_width / 16);
	
	repeat (rep)
		create_debris(bbox_xrange, bbox_yrange, spr_gummywormdebrisloop);
	
	repeat (3)
	{
		create_debris(bbox_xrange, bbox_yrange, spr_slapstar);
		instance_create(bbox_xrange, bbox_yrange, obj_baddieGibs);
	}
	
	create_particle(bbox_xrange, bbox_yrange, spr_bangEffect);
	event_play_oneshot("event:/SFX/player/punch", x, y);
	event_play_oneshot("event:/SFX/general/wormKill", x, y);
	event_play_oneshot("event:/SFX/enemies/kill", x, y);
	global.ComboTime = 60;
	camera_shake_add(3, 3);
	obj_parent_player.superTauntBuffer++;
	global.Combo++;
	var _score = 10 + floor(global.Combo / 2);
	global.Collect += _score;
	global.ComboScore += _score;
	ds_list_add(global.SaveRoom, id);
	
	with (obj_gummyWormBump)
	{
		if (linkedWorm == other.id)
			instance_destroy(id, false);
	}
}
