depth = 4;

canCollide = function(player = obj_parent_player)
{
	switch player
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			var _state = global.freezeframe ? player.frozenState : player.state;
			return _state == States.minecart || _state == States.minecart_launched || _state == States.minecart_bump;
			break;
		case obj_minecart:
		case obj_creamThief:
		case obj_cherryBombCart:
			return true;
			break;
		default:
			return false;
			break;
	}
};
