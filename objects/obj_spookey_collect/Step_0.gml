if (place_meeting_collision(x, y))
{
	var dir = point_direction(x, y, obj_parent_player.x, obj_parent_player.y);
	x += lengthdir_x(16, dir);
	y += lengthdir_y(16, dir);
}

if (blurEffectTimer-- <= 0)
{
	blurEffectTimer = 2;
	with (create_afterimage(AfterImageType.plain, image_xscale))
	{
		image_yscale = other.image_yscale;
		image_alpha = 0.6;
		image_index = other.image_index - 1;
		vanish = true;
	}
}
