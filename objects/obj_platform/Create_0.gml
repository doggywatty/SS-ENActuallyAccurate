canCollide = function(stpl, player = obj_parent_player)
{
	switch player.object_index
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			var _state = global.freezeframe ? player.frozenState : player.state;
			return _state != States.ladder;
			break;
		default:
			return true;
			break;
	}
};
