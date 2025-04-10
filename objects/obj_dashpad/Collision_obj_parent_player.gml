if (other.state == States.mach3)
{
	with other
	{
		movespeed += 0.25;
		movespeed = clamp(movespeed, 12, 24);
	}
}

if (other.dashpadBuffer <= 0)
{
	with other
	{
		if (state != States.Sjumpprep && state != States.minecart && state != States.crouch
		&& state != States.doughmountspin && state != States.doughmount
		&& sprite_get_bbox_bottom(mask_index) <= other.bbox_bottom)
		{
			movespeed += 0.25;
			movespeed = clamp(movespeed, 12, 24);
			event_play_multiple("event:/SFX/general/dashpad", x, y);
			fmod_studio_event_instance_start(sndMachStart);
			
			if (global.playerCharacter == Characters.Pizzelle)
			{
				dashpadBuffer = 25;
				state = States.mach3;
				
				if (sprite_index != spr_machdashpad)
				{
					sprite_index = spr_machdashpad;
					image_index = 0;
				}
				
				xscale = sign(other.image_xscale);
				
				var try_y = 0;
				while (try_y <= 16)
				{
					if (scr_solid(x, other.y - try_y))
						try_y++;
					else
					{
						y = other.y - try_y;
						break;
					}
				}
				
				if (state != States.climbwall && !scr_solid(other.x, y))
					x = other.x;
				
				vsp = 3;
				flash = true;
			}
		}
		else if (state == States.minecart && sprite_get_bbox_bottom(mask_index) <= other.bbox_bottom)
		{
			xscale = sign(other.image_xscale);
			movespeed += 4;
			movespeed = clamp(movespeed, 14, 24);
			
			if !scr_solid(other.x, y)
				x = other.x;
			
			flash = true;
			dashpadBuffer = 50;
			image_index = 0;
			sprite_index = spr_player_PZ_minecart_fast_land;
		}
		else if !scr_isMainCharacter()
		{
			xscale = sign(other.image_xscale);
			movespeed = max(14, movespeed);
			dashpadBuffer = 50;
			state = States.run;
		}
	}
}
