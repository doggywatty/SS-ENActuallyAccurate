flags.do_once = true;
flags.do_save = false;

condition = function()
{
	var _check = false;
	var _x = x;
	var _y = y;
	with obj_parent_player
	{
		if place_meeting(roomStartX, roomStartY, other)
			_check = true;
	}
	return _check;
};

output = function()
{
	with obj_parent_player
	{
		movespeed = 12;
		jumpStop = true;
		state = States.mach3;
		sprite_index = spr_machdashpad;
		vsp = 5;
		dashpadBuffer = 50;
	}
	
	if (ds_list_find_index(flags.saveroom, id) != -1)
	{
		instance_destroy();
		exit;
	}
	
	for (var i = 0; i < (sprite_get_number(spr_gclocktowerdebris) - 1); i++)
	{
		with (create_debris(x + random_range(-10, 10), y + random_range(-10, 10), spr_gclocktowerdebris))
			image_index = i;
	}
	
	repeat 3
		create_debris((x - sprite_xoffset) + (sprite_width / 2) + random_range(-10, 10), y + random_range(-10, 10), spr_gclocktowerdebris);
	
	camera_shake_add(20, 40);
	event_play_oneshot("event:/SFX/general/breakmetal");
	var lay_id = layer_get_id("Assets_1");
	var sprite_id = layer_sprite_get_id(lay_id, "graphic_5748A7F1");
	layer_sprite_change(sprite_id, spr_clocktowerexterior_broken);
	
	with obj_parent_player
	{
		if (state == States.mach3 && sprite_index != spr_mach3hit)
		{
			sprite_index = spr_mach3hit;
			image_index = 0;
		}
	}
	
	if (ds_list_find_index(flags.saveroom, id) == -1)
		ds_list_add(flags.saveroom, id);
	instance_destroy();
};
