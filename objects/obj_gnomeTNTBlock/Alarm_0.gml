instance_create(x + (sprite_width / 2), y + (sprite_height / 2), obj_bombExplosion);
var rep = 3 + round(sprite_width / 16);

repeat (rep)
	create_debris(bbox_xrange, bbox_yrange, spr_gnomewalldebris);

camera_shake_add(20, 40);

for (var i = 0; i < (sprite_get_number(spr_minecartdebris) - 1); i++)
{
	with (create_debris(x + random_range(-10, 10), y + random_range(-10, 10), spr_gnomewalldebris))
		image_index = i;
}

instance_destroy();
