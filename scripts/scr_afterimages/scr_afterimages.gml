function create_afterimage(arg0, arg1 = image_xscale, arg2 = false)
{
	if (!instance_exists(id))
		exit;
	
	var parent = object_index;
	var afterimage_id = id;
	var pal = [-4, -4];
	var angle = afterimage_id.image_angle;
	
	if (object_is_ancestor(parent, obj_parent_enemy))
		pal = [paletteSelect, paletteSprite];
	
	if (object_is_ancestor(parent, obj_parent_player))
		angle = afterimage_id.draw_angle;
	
	var q = 
	{
		x: afterimage_id.x,
		y: afterimage_id.y,
		blink: arg2,
		sprite_index: afterimage_id.sprite_index,
		image_index: afterimage_id.image_index,
		image_alpha: 1,
		image_angle: angle,
		image_xscale: arg1,
		image_yscale: 1,
		visible: true,
		alarm: [13, 30],
		color_choose: arg0,
		hsp: 0,
		vsp: 0,
		identity: afterimage_id,
		gonealpha: (arg0 == (0 << 0)) ? 0.85 : 1,
		vanish: false,
		paletteSelect: pal[0],
		paletteSprite: pal[1],
		basicAfterimage: true,
		mach3Afterimage: false,
		vanishSpd: 0.15,
		fakeMach3Afterimage: false
	};
	
	if (arg0 == (7 << 0))
		q.vanishSpd = 0.05;
	
	ds_list_add(global.afterimage_list, q);
	return q;
}

function create_heat_afterimage(arg0, arg1 = image_xscale, arg2 = 8)
{
	with (create_afterimage(arg0, arg1))
	{
		gonealpha = 0.85;
		vsp = arg2;
		alarm[0] = 1;
		alarm[1] = 60;
	}
	
	with (create_afterimage(arg0, arg1))
	{
		gonealpha = 0.85;
		vsp = -arg2;
		alarm[0] = 1;
		alarm[1] = 60;
	}
	
	with (create_afterimage(arg0, arg1))
	{
		gonealpha = 0.85;
		hsp = arg2;
		alarm[0] = 1;
		alarm[1] = 60;
	}
	
	with (create_afterimage(arg0, arg1))
	{
		gonealpha = 0.85;
		hsp = -arg2;
		alarm[0] = 1;
		alarm[1] = 60;
	}
}
