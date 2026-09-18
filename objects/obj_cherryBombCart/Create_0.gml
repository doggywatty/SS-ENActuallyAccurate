canCollide = function(arg0, arg1 = obj_parent_player)
{
	switch (arg1.object_index)
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			var _state = global.freezeframe ? arg1.frozenState : arg1.state;
			return _state == states.shotgun || (_state == states.Nhookshot && arg1.movespeed >= 12) || _state == states.uppercut || (_state == states.pal && arg1.movespeed > 5) || _state == states.freefallprep || (_state == states.climbdownwall && arg1.mach3Roll > 0) || _state == states.victory || (_state == states.barrelmach2 && arg1.substate == 0);
			break;
		default:
			return true;
			break;
	}
};

hsp = 0;
