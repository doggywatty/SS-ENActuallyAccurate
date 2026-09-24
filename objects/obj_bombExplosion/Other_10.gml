repeat (irandom_range(4, 7))
{
	with (instance_create(bbox_xrange, bbox_yrange, obj_machDustEffect))
	{
		sprite_index = spr_smogPuff;
		image_index = 0;
	}
}

repeat (irandom_range(3, 5))
	instance_create(bbox_xrange, bbox_yrange, obj_explosionSpark);

summonedDust = true;
