repeat (irandom_range(4, 7))
{
	with (instance_create(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), obj_machDustEffect))
	{
		sprite_index = spr_smogPuff;
		image_index = 0;
	}
}

repeat (irandom_range(3, 5))
	instance_create(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), obj_explosionSpark);

summonedDust = true;
