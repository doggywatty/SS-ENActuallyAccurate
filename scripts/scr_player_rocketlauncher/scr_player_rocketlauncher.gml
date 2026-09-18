function state_player_rocketlauncher()
{
	hsp = 0;
	movespeed = 0;
	sprite_index = spr_player_PZ_bazooka_shoot;
	
	if (sprite_animation_end())
		state = states.normal;
}
