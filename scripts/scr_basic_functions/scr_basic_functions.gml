function approach(value, target, amount)
{
	return value + clamp(target - value, -amount, amount);
}

function instance_random(obj)
{
	return instance_find(obj, irandom(instance_number(obj) - 1));
}

function trace()
{
	var trace_string = "";
	for (var i = 0; i < argument_count; i++)
		trace_string += string(argument[i]);
	show_debug_message(trace_string);
	exit;
}

function get_panic()
{
	return (global.panic && !global.RoomIsSecret) || instance_exists(obj_sucroseTimer);
}

function chance(percent)
{
	return random(100) <= percent;
}

function wave(from, to, duration, offset, _current_time = global.CurrentTime)
{
	var a4 = (to - from) / 2;
	return from + a4 + (sin((((_current_time * 0.001) + (duration * offset)) / duration) * 2 * pi) * a4);
}

function wrap(value, minute, maximum)
{
	var _min = min(minute, maximum);
	var _max = max(minute, maximum);
	var range = (_max - _min) + 1;
	return ((((value - _min) % range) + range) % range) + _min;
}

function animation_end_old(current_frame = floor(image_index), last_frame = image_number - 1)
{
	return current_frame >= last_frame;
}

function sprite_animation_end(spr = sprite_index, frame = image_index, total_frames = sprite_get_number(spr), speed = image_speed)
{
	return (frame + ((speed * sprite_get_speed(spr)) / ((sprite_get_speed_type(spr) == 1) ? 1 : game_get_speed(gamespeed_fps)))) >= total_frames;
}

function absfloor(n)
{
	return (n > 0) ? floor(n) : ceil(n);
}

function rank_checker(_rank = global.rank)
{
	var ranks = ["d", "c", "b", "a", "s", "p"];
	for (var i = 0; i < array_length(ranks); i++)
	{
		if (_rank == ranks[i])
			return i;
	}
	return -4;
}

function string_extract(str, delimiter, count)
{
	var len = string_length(delimiter) - 1;
	repeat count
		str = string_delete(str, 1, string_pos(delimiter, str) + len);
	str = string_delete(str, string_pos(delimiter, str), string_length(str));
	return str;
}

function create_small_number(_x, _y, _num, _img_blend = c_white)
{
	return instance_create(_x, _y, obj_smallnumber, 
	{
		image_blend: _img_blend,
		number: string(_num)
	});
}

function array_get_any(_arrs)
{
	return array_get(_arrs, irandom_range(0, array_length(_arrs) - 1));
}

function draw_sprite_ext_flash(spr, subimg, _x, _y, xscale, yscale, rot, flash_col, alpha)
{
	gpu_set_fog(true, flash_col, 0, 1);
	draw_sprite_ext(spr, subimg, _x, _y, xscale, yscale, rot, flash_col, alpha);
	gpu_set_fog(false, c_black, 0, 0);
}

function draw_self_flash(flash_col)
{
	draw_sprite_ext_flash(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, flash_col, image_alpha);
}

function draw_sprite_ext_duotone(spr, subimg, _x, _y, xscale, yscale, rot, color1, color2, alpha)
{
	shader_set(shd_afterimage);
	var color_blend_1 = shader_get_uniform(shd_afterimage, "blendcolor1");
	var color_blend_2 = shader_get_uniform(shd_afterimage, "blendcolor2");
	shader_set_uniform_f(color_blend_1, color_get_red(color1) / 255, color_get_green(color1) / 255, color_get_blue(color1) / 255);
	shader_set_uniform_f(color_blend_2, color_get_red(color2) / 255, color_get_green(color2) / 255, color_get_blue(color2) / 255);
	draw_sprite_ext(spr, subimg, _x, _y, xscale, yscale, rot, c_white, alpha);
	shader_reset();
}

function draw_self_duotone(color1, color2)
{
	draw_sprite_ext_duotone(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, color1, color2, image_alpha);
}

function time_in_frames(minutes, seconds)
{
	return ((minutes * 60) + seconds) * 60;
}

function onBeat(_beatspersec, _beatstate = false)
{
	var bps = _beatspersec / 60;
	var spb = 1 / bps;
	var song_timer = audio_sound_get_track_position(global.music);
	var game_fps = 60;
	var beat2 = floor(song_timer) / (spb * game_fps);
	if (beat != beat2)
	{
		beat = beat2;
		return true;
	}
	return false;
}

function solid_in_line(_x, _y = -4, _self = self)
{
	var _list = ds_list_create();
	var set_list = collision_line_list(x, y, _x.x, _x.y, obj_parent_collision, true, true, _list, true);
	if (set_list > 0)
	{
		for (var i = 0; i < set_list; i++)
		{
			var obj = ds_list_find_value(_list, i);
			if _y != -4
			{
				var found_obj = false;
				for (var b = 0; b < array_length(_y); b++)
				{
					var arr = _y[b];
					if (obj.object_index == arr)
						found_obj = true;
				}
				if !found_obj
				{
					ds_list_destroy(_list);
					return true;
				}
			}
			else
			{
				ds_list_destroy(_list);
				return true;
			}
		}
	}
	ds_list_destroy(_list);
	return false;
}

function angle_rotate(angle, target, _spd)
{
	// STOLEN! https://forum.gamemaker.io/index.php?threads/smooth-camera-rotation.84059/	
	var diff = wrap(target - angle, -180, 180);
	if (diff < -_spd)
		return angle - _spd;
	if (diff > _spd)
		return angle + _spd;
	return target;
}

function getFacingDirection(_x, _y)
{
	if (_x != _y)
		return -sign(_x - _y);
	return 1;
}

function number_in_range(value, min_val, max_val)
{
	return value >= min_val && value <= max_val;
}

function parameter_get_array()
{
	var p_num = parameter_count(), p_string = [];
	if (p_num > 0)
	{
		for (var i = 0; i < p_num; i++)
			p_string[i] = parameter_string(i);
	}
	return p_string;
}

function round_nearest(_x, _y)
{
	var val = abs(_y[0] - _x);
	var ind = 0;
	for (var i = 1; i < array_length(_y); i++)
	{
		var dist = abs(_y[i] - _x);
		if (dist < val)
		{
			ind = i;
			val = dist;
		}
	}
	return _y[ind];
}

function randomize_animations(_anim)
{
	if !variable_instance_exists(self, "saved_rand_anim")
		saved_rand_anim = [];
	if !variable_instance_exists(self, "rand_anim")
		rand_anim = [];
	if (saved_rand_anim != _anim || array_length(rand_anim) <= 0)
	{
		saved_rand_anim = _anim;
		rand_anim = array_shuffle(_anim);
	}
	return array_shift(rand_anim);
}

function array_clone(array)
{
	var temp_arr = [];
	array_copy(temp_arr, 0, array, 0, array_length(array));
	return temp_arr;
}
