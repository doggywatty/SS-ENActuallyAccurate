if !global.panic && ds_list_size(global.KeyFollowerList) <= 0
	exit;

var target_player = get_nearestPlayer();
switch state
{
	case States.frozen:
		sprite_index = spr_wakeup;
		
		if (shaketime > 0)
		{
			shaketime--;
			x = xstart + random_range(-2, 2);
			y = ystart + random_range(-2, 2);
		}
		else
		{
			x = xstart;
			y = ystart;
		}
		
		if (((target_player.cutscene || target_player.state == States.gotkey) && !awoken) || offended)
			exit;
		
		if !playedSound && !awoken
		{
			playedSound = true;
			fmod_quick3D(sndWake);
			fmod_studio_event_instance_start(sndWake);
		}
		
		awoken = true;
		image_speed = 0.35;
		
		if sprite_animation_end()
		{
			sprite_index = spr_aim;
			image_index = 0;
			chaseActive = true;
			state = States.normal;
		}
		break;
	case States.normal:
		image_xscale = sign(target_player.x - x);
		movespeed = approach(movespeed, 0, accel);
		targetx = target_player.x;
		targety = target_player.y;
		pathxstart = x;
		pathystart = y;
		dir = point_direction(x, y, targetx, targety);
		
		if (aimtime > 0)
			aimtime--;
		else
		{
			aimtime = 30;
			state = States.run;
			movespeed = -6;
			sprite_index = spr_windup;
			image_index = 0;
			targetpassed = false;
			candie = false;
		}
		break;
	case States.titlescreen:
		movespeed = approach(movespeed, 10, 2 * accel);
		if (movespeed > 0 && sprite_index == spr_windup)
		{
			sprite_index = spr_charge;
			image_index = 0;
		}
		if (movespeed == 10)
			state = States.run;
		x += lengthdir_x(movespeed, dir);
		y += lengthdir_y(movespeed, dir);
		break;
	case States.run:
		if !targetpassed
		{
			candie = 1;
			var _accel = (movespeed < 6) ? (accel * 2) : accel;
			movespeed = approach(movespeed, maxspeed, _accel);
			if (point_distance(x, y, targetx, targety) < movespeed)
				targetpassed = true;
		}
		else if (candie && movespeed > 0)
		{
			if (distance_to_object(target_player) < 64)
				movespeed = approach(movespeed, maxspeed, accel);
			else
				movespeed = approach(movespeed, 0, 1.65 * accel);
		}
		else if candie
		{
			aimtime = 30;
			sprite_index = spr_aim;
			image_index = 0;
			state = States.normal;
			candie = 0;
			movespeed = 0;
			targetpassed = false;
		}
		
		if !targetpassed
		{
			var _passedX = (sign(targetx - pathxstart) == -1) ? (x <= targetx) : (x >= targetx);
			var _passedY = (sign(targety - pathystart) == -1) ? (y <= targety) : (y >= targety);
			if (_passedX && _passedY)
				targetpassed = true;
		}
		
		if (sprite_index != spr_aim)
		{
			if (sprite_index != spr_aim || movespeed > 0)
				sprite_index = spr_charge;
		}
		
		x += lengthdir_x(movespeed, dir);
		y += lengthdir_y(movespeed, dir);
		break;
	case States.charge:
		if (stuntime > 0)
		{
			x = targetx + random_range(-2, 2);
			y = targety + random_range(-2, 2);
			stuntime--;
			
			if (stuntime <= 0)
				dir = point_direction(targetx, targety, target_player.x, target_player.y) - 180;
		}
		else
		{
			x += lengthdir_x(movespeed, dir);
			y += lengthdir_y(movespeed, dir);
			movespeed = approach(movespeed, 0, 2 * accel);
			
			if (offended && movespeed == 0)
			{
				targetx = xstart;
				targety = ystart;
				state = States.climbwall;
				sprite_index = spr_guardianohbye;
				image_index = 0;
				fmod_quick3D(sndSob);
				fmod_studio_event_instance_start(sndSob);
			}
			else if (movespeed == 0)
			{
				chaseActive = true;
				aimtime = 30;
				sprite_index = spr_aim;
				image_index = 0;
				state = States.normal;
				candie = false;
				movespeed = 0;
				targetpassed = false;
			}
		}
		
		break;
	case States.stun:
		sprite_index = spr_guardianohbye;
		x += (5 * image_xscale);
		y -= 5;
		break;
	case States.climbwall:
		fmod_quick3D(sndSob);
		movespeed = approach(movespeed, 12, 0.2);
		dir = point_direction(x, y, targetx, targety);
		var dist = point_distance(x, y, targetx, targety);
		
		if (movespeed > dist)
			movespeed = dist;
		
		image_xscale = sign(targetx - x);
		x += lengthdir_x(movespeed, dir);
		y += lengthdir_y(movespeed, dir);
		
		if (dist < 0.5)
		{
			x = xstart;
			y = ystart;
			image_xscale = 1;
			sprite_index = spr_wakeup;
			image_index = 0;
			image_speed = 0;
			state = States.frozen;
			shaketime = 10;
			fmod_studio_event_instance_set_parameter_by_name(sndSob, "state", 1, true);
		}
		break;
}

if (state == States.frozen)
	exit;

var player_supertaunt = false;
with target_player
{
	if ((sprite_index == spr_supertaunt1 || sprite_index == spr_supertaunt2 || sprite_index == spr_supertaunt3 || sprite_index == spr_supertaunt4) && state == States.taunt)
		player_supertaunt = true;
}

if (state != States.charge && state != States.frozen && player_supertaunt && bbox_in_camera(id, view_camera[0]))
{
	state = States.charge;
	offended = true;
	sprite_index = spr_aim;
	image_index = 0;
	movespeed = max(movespeed, 12);
	chaseActive = false;
	stuntime = 35;
	targetx = x;
	targety = y;
	global.ComboTime = 60;
	global.ComboFreeze = 15;
	event_play_oneshot("event:/SFX/general/softkaboom", x, y);
	
	with obj_achievementTracker
		guardianSupertaunted++;
}

if (target_player.state == States.fling || target_player.state == States.fling_launch)
{
	state = States.charge;
	movespeed = 0;
	stuntime = max(stuntime, 10);
	chaseActive = false;
	targetx = x;
	targety = y;
}

if (instance_exists(obj_coneball_timesUp))
{
	state = States.stun;
	if (instance_exists(obj_icontracker))
		instance_destroy(obj_icontracker);
}

if (state == States.run || state == States.titlescreen)
{
	if !event_instance_isplaying(sndMoving)
		fmod_studio_event_instance_start(sndMoving);
}
else
	fmod_studio_event_instance_stop(sndMoving, false);

fmod_quick3D(sndMoving);
