event_inherited();

canCollide = function(arg0, arg1 = obj_parent_player)
{
	var in_object = false;
	
	with (arg1)
		in_object = place_meeting(xprevious, yprevious, arg0);
	
	return !arg0.destroyed && !in_object;
};

dissolveBufferMax = 100;
dissolveBuffer = dissolveBufferMax;
image_speed = 0.35;
depth = 4;
destroyed = false;
mask_index = spr_caramel_idle;
sprite_index = spr_caramel_idle;
