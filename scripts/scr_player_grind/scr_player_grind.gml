function state_player_grind()
{
	vsp = 0;
	sprite_index = spr_grindrail;
	image_speed = 0.35;
	hsp = xscale * movespeed;
	
	if (movespeed < 10)
		movespeed = approach(movespeed, 10, 0.5);
	
	if (!place_meeting(x, y + 18, obj_grindRail) && !place_meeting(x, y + 18, obj_grindRail_Slope))
	{
		if (movespeed < 12)
		{
			state = states.pistol;
			sprite_index = spr_mach2_spinJump;
		}
		else
		{
			state = states.shotgun;
			sprite_index = spr_mach3jump;
		}
	}
	
	if (place_meeting_collision(x + xscale, y, Exclude.SLOPES))
	{
		state = states.throwing;
		hsp = xscale * -5;
		vsp = 1;
		instance_create(x + (10 * xscale), y + 10, obj_bumpEffect);
		event_play_oneshot("event:/SFX/player/bumpwall", (x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2));
	}
	
	if (inputBufferJump > 0)
	{
		inputBufferJump = 0;
		vsp = -11;
		grav = 0.3;
		jumpStop = false;
		
		if (movespeed < 12)
		{
			state = states.pistol;
			sprite_index = spr_mach2_spinJump;
		}
		else
		{
			state = states.shotgun;
			sprite_index = spr_mach3jump;
		}
	}
	
	if (!instance_exists(obj_grindEffect))
	{
		instance_create(x, y, obj_grindEffect, 
		{
			playerID: id
		});
	}
}
