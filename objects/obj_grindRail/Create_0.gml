depth = 4;
canCollide = function(arg0, arg1 = obj_parent_player)
{
	switch (arg1.object_index)
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			var _state = global.freezeframe ? arg1.frozenState : arg1.state;
			return _state != states.noclip && _state != states.bossintro && _state != states.keyget && _state != states.tackle && _state != states.runonball && _state != states.gottreasure && _state != states.throwing && _state != states.mach3 && _state != states.frozen;
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
