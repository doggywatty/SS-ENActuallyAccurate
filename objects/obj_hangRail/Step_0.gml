with (obj_parent_player)
{
	if (state != PlayerState.noclip && state != PlayerState.cotton && state != PlayerState.cottondrill && state != PlayerState.cottonroll && state != PlayerState.tumble && state != PlayerState.taunt && state != PlayerState.bump && state != PlayerState.actor && state != PlayerState.frozen)
	{
		if (place_meeting(x, y, other) && vsp <= 4 && !grounded && place_meeting_collision(x, y - 16) && y >= other.y && state != PlayerState.hang)
		{
			state = PlayerState.hang;
			vsp = -16;
		}
	}
}
