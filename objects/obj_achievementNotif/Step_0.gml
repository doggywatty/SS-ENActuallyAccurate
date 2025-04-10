if (showTimer > 0)
{
	var target_y = camera_get_view_height(view_camera[0]) - 100;
	if (sprite_index == spr_paletteUnlock)
		target_y = camera_get_view_height(view_camera[0]) - 140;
	if (abs(target_y - y) <= 40)
		movespeed = approach(movespeed, 1, 0.1);
	
	y = approach(y, target_y, movespeed);
	if (y <= target_y)
		showTimer--;
	exit;
}
movespeed = clamp(movespeed + 0.2, 4, 8);
y = approach(y, ystart, movespeed);

if y >= ystart
	instance_destroy();
