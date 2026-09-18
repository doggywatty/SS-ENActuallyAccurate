global.ParallaxMap = ds_map_create();

function scr_calculate_farParallaxX(arg0, arg1)
{
	if (!sprite_exists(arg0))
		return 0;
	
	var sprite_size = sprite_get_width(arg0) - camera_get_view_width(view_camera[0]);
	var max_pos = 0;
	
	if (room_width > camera_get_view_width(view_camera[0]) && sprite_size <= room_width)
		max_pos = camera_get_view_x(view_camera[0]) / (room_width - camera_get_view_width(view_camera[0]));
	
	return max(sprite_size * max_pos * arg1, 0);
}

function scr_calculate_farParallaxY(arg0, arg1)
{
	if (!sprite_exists(arg0))
		return 0;
	
	var sprite_size = sprite_get_height(arg0) - camera_get_view_height(view_camera[0]);
	var max_pos = 0;
	
	if (room_height > camera_get_view_height(view_camera[0]) && sprite_size <= room_height)
		max_pos = camera_get_view_y(view_camera[0]) / (room_height - camera_get_view_height(view_camera[0]));
	
	return max(sprite_size * max_pos * arg1, 0);
}

function scr_addParallaxLayer(arg0, arg1, arg2 = [])
{
	ds_map_set(global.ParallaxMap, arg0, 
	{
		func: arg1,
		args: arg2
	});
	exit;
}

function defaultParallax(arg0, arg1)
{
	x += (camera_get_view_x(view_camera[0]) * arg0);
	y += (camera_get_view_y(view_camera[0]) * arg1);
}

function defaultParallaxGround(arg0, arg1)
{
	x += (camera_get_view_x(view_camera[0]) * arg0);
	y += round(room_height - sprite_get_height(layer_background_get_sprite(layer_background_get_id_fixed(id))));
}

function defaultParallaxZigZag(arg0, arg1, arg2, arg3)
{
	var time = global.CurrentTime;
	x += (camera_get_view_x(view_camera[0]) * arg0);
	y += (camera_get_view_y(view_camera[0]) * arg1);
	x += wave(-arg2, arg2, 4, 10, time);
	y += wave(-arg3, arg3, 4, 10, time);
}

function defaultParallaxH(arg0, arg1)
{
	var sprite = layer_background_get_sprite(layer_background_get_id_fixed(id));
	x += (camera_get_view_x(view_camera[0]) * arg0);
	y += (camera_get_view_y(view_camera[0]) - scr_calculate_farParallaxY(sprite, arg1));
}

function defaultParallaxV(arg0, arg1)
{
	var sprite = layer_background_get_sprite(layer_background_get_id_fixed(id));
	x += (camera_get_view_x(view_camera[0]) - scr_calculate_farParallaxX(sprite, arg0));
	y += (camera_get_view_y(view_camera[0]) * arg1);
}

function defaultParallaxFar(arg0, arg1)
{
	var sprite = layer_background_get_sprite(layer_background_get_id_fixed(id));
	x += (camera_get_view_x(view_camera[0]) - scr_calculate_farParallaxX(sprite, arg0));
	y += (camera_get_view_y(view_camera[0]) - scr_calculate_farParallaxY(sprite, arg1));
}

function parallaxZigZagV(arg0, arg1)
{
	var _spd = layer_get_vspeed(id);
	var _sin = wave(-_spd, _spd, 1, 0);
	x += (camera_get_view_x(view_camera[0]) * arg0);
	y += ((camera_get_view_y(view_camera[0]) * arg1) + _sin);
	y -= yShift;
}

function parallaxZigZagHFar(arg0, arg1)
{
	var time = global.ScrollOffset / 60;
	var _spd = vspeed;
	var _sin = wave(-_spd, _spd, 1, 0);
	var sprite = layer_background_get_sprite(layer_background_get_id_fixed(id));
	x += (camera_get_view_x(view_camera[0]) * arg0);
	y += (camera_get_view_y(view_camera[0]) - scr_calculate_farParallaxY(sprite, arg1));
	y += _sin;
	y -= yShift;
}

function parallaxZigZagVFar(arg0, arg1)
{
	var time = global.ScrollOffset / 60;
	var _spd = vspeed;
	var _sin = wave(-_spd, _spd, 1, 0);
	var sprite = layer_background_get_sprite(layer_background_get_id_fixed(id));
	x += (camera_get_view_x(view_camera[0]) - scr_calculate_farParallaxX(sprite, arg0));
	y += (camera_get_view_y(view_camera[0]) - scr_calculate_farParallaxY(sprite, arg1));
	y += _sin;
	y -= yShift;
}
