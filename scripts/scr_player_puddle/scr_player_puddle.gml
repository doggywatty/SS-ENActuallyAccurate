function state_player_puddle()
{
	hsp = xscale * movespeed;
	if (scr_solid(x + xscale, y, true) && !place_meeting(x + xscale, y, obj_destructibles) && !place_meeting(x + xscale, y, obj_metalblock))
	{
		event_play_oneshot("event:/SFX/player/slipbump", x, y);
		create_particle(x, y, spr_bangEffect);
		xscale *= -1;
		if (sprite_index == spr_player_PZ_slipSlide)
			movespeed = approach(movespeed, 0, 3);
		sprite_index = spr_player_PZ_fall_outOfControl;
	}
	
	var _xscale = xscale;
	if (sprite_index == spr_player_PZ_slipSlide_intro || sprite_index == spr_player_PZ_fall_outOfControl)
	{
		if (grounded && vsp > -1 && !place_meeting(x + sign(hsp), y, obj_destructibles)
		&& !place_meeting(x, y + 1, obj_metalblock) && !place_meeting(x, y + 1, obj_destructibles))
		{
			if (sprite_index == spr_player_PZ_slipSlide_intro)
			{
				sprite_index = spr_player_PZ_fall_outOfControl;
				vsp = -6;
				movespeed = approach(movespeed, 0, 3);
				create_particle(x, y, spr_bangEffect);
				event_play_oneshot("event:/SFX/player/slipbump", x, y);
			}
			else
			{
				squashValueX = 1;
				image_index = 0;
				event_play_oneshot("event:/SFX/player/slipend", x, y);
				sprite_index = spr_player_PZ_slipSlide_end;
			}
			image_index = 0;
			image_speed = 0.35;
		}
	}
	else if (sprite_index == spr_player_PZ_slipSlide_end)
	{
		image_speed = 0.35;
		movespeed = approach(movespeed, 0, 0.5);
		player_slopeMomentum(0.75, 0);
		if sprite_animation_end()
			state = States.normal;
		if !grounded
		{
			event_play_oneshot("event:/SFX/player/slip", x, y);
			sprite_index = spr_player_PZ_fall_outOfControl;
		}
	}
	
	if (sprite_animation_end() && sprite_index == spr_player_PZ_slipSlide_intro)
		image_speed = 0;
	else if (sprite_index == spr_player_PZ_fall_outOfControl)
		image_speed = clamp(movespeed / 15, 0.3, 1) * 0.6;
	else
		image_speed = 0.35;
}
