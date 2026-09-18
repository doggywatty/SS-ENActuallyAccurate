function state_player_timesup()
{
	hsp = 0;
	vsp = 0;
	xscale = 1;
	sprite_index = spr_Timesup;
	alarm[5] = -1;
	alarm[7] = -1;
	
	if (place_meeting(x, y, obj_timesup))
	{
		sprite_index = spr_player_PZ_fall_outOfControl;
		alarm[1] = 3;
		state = states.knightpep;
		vsp = irandom_range(-8, -5);
		hsp = irandom_range(-4, 4);
	}
	
	if (room == timesuproom)
	{
		obj_parent_player.x = 480;
		obj_parent_player.y = 270;
	}
	
	image_speed = (floor(image_index) >= 15 || room != timesuproom) ? 0 : 0.35;
}
