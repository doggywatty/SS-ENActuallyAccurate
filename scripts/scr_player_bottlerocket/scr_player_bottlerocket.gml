function state_player_bottlerocket()
{
	image_speed = 0.35;
	move = key_left + key_right;
	move2 = key_up - key_down;
	
	if (substate == 1)
	{
		movespeed = approach(movespeed, 0, 0.5);
		hsp = xscale * movespeed;
		
		if (!grounded)
			substate = 0;
		
		if (movespeed <= 0)
		{
			xscale *= -1;
			substate = 0;
			sprite_index = spr_player_PZ_bottleRocket_grounded;
			movespeed = 12;
		}
	}
	
	if (substate == 0)
	{
		if (sprite_index != spr_player_PZ_bottleRocket_intro)
		{
			hsp = xscale * movespeed;
			vsp = move2 * -5;
			
			if (grounded)
				sprite_index = spr_player_PZ_bottleRocket_grounded;
			else
				sprite_index = spr_player_PZ_bottleRocket_normal;
			
			if (move == xscale)
			{
				movespeed = approach(movespeed, 24, 0.1);
			}
			else if (move == -xscale)
			{
				if (grounded)
				{
					substate = 1;
					sprite_index = spr_player_PZ_bottleRocket_turn;
					image_index = 0;
				}
				else
				{
					movespeed = approach(movespeed, 8, 0.2);
				}
			}
			else
			{
				movespeed = approach(movespeed, 12, 0.2);
			}
			
			if (inputBufferJump > 0)
			{
				state = PlayerState.mach2;
				vsp = -15;
				image_index = 0;
				sprite_index = spr_mach2_spinJump;
				
				if (!instance_exists(obj_rocketdud))
					instance_create(x, y, obj_rocketdud);
				
				inputBufferJump = 0;
			}
		}
		else
		{
			movespeed = approach(movespeed, 8, 0.1);
			hsp = xscale * movespeed;
			vsp = 0;
			
			if (sprite_animation_end())
			{
				movespeed = 12;
				image_speed = 0.35;
				sprite_index = spr_player_PZ_bottleRocket_normal;
			}
		}
		
		if (scr_solid(x + xscale, y, true) && !place_meeting(x + sign(hsp), y, obj_destructibles) && !place_meeting(x + sign(hsp), y, obj_chocofrog))
		{
			instance_create(x, y, obj_bombExplosion);
			vsp = -6;
			movespeed /= 2;
			xscale *= -1;
			machTwo = 0;
			grounded = 0;
			sprite_index = spr_player_PZ_slipSlide_intro;
			state = PlayerState.puddle;
		}
	}
}
