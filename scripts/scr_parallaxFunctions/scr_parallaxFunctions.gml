global.ParallaxMap = ds_map_create();
function scr_calculate_farParallaxX(_spr, multiplier)
{
	if !sprite_exists(_spr)
		return 0;
	var sprite_size = sprite_get_width(_spr) - camera_get_view_width(view_camera[0]);
	var max_pos = 0;
	if (room_width > camera_get_view_width(view_camera[0]) && sprite_size <= room_width)
		max_pos = camera_get_view_x(view_camera[0]) / (room_width - camera_get_view_width(view_camera[0]));
	return max(sprite_size * max_pos * multiplier, 0);
}

function scr_calculate_farParallaxY(_spr, multiplier)
{
	if !sprite_exists(_spr)
		return 0;
	var sprite_size = sprite_get_height(_spr) - camera_get_view_height(view_camera[0]);
	var max_pos = 0;
	if (room_height > camera_get_view_height(view_camera[0]) && sprite_size <= room_height)
		max_pos = camera_get_view_y(view_camera[0]) / (room_height - camera_get_view_height(view_camera[0]));
	return max(sprite_size * max_pos * multiplier, 0);
}

function scr_addParallaxLayer(_parallax, _func, _args = [])
{
	ds_map_set(global.ParallaxMap, _parallax, 
	{
		func: _func,
		args: _args
	});
	exit;
}

function defaultParallax(_x, _y)
{
	x += (camera_get_view_x(view_camera[0]) * _x);
	y += (camera_get_view_y(view_camera[0]) * _y);
}

function defaultParallaxGround(_x, _y)
{
	x += (camera_get_view_x(view_camera[0]) * _x);
	y += round(room_height - sprite_get_height(layer_background_get_sprite(layer_background_get_id_fixed(id))));
}

function defaultParallaxZigZag(_x, _y, _x1, _y1)
{
	var time = global.CurrentTime;
	x += (camera_get_view_x(view_camera[0]) * _x);
	y += (camera_get_view_y(view_camera[0]) * _y);
	x += wave(-_x1, _x1, 4, 10, time);
	y += wave(-_y1, _y1, 4, 10, time);
}

function defaultParallaxH(_x, _y)
{
	var sprite = layer_background_get_sprite(layer_background_get_id_fixed(id));
	x += (camera_get_view_x(view_camera[0]) * _x);
	y += (camera_get_view_y(view_camera[0]) - scr_calculate_farParallaxY(sprite, _y));
}

function defaultParallaxV(_x, _y)
{
	var sprite = layer_background_get_sprite(layer_background_get_id_fixed(id));
	x += (camera_get_view_x(view_camera[0]) - scr_calculate_farParallaxX(sprite, _x));
	y += (camera_get_view_y(view_camera[0]) * _y);
}

function defaultParallaxFar(_x, _y)
{
	var sprite = layer_background_get_sprite(layer_background_get_id_fixed(id));
	x += (camera_get_view_x(view_camera[0]) - scr_calculate_farParallaxX(sprite, _x));
	y += (camera_get_view_y(view_camera[0]) - scr_calculate_farParallaxY(sprite, _y));
}

function parallaxZigZagV(_x, _y)
{
	var _spd = layer_get_vspeed(id);
	var _sin = wave(-_spd, _spd, 1, 0);
	x += (camera_get_view_x(view_camera[0]) * _x);
	y += ((camera_get_view_y(view_camera[0]) * _y) + _sin);
	y -= yShift;
}

function parallaxZigZagHFar(_x, _y)
{
	var time = global.ScrollOffset / 60;
	var _spd = vspeed;
	var _sin = wave(-_spd, _spd, 1, 0);
	var sprite = layer_background_get_sprite(layer_background_get_id_fixed(id));
	x += (camera_get_view_x(view_camera[0]) * _x);
	y += (camera_get_view_y(view_camera[0]) - scr_calculate_farParallaxY(sprite, _y));
	y += _sin;
	y -= yShift;
}

function parallaxZigZagVFar(_x, _y)
{
	var time = global.ScrollOffset / 60;
	var _spd = vspeed;
	var _sin = wave(-_spd, _spd, 1, 0);
	var sprite = layer_background_get_sprite(layer_background_get_id_fixed(id));
	x += (camera_get_view_x(view_camera[0]) - scr_calculate_farParallaxX(sprite, _x));
	y += (camera_get_view_y(view_camera[0]) - scr_calculate_farParallaxY(sprite, _y));
	y += _sin;
	y -= yShift;
}
