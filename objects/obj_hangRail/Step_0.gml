with (obj_parent_player)
{
	if (state != states.noclip && state != states.bossintro && state != states.keyget && state != states.tackle && state != states.runonball && state != states.gottreasure && state != states.throwing && state != states.mach3 && state != states.frozen)
	{
		if (place_meeting(x, y, other) && vsp <= 4 && !grounded && place_meeting_collision(x, y - 16) && y >= other.y && state != states.grind)
		{
			state = states.grind;
			vsp = -16;
		}
	}
}
