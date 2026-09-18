scr_collision();

if (state == 1)
	hsp = approach(hsp, xscale * 8, 0.3);
else
	hsp = 0;

if (place_meeting(x + hsp, y, obj_solid))
	instance_destroy();
