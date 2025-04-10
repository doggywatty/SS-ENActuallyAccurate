function state_player_run()
{
	move = key_left + key_right;
	hsp = xscale * movespeed;
	scr_conveyorBeltKinematics();
	
	if (hsp != 0 && grounded && vsp > 0)
	{
		stepBuffer--;
		if (stepBuffer <= 0 && grounded && vsp > 0)
		{
			stepBuffer = 16;
			instance_create(x, y + 43, obj_puffEffect);
			event_play_oneshot("event:/SFX/player/step", x, y + 46);
		}
	}
	
	if (!(sprite_animation_end() && sprite_index == spr_mach1))
		sprite_index = (movespeed < 12) ? spr_mach2 : spr_mach3player;
	
	if (move != 0 && key_attack)
	{
		if (move == xscale)
			movespeed = approach(movespeed, 12, 0.35);
		else if (movespeed > 2)
		{
			xscale = move;
			state = States.machslide;
			sprite_index = spr_runskid;
		}
		else
		{
			xscale = move;
			movespeed = 0;
		}
	}
	else
	{
		movespeed = approach(movespeed, 0, 0.5);
		if (grounded && movespeed <= 7)
			state = States.normal;
	}
	
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
		grav = 0.3;
	}
	
	if (movespeed >= 12)
	{
		if !instance_exists(obj_chargeEffect)
		{
			instance_create(x, y, obj_chargeEffect, 
			{
				playerID: id
			});
		}
		
		if (scr_solid(x + xscale, y, true) && !place_meeting(x + xscale, y, obj_destructibles) && !place_meeting(x + xscale, y, obj_metalblock))
		{
			var _ledge = snap_to_ledge();
			if !_ledge
			{
				event_play_oneshot("event:/SFX/player/groundpound", x, y);
				camera_shake_add(20, 40);
				image_speed = 0.35;
				with obj_parent_enemy
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
				hsp = -2.5 * xscale;
				vsp = -3;
				machTwo = 0;
				image_index = 0;
				instance_create(x + (10 * xscale), y + 10, obj_bumpEffect);
			}
		}
	}
	else if (scr_solid(x + xscale, y, true) && !place_meeting(x + xscale, y, obj_destructibles))
	{
		movespeed = 0;
		state = States.normal;
	}
	
	if (movespeed > 4)
		image_speed = movespeed / 12;
	else
		image_speed = 0.35;
	
	if (!instance_exists(dashCloudID) && grounded)
	{
		dashCloudID = instance_create(x, y, obj_dashCloud, 
		{
			image_xscale: xscale,
			sprite_index: (movespeed >= 8) ? spr_dashcloud2 : spr_dashCloud
		});
	}
	
	do_grab();
	do_taunt();
}
