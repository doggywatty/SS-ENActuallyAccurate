function state_player_golf()
{
	move = key_left + key_right;
	
	if (move != 0)
		move = xscale;
	
	hsp = 0;
	vsp = 0;
	
	if (sprite_index != spr_haulingIdle)
		sprite_index = spr_swingDing;
	else if (sprite_animation_end())
		state = states.normal;
	
	if (key_slap2)
	{
		image_index = 0;
		sprite_index = spr_swingDingEnd;
		instance_create(x, y, obj_slaphitbox);
	}
}
