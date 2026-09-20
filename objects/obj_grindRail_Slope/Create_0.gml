depth = 4;
canCollide = function(arg0, arg1 = obj_parent_player)
{
	switch (arg1.object_index)
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			var _state = global.freezeframe ? arg1.frozenState : arg1.state;
			return _state != PlayerState.noclip && _state != PlayerState.cotton && _state != PlayerState.cottondrill && _state != PlayerState.cottonroll && _state != PlayerState.tumble && _state != PlayerState.taunt && _state != PlayerState.bump && _state != PlayerState.actor && _state != PlayerState.frozen;
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
