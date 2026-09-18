function scr_slope(arg0 = false)
{
	return scr_slope_ext(x, y + 1, arg0);
}

function scr_slope_ext(arg0, arg1, arg2 = false)
{
	return place_meeting_slope(arg0, arg1, !arg2);
}

function scr_solid_slope(arg0, arg1)
{
	place_meeting_slopeSolid(arg0, arg1);
}

function slopeCheck(arg0, arg1)
{
	return scr_slope_ext(arg0, arg1 + 1) && !scr_solid_slope(arg0, arg1 + 1) && !scr_solid_slope(arg0, arg1) && scr_slope_ext(arg0, (arg1 - bbox_top) + bbox_bottom);
}

function scr_slopePlatform(arg0, arg1)
{
	place_meeting_slopePlatform(arg0, arg1);
}

function slopeMomentum_acceleration()
{
	if (place_meeting_slope(x, y + 1, false))
	{
		with (instance_place(x, y + 1, obj_slope))
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
		with (instance_place(x, y + 1, obj_slopePlatform))
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
		with (instance_place(x, y + 1, obj_slope))
			return sign(image_xscale);
	}
	
	if (place_meeting_slopePlatform(x, y + 1))
	{
		with (instance_place(x, y + 1, obj_slopePlatform))
			return sign(image_xscale);
	}
	
	return -1;
}

function player_slopeMomentum(arg0, arg1 = 0)
{
	var inst = instance_place(x, y + 1, obj_slopePlatform);
	
	if (instance_place(x, y + 1, obj_slope) != -4)
		inst = instance_place(x, y + 1, obj_slope);
	
	if (groundedSlope && inst != -4)
	{
		var _xscale = sign(inst.image_xscale);
		var slope_acceleration = abs(inst.image_yscale) / abs(inst.image_xscale);
		
		if (sign(image_xscale) == _xscale)
			movespeed -= (arg1 * slope_acceleration);
		else
			movespeed += (arg0 * slope_acceleration);
	}
}
