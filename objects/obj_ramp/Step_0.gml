if (place_meeting(x, y - 16, obj_parent_player))
{
	with (obj_parent_player)
	{
		if (place_meeting(x, y + 16, other.id) && !scr_solid(x + xscale, y, true) && bbox_bottom <= other.bbox_top && xscale == sign(other.image_xscale))
		{
			if (state == states.pistol || state == states.shotgun || state == states.freefallland)
			{
				if (state != states.freefallland)
					event_play_oneshot("event:/SFX/player/rampjump", x, y);
				
				state = states.freefallland;
				vsp = -12;
				movespeed = 14;
			}
			else if (state == states.punch || state == states.backkick)
			{
				inputBuffer = 60;
				vsp = -22;
				movespeed = 22 * obj_parent_player.xscale;
			}
		}
	}
}
