image_index = count;
if !isCollect
{
	movespeed = approach(movespeed, collectSpeed, 1);
	var py = playerID.y - 100;
	var px = playerID.x;
	var canCollect = false;
	with obj_minesgem
	{
		if (gemCount >= other.count)
			canCollect = true;
	}
	dirAdj = approach(dirAdj, 1, 0.1);
	dir = point_direction(x, y, px, py);
	x += (lengthdir_x(movespeed, dir) * sign(dirAdj));
	y += (lengthdir_y(movespeed, dir) * sign(dirAdj));
	if (point_distance(x, y, px, py) < 16 && canCollect)
		instance_destroy();
}
else
{
	x += hsp;
	y += vsp;
	vsp += grav;
	if (y > (ystart + 128))
	{
		with instance_create(x, y, obj_collect_giver)
		{
			collect_sprite = spr_gem_points;
			collect = 50;
		}
		instance_create(x, y, obj_poofeffect);
		instance_destroy();
	}
}
