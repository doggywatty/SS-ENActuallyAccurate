with (obj_parent_player)
{
	if (state != states.hang && state != states.bossintro && state != states.keyget && state != states.tackle && state != states.runonball && state != states.gottreasure && state != states.throwing && state != states.mach3 && state != states.frozen)
	{
		if (place_meeting_platform(x, y + 1, other) && vsp >= 0 && state != states.chainsawbump)
		{
			state = states.chainsawbump;
			vsp = 0;
		}
	}
}
