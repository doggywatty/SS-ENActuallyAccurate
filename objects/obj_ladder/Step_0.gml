visible = global.showcollisions || isVisible;

if (place_meeting(x, y - 16, obj_parent_player))
{
	with (obj_parent_player)
	{
		var collide = place_meeting(x, y + 1, obj_ladder) && !place_meeting_collision(other.x + (other.sprite_width / 2), round(y + 5), Exclude.MOVING | Exclude.PLATFORMS);
		
		if ((collide && key_down && !key_up) && !inputLadderBuffer && (grounded && (state == PlayerState.crouch || state == PlayerState.freefallland)))
		{
			hsp = 0;
			vsp = 0;
			y += 5;
			state = PlayerState.ladder;
			x = other.x + (other.sprite_width / 2);
			y = round(y);
			
			if ((y % 2) == 1)
				y -= 1;
		}
	}
}
