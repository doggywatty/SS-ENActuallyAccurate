function state_player_handstand()
{
	image_speed = 0.35;
	scr_getinput();
	
	if (dir != xscale)
	{
		dir = xscale;
		movespeed = 0;
	}
	
	if (!key_jump2 && !jumpStop && vsp < 0.5)
	{
		vsp /= 20;
		jumpStop = true;
	}
	
	if (grounded && vsp > 0)
		jumpStop = false;
	
	move = key_left + key_right;
	
	if (move != 0)
		xscale = move;
	
	hsp = (move * movespeed) + bounceSpeed;
	
	if (move != 0)
		bounceSpeed += (move * 0.05);
	else
		bounceSpeed = 0;
	
	if (sprite_index == spr_null && scr_solid(x, y + 1))
	{
		sprite_index = spr_null;
		movespeed = 0;
		vsp = 0;
		image_index = 0;
	}
	
	if (sprite_index == spr_null && floor(image_index) < 4 && grounded)
	{
		vsp = 0;
		movespeed = 0;
		hsp = 0;
	}
	
	if (sprite_index == spr_null && floor(image_index) == (image_number - 5))
	{
		movespeed = 10 + bounceSpeed;
		
		if (key_jump2 && !key_down)
		{
			vsp = -11;
			grav = 0.3;
		}
		else if (!key_jump2)
		{
			vsp = key_down ? -4 : -7;
		}
		
		bounced = true;
	}
	
	if (sprite_index == spr_null && floor(image_index) == (image_number - 1))
		sprite_index = spr_null;
	
	if (!key_attack)
		state = states.normal;
	
	if (inputBufferSlap > 0 && bounced)
	{
		sprite_index = spr_null;
		image_index = 0;
		hsp = 0;
		vsp = 0;
		movespeed = 0;
		bounceSpeed = 0;
		bounced = false;
		state = key_up ? states.highjump : states.shotgun;
	}
}
