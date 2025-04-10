function state_player_mach3()
{
	windingAnim = min(windingAnim + 1, 2000);
	machTwo = 100;
	hsp = xscale * movespeed;
	scr_conveyorBeltKinematics();
	move = key_right + key_left;
	move2 = key_right2 + key_left2;
	momentum = true;
	
	if (!key_jump2 && !jumpStop && vsp < 0.5)
	{
		vsp /= 20;
		jumpStop = true;
	}
	
	if (grounded && vsp > 0)
		jumpStop = false;
	
	if (inputBufferJump > 0 && can_jump && move != -xscale)
	{
		image_index = 0;
		sprite_index = spr_mach3jump;
		inputBufferJump = 0;
		fmod_studio_event_instance_start(sndJump);
		vsp = -11;
		instance_create(x, y, obj_jumpdust, 
		{
			playerID: id
		});
	}
	
	if (grounded)
	{
		if (slopeCheck(x, y) && hsp != 0 && movespeed > 12 && movespeed < 18)
			player_slopeMomentum(0.2, 0);
	}
	
	var maxspd = 20;
	if (move == xscale && grounded)
	{
		if (movespeed < maxspd)
			movespeed += (machFourMode ? 0.1 : 0.025);
	}
	
	if (sprite_index == spr_mach3jump && floor(image_index) == (image_number - 1))
		sprite_index = spr_mach3player;
	
	if (sprite_index == spr_wallJumpCancelIntro && sprite_animation_end())
		sprite_index = spr_wallJumpCancel;
	
	if (sprite_index == spr_superjumpCancel && grounded)
		sprite_index = spr_mach3player;
	
	if (sprite_animation_end() && (sprite_index == spr_rollgetup || sprite_index == spr_mach3hit || sprite_index == spr_machdashpad))
		sprite_index = spr_mach3player;
	
	if (grounded && (sprite_index == spr_dive || sprite_index == spr_wallJumpCancelIntro || sprite_index == spr_wallJumpCancel))
		sprite_index = spr_rollgetup;
	
	if (!grounded && !key_down && sprite_index == spr_dive)
	{
		vsp = 15;
		sprite_index = spr_mach3player;
	}
	
	if (movespeed > 16 && sprite_index != spr_crazyrun && sprite_index != spr_dive)
	{
		machFourMode = true;
		flash = true;
		sprite_index = spr_crazyrun;
		
		with (create_debris(x, y, spr_slapstar))
		{
			hsp = random_range(-5, 5);
			vsp = random_range(-10, 10);
		}
	}
	else if (movespeed <= 16 && sprite_index == spr_crazyrun)
		sprite_index = spr_mach3player;
	
	if grounded
		sJumpCanDoubleJump = true;
	
	if (scr_checksuperjump() && sprite_index != spr_machdashpad && sprite_index != spr_dive && can_jump)
	{
		sprite_index = spr_superjumpPrep;
		state = States.Sjumpprep;
		hsp = 0;
		instance_create(x, y, obj_jumpdust, 
		{
			playerID: id
		});
		vsp = min(vsp + 5, terminalVelocity);
		image_index = 0;
	}
	
	if (grounded && vsp >= 0 && dashpadBuffer <= 0)
	{
		if (!key_attack && sprite_index != spr_machdashpad)
		{
			event_play_oneshot("event:/SFX/player/break", x, y);
			sprite_index = spr_machslidestart;
			image_index = 0;
			state = States.machslide;
		}
		
		if (move == -xscale)
		{
			event_play_oneshot("event:/SFX/player/machslideboost", x, y);
			sprite_index = spr_machslideboost3;
			flash = false;
			state = States.machslide;
			image_index = 0;
			machTwo = 100;
		}
	}
	
	if (key_down && !key_slap2 && !place_meeting(x, y, obj_dashpad))
	{
		mach3Roll = mach3RollMax;
		flash = false;
		state = States.machroll;
		instance_create(x, y, obj_jumpdust, 
		{
			playerID: id
		});
		image_index = 0;
		sprite_index = spr_machroll3intro;
		
		if (!grounded)
		{
			sprite_index = spr_dive;
			fmod_studio_event_instance_start(sndDive);
		}
		
		vsp = 10;
	}
	
	if ((!grounded || slopeCheck(x + xscale, y)) && scr_solid(x + xscale, y, true) && !place_meeting(x + xscale, y, obj_destructibles) && !place_meeting(x + xscale, y, obj_metalblock))
	{
		verticalMovespeed = movespeed;
		
		if (vsp > 0 && place_meeting(x + xscale, y, obj_icyWall))
			verticalMovespeed -= vsp;
		
		grabClimbBuffer = 0;
		inputBufferJump = 0;
		state = States.climbwall;
	}
	else if (scr_solid(x + xscale, y, true) && !place_meeting(x + xscale, y, obj_destructibles) && !place_meeting(x + xscale, y, obj_metalblock))
	{
		var _ledge = snap_to_ledge();
		if !_ledge
		{
			event_play_oneshot("event:/SFX/player/groundpound", x, y);
			camera_shake_add(20, 40);
			image_speed = 0.35;
			
			with (obj_parent_enemy)
			{
				if (bbox_in_camera(id, view_camera[0]) && grounded)
				{
					stun = 1;
					alarm[0] = 200;
					ministun = 0;
					vsp = -5;
					hsp = 0;
				}
			}
			
			flash = false;
			combo = 0;
			sprite_index = spr_mach3hitwall;
			state = States.bump;
			hsp = -6 * xscale;
			vsp = -6;
			machTwo = 0;
			image_index = 0;
			instance_create(x + (10 * xscale), y + 10, obj_bumpEffect);
		}
	}
	
	if (sprite_index == spr_crazyrun && !instance_exists(obj_crazyRunHoopEffect))
	{
		instance_create(x, y, obj_crazyRunHoopEffect, 
		{
			playerID: id
		});
	}
	
	if (!instance_exists(obj_crazyRunEffect))
	{
		instance_create(x, y, obj_crazyRunEffect, 
		{
			playerID: id
		});
	}
	
	if (!instance_exists(obj_chargeEffect) && sprite_index != spr_dive)
	{
		instance_create(x, y, obj_chargeEffect, 
		{
			playerID: id
		});
	}
	
	if (!instance_exists(obj_superdashcloud) && grounded)
	{
		instance_create(x, y, obj_superdashcloud, 
		{
			playerID: id
		});
	}
	
	image_speed = 0.4;
	
	if (sprite_index == spr_crazyrun)
		image_speed = 0.7;
	else if (sprite_index == spr_machdashpad)
		image_speed = 0.3;
	else if (sprite_index == spr_wallJumpCancel || sprite_index == spr_wallJumpCancelIntro)
		image_speed = 0.35;
	
	if (sprite_index != spr_dive)
	{
		do_grab(States.mach3);
		do_taunt(States.mach3);
	}
}
