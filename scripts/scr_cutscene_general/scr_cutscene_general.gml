function cutscene_wait(_time)
{
	with obj_cutsceneManager
	{
		timer++;
		if (timer >= _time)
		{
			timer = 0;
			cutscene_event_end();
		}
	}
}

function cutscene_end_player()
{
	obj_parent_player.state = States.normal;
	obj_parent_player.hsp = 0;
	obj_parent_player.vsp = 0;
	obj_parent_player.sprite_index = obj_parent_player.spr_idle;
	cutscene_event_end();
}

function cutscene_start_player()
{
	obj_parent_player.state = States.actor;
	obj_parent_player.hsp = 0;
	obj_parent_player.vsp = 0;
	obj_parent_player.sprite_index = obj_parent_player.spr_idle;
	cutscene_event_end();
}

function cutscene_create_instance(_x, _y, obj)
{
	instance_create(_x, _y, obj);
	cutscene_event_end();
}

function cutscene_do_func(_func)
{
	_func();
	cutscene_event_end();
}

function cutscene_with_actor(_cutscene, _actor)
{
	cutscene_event_end();
	with cutscene_get_actor(_cutscene)
		return _actor();
}

function cutscene_do_dialog(_cutscene, _destroy = false)
{
	queue_dialogue(_cutscene, _destroy);
	with obj_dialogue
		instant_destroy = _destroy;
	cutscene_event_end();
}

function cutscene_wait_dialog()
{
	var finished = false;
	if (!instance_exists(obj_dialogue) && !instance_exists(obj_dialogue_choices))
		finished = true;
	if finished
		cutscene_event_end();
}

function cutscene_lerp_actor(_cutscene, _x, _y, _amount)
{
	var finished = false;
	with cutscene_get_actor(_cutscene)
	{
		x = lerp(x, _x, _amount);
		y = lerp(y, _y, _amount);
		if (distance_to_point(_x, _y) <= 4)
		{
			finished = true;
			x = _x;
			y = _y;
		}
	}
	if finished
		cutscene_event_end();
}

function cutscene_move_actor(_cutscene, _x, _y, _len)
{
	var finished = false;
	var real_actor = cutscene_get_actor(_cutscene);
	with real_actor
	{
		var angle = point_direction(x, y, _x, _y);
		var dir_x = lengthdir_x(_len, angle);
		var dir_y = lengthdir_y(_len, angle);
		x = approach(x, _x, dir_x);
		y = approach(y, _y, dir_y);
		
		if (x == _x && y == _y)
			finished = true;
	}
	if finished || !real_actor
		cutscene_event_end();
}

function cutscene_new_actor(_x, _y, _spr_ind, _actor)
{
	var new_actor = instance_create(_x, _y, obj_actor);
	new_actor.sprite_index = _spr_ind;
	with new_actor
		cutscene_declare_actor(id, _actor);
	cutscene_event_end();
	return new_actor;
}

function cutscene_actor_animend(_cutscene)
{
	var finished = false;
	with cutscene_get_actor(_cutscene)
	{
		if sprite_animation_end()
			finished = true;
	}
	if finished
		cutscene_event_end();
}
