with (obj_parent_player)
{
	if (state != states.noclip && state != states.bossintro && state != states.keyget && state != states.tackle && state != states.runonball && state != states.gottreasure && state != states.throwing && state != states.mach3 && state != states.frozen)
	{
		if (place_meeting_slopePlatform(x, y + 1, other) && vsp >= 0 && state != states.chainsawbump)
		{
			state = states.chainsawbump;
			vsp = 0;
		}
	}
}
