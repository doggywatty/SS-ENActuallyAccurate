function state_player_fireass()
{
	static fire_afterimage_timer = 7;
	
	image_speed = 0.35;
	alarm[5] = 2;
	alarm[7] = 60;
	
	if (sprite_index == spr_player_PZ_fireAss_intro || sprite_index == spr_player_PZ_fireAss_fall)
	{
		move = key_left + key_right;
		hsp = movespeed;
		
		if (move != 0)
		{
			if (move == xscale)
				movespeed = approach(movespeed, xscale * 8, 0.5);
			else
				movespeed = approach(movespeed, 0, 0.5);
			
			if (movespeed <= 0)
				xscale = move;
		}
		else
		{
			movespeed = approach(movespeed, 0, 0.1);
		}
		
		if (place_meeting_solid(x + sign(hsp), y) && !place_meeting(x + sign(hsp), y, obj_chocofrog))
			movespeed = 0;
		
		if (grounded && vsp > 0 && !place_meeting(x, y + sign(vsp), obj_chocofrog))
		{
			movespeed = 6;
			sprite_index = spr_player_PZ_fireAss_ground;
			image_index = 0;
		}
		
		if (inputBufferSlap > 0)
		{
			inputBufferSlap = 0;
			sprite_index = spr_player_PZ_fireAss_dash;
			image_index = 0;
			state = PlayerState.fireassdash;
			
			if (move != 0)
				xscale = move;
			
			movespeed = 12;
			vsp = 0;
		}
		
		if (sprite_animation_end() && sprite_index == spr_player_PZ_fireAss_intro)
			sprite_index = spr_player_PZ_fireAss_fall;
	}
	
	if (sprite_index == spr_player_PZ_fireAss_ground)
	{
		scr_conveyorBeltKinematics();
		hsp = xscale * movespeed;
		
		if (movespeed > 0)
			movespeed -= 0.25;
		
		if (sprite_animation_end())
		{
			state = PlayerState.normal;
			hsp = 0;
			image_index = 0;
			hurted = 1;
			landAnim = 0;
		}
	}
	
	fire_afterimage_timer = max(fire_afterimage_timer - 1, 0);
	
	if (fire_afterimagetimer <= 0 && sprite_index != spr_player_PZ_fireAss_ground)
	{
		create_afterimage(afterimagetypes.fireass, xscale);
		fire_afterimagetimer = 7;
	}
}

function state_player_fireassdash()
{
	static fire_afterimagetimer = 7;
	
	hsp = movespeed * xscale;
	movespeed = approach(movespeed, 11, 0.15);
	
	if (floor(image_index) < 12)
		vsp = 0;
	
	sprite_index = spr_player_PZ_fireAss_dash;
	
	if (sprite_animation_end() || grounded)
	{
		image_index = 0;
		sprite_index = spr_fall;
		state = PlayerState.jump;
		
		if (key_attack)
		{
			sprite_index = spr_secondjump2;
			state = PlayerState.mach2;
		}
	}
	
	if (place_meeting_collision(x + xscale, y, Exclude.SLOPES) && !place_meeting(x + xscale, y, obj_destructibles) && !place_meeting(x + xscale, y, obj_chocofrog))
	{
		sprite_index = spr_player_PZ_fall_outOfControl;
		state = PlayerState.jump;
		vsp = -12;
		jumpStop = true;
		movespeed = 0;
	}
	
	if (fire_afterimagetimer > 0)
		fire_afterimagetimer--;
	
	if (fire_afterimagetimer <= 0)
	{
		create_afterimage(afterimagetypes.fireass, xscale);
		fire_afterimagetimer = 7;
	}
	
	image_speed = 0.4;
}
