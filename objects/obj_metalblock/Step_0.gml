with (instance_nearest(x, y, obj_parent_player))
{
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && (state == PlayerState.mach3 || (state == PlayerState.run && movespeed >= 12) || state == PlayerState.frostburnslide || (state == PlayerState.frostburnjump && movespeed > 5) || state == PlayerState.puddle || (state == PlayerState.machroll && mach3Roll > 0) || state == PlayerState.minecart || (state == PlayerState.bottlerocket && substate == 0)))
	{
		with (other.id)
		{
			DestroyedBy = other.id;
			event_user(0);
		}
	}
	
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x - xscale, y, other.id)) && state == PlayerState.unknownrun && movespeed >= 12)
	{
		with (other.id)
		{
			DestroyedBy = other.id;
			event_user(0);
		}
	}
	
	if (((place_meeting(x, y + vsp, other.id) && vsp < 0) || place_meeting(x, y - 1, other.id)) && state == PlayerState.Sjump)
	{
		with (other.id)
		{
			DestroyedBy = other.id;
			event_user(0);
		}
	}
	
	if (((place_meeting(x, y + vsp, other.id) && vsp < 0) || place_meeting(x, y - 1, other.id)) && state == PlayerState.fling_launch)
	{
		with (other.id)
		{
			DestroyedBy = other.id;
			event_user(0);
		}
	}
	
	if (((place_meeting(x, y + vsp, other.id) && vsp < 0) || place_meeting(x, y - 1, other.id)) && state == PlayerState.climbwall && machTwo >= 100)
	{
		with (other.id)
		{
			DestroyedBy = other.id;
			event_user(0);
		}
	}
	
	if (((place_meeting(x, y + vsp, other.id) && vsp >= 0) || place_meeting(x, y + 1, other.id)) && state == PlayerState.freefallland && freeFallSmash > 10)
	{
		with (other.id)
		{
			DestroyedBy = other.id;
			event_user(0);
		}
	}
}
