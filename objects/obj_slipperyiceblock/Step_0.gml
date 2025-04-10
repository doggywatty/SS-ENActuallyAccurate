if !global.freezeframe
{
	var _player = instance_nearest(x, y, obj_parent_player);
	if (place_meeting(x, y - 1, _player) && _player.grounded && !_player.cutscene && _player.state != States.noclip && _player.state != States.frozen)
	{
		with _player
		{
			if (state == States.frostburnnormal || state == States.frostburnjump || state == States.frostburnstick)
			{
				state = States.frostburnslide;
				if (move != 0)
					xscale = move;
				else if (hsp != 0)
					xscale = sign(hsp);
			}

			if (state != States.frostburnslide)
				state = States.slipnslide;
			movespeed = clamp(movespeed, 12, 14);
		}
	}
}
