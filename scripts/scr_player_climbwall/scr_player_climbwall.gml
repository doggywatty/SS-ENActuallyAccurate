function state_player_climbwall()
{
	floatyGrab = 0;
	conveyorHsp = 0;
	hsp = xscale * movespeed;
	if (windingAnim < 200)
		windingAnim++;
	jumpStop = false;
	move = key_right + key_left;
	vsp = -verticalMovespeed;
	if (vsp != 0 && place_meeting(x + xscale, y, obj_molassesWall))
	{
		if ((floor(image_index) % 4) == 0)
		{
			create_debris(x + (xscale * 16), y + 46, spr_molassesgoop);
			event_play_oneshot("event:/SFX/player/goopfloor", x, y);
		}
	}
	
	var _maxspeed = (move == xscale) ? 20 : 12;
	if (verticalMovespeed < _maxspeed && !place_meeting(x + xscale, y, obj_molassesWall))
		verticalMovespeed += 0.1;
	else if (place_meeting(x + xscale, y, obj_molassesWall))
	{
		if (verticalMovespeed > 0)
			verticalMovespeed -= 0.05;
	}
	if (verticalMovespeed > 0)
	{
		if (movespeed < 20)
			movespeed += (machFourMode ? 0.1 : 0.025);
	}
	if (sprite_index == spr_mach2_climbwall && verticalMovespeed >= 12)
	{
		flash = true;
		fmod_studio_event_instance_start(sndMachStart);
	}
	sprite_index = (verticalMovespeed >= 12) ? spr_mach3_climbwall : spr_mach2_climbwall;
	if (verticalMovespeed <= 0)
	{
		movespeed = 0;
		machTwo = 0;
	}
	if (grabClimbBuffer > 0)
		grabClimbBuffer--;
	if (!key_attack && grabClimbBuffer <= 0)
	{
		movespeed = 0;
		vsp /= 2;
		state = States.jump;
		sprite_index = spr_fall;
		conveyorHsp = -6 * xscale;
	}
	
	if !place_meeting_collision(x + xscale, y)
	{
		instance_create(x, y, obj_jumpdust, 
		{
			playerID: id
		});
		vsp = 0;
		verticalMovespeed = max(verticalMovespeed, 6);
		var old_x = x;
		var old_y = y;
		var attempt = 0;
		while !place_meeting_collision(x + xscale, y)
		{
			attempt++;
			y++;
			if place_meeting_collision(x + xscale, y)
			{
				y--;
				if key_slap
					y -= 11;
				break;
			}
			if (attempt > 32)
				break;
		}
		
		if (verticalMovespeed < 12)
		{
			state = States.mach2;
			movespeed = verticalMovespeed;
		}
		else if (verticalMovespeed >= 12)
		{
			state = States.mach3;
			sprite_index = spr_mach3player;
			movespeed = verticalMovespeed;
		}
		hsp = movespeed * xscale;
	}
	
	if ((place_meeting_collision(x, y - 1, Exclude.SLOPES) && vsp <= 0)
	&& !place_meeting(x, y - 1, obj_transportBox) && !place_meeting(x, y - 1, obj_destructibles))
	{
		if (scr_slope_ext(x + xscale, y))
		{
			vsp = 0;
			xscale *= -1;
			image_index = 0;
			sprite_index = spr_climbCeilingJump;
			verticalMovespeed = max(verticalMovespeed, 6);
			movespeed = verticalMovespeed;
			if (verticalMovespeed < 12)
				state = States.mach2;
			else if (verticalMovespeed >= 12)
				state = States.mach3;
		}
		else
		{
			sprite_index = spr_player_PZ_wallclimb_crash;
			event_play_oneshot("event:/SFX/player/groundpound", x, y);
			image_index = 0;
			state = States.ceilingCrash;
			camera_shake_add(10, 30);
			with obj_parent_enemy
			{
				if (bbox_in_camera(id, view_camera[0]) && grounded)
				{
					vsp = -7;
					hsp = 0;
				}
			}
		}
	}
	if (inputBufferJump > 0)
	{
		inputBufferJump = 0;
		image_index = 0;
		if (global.playerCharacter == Characters.Pizzelle)
		{
			jumpStop = false;
			xscale *= -1;
			state = States.wallkick;
			fmod_studio_event_instance_start(sndWallkickStart);
			vsp = -14;
			sprite_index = spr_wallJumpIntro;
			movespeed = 4 * xscale;
			hsp = movespeed;
			dir = xscale;
			repeat 5
			{
				instance_create(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), obj_secretpoof, 
				{
					sprite_index: spr_spinningFireParticle
				});
			}
			with (instance_create(x, y, obj_jumpdust, 
			{
				playerID: id
			}))
			{
				image_xscale = other.xscale;
				sprite_index = spr_wallkick_effect;
			}
			fmod_studio_event_instance_start(sndJump);
		}
		else
		{
			sprite_index = spr_wallJumpCancelIntro;
			vsp = -9;
			jumpStop = false;
			xscale *= -1;
			state = States.mach2;
			if (verticalMovespeed >= 12 && !place_meeting(x + xscale, y, obj_molassesWall))
			{
				if (movespeed > 13)
					movespeed = 13;
				sprite_index = spr_machdashpad;
				state = States.mach3;
			}
			else if (place_meeting(x + xscale, y, obj_molassesWall))
			{
				movespeed = clamp(movespeed, 6, 10);
				create_debris(x + (xscale * 16), y + 46, spr_molassesgoop);
				event_play_oneshot("event:/SFX/player/goopjump", x, y);
			}
			instance_create(x, y, obj_jumpdust);
			fmod_studio_event_instance_start(sndJump);
		}
	}
	
	image_speed = 0.6;
	if !instance_exists(obj_puffEffect)
		instance_create(x, y + 43, obj_puffEffect);
	if !instance_exists(superJumpEffect) && verticalMovespeed >= 12
	{
		superJumpEffect = instance_create(x, y - 35, obj_superJumpEffect, 
		{
			playerID: id
		});
	}
}
