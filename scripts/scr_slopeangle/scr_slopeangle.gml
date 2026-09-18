function scr_slopeanglenonplayer(arg0, arg1, arg2 = 1)
{
	var array = 0;
	var checkside = -1;
	var height = sprite_get_bbox_bottom(mask_index) - sprite_get_bbox_top(mask_index);
	var top = -4;
	var i = 0;
	array[0] = arg1;
	array[1] = arg1;
	
	var _function = function(arg0, arg1)
	{
		return scr_solid(arg0, arg1) || (scr_slope_ext(arg0, arg1) && scr_slopePlatform(arg0, arg1));
	};
	
	while (i < 2)
	{
		while (top < height)
		{
			array[i] = arg1;
			var check_1 = _function(arg0 + (arg2 * checkside), arg1 + top);
			var check_2 = !_function(arg0 + (arg2 * checkside), (arg1 + top) - 1);
			
			if (check_1 && check_2)
			{
				var sex = (arg1 + top) - 1;
				array[i] = sex;
				break;
			}
			
			top++;
		}
		
		checkside = !checkside;
		i++;
	}
	
	var pointer1 = array[0];
	var pointer2 = array[1];
	var _angle = 0;
	
	if (pointer1 != pointer2)
		_angle = point_direction(arg0 - arg2, pointer1, arg0 + arg2, pointer2);
	
	return _angle;
}

function scr_checkSlopeAngle()
{
	return scr_checkPositionSolidAngle(x, bbox_bottom, abs(x - bbox_left), abs(x - bbox_right) - 1, (bbox_bottom - bbox_top) / 2, -90, undefined, true);
}
