x += (image_xscale * movespeed);

if (place_meeting_collision(x + hsp, y) || place_meeting(x, y, obj_destructibles) || place_meeting(x, y, obj_metalblock))
	instance_destroy();
