function approach(arg0, arg1, arg2)
{
	return arg0 + clamp(arg1 - arg0, -arg2, arg2);
}

function instance_random(arg0)
{
	return instance_find(arg0, irandom(instance_number(arg0) - 1));
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

function chance(arg0)
{
	return random(100) <= arg0;
}

function wave(arg0, arg1, arg2, arg3, arg4 = global.CurrentTime)
{
	var a4 = (arg1 - arg0) / 2;
	return arg0 + a4 + (sin((((arg4 * 0.001) + (arg2 * arg3)) / arg2) * 2 * pi) * a4);
}

function wrap(arg0, arg1, arg2)
{
	var _min = min(arg1, arg2);
	var _max = max(arg1, arg2);
	var range = (_max - _min) + 1;
	return ((((arg0 - _min) % range) + range) % range) + _min;
}

function animation_end_old(arg0 = floor(image_index), arg1 = image_number - 1)
{
	return arg0 >= arg1;
}

function sprite_animation_end(arg0 = sprite_index, arg1 = image_index, arg2 = sprite_get_number(arg0), arg3 = image_speed)
{
	return (arg1 + ((arg3 * sprite_get_speed(arg0)) / ((sprite_get_speed_type(arg0) == 1) ? 1 : game_get_speed(gamespeed_fps)))) >= arg2;
}

function absfloor(arg0)
{
	return (arg0 > 0) ? floor(arg0) : ceil(arg0);
}

function rank_checker(arg0 = global.rank)
{
	var ranks = ["d", "c", "b", "a", "s", "p"];
	
	for (var i = 0; i < array_length(ranks); i++)
	{
		if (arg0 == ranks[i])
			return i;
	}
	
	return -4;
}

function string_extract(arg0, arg1, arg2)
{
	var len = string_length(arg1) - 1;
	
	repeat (arg2)
		arg0 = string_delete(arg0, 1, string_pos(arg1, arg0) + len);
	
	arg0 = string_delete(arg0, string_pos(arg1, arg0), string_length(arg0));
	return arg0;
}

function create_small_number(arg0, arg1, arg2, arg3 = 16777215)
{
	return instance_create(arg0, arg1, obj_smallnumber, 
	{
		image_blend: arg3,
		number: string(arg2)
	});
}

function array_get_any(arg0)
{
	return array_get(arg0, irandom_range(0, array_length(arg0) - 1));
}

function draw_sprite_ext_flash(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
{
	gpu_set_fog(true, arg7, 0, 1);
	draw_sprite_ext(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
	gpu_set_fog(false, c_black, 0, 0);
}

function draw_self_flash(arg0)
{
	draw_sprite_ext_flash(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, arg0, image_alpha);
}

function draw_sprite_ext_duotone(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
{
	shader_set(shd_afterimage);
	var color_blend_1 = shader_get_uniform(shd_afterimage, "blendcolor1");
	var color_blend_2 = shader_get_uniform(shd_afterimage, "blendcolor2");
	shader_set_uniform_f(color_blend_1, color_get_red(arg7) / 255, color_get_green(arg7) / 255, color_get_blue(arg7) / 255);
	shader_set_uniform_f(color_blend_2, color_get_red(arg8) / 255, color_get_green(arg8) / 255, color_get_blue(arg8) / 255);
	draw_sprite_ext(arg0, arg1, arg2, arg3, arg4, arg5, arg6, c_white, arg9);
	shader_reset();
}

function draw_self_duotone(arg0, arg1)
{
	draw_sprite_ext_duotone(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, arg0, arg1, image_alpha);
}

function time_in_frames(arg0, arg1)
{
	return ((arg0 * 60) + arg1) * 60;
}

function onBeat(arg0, arg1 = false)
{
	var bps = arg0 / 60;
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

function solid_in_line(arg0, arg1 = -4, arg2 = self)
{
	var _list = ds_list_create();
	var set_list = collision_line_list(x, y, arg0.x, arg0.y, obj_parent_collision, true, true, _list, true);
	
	if (set_list > 0)
	{
		for (var i = 0; i < set_list; i++)
		{
			var obj = ds_list_find_value(_list, i);
			
			if (arg1 != -4)
			{
				var found_obj = false;
				
				for (var b = 0; b < array_length(arg1); b++)
				{
					var arr = arg1[b];
					
					if (obj.object_index == arr)
						found_obj = true;
				}
				
				if (!found_obj)
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

function angle_rotate(arg0, arg1, arg2)
{
	var diff = wrap(arg1 - arg0, -180, 180);
	
	if (diff < -arg2)
		return arg0 - arg2;
	
	if (diff > arg2)
		return arg0 + arg2;
	
	return arg1;
}

function getFacingDirection(arg0, arg1)
{
	if (arg0 != arg1)
		return -sign(arg0 - arg1);
	
	return 1;
}

function number_in_range(arg0, arg1, arg2)
{
	return arg0 >= arg1 && arg0 <= arg2;
}

function parameter_get_array()
{
	var p_num = parameter_count();
	var p_string = [];
	
	if (p_num > 0)
	{
		for (var i = 0; i < p_num; i++)
			p_string[i] = parameter_string(i);
	}
	
	return p_string;
}

function round_nearest(arg0, arg1)
{
	var val = abs(arg1[0] - arg0);
	var ind = 0;
	
	for (var i = 1; i < array_length(arg1); i++)
	{
		var dist = abs(arg1[i] - arg0);
		
		if (dist < val)
		{
			ind = i;
			val = dist;
		}
	}
	
	return arg1[ind];
}

function randomize_animations(arg0)
{
	if (!variable_instance_exists(self, "saved_rand_anim"))
		saved_rand_anim = [];
	
	if (!variable_instance_exists(self, "rand_anim"))
		rand_anim = [];
	
	if (saved_rand_anim != arg0 || array_length(rand_anim) <= 0)
	{
		saved_rand_anim = arg0;
		rand_anim = array_shuffle(arg0);
	}
	
	return array_shift(rand_anim);
}

function array_clone(arg0)
{
	var temp_arr = [];
	array_copy(temp_arr, 0, arg0, 0, array_length(arg0));
	return temp_arr;
}
