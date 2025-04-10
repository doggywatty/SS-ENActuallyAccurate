function cutscene_elevator_prestart()
{
	colorID = 0;
	var elevator = cutscene_get_actor("ELEVATOR");
	var finished = false;
	global.ComboFreeze = 15;
	with obj_parent_player
	{
		state = States.actor;
		movespeed = 6;
		hsp = 0;
		vsp = 0;
		image_speed = 0.35;
		if instance_exists(elevator)
		{
			x = approach(x, elevator.x, 5);
			y = approach(y, elevator.bbox_bottom - (bbox_bottom - y), 5);
			if (elevator.sprite_index == spr_minesElevator)
			{
				elevator.sprite_index = spr_minesElevatorClosing;
				elevator.image_index = 0;
				elevator.depth = depth - 1;
				sprite_index = spr_player_PZ_elevator;
				visible = false;
			}
			if (elevator.sprite_index == spr_minesElevatorClosing && elevator.image_index >= (elevator.image_number - 1))
			{
				finished = true;
				elevator.sprite_index = spr_minesElevatorRunning;
				with obj_parent_follower
					visible = false;
			}
		}
	}
	if finished
		cutscene_event_end();
}

function cutscene_elevator_start()
{
	var elevator = cutscene_get_actor("ELEVATOR");
	var finished = false;
	global.ComboFreeze = 15;
	with obj_parent_player
	{
		state = States.actor;
		hsp = 0;
		vsp = 0;
		sprite_index = spr_idle;
		visible = false;
		if instance_exists(elevator)
		{
			x = elevator.x;
			y = (elevator.y + (elevator.sprite_height / 2)) - (sprite_height / 2);
			elevator.vsp = lerp(elevator.vsp, 8, 0.125);
			elevator.sprite_index = spr_minesElevatorRunning;
			elevator.image_speed = 0.35;
			if (elevator.y > (room_height + 100))
				finished = true;
		}
	}
	if finished
		cutscene_event_end();
}

function cutscene_elevator_premiddle()
{
	var elevator = cutscene_get_actor("ELEVATOR");
	global.ComboFreeze = 15;
	with obj_parent_player
	{
		state = States.actor;
		targetRoom = mineshaft_elevator;
		hsp = 0;
		vsp = 0;
		visible = false;
	}
	if instance_exists(elevator)
	{
		if !instance_exists(obj_fadeoutTransition)
		{
			event_play_oneshot("event:/SFX/general/door");
			instance_create(0, 0, obj_fadeoutTransition);
		}
	}
	else if (room == mineshaft_elevator)
		cutscene_event_end();
}

function cutscene_elevator_middle()
{
	var finished = false;
	global.ComboFreeze = 15;
	with obj_parent_player
	{
		state = States.actor;
		hsp = 0;
		vsp = 0;
		targetRoom = targetElevatorRoom;
	}
	if (room == mineshaft_elevator && instance_exists(obj_minesElevatorCounter))
	{
		colorID = obj_minesElevatorCounter.colorID;
		finished = obj_minesElevatorCounter.count > 120;
		with obj_parent_player
		{
			x = room_width / 2;
			y = room_height / 2;
			visible = false;
		}
	}
	if (finished && room == mineshaft_elevator)
	{
		if !instance_exists(obj_fadeoutTransition)
		{
			event_play_oneshot("event:/SFX/elevator/snap");
			instance_create(0, 0, obj_fadeoutTransition);
		}
	}
	else if (room != mineshaft_elevator)
	{
		layer_set_visible("Assets_Elevator", false);
		if !instance_exists(obj_elevatorCrashing)
			instance_create(x, camera_get_view_y(view_camera[0]) - 100, obj_elevatorCrashing);
		else
			cutscene_event_end();
	}
}

function cutscene_elevator_preend()
{
	var elevator = obj_elevatorCrashing;
	with obj_parent_player
	{
		state = States.actor;
		hsp = 0;
		vsp = 0;
		x = elevator.x;
		visible = false;
	}
	if !obj_camera.cameraLock
	{
		with obj_camera
		{
			event_perform(ev_step, ev_step_normal);
			cameraLock = true;
		}
	}
	if elevator.grounded
	{
		elevator.sprite_index = spr_minesElevatorCrashed;
		camera_shake_add(8, 20);
		event_play_oneshot("event:/SFX/player/groundpound", elevator.x, elevator.y);
		event_play_oneshot("event:/SFX/elevator/open");
		for (var i = 0; i < sprite_get_number(spr_minesElevatorDebris); i++)
		{
			with (instance_create(elevator.x + irandom_range(-40, 40), elevator.y - irandom_range(20, 60), obj_debris))
			{
				sprite_index = spr_minesElevatorDebris;
				image_index = i;
			}
		}
		with (instance_create(elevator.x, elevator.y, obj_baddieDead))
		{
			image_xscale = other.image_xscale;
			image_blend = other.image_blend;
			sprite_index = spr_gnomeMinerDie;
			paletteSprite = pal_gnome;
			paletteSelect = other.colorID;
		}
		cutscene_event_end();
	}
}

function cutscene_elevator_end()
{
	global.ComboFreeze = 15;
	obj_camera.cameraLock = false;
	with obj_parent_player
	{
		roomStartX = x;
		roomStartY = y;
		image_index = 0;
		image_speed = 0.35;
		sprite_index = spr_player_PZ_fall_outOfControl;
		visible = true;
		state = States.puddle;
		vsp = -11;
		hsp = 0;
		movsepeed = 0;
		image_xscale = 1;
		xscale = 1;
		grounded = false;
	}
	with obj_parent_follower
		visible = true;
	cutscene_event_end();
}
