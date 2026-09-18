scr_collision();

if (grounded || place_meeting_collision(x, y))
	instance_destroy();
