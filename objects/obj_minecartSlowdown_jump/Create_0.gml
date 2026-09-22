canCollide = function(stpl, _player = obj_parent_player)
{
	switch (_player.object_index)
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			return _player.state != PlayerState.minecart && _player.state != PlayerState.minecart_bump && _player.state != PlayerState.minecart_launched;
			break;
		default:
			return true;
			break;
	}
};

image_speed = 0.05;
