var target_player = get_nearestPlayer();

with (target_player)
{
	if (place_meeting(x, y, other.id) && (state == states.victory || state == states.Sjump || (state == states.comingoutdoor && vsp >= 0)))
	{
		event_play_oneshot("event:/SFX/general/mallowbounce", x, y);
		x = other.x;
		y = other.y;
		image_index = 0;
		movespeed = 0;
		vsp = -25;
		state = states.comingoutdoor;
		sprite_index = spr_player_PZ_minecart_jump;
	}
}
