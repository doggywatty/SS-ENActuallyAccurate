function scr_enemy_cherrywait()
{
	var player_object = get_nearestPlayer(x, y);
	image_speed = 0.35;
	hsp = 0;
	sprite_index = spr_charcherry_waitair;
	if (grounded || place_meeting_collision(x, y + vsp))
		sprite_index = spr_charcherry_wait;
	if (grounded && sprite_index != spr_charcherry_popout
	&& point_in_rectangle(x, y, player_object.x - 400, player_object.y - 60, player_object.x + 400,
	player_object.y + 60))
	{
		sprite_index = spr_charcherry_popout;
		image_index = 0;
		state = States.frozen;
	}
}
