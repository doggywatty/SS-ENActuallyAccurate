if (place_meeting(x, y - 16, obj_parent_player))
{
	with (obj_parent_player)
	{
		if (place_meeting(x, y + 16, other.id) && !scr_solid(x + xscale, y, true) && bbox_bottom <= other.bbox_top && xscale == sign(other.image_xscale))
		{
			if (state == PlayerState.mach2 || state == PlayerState.mach3 || state == PlayerState.trick)
			{
				if (state != PlayerState.trick)
					event_play_oneshot("event:/SFX/player/rampjump", x, y);
				
				state = PlayerState.trick;
				vsp = -12;
				movespeed = 14;
			}
			else if (state == PlayerState.doughmount || state == PlayerState.doughmountspin)
			{
				inputBuffer = 60;
				vsp = -22;
				movespeed = 22 * obj_parent_player.xscale;
			}
		}
	}
}
