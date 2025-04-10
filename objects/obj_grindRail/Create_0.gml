depth = 4;

canCollide = function(player = obj_parent_player)
{
	switch player
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			var _state = global.freezeframe ? player.frozenState : player.state;
			return _state != States.noclip && _state != States.cotton && _state != States.cottondrill
			&& _state != States.cottonroll && _state != States.tumble && _state != States.taunt
			&& _state != States.bump && _state != States.actor && _state != States.frozen;
			break;
		case obj_creamThief:
		case obj_bigcherry:
		case obj_gigacherrydead:
		case obj_cherryBombCart:
			return true;
			break;
		default:
			return false;
			break;
	}
};
