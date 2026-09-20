function state_player_crouchjump()
{
	move = key_left + key_right;
	
	if (vsp > 5)
		fallingAnimation++;
	
	if (fallingAnimation >= 40 && fallingAnimation < 65)
	{
		sprite_index = spr_player_PZ_freeFall_1;
		state = PlayerState.jump;
	}
	
	mask_index = spr_crouchmask;
	hsp = move * movespeed;
	movespeed = 4;
	
	if (jumpAnim && !jumpStop)
	{
		if (!key_jump2)
		{
			vsp /= 20;
			jumpStop = true;
		}
		
		if (scr_solid(x, y - 1))
		{
			vsp = grav;
			jumpStop = true;
		}
	}
	
	if (grounded && vsp >= 0)
	{
		if (key_down)
		{
			state = PlayerState.crouch;
			jumpAnim = true;
			crouchAnim = true;
			image_index = 0;
			jumpStop = false;
		}
		else if (!scr_solid(x, y - 16))
		{
			movespeed = 0;
			state = PlayerState.normal;
			jumpAnim = true;
			landAnim = true;
			crouchAnim = true;
			image_index = 0;
			jumpStop = false;
			mask_index = spr_player_mask;
		}
		
		state = PlayerState.crouch;
		jumpAnim = true;
		crouchAnim = true;
		image_index = 0;
		jumpStop = false;
	}
	
	if (jumpAnim)
	{
		sprite_index = spr_crouchjump;
		
		if (floor(image_index) == (image_number - 1))
		{
			jumpAnim = false;
			sprite_index = spr_crouchfall;
		}
	}
	else
	{
		sprite_index = spr_crouchfall;
	}
	
	if (move != 0)
		xscale = move;
	
	image_speed = 0.35;
}
