image_speed = 0.5;
depth = -30;

updateEffectPosition = function()
{
	x = playerID.x;
	y = playerID.y - 20;
	
	if (playerID.sprite_index == playerID.spr_superspring)
		y = playerID.y + 7;
	
	image_xscale = playerID.image_xscale;
	
	if (playerID.state == PlayerState.climbwall)
		sprite_index = spr_wallChargeEffect;
	else
		sprite_index = spr_superJumpEffect;
};

updateEffectPosition();
