if (!global.freezeframe)
{
	var _player = instance_nearest(x, y, obj_parent_player);
	
	if (place_meeting(x, y - 1, _player) && _player.grounded && !_player.cutscene && _player.state != PlayerState.noclip && _player.state != PlayerState.frozen)
	{
		with (_player)
		{
			if (state == PlayerState.frostburnnormal || state == PlayerState.frostburnjump || state == PlayerState.frostburnstick)
			{
				state = PlayerState.frostburnslide;
				
				if (move != 0)
					xscale = move;
				else if (hsp != 0)
					xscale = sign(hsp);
			}
			
			if (state != PlayerState.frostburnslide)
				state = PlayerState.slipnslide;
			
			movespeed = clamp(movespeed, 12, 14);
		}
	}
}
