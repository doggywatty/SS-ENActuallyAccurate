function gate_createlayer(_spr, _img_ind, Hsp = 0, Vsp = 0, _img_spd = 0)
{
	var w = sprite_get_width(_spr);
	var h = sprite_get_height(_spr);
	var x1 = sprite_get_xoffset(_spr);
	var y1 = sprite_get_yoffset(_spr);
	return 
	{
		sprite_index: _spr,
		image_index: _img_ind,
		image_xscale: 1,
		image_yscale: 1,
		image_speed: _img_spd,
		image_alpha: 1,
		image_blend: c_white,
		image_angle: 0,
		x: 0,
		y: 0,
		xstart: 0,
		ystart: h,
		hspeed: Hsp,
		vspeed: Vsp,
		readjust: false,
		dbg: false,
		func: -4
	};
}

function default_gate_scroll(_spr)
{
	var length = sprite_get_number(_spr);
	var arr = [];
	var debug_arr = [];
	for (var i = length; i > 0; i--)
	{
		var pct = lerp(-0.5, -0.85, i / length);
		array_push(arr, gate_createlayer(_spr, i - 1, pct));
		array_push(debug_arr, i - 1);
	}
	return arr;
}

function default_gate_parallax(_spr_parallax)
{
	var length = sprite_get_number(_spr_parallax);
	var arr = [];
	var xoffset = x;
	var yoffset = y - (sprite_height / 2);
	for (var i = length; i > 0; i--)
	{
		var pct = lerp(0.15, 0.05, i / length);
		var g = gate_createlayer(_spr_parallax, i - 1, pct, pct);
		with g
		{
			xoff = xoffset;
			yoff = yoffset;
			func = function()
			{
				x = ((camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2)) - xoff) * hspeed;
				y = ((camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2)) - yoff) * vspeed;
			};
		}
		array_push(arr, g);
	}
	trace(arr);
	return arr;
}
