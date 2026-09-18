function state_player_tackle()
{
	combo = 0;
	movespeed = 0;
	machTwo = 0;
	
	if (grounded && vsp > 0)
		hsp = 0;
	
	jumpAnim = true;
	landAnim = false;
	crouchAnim = true;
	
	if (sprite_animation_end())
	{
		if (key_attack && grounded)
		{
			machTwo = 0;
			movespeed = max(movespeed, 6);
			sprite_index = spr_mach1;
			image_index = 0;
			jumpAnim = true;
			state = states.pistol;
		}
		else
		{
			state = states.normal;
		}
	}
	
	image_speed = 0.5;
}
