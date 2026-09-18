dir = point_direction(x, y, targetX, targetY);
x = approach(x, targetX, abs(lengthdir_x(16, dir)));
y = approach(y, targetY, abs(lengthdir_y(16, dir)));

if (x == targetX || y == targetY)
	instance_destroy();

if (x != targetX)
	image_xscale = getFacingDirection(x, targetX);

if (blurEffectTimer-- <= 0)
{
	blurEffectTimer = 1;
	
	with (create_afterimage(afterimagetypes.basic, image_xscale))
	{
		image_alpha = 0.6;
		image_index = other.image_index - 1;
		vanish = true;
	}
}
