function state_player_freefall()
{
	static cloudeffect = 8;
	static mach3effect = 5;
	static piledrivereffect = 15;
	static afterimage_timer = 2;
	if place_meeting(x, y, obj_vertical_hallway)
		exit;
	
	landAnim = true;
	var is_divebomb = sprite_index == spr_diveBombstart || sprite_index == spr_diveBombfall;
	if (vsp >= 2)
	{
		vsp += 0.5;
		if (verticalMovespeed > 17)
		{
			if !mach3effect--
			{
				with (create_afterimage(choose(AfterImageType.mach3effect1, AfterImageType.mach3effect2), xscale, true))
					basicAfterimage = false;
				mach3effect = 5;
			}
			if !cloudeffect--
			{
				create_particle(x, y, spr_cloudEffect, 25);
				cloudeffect = 8;
			}
			if !piledrivereffect--
			{
				instance_create(x, y, obj_piledrivereffect, 
				{
					playerID: id
				});
				piledrivereffect = 15;
			}
		}
	}
	
	if (vsp > 0)
		freeFallSmash++;
	else if (vsp < 0)
		freeFallSmash = -14;
	
	move = key_left + key_right;
	if !grounded
	{
		hsp = (sprite_index == spr_player_PZ_fall_outOfControl) ? 0 : (move * movespeed);
		if (move != xscale && momentum && movespeed != 0)
			movespeed -= 0.05;
		if (movespeed == 0)
			momentum = false;
		if (move != dir && move != 0)
		{
			dir = move;
			movespeed = 0;
		}
		if ((move == 0 && !momentum) || scr_solid(x + hsp, y))
			movespeed = 0;		
		if (move != 0 && movespeed < 7)
			movespeed += 0.25;
		if (movespeed > 7)
			movespeed -= 0.05;
		if (scr_solid(x + move, y) && move != 0)
			movespeed = 0;
		if (move != 0 && !is_divebomb)
			xscale = move;
	}
	if (sprite_index != spr_player_PZ_fall_outOfControl)
	{
	}
	if (sprite_index == spr_groundPoundstart && sprite_animation_end())
	{
		image_index = 0;
		sprite_index = spr_groundPoundfall;
	}
	if (sprite_index == spr_diveBombstart && sprite_animation_end())
	{
		image_index = 0;
		sprite_index = spr_diveBombfall;
	}
	if (grounded && (freeFallSmash < 10 || !place_meeting(x, y + vsp, obj_metalblock)) && !place_meeting(x, y + vsp, obj_destructibles))
	{
		if (slopeCheck(x, y) && !place_meeting(x, y, obj_dashpad))
		{
			state = States.machroll;
			sprite_index = spr_crouchslip;
			movespeed = (freeFallSmash > 20) ? 12 : 8;
			xscale = -slopeMomentum_direction();
			with instance_create(x, y, obj_jumpdust)
				image_xscale = other.xscale;
		}
		else
		{
			event_play_oneshot("event:/SFX/player/groundpound", x, y);
			image_index = 0;
			state = States.freefallland;
			jumpAnim = true;
			jumpStop = false;
			with obj_parent_enemy
			{
				if (bbox_in_camera(id, view_camera[0]) && grounded)
				{
					vsp = -7;
					hsp = 0;
					movespeed = 0;
					if (other.freeFallSmash >= 10)
					{
						state = States.charge;
						vsp = -11;
						image_xscale *= -1;
						if (baddieStunTimer < 60)
							baddieStunTimer = 60;
					}
				}
			}
			
			camera_shake_add(10, 30);
			combo = 0;
			with instance_create(x, y, obj_landcloud)
				sprite_index = spr_groundpoundLandEffect;
			
			freefallstart = 0;
			image_index = 0;
			var landing_sprite_transitions = [
				[spr_groundPoundfall, spr_groundPoundland],
				[spr_groundPoundstart, spr_groundPoundland],
				[spr_player_PZ_fall_outOfControl, spr_player_PZ_freeFall_land], 
				[spr_diveBombfall, spr_diveBombland],
				[spr_diveBombstart, spr_diveBombland]
			];
			for (var i = 0; i < array_length(landing_sprite_transitions); i++)
			{
				if (sprite_index == landing_sprite_transitions[i][0])
					sprite_index = landing_sprite_transitions[i][1];
			}
		}
	}
	image_speed = 0.35;
	if (freeFallSmash >= 10)
	{
		if !instance_exists(groundpoundEffect)
		{
			groundpoundEffect = instance_create(x, y + 32, obj_groundPoundEffect, 
			{
				playerID: id
			});
		}
		if !instance_exists(obj_verticalHoopEffect)
		{
			instance_create(x, y, obj_verticalHoopEffect, 
			{
				playerID: id,
				image_angle: -90
			});
		}
	}
	
	afterimage_timer = max(afterimage_timer - 1, 0);
	if (afterimage_timer <= 0)
	{
		with (create_afterimage(AfterImageType.plain, xscale, 0))
		{
			gonealpha = 0.8;
			alarm[0] = 1;
			alarm[1] = 60;
		}
		afterimage_timer = 2;
	}
}
