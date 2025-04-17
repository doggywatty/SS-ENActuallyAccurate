function scr_slope(_checkSlope = false)
{
	return scr_slope_ext(x, y + 1, _checkSlope);
}

function scr_slope_ext(_x, _y, _checkSlopeExt = false)
{
	return place_meeting_slope(_x, _y, !_checkSlopeExt);
}

function scr_solid_slope(_x, _y)
{
	place_meeting_slopeSolid(_x, _y);
}

function slopeCheck(_x, _y)
{
	return scr_slope_ext(_x, _y + 1) && !scr_solid_slope(_x, _y + 1)
	&& !scr_solid_slope(_x, _y) && scr_slope_ext(_x, (_y - bbox_top) + bbox_bottom);
}

function scr_slopePlatform(_x, _y)
{
	place_meeting_slopePlatform(_x, _y);
}

function slopeMomentum_acceleration()
{
	if (place_meeting_slope(x, y + 1, false))
	{
		with instance_place(x, y + 1, obj_slope)
		{
			var slope_acceleration = abs(image_yscale) / abs(image_xscale);
			if (sign(image_xscale) >= 1)
				return -slope_acceleration;
			else
				return slope_acceleration;
		}
	}
	if (place_meeting_slopePlatform(x, y + 1))
	{
		with instance_place(x, y + 1, obj_slopePlatform)
		{
			var slope_acceleration = abs(image_yscale) / abs(image_xscale);
			if (sign(image_xscale) >= 1)
				return -slope_acceleration;
			else
				return slope_acceleration;
		}
	}
}

function slopeMomentum_direction()
{
	if (place_meeting_slope(x, y + 1, false))
	{
		with instance_place(x, y + 1, obj_slope)
			return sign(image_xscale);
	}
	if (place_meeting_slopePlatform(x, y + 1))
	{
		with instance_place(x, y + 1, obj_slopePlatform)
			return sign(image_xscale);
	}
	return -1;
}

function player_slopeMomentum(_up, _down = 0)
{
	var inst = instance_place(x, y + 1, obj_slopePlatform);
	if (instance_place(x, y + 1, obj_slope) != -4)
		inst = instance_place(x, y + 1, obj_slope);
	if (groundedSlope && inst != -4)
	{
		var _xscale = sign(inst.image_xscale);
		var slope_acceleration = abs(inst.image_yscale) / abs(inst.image_xscale);
		if (sign(image_xscale) == _xscale)
			movespeed -= (_down * slope_acceleration);
		else
			movespeed += (_up * slope_acceleration);
	}
}
