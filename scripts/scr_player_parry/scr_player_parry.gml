function state_player_parry()
{
	hsp = -xscale * movespeed;
	
	if (movespeed > 0)
		movespeed = approach(movespeed, 0, 0.5);
	
	if (sprite_animation_end())
		state = states.normal;
	
	image_speed = 0.5;
}
