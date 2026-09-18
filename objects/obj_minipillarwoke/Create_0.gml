event_inherited();

canCollide = function(arg0, arg1 = obj_parent_player)
{
	var in_object = false;
	
	with (arg1)
		in_object = place_meeting(xprevious, yprevious, arg0);
	
	return arg0.isWoke == !global.panic && !in_object;
};

image_speed = 0.35;
depth = 3;
