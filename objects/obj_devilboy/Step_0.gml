if following
{
	var tgtX = obj_parent_player.x;
	var tgtY = obj_parent_player.y - 60;
	x = lerp(x, tgtX, spd);
	y = lerp(y, tgtY, spd);
	
	if (point_distance(x, y, tgtX, tgtY) <= 10)
	{
		if (alarm[0] < 0)
		{
			alarm[0] = 50;
			spd = 0.2;
		}
	}
}
else
{
	y -= 8;
	x += 4;
}

sprite_index = spr_devilboy;
