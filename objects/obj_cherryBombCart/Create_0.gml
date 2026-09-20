canCollide = function(arg0, arg1 = obj_parent_player)
{
	switch (arg1.object_index)
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			var _state = global.freezeframe ? arg1.frozenState : arg1.state;
			return _state == PlayerState.mach3 || (_state == PlayerState.run && arg1.movespeed >= 12) || _state == PlayerState.frostburnslide || (_state == PlayerState.frostburnjump && arg1.movespeed > 5) || _state == PlayerState.puddle || (_state == PlayerState.machroll && arg1.mach3Roll > 0) || _state == PlayerState.minecart || (_state == PlayerState.bottlerocket && arg1.substate == 0);
			break;
		default:
			return true;
			break;
	}
};

hsp = 0;
