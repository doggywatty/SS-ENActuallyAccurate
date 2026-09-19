if (!global.freezeframe)
{
	var _player = instance_nearest(x, y, obj_parent_player);
	
	if (place_meeting(x, y - 1, _player) && _player.grounded && !_player.cutscene && _player.state != states.noclip && _player.state != states.frozen)
	{
		with (_player)
		{
			if (state == states.cotton || state == states.pal || state == states.shocked)
			{
				state = states.uppercut;
				
				if (move != 0)
					xscale = move;
				else if (hsp != 0)
					xscale = sign(hsp);
			}
			
			if (state != states.uppercut)
				state = states.bombpep;
			
			movespeed = clamp(movespeed, 12, 14);
		}
	}
}
