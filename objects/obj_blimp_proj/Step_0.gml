hsp = movespeed * image_xscale;

if (place_meeting_collision(x + image_xscale, y))
	image_xscale *= -1;

if (grounded)
{
	vsp = -4;
	
	if (!once)
	{
		once = true;
		
		if (bounced)
			instance_destroy();
		else
			bounced = true;
	}
}
else
{
	once = false;
}
