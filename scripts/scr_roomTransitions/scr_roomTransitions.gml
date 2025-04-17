function scr_roomStart_SetPosition_player(player = obj_player1)
{
	if (instance_exists(obj_cutsceneManager) && obj_cutsceneManager.exitLevelCustcene)
		exit;
	
	with player
	{
		var target_door = obj_parent_doortrigger;
		var is_box_above = false;
		var gotohub = hubTransition && room == hubRoom;
		
		with obj_parent_doortrigger
		{
			if (other.targetDoor == id_door)
			{
				target_door = id;
				if (other.box && place_meeting(x, y - 1, obj_transportBox))
					is_box_above = true;
			}
		}
		
		if !instance_exists(target_door)
			show_debug_message("Door Trigger Instance not found");
		else if !gotohub
		{
			x = target_door.x + 16;
			if hallway
				x = target_door.x + (target_door.sprite_width / 2) + (hallwaydirection * 96);
			else if vertical
				x = target_door.x + verticalOffset;
			else if box || secretPortal
				x = target_door.x + 32;
			
			y = target_door.y - 14;
			if vertical
				y = target_door.y + (hallwaydirection * 160);
			else if box && is_box_above
				y = target_door.y - 1;
			else if secretPortal
				y = target_door.y;
		}
		
		if (place_meeting(x, y, obj_exitgate) && !gotohub)
		{
			var gate = instance_place(x, y, obj_exitgate);
			x = gate.x;
			gate.image_index = 0;
		}
		
		if ((state == States.door || state == States.victory) && room != rank_room)
		{
			state = States.comingoutdoor;
			image_index = 0;
			
			if box
			{
				hsp = 0;
				vsp = 0;
				verticalMovespeed = 0;
				movespeed = 0;
				jumpStop = true;
				state = States.jump;
				sprite_index = spr_fall;
				grounded = false;
			}
		}
		
		hallway = false;
		box = false;
		vertical = false;
		secretPortal = false;
		roomStartX = x;
		roomStartY = y;
	}
	
	if (hubTransition && room == hubRoom)
	{
		x = hubX;
		y = hubY;
		hubTransition = false;
		
		if (x == -1 || y == -1)
		{
			with obj_doorA
			{
				other.x = x + 16;
				other.y = y - 14;
			}
		}
		
		if (place_meeting(x, y, obj_startGate))
		{
			x = instance_place(x, y, obj_startGate).x;
			hubX = x;
		}
		
		if !global.CompletedLevel
		{
			if (isDemo && room != hub_demohallway)
				var _cutscene = cutscene_create([
					cutscene_backtohub_prestart, cutscene_backtohub_start, 
					cutscene_backtohub_en_out, cutscene_backtohub_middle, cutscene_backtohub_end
				]);
			else
				var _cutscene = cutscene_create([
					cutscene_backtohub_prestart, cutscene_backtohub_start,
					cutscene_backtohub_middle, cutscene_backtohub_end
				]);
		}
		
		global.CompletedLevel = false;
	}
	
	return true;
}

function defaultSecretState(_state = undefined)
{
	var player = obj_parent_player;
	if !is_undefined(_state)
		player = _state;
	return player.state;
}

function portal_activate(_portal, _activated)
{
	with _portal
	{
		var activate = !secretActivated;
		if is_undefined(_activated)
			activate = _activated;
		secretActivated = activate;
	}
}

function cutscene_secretPortal_start()
{
	var portal = cutscene_get_actor("SECRETPORTAL");
	var finished = false;
	global.ComboFreeze = 15;
	scr_queueTVAnimation(global.TvSprPlayer_Secret, 80);
	
	with obj_parent_player
	{
		isInSecretPortal = true;
		state = States.actor;
		hsp = 0;
		vsp = 0;
		sprite_index = spr_hurt;
		image_speed = 0.35;
		
		switch other.storedState
		{
			case States.cotton:
			case States.cottondrill:
			case States.cottonroll:
				sprite_index = spr_cottonDoubleJumpFall;
				break;
			default:
				sprite_index = spr_hurt;
				break;
		}
		
		if instance_exists(portal)
		{
			targetDoor = portal.targetDoor;
			targetRoom = portal.targetRoom;
			secretPortal = true;
			x = lerp(x, portal.x, 0.5);
			y = lerp(y, portal.y, 0.5);
			
			if (portal.sprite_index == spr_secretPortal_tele)
			{
				scale = 1 - (min(portal.image_index, 9) / 9);
				if (floor(portal.image_index) >= (portal.image_number - 1))
				{
					finished = true;
					scale = 0;
				}
			}
		}
	}
	with obj_spookey
	{
		image_xscale = obj_parent_player.scale;
		image_yscale = obj_parent_player.scale;
	}
	with obj_parent_confecti
		scale = obj_parent_player.scale;
	if finished
		cutscene_event_end();
}

function cutscene_secretPortal_middle()
{
	var portal = cutscene_get_actor("SECRETPORTAL");
	var finished = true;
	global.ComboFreeze = 15;
	
	with obj_parent_player
	{
		isInSecretPortal = true;
		state = States.actor;
		hsp = 0;
		vsp = 0;
	}
	
	if finished
	{
		instance_destroy(portal);
		if !instance_exists(obj_fadeoutTransition)
		{
			if !global.RoomIsSecret
				global.RoomIsSecret = true;
			event_play_oneshot("event:/SFX/general/door");
			instance_create(0, 0, obj_fadeoutTransition);
		}
		cutscene_event_end();
	}
}

function cutscene_secretPortal_preend()
{
	static portal = -4;
	
	var finished = false;
	global.ComboFreeze = 15;
	
	with obj_parent_player
	{
		scale = 0;
		isInSecretPortal = true;
		state = States.actor;
		hsp = 0;
		vsp = 0;
		image_speed = 0;
		image_index = 0;
		
		with instance_place(x, y, obj_secretPortal)
		{
			visible = false;
			savedActivate = false;
			appearTimer = 110;
		}
		
		if !instance_exists(obj_fadeoutTransition)
		{
			portal = instance_create(x, y + 14, obj_secretPortalexit);
			cutscene_declare_actor(portal, "EXITPORTAL");
			cutscene_event_end();
			exit;
		}
	}
}

function cutscene_secretPortal_end()
{
	static wait_timer = 0;
	
	var portal = cutscene_get_actor("EXITPORTAL");
	var finished = false;
	global.ComboFreeze = 15;
	
	with obj_parent_player
	{
		isInSecretPortal = true;
		image_speed = 0.35;
		
		with instance_place(x, y, obj_secretPortal)
		{
			visible = false;
			savedActivate = false;
			appearTimer = 110;
		}
		
		switch other.storedState
		{
			case States.cotton:
			case States.cottondrill:
			case States.cottonroll:
				movespeed = 0;
				verticalMovespeed = 0;
				hsp = 0;
				vsp = -5;
				sprite_index = spr_cottonDoubleJumpFall;
				state = States.cotton;
				groundedCot = false;
				break;
			default:
				sprite_index = spr_groundPoundfall;
				image_index = 0;
				movespeed = 0;
				verticalMovespeed = 0;
				hsp = 0;
				vsp = 0;
				state = States.freefall;
				freeFallSmash = -14;
				break;
		}
		
		scale = wait_timer;
		
		if wait_timer >= 1
		{
			wait_timer = 0;
			finished = true;
			scale = 1;
			
			repeat 5
				instance_create(x, y, obj_secretpoof);
			
			if !place_meeting(x, y, obj_tilePaintSplatter)
			{
				instance_create(x, y, obj_tilePaintSplatter, 
				{
					blendColor: #6f5bab
				});
			}
		}
		else
		{
			hsp = 0;
			vsp = 0;
			verticalMovespeed = 0;
			movespeed = 0;
		}
	}
	
	with portal
	{
		if (sprite_index != spr_secretPortal_exitopen)
		{
			wait_timer += 0.1;
			obj_parent_player.image_index = 0;
		}
		else
			obj_parent_player.scale = 0;
		
		alarm[0] = 30;
	}
	
	with obj_spookey
	{
		image_xscale = obj_parent_player.scale;
		image_yscale = obj_parent_player.scale;
	}
	
	with obj_parent_confecti
		scale = obj_parent_player.scale;
	
	if finished
	{
		cutscene_event_end();
		exit;
	}
}

function cutscene_backtohub_prestart()
{
	if (room == obj_parent_player.hubRoom)
		cutscene_event_end();
}

function cutscene_backtohub_start()
{
	obj_cutsceneManager.exitLevelCustcene = true;
	
	with obj_camera
	{
		event_perform(ev_step, ev_step_begin);
		event_perform(ev_step, ev_step_normal);
		cameraLock = true;
	}
	
	with obj_parent_player
	{
		y = hubY - (camera_get_view_height(view_camera[0]) * 2);
		x = hubX;
		state = States.actor;
		sprite_index = spr_player_PZ_slipSlide;
		image_index = 0;
		hsp = 0;
		vsp = 0;
		
		if (isDemo && room != hub_demohallway)
		{
			scale = 0;
			sprite_index = spr_player_PZ_geyser;
			event_play_oneshot("event:/SFX/general/paintingexit");
		}
	}
	
	cutscene_event_end();
}

function cutscene_backtohub_en_out()
{
	static afterimagebuffer = 2;
	
	var _offset = 60;
	var _timer = current_time / 100;
	var _finished = false;
	
	with obj_parent_player
	{
		state = States.actor;
		hsp = 0;
		vsp = 0;
		grav = 0;
		scale = approach(scale, 1, 0.015);
		movespeed = 0;
		var sin_pct = sin(scale * pi);
		x = hubX + (sin(_timer) * _offset * sin_pct);
		y = (hubY - 75) + (cos(_timer) * _offset * sin_pct);
		
		if !afterimagebuffer--
		{
			with create_afterimage(AfterImageType.plain, xscale * scale, false)
			{
				image_xscale = other.xscale * other.scale;
				image_yscale = other.yscale * other.scale;
			}
			afterimagebuffer = 2;
		}
		
		if scale >= 1
		{
			_finished = true;
			x = hubX;
			y = hubY - 75;
			scale = 1;
		}
	}
	
	if _finished
		cutscene_event_end();
}

function cutscene_backtohub_middle()
{
	static actorbuffer = 10;
	static fakeVSP = -6;
	
	var _finished = false;
	
	with obj_parent_player
	{
		state = States.actor;
		movespeed = 0;
		
		switch sprite_index
		{
			case spr_player_PZ_slipSlide:
				fakeVSP = 20;
				y += fakeVSP;
				vsp = 0;
				hsp = 0;
				grav = 0;
				if y >= hubY
				{
					y = hubY;
					fakeVSP = -14;
					sprite_index = spr_player_PZ_fall_outOfControl;
					camera_shake_add(3, 3);
					event_play_oneshot("event:/SFX/player/groundpound", x, y);
					create_particle(x, y + 39, spr_bangEffect);
					create_particle(x, y, spr_landcloud);
				}
				
				break;
			case spr_player_PZ_fall_outOfControl:
			case spr_player_PZ_geyser:
				hsp = 0;
				vsp = 0;
				y += fakeVSP;
				if fakeVSP < 20
					fakeVSP += 0.5;
				grav = 0;
				if (y >= hubY && vsp >= 0)
				{
					y = hubY;
					sprite_index = spr_player_PZ_slipSlide_end;
					image_index = 0;
					actorbuffer = 25;
					event_play_oneshot("event:/SFX/player/splat", x, y);
				}
				break;
			case spr_player_PZ_slipSlide_end:
				if sprite_animation_end()
				{
					image_index = image_number - 1;
					_finished = true;
					fakeVSP = -6;
					actorbuffer = 10;
				}
				break;
		}
	}
	
	if _finished
	{
		actorbuffer = 10;
		fakeVSP = -6;
		cutscene_event_end();
	}
}

function cutscene_backtohub_end()
{
	with obj_parent_player
		state = States.normal;
	obj_camera.cameraLock = false;
	cutscene_event_end();
}
