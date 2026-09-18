function scr_enemy_slugparry()
{
	if (substate == 1)
	{
		hsp = movespeed * image_xscale;
		
		if (movespeed < 0 && grounded)
			movespeed += 0.2;
		
		if (movespeed > 0)
			movespeed = 0;
		
		image_speed = 0.35;
	}
}
