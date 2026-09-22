canCollide = function(stpl, _player = obj_parent_player)
{
	switch (_player.object_index)
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			var _state = global.freezeframe ? _player.frozenState : _player.state;
			return _state == PlayerState.mach3 || (_state == PlayerState.run && _player.movespeed >= 12) || _state == PlayerState.frostburnslide || (_state == PlayerState.frostburnjump && _player.movespeed > 5) || _state == PlayerState.puddle || (_state == PlayerState.machroll && _player.mach3Roll > 0) || _state == PlayerState.minecart || (_state == PlayerState.bottlerocket && _player.substate == 0);
			break;
		default:
			return true;
			break;
	}
};

hsp = 0;
