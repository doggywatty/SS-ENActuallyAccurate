function state_player_swingclub()
{
	hsp = xscale * movespeed;
	dir = xscale;
	
	if (grounded && movespeed > 0)
		movespeed -= 0.2;
	
	if (scr_solid(x + hsp, y))
		movespeed = 0;
	
	landAnim = false;
	momentum = true;
	
	if (floor(image_index) == (image_number - 1))
		state = PlayerState.normal;
	
	image_speed = 0.4;
	
	if (!instance_exists(obj_slidecloud) && grounded && movespeed > 4)
		instance_create(x, y, obj_slidecloud);
}
