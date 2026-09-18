function state_player_Sjumpprep()
{
	combo = 0;
	machTwo = 0;
	move = key_left + key_right;
	
	if (sprite_index == spr_superjumpPrep)
	{
		hsp = xscale * movespeed;
		
		if (movespeed >= 0)
			movespeed -= 0.8;
	}
	
	scr_conveyorBeltKinematics();
	
	if (sprite_index == spr_superjumpPrep_flash || sprite_index == spr_superjumpPrep_right || sprite_index == spr_superjumpPrep_left)
		hsp = move * 2;
	
	if (sprite_index != spr_superjumpPrep)
	{
		if (sign(hsp) == 0)
		{
			sprite_index = spr_superjumpPrep_flash;
		}
		else if (sign(hsp) == 1)
		{
			if (xscale == 1)
				sprite_index = spr_superjumpPrep_right;
			else if (xscale == -1)
				sprite_index = spr_superjumpPrep_left;
		}
		else if (xscale == 1)
		{
			sprite_index = spr_superjumpPrep_left;
		}
		else if (xscale == -1)
		{
			sprite_index = spr_superjumpPrep_right;
		}
	}
	
	alarm[4] = 14;
	jumpAnim = true;
	landAnim = false;
	machSlideAnim = true;
	crouchAnim = true;
	
	if (floor(image_index) == (image_number - 1) && sprite_index == spr_superjumpPrep)
		sprite_index = spr_superjumpPrep_flash;
	
	if (!scr_checksuperjump() && grounded && (sprite_index == spr_superjumpPrep_flash || sprite_index == spr_superjumpPrep_left || sprite_index == spr_superjumpPrep_right) && !scr_solid(x, y - 16) && !scr_solid(x, y - 32))
	{
		instance_create(x, y, obj_mushroomCloudEffect);
		sprite_index = spr_superjump;
		state = states.highjump;
		vsp = -12;
		verticalMovespeed = vsp;
		sJumpCanDoubleJump = false;
	}
	
	image_speed = 0.35;
}
