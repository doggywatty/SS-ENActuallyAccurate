canCollide = function(stpl, _player = obj_parent_player)
{
	switch (_player.object_index)
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			var _state = global.freezeframe ? _player.frozenState : _player.state;
			return (_state == PlayerState.cotton && _player.state != PlayerState.cottondrill) || _state == PlayerState.cottonroll;
			break;
		default:
			return true;
			break;
	}
};
