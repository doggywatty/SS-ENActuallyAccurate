if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	with (instance_create(x + (sprite_width / 2), y + (sprite_height / 2), obj_baddieDead))
		sprite_index = spr_molassescorkpopped;
	
	repeat (3)
	{
		instance_create(bbox_xrange, bbox_yrange, obj_slapstar);
		instance_create(bbox_xrange, bbox_yrange, obj_baddieGibs);
	}
	
	create_particle(bbox_xrange, bbox_yrange, spr_bangEffect);
	event_play_oneshot("event:/SFX/general/bottlepop", xorigin + (sprite_width / 2), yorigin + (sprite_height / 2));
	ds_list_add(global.SaveRoom, id);
}
