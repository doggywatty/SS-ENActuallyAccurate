image_speed = 0.5;
depth = -30;

updateEffectPosition = function()
{
	x = playerID.x;
	y = playerID.y;
	image_xscale = playerID.image_xscale;
	image_yscale = 1;
	
	if (playerID.sprite_index == spr_player_PZ_flicked)
	{
		image_xscale = -playerID.image_xscale;
		x -= (18 * playerID.xscale);
	}
	else if (playerID.state == PlayerState.minecart || playerID.sprite_index == spr_player_PZ_wallJumpCancel || playerID.sprite_index == spr_player_PZ_wallJumpCancel_intro)
	{
		x += (32 * playerID.xscale);
	}
	else if (playerID.state == PlayerState.machroll)
	{
		x += (40 * playerID.xscale);
		y += 20;
		image_yscale = 0.65;
	}
	else if (playerID.state == PlayerState.machroll)
	{
		x += (40 * playerID.xscale);
		y += 20;
		image_yscale = 0.65;
	}
	else
	{
		x += (16 * playerID.xscale);
	}
	
	image_angle = playerID.draw_angle;
};

updateEffectPosition();
