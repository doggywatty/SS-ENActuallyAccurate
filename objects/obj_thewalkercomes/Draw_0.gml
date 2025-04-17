var player_far_away = distance_to_object(obj_parent_player) > 1200;
if player_far_away
{
	if (t >= 18000)
	{
		if (t < 21600)
			visible = true;
		else
			visible = false;
	}
}
draw_sprite_ext(sprite_index, image_index, x, y, xscale, 1, 0, c_white, 1);
t = (t + 1) % 1000000000;
