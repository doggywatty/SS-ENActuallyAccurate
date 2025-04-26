function cutscene_lapPortal_start()
{
	var finished = false;
	global.ComboFreeze = 2;
	with obj_parent_player
	{
		isInLapPortal = true;
		state = States.actor;
		hsp = 0;
		vsp = 0;
		sprite_index = spr_lappingportal_enter;
		image_speed = 0.35;
		if sprite_animation_end()
			finished = true;
	}
	with obj_parent_follower
		visible = false;
	if finished
	{
		global.lapcount = 1;
		global.ComboTime = 60;
		
		for (var i = 0; i < ds_list_size(global.EscapeRoom); i++)
		{
			var b = ds_list_find_value(global.EscapeRoom, i);
			var q = ds_list_find_index(global.BaddieRoom, b);
			var t = false;
			if (q == -1)
			{
				q = ds_list_find_index(global.SaveRoom, b);
				t = true;
			}
			if (q != -1)
			{
				if !t
					ds_list_delete(global.BaddieRoom, q);
				else
					ds_list_delete(global.SaveRoom, q);
			}
		}
		ds_list_clear(global.EscapeRoom);
		if !instance_exists(obj_fadeoutTransition)
		{
			event_play_oneshot("event:/SFX/general/door");
			instance_create(0, 0, obj_fadeoutTransition);
		}
		cutscene_event_end();
	}
}

function cutscene_lapPortal_middle()
{
	static portal = -4;

	var finished = false;
	global.ComboFreeze = 2;
	with obj_parent_player
	{
		isInLapPortal = true;
		visible = false;
		state = States.actor;
		hsp = 0;
		vsp = 0;
		sprite_index = spr_groundPoundfall;
		image_speed = 0.35;
		if !instance_exists(obj_fadeoutTransition)
		{
			if !instance_exists(portal)
				portal = instance_create(x, y + 14, obj_lapPortalexit);
			else if (floor(portal.image_index) >= 4)
			{
				event_play_oneshot("event:/SFX/general/lapexit", portal.x, portal.y);
				finished = true;
			}
		}
	}
	if finished
		cutscene_event_end();
}

function cutscene_lapPortal_end()
{
	var finished = false;
	global.ComboFreeze = 2;
	with obj_parent_player
	{
		isInLapPortal = true;
		visible = true;
		hsp = 0;
		vsp = 0;
		movespeed = 0;
		freeFallSmash = -14;
		sprite_index = spr_groundPoundfall;
		state = States.freefall;
		finished = true;
	}
	with obj_parent_follower
		visible = true;
	if finished
	{
		if (global.lapcount == 1)
			global.savedfill = global.EscapeTime;
		else if (global.lapcount > 1)
			global.EscapeTime = global.savedfill - ((global.lapcount - 1) * 100);
		instance_create(0, 0, obj_lap2visual);
		event_play_oneshot("event:/SFX/general/lap2start", x, y);
		cutscene_event_end();
	}
}
