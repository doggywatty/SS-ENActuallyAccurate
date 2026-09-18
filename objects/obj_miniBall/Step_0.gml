hsp = -image_xscale * movespeed;

if (grounded)
{
	if (vsp > 1)
	{
		event_play_oneshot("event:/SFX/general/paperballhit");
		vsp /= -2;
	}
	
	tossCooldown = 0;
	movespeed = approach(movespeed, 0, 0.5);
}

if ((place_meeting(x - image_xscale, y, obj_hallway) || place_meeting_collision(x - image_xscale, y)) && !grounded)
{
	vsp = random_range(-5, -8);
	image_xscale *= -1;
	movespeed *= 0.6;
}

if (!grounded)
	angle += (movespeed * image_xscale);

tossCooldown = max(tossCooldown - 1, 0);
