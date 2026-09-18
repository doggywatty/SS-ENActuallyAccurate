canCollide = function(arg0, arg1 = obj_parent_player)
{
	switch (arg1.object_index)
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			return arg1.state != states.victory && arg1.state != states.Sjump && arg1.state != states.comingoutdoor;
			break;
		default:
			return true;
			break;
	}
};

image_speed = 0.05;
