function cutscene_wait(arg0)
{
	with (obj_cutsceneManager)
	{
		timer++;
		
		if (timer >= arg0)
		{
			timer = 0;
			cutscene_event_end();
		}
	}
}

function cutscene_end_player()
{
	obj_parent_player.state = states.normal;
	obj_parent_player.hsp = 0;
	obj_parent_player.vsp = 0;
	obj_parent_player.sprite_index = obj_parent_player.spr_idle;
	cutscene_event_end();
}

function cutscene_start_player()
{
	obj_parent_player.state = states.mach3;
	obj_parent_player.hsp = 0;
	obj_parent_player.vsp = 0;
	obj_parent_player.sprite_index = obj_parent_player.spr_idle;
	cutscene_event_end();
}

function cutscene_create_instance(arg0, arg1, arg2)
{
	instance_create(arg0, arg1, arg2);
	cutscene_event_end();
}

function cutscene_do_func(arg0)
{
	arg0();
	cutscene_event_end();
}

function cutscene_with_actor(arg0, arg1)
{
	cutscene_event_end();
	
	with (cutscene_get_actor(arg0))
		return arg1();
}

function cutscene_do_dialog(arg0, arg1 = false)
{
	queue_dialogue(arg0, arg1);
	
	with (obj_dialogue)
		instant_destroy = arg1;
	
	cutscene_event_end();
}

function cutscene_wait_dialog()
{
	var finished = false;
	
	if (!instance_exists(obj_dialogue) && !instance_exists(obj_dialogue_choices))
		finished = true;
	
	if (finished)
		cutscene_event_end();
}

function cutscene_lerp_actor(arg0, arg1, arg2, arg3)
{
	var finished = false;
	
	with (cutscene_get_actor(arg0))
	{
		x = lerp(x, arg1, arg3);
		y = lerp(y, arg2, arg3);
		
		if (distance_to_point(arg1, arg2) <= 4)
		{
			finished = true;
			x = arg1;
			y = arg2;
		}
	}
	
	if (finished)
		cutscene_event_end();
}

function cutscene_move_actor(arg0, arg1, arg2, arg3)
{
	var finished = false;
	var real_actor = cutscene_get_actor(arg0);
	
	with (real_actor)
	{
		var angle = point_direction(x, y, arg1, arg2);
		var dir_x = lengthdir_x(arg3, angle);
		var dir_y = lengthdir_y(arg3, angle);
		x = approach(x, arg1, dir_x);
		y = approach(y, arg2, dir_y);
		
		if (x == arg1 && y == arg2)
			finished = true;
	}
	
	if (finished || !real_actor)
		cutscene_event_end();
}

function cutscene_new_actor(arg0, arg1, arg2, arg3)
{
	var new_actor = instance_create(arg0, arg1, obj_actor);
	new_actor.sprite_index = arg2;
	
	with (new_actor)
		cutscene_declare_actor(id, arg3);
	
	cutscene_event_end();
	return new_actor;
}

function cutscene_actor_animend(arg0)
{
	var finished = false;
	
	with (cutscene_get_actor(arg0))
	{
		if (sprite_animation_end())
			finished = true;
	}
	
	if (finished)
		cutscene_event_end();
}
