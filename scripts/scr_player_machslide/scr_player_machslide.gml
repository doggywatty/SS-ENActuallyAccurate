function state_player_machslide()
{
	hsp = xscale * movespeed;
	scr_conveyorBeltKinematics();
	move = key_right + key_left;
	
	if (sprite_index == spr_machslidestart && sprite_animation_end())
		sprite_index = spr_machslide;
	
	if (sprite_animation_end() && !grounded)
	{
		switch (sprite_index)
		{
			case spr_machslideboost:
				sprite_index = spr_machslideboostFall;
				image_index = 0;
				break;
			case spr_machslideboost3:
				sprite_index = spr_machslideboost3Fall;
				image_index = 0;
				break;
		}
	}
	
	if (!instance_exists(dashCloudID) && grounded)
	{
		dashCloudID = instance_create(x, y, obj_dashCloud, 
		{
			image_xscale: xscale
		});
	}
	
	image_speed = 0.35;
	landAnim = false;
	
	if (sprite_index == spr_runskid)
	{
		hsp = xscale * -movespeed;
		movespeed = approach(movespeed, 0, 0.8);
		
		if (movespeed <= 0)
		{
			movespeed = 0;
			state = states.Nhookshot;
		}
		
		image_speed = 0.4;
		exit;
	}
	
	movespeed = approach(movespeed, 0, 0.4);
	
	if (sprite_index == spr_machslide || sprite_index == spr_player_PZ_crouchSlide)
	{
		if (floor(movespeed) <= 0)
		{
			image_index = 0;
			
			if (sprite_index == spr_machslide)
				machSlideAnim = true;
			
			movespeed = 0;
			state = states.normal;
		}
		
		if (scr_solid(x + xscale, y, true))
		{
			state = states.throwing;
			movespeed = 0;
			image_index = 0;
			sprite_index = spr_splat;
			event_play_oneshot("event:/SFX/player/splat", x, y);
		}
	}
	
	if (grounded && ((sprite_animation_end() && sprite_index == spr_machslideboost) || sprite_index == spr_machslideboostFallStart || sprite_index == spr_machslideboostFall))
	{
		hsp = 0;
		image_index = 0;
		xscale *= -1;
		movespeed = 8;
		state = states.pistol;
		sprite_index = spr_mach2;
		instance_create(x, y, obj_jumpdust);
	}
	
	if (grounded && ((sprite_animation_end() && sprite_index == spr_machslideboost3) || sprite_index == spr_machslideboost3FallStart || sprite_index == spr_machslideboost3Fall))
	{
		hsp = 0;
		sprite_index = spr_mach3player;
		image_index = 0;
		xscale *= -1;
		movespeed = 12;
		state = states.shotgun;
	}
}
