function state_player_hang()
{
	vsp = 0;
	sprite_index = spr_hanging;
	image_speed = 0.35;
	hsp = xscale * movespeed;
	
	if (movespeed < 10)
		movespeed = approach(movespeed, 10, 0.5);
	
	if (place_meeting_collision(x + xscale, y, Exclude.SLOPES))
	{
		state = states.throwing;
		hsp = xscale * -5;
		vsp = 1;
		instance_create(x + (10 * xscale), y + 10, obj_bumpEffect);
		event_play_oneshot("event:/SFX/player/bumpwall", (x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2));
	}
	
	if (inputBufferJump > 0 || !place_meeting(x, y - 1, obj_hangRail))
	{
		vsp = 0;
		
		if (inputBufferJump > 0)
		{
			inputBufferJump = 0;
			vsp = 5;
		}
		
		jumpStop = false;
		image_index = 0;
		sprite_index = spr_climbCeilingJump;
		
		if (movespeed < 12)
			state = states.pistol;
		else
			state = states.shotgun;
	}
}
