if (other.state == PlayerState.titlescreen)
{
	helptimer = -1;
	
	with (other)
	{
		sprite_index = spr_creamthief_grab;
		image_index = 0;
		state = PlayerState.frozen;
		ds_list_add(global.SaveRoom, id, true);
		instance_create(x, y, obj_creamThiefCar);
	}
	
	event_play_oneshot("event:/SFX/general/loserace");
	
	repeat (6)
		create_debris(bbox_xrange, bbox_yrange, spr_confecticage_debris);
	
	instance_destroy();
	ds_list_add(global.SaveRoom, id);
}
