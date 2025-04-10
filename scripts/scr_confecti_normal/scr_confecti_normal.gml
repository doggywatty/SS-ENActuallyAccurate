function scr_confecti_normal()
{
	if (sprite_index != spr_appear)
	{
		if (x != real_x)
		{
			if (global.panic == 0)
				sprite_index = spr_run;
			else
				sprite_index = spr_runpanic;
		}
		else if (global.panic == 0)
			sprite_index = spr_idle;
		else
			sprite_index = spr_panic;
	}
	
	var _dir = 0;
	if (obj_parent_player.state != States.ladder && obj_parent_player.state != States.door && obj_parent_player.state != States.comingoutdoor)
		_dir = obj_parent_player.xscale;
	confecti_dir = approach(confecti_dir, _dir, 0.2);
	distance = confecti_dir * 25;
	var leader = -4;
	leader = !ds_list_find_index(global.FollowerList, id) ? obj_parent_player : ds_list_find_value(global.FollowerList, floor(ds_list_find_index(global.FollowerList, id) - 1));
	if !instance_exists(leader)
		leader = obj_parent_player;
	
	if instance_exists(leader)
	{
		ds_queue_enqueue(followQueue, leader.x - distance);
		ds_queue_enqueue(followQueue, leader.y);
	}
	
	LAG_STEPS = 10;
	if (ds_queue_size(followQueue) > (LAG_STEPS * 2))
	{
		targetx = ds_queue_dequeue(followQueue);
		targety = ds_queue_dequeue(followQueue);
	}
	if (obj_parent_player.x != x)
		drawxscale = -sign(x - obj_parent_player.x);
	
	real_x = x;
	if (use_interpolation)
	{
		x = lerp(x, targetx, interpolation);
		y = lerp(y, targety, interpolation);
		interpolation = approach(interpolation, 1, 0.01);
		if interpolation
		{
			interpolation = 0;
			use_interpolation = false;
		}
	}
	else
	{
		x = targetx;
		y = targety;
	}
	x = round(x);
	y = round(y);
	
	var supertaunts = [
		obj_parent_player.spr_supertaunt1, obj_parent_player.spr_supertaunt2,
		obj_parent_player.spr_supertaunt3, obj_parent_player.spr_supertaunt4
	];
	if (obj_parent_player.state == States.taunt && state != States.normal && state != States.titlescreen)
	{
		if (array_contains(supertaunts, obj_parent_player.sprite_index))
		{
			sprite_index = spr_supertaunt;
			image_index = 0;
			state = States.titlescreen;
			with obj_confectitaunt
			{
				if (o_id == other.id)
					instance_destroy();
			}
		}
		else if (obj_parent_player.sprite_index == obj_parent_player.spr_taunt)
		{
			instance_create(x, y, obj_confectitaunt, 
			{
				o_id: id,
				depth: depth + 1,
				bigTaunt: bigTaunt
			});
			state = States.normal;
			image_index = irandom_range(0, sprite_get_number(spr_taunt) - 1);
		}
	}
	image_speed = 0.35;
}
