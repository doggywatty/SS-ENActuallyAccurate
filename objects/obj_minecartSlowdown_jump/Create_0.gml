canCollide = function(arg0, arg1 = obj_parent_player)
{
	switch (arg1.object_index)
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			return arg1.state != PlayerState.minecart && arg1.state != PlayerState.minecart_bump && arg1.state != PlayerState.minecart_launched;
			break;
		default:
			return true;
			break;
	}
};

image_speed = 0.05;
