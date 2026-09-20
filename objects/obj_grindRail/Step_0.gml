with (obj_parent_player)
{
	if (state != PlayerState.noclip && state != PlayerState.cotton && state != PlayerState.cottondrill && state != PlayerState.cottonroll && state != PlayerState.tumble && state != PlayerState.taunt && state != PlayerState.bump && state != PlayerState.actor && state != PlayerState.frozen)
	{
		if (place_meeting_platform(x, y + 1, other) && vsp >= 0 && state != PlayerState.grind)
		{
			state = PlayerState.grind;
			vsp = 0;
		}
	}
}
