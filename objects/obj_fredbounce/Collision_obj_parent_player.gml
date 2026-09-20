with (other)
{
	if ((state == PlayerState.minecart || state == PlayerState.minecart_bump || (state == PlayerState.minecart_launched && vsp > 0)) && !other.holdingPlayer && !global.freezeframe)
	{
		var _x = x;
		var _y = y;
		x = other.x;
		
		if (!other.cutscene)
			other.fred_y = y - 30;
		
		image_index = 0;
		movespeed = 0;
		
		with (obj_camera)
		{
			cameraXOffset = _x - other.x;
			cameraYOffset = _y - other.y;
		}
		
		other.holdingPlayer = true;
		sprite_index = spr_player_PZ_minecart_bounce;
		other.sprite_index = spr_fred_bouncehold;
		other.image_index = 0;
		other.vsp = 20;
		other.cutscene = 1;
	}
}
