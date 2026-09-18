if (get_panic())
{
	xstart -= movespeed;
	ystart -= movespeed;
	movespeed = approach(movespeed, 8, 0.4);
	sprite_index = spr_steamycottontownblimp_escape;
}

x = xstart + (camera_get_view_x(view_camera[0]) * 0.05) + wave(-2, 2, 10, 0);
y = ystart + (camera_get_view_y(view_camera[0]) * 0.05) + wave(-5, 5, 5, 0);
