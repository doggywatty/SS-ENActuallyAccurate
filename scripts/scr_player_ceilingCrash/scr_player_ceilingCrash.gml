function state_player_ceilingCrash()
{
	machTwo = 0;
	jumpAnim = true;
	landAnim = false;
	machSlideAnim = true;
	crouchAnim = false;
	movespeed = 0;
	alarm[4] = 14;
	vsp = 0;
	hsp = 0;
	
	if (sprite_animation_end())
	{
		sprite_index = spr_player_PZ_geyser;
		state = PlayerState.jump;
		jumpAnim = false;
	}
}
