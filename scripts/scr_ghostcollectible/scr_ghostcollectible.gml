function scr_ghostcollectible(arg0 = false, arg1 = undefined, arg2 = undefined)
{
	if (!instance_exists(obj_secretfound) || createdGhost)
		return -4;
	
	createdGhost = true;
	var q = -4;
	var b = id;
	
	with (obj_secretfound)
	{
		q = 
		{
			x: b.xstart,
			y: b.ystart,
			sprite_index: b.sprite_index,
			image_speed: b.image_speed * sprite_get_speed(b.sprite_index),
			image_number: b.image_number,
			image_xscale: b.image_xscale,
			image_yscale: b.image_yscale,
			image_alpha: 0.5,
			image_index: 0,
			candysona: arg0,
			paletteSprite: arg1,
			paletteSelect: arg2,
			usePalette: !is_undefined(arg1),
			platformIndex: 0
		};
		show_debug_message($"Ghost Collectable created: {q} (Struct)");
		ds_list_add(collectSecretList, q);
	}
	
	return q;
}
