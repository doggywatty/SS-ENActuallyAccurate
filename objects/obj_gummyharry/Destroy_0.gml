if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	repeat 2
	{
		create_particle(x, y, spr_bangEffect);
		create_debris(x, y, spr_slapstar);
		create_debris(x, y, spr_baddieGibs);
	}
	
	instance_create(x, y, obj_harrydead);
	var time_array = scr_escapetimes();
	global.panic = true;
	global.EscapeTime = time_in_frames(time_array[0], time_array[1]);
	global.MaxEscapeTime = global.EscapeTime;
	
	with obj_hudManager.HUDObject_timer
		targetEscapeTime = global.EscapeTime;
	
	instance_create(0, 0, obj_sugarrush);
	
	if !instance_exists(obj_panicchanger)
		instance_create(x, y, obj_panicchanger);
	
	event_play_oneshot("event:/SFX/general/escaperumble");
	event_play_oneshot("event:/SFX/enemies/kill");
	scr_sleep();
	global.ComboFreeze = 15;
	global.ComboTime = 60;
	global.Combo++;
	ds_list_add(global.SaveRoom, id);
}
