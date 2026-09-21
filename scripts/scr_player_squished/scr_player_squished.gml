function state_player_squished()
{
	hsp = 0;
	move = 0;
	movespeed = 0;
	
	if (sprite_animation_end() && sprite_index == spr_player_PZ_squished)
	{
		if (grounded)
		{
			image_speed = 0.35;
			state = PlayerState.normal;
		}
		else
		{
			image_speed = 0;
		}
	}
}
