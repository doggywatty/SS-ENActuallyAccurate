with (instance_nearest(x, y, obj_parent_player))
{
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && (state == states.shotgun || (state == states.Nhookshot && movespeed >= 12) || state == states.uppercut || (state == states.pal && movespeed > 5) || state == states.freefallprep || (state == states.climbdownwall && mach3Roll > 0) || state == states.victory || (state == states.barrelmach2 && substate == 0)))
	{
		with (other.id)
		{
			DestroyedBy = other.id;
			event_user(0);
		}
	}
	
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x - xscale, y, other.id)) && state == states.current && movespeed >= 12)
	{
		with (other.id)
		{
			DestroyedBy = other.id;
			event_user(0);
		}
	}
	
	if (((place_meeting(x, y + vsp, other.id) && vsp < 0) || place_meeting(x, y - 1, other.id)) && state == states.highjump)
	{
		with (other.id)
		{
			DestroyedBy = other.id;
			event_user(0);
		}
	}
	
	if (((place_meeting(x, y + vsp, other.id) && vsp < 0) || place_meeting(x, y - 1, other.id)) && state == states.parry)
	{
		with (other.id)
		{
			DestroyedBy = other.id;
			event_user(0);
		}
	}
	
	if (((place_meeting(x, y + vsp, other.id) && vsp < 0) || place_meeting(x, y - 1, other.id)) && state == states.cheesepep && machTwo >= 100)
	{
		with (other.id)
		{
			DestroyedBy = other.id;
			event_user(0);
		}
	}
	
	if (((place_meeting(x, y + vsp, other.id) && vsp >= 0) || place_meeting(x, y + 1, other.id)) && state == states.skateboard && freeFallSmash > 10)
	{
		with (other.id)
		{
			DestroyedBy = other.id;
			event_user(0);
		}
	}
}
