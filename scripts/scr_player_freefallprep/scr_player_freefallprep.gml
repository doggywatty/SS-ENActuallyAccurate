function state_player_freefallprep()
{
	static freefall_buffer = 0;
	static afterimage_timer = 2;
	
	move = key_left + key_right;
	
	if (!grounded)
	{
		hsp = move * movespeed;
		
		if (move != xscale && momentum)
			movespeed = approach(0, movespeed, 0.05);
		
		if (movespeed <= 0)
			momentum = false;
		
		if ((move == 0 && !momentum) || place_meeting_collision(x + hsp, y))
			movespeed = 0;
		
		if (move != 0 && movespeed < 7)
			movespeed += 0.25;
		
		if (movespeed > 7)
			movespeed -= 0.05;
		
		if (place_meeting_collision(x + move, y) && move != 0)
			movespeed = 0;
		
		if (dir != xscale)
		{
			dir = xscale;
			movespeed = 0;
		}
		
		if (move == -xscale)
		{
			movespeed = 0;
			momentum = false;
		}
		
		if (move != 0)
			xscale = move;
		
		vsp = min(vsp, 0);
	}
	
	if (sprite_animation_end())
		image_index = image_number - 1;
	
	image_speed = 0.35;
	
	if (++freefall_buffer > 15)
	{
		freefall_buffer = 0;
		verticalMovespeed = vsp;
		state = PlayerState.freefall;
		freeFallSmash = -14;
		create_particle(x, y, spr_groundPoundClouds);
	}
	
	afterimage_timer = max(afterimage_timer - 1, 0);
	
	if (afterimage_timer <= 0)
	{
		with (create_afterimage(afterimagetypes.plain, xscale, 0))
		{
			gonealpha = 0.8;
			alarm[0] = 1;
			alarm[1] = 60;
		}
		
		afterimage_timer = 2;
	}
}
