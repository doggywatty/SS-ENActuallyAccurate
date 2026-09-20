if (collide == 1)
{
	instance_destroy(id, false);
	
	with (obj_parent_player)
	{
		if (state != PlayerState.bottlerocket)
		{
			state = PlayerState.bottlerocket;
			xscale = other.image_xscale;
			x = other.x;
			y = other.y;
			image_index = 0;
			sprite_index = spr_player_PZ_bottleRocket_normal;
		}
	}
}
