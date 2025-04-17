warningx = lerp(warningx, targetx, warningspeed);
warningy = lerp(warningy, targety, warningspeed);
if (chaseActive && state != States.stun)
{
	var _x = pathxstart;
	var _y = pathystart;
	var _dist = point_distance(_x, _y, warningx, warningy);
	var _dir = point_direction(_x, _y, warningx, warningy);
	var w = sprite_get_width(pathspr);
	var wto = _dist / w;
	var drawX = false;
	var drawY = false;
	for (var i = 0; i < floor(wto); i++)
	{
		drawX = (sign(warningx - pathxstart) == -1) ? (_x <= x) : (_x >= x);
		drawY = (sign(warningy - pathystart) == -1) ? (_y <= y) : (_y >= y);
		if (drawX && drawY)
			draw_sprite_ext(pathspr, 0, _x, _y, 1, 1, _dir, image_blend, image_alpha);
		_x += lengthdir_x(w, _dir);
		_y += lengthdir_y(w, _dir);
	}
	if (frac(wto) > 0 && drawX && drawY)
	{
		var _dist2 = frac(wto) * w;
		draw_sprite_general(pathspr, 0, 0, 29, _dist2, 37, _x, _y, 1, 1, _dir, image_blend, image_blend, image_blend, image_blend, image_alpha);
	}
	draw_sprite(warningspr, -1, warningx, warningy);
}
draw_self();
