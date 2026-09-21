if (state == PlayerState.normal)
{
	if ((other.jumpLeft && image_xscale < 0) || (other.jumpRight && image_xscale > 0))
	{
		vsp = -24;
		movespeed /= 2;
		image_index = 0;
		sprite_index = spr_creamthief_jump;
	}
}
