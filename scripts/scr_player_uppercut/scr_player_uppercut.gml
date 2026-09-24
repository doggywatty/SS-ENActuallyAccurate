function state_player_uppercut()
{
	static afterimage_timer = 2;
	static petal_timer = 2;
	
	image_speed = 0.35;
	
	if ((sprite_index == spr_uppercutbegin && sprite_animation_end()) || (grounded && vsp > 0))
	{
		sprite_index = spr_uppercutend;
		image_index = 0;
	}
	
	if (scr_solid(x + sign(hsp), y) && !scr_slope_ext(x + xscale, y) && move != 0)
		movespeed = 0;
	
	move = key_left + key_right;
	landAnim = true;
	jumpStop = false;
	hsp = movespeed;
	
	if (move != 0)
	{
		dir = move;
		movespeed = approach(movespeed, move * 4, 0.5);
	}
	else
	{
		movespeed = approach(movespeed, 0, 0.5);
	}
	
	if (grounded && vsp > 0)
	{
		event_play_oneshot("event:/SFX/player/step", x, y);
		landAnim = true;
		movespeed = abs(movespeed);
		movespeed = min(movespeed, 6);
		inputBufferSecondJump = 0;
		state = PlayerState.normal;
		jumpAnim = true;
		jumpStop = false;
		image_index = 0;
		freefallstart = 0;
		instance_create(x, y, obj_landcloud);
	}
	
	afterimage_timer = max(afterimage_timer - 1, 0);
	
	if (afterimage_timer <= 0)
	{
		with (create_afterimage(choose(AfterImageType.MACH3, AfterImageType.MACH3ALT), xscale, true))
			mach3Afterimage = true;
		
		afterimage_timer = 6;
	}
	
	if (!petal_timer-- && vsp <= 0)
	{
		with (create_debris(x + irandom_range(-45, 45), y + irandom_range(15, 45), choose(spr_flowerpetal1, spr_flowerpetal2, spr_flowerpetal3, spr_flowerpetal4)))
		{
			image_angle = 0;
			image_alpha = 5;
			image_speed = 0.35;
			fading = true;
			vsp = -2;
			hsp = 0;
			grav = 0.35;
			terminalVelocity = 1;
			stompAnim = true;
		}
		
		petal_timer = 4;
	}
}
