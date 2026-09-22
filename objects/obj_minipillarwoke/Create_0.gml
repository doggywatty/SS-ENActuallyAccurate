event_inherited();

canCollide = function(_obj, _player = obj_parent_player)
{
	var in_object = false;
	
	with (_player)
		in_object = place_meeting(xprevious, yprevious, _obj);
	
	return _obj.isWoke == !global.panic && !in_object;
};

image_speed = 0.35;
depth = 3;
