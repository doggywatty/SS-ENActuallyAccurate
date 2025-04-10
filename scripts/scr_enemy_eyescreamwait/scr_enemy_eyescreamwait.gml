function scr_enemy_eyescreamwait()
{
	image_speed = 0.35;
	sprite_index = spr_eyescreamsandwich;
	var p = get_nearestPlayer();
	var _dist = point_distance(x, y, xstart, ystart);
	var _disttoplayer = point_distance(x, y, p.x, p.y);
	var dir = point_direction(x, y, xstart, ystart);
	var _spd = 5;
	hsp = approach(hsp, lengthdir_x(_spd, dir), 0.5);
	vsp = approach(vsp, lengthdir_y(_spd, dir), 0.5);
	x += hsp;
	y += vsp;
	if (abs(_dist) < 400 && abs(_disttoplayer) < 400)
		state = EnemyStates.eyescream;
	if (abs(_dist) <= 10)
	{
		state = EnemyStates.eyescreampopout;
		x = xstart;
		y = ystart;
		sprite_index = spr_eyescreamsandwich_wait;
	}
}
