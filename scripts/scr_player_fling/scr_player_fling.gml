function state_player_fling()
{
	image_speed = 0.35;
	hsp = 0;
	vsp = 0;
	global.ComboFreeze = 15;
	
	if (sprite_index == spr_player_PZ_flinged_start && sprite_animation_end())
		sprite_index = spr_player_PZ_flinged;
}

function state_player_fling_launch()
{
	image_speed = 0.35;
	hsp = approach(hsp, 15 * sign(hsp), 0.2);
	flingDashTimer--;
	
	if (sprite_index == spr_player_PZ_flinged_up_start && sprite_animation_end())
		sprite_index = spr_player_PZ_flinged_up;
	if (sprite_index == spr_player_PZ_flinged_tilt_start && sprite_animation_end())
		sprite_index = spr_player_PZ_flinged_tilt;
	
	if (flingDashTimer <= 0)
	{
		grav = 0.5;
		if (!grounded && vsp >= 0)
		{
			if (sprite_index == spr_player_PZ_flinged_straightup)
			{
				repeat 4
				{
					with instance_create(x, y, obj_poofeffectsmall)
					{
						depth -= 5;
						sprite_index = choose(spr_flingparticle, spr_flingparticle2);
						hspeed = random_range(-8, 8);
						vspeed = random_range(-8, 8);
					}
				}
				sprite_index = spr_player_PZ_geyser;
				state = States.jump;
				jumpStop = true;
			}
			else if (sprite_index != spr_player_PZ_flinged_tilt_start && sprite_index != spr_player_PZ_flinged_tilt)
			{
				image_index = 0;
				sprite_index = spr_player_PZ_flinged_tilt_start;
			}
		}
	}
	else
		grav = 0;
	if (grounded && !place_meeting(x, y + 1, obj_destructibles))
	{
		repeat 4
		{
			with instance_create(x, y, obj_poofeffectsmall)
			{
				depth -= 5;
				sprite_index = choose(spr_flingparticle, spr_flingparticle2);
				hspeed = random_range(-8, 8);
				vspeed = random_range(-8, 8);
			}
		}
		if (abs(hsp) <= 5)
		{
			state = States.freefall;
			movespeed = 0;
			vsp = 12;
			freeFallSmash = 20;
			sprite_index = spr_player_PZ_fall_outOfControl;
		}
		else
		{
			if (abs(hsp) <= 0 && slopeCheck(x, y))
				xscale = -slopeMomentum_direction();
			state = States.machroll;
			sprite_index = spr_crouchslip;
			movespeed = min(abs(hsp), 12);
			hsp = movespeed * xscale;
			with instance_create(x, y, obj_jumpdust)
				image_xscale = other.xscale;
		}
	}
	
	if (scr_solid(x, y - 1) && vsp < 0 && !place_meeting(x + hsp, y + vsp, obj_transportBox) && !place_meeting(x + hsp, y + vsp, obj_metalblock) && !place_meeting(x + hsp, y + vsp, obj_destructibles) && sprite_index != spr_superjumpCancelIntro)
	{
		repeat 4
		{
			with instance_create(x, y, obj_poofeffectsmall)
			{
				depth -= 5;
				sprite_index = choose(spr_flingparticle, spr_flingparticle2);
				hspeed = random_range(-8, 8);
				vspeed = random_range(-8, 8);
			}
		}
		sprite_index = spr_player_PZ_fall;
		state = States.jump;
		vsp = -12;
		verticalMovespeed = vsp;
		freeFallSmash = 0;
		grabClimbBuffer = 0;
		inputBufferJump = 0;
	}
	
	if (bump_wall(xscale) && !place_meeting(x + xscale, y, obj_destructibles)
	&& !place_meeting(x + xscale, y, obj_metalblock))
	{
		var _check = (vsp <= 0) ? 40 : 32;
		var _ledge = snap_to_ledge(xscale, _check);
		if !_ledge
		{
			if (!grounded || slopeCheck(x, y))
			{
				verticalMovespeed = movespeed;
				if (vsp > 0 && place_meeting(x + xscale, y, obj_icyWall))
					verticalMovespeed -= vsp;
				grabClimbBuffer = 0;
				inputBufferJump = 0;
				state = States.climbwall;
			}
			else
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
	if (state != States.fling_launch)
		grav = 0.5;
}
