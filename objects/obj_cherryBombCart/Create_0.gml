canCollide = function(player = obj_parent_player)
{
	switch player
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			var _state = global.freezeframe ? player.frozenState : player.state;
			return _state == States.mach3 || (_state == States.run && player.movespeed >= 12)
			|| _state == States.frostburnslide || (_state == States.frostburnjump && player.movespeed > 5)
			|| _state == States.puddle || (_state == States.machroll && player.mach3Roll > 0)
			|| _state == States.minecart || (_state == States.bottlerocket && player.substate == 0);
			break;
		default:
			return true;
			break;
	}
};

hsp = 0;
