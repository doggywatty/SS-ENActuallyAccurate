event_inherited();
canCollide = function(stpl, player = obj_parent_player)
{
	var in_object = false;
	with player
		in_object = place_meeting(xprevious, yprevious, stpl);
	return stpl.isWoke == !global.panic && !in_object;
};
image_speed = 0.35;
depth = 3;
