function scr_enemy_eyescream()
{
	sprite_index = spr_eyescreamsandwich;
	image_speed = 0.35;
	faceTowardsPlayerFunc();
	var _dist = point_distance(x, y, xstart, ystart);
	if (abs(_dist) < 800)
	{
		var p = get_nearestPlayer();
		var dir = point_direction(x, y, p.x, p.y);
		var _spd = 6;
		hsp = approach(hsp, lengthdir_x(_spd, dir), 0.5);
		vsp = approach(vsp, lengthdir_y(_spd, dir), 0.5);
		if (abs(point_distance(x, y, p.x, p.y)) < 120)
		{
			hsp = 0;
			vsp = 0;
		}
		x += hsp;
		y += vsp;
		if (abs(point_distance(x, y, p.x, p.y)) < 100 && ragereset <= 0)
		{
			state = States.titlescreen;
			sprite_index = spr_eyescreamsandwich_divestart;
			image_index = 0;
		}
	}
	else
		state = EnemyStates.eyescreamwait;
}
