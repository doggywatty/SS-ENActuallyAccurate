function scr_slopeanglenonplayer(_col, _arr1, _arr2 = 1)
{
	var array = 0;
	var checkside = -1;
	array[0] = _arr1;
	array[1] = _arr1;
	
	var _function = function(_x, _y)
	{
		return scr_solid(_x, _y) || (scr_slope_ext(_x, _y) && scr_slopePlatform(_x, _y));
	};
	
	for (var i = 0; i < 2; i++)
	{
		for (var height = sprite_get_bbox_bottom(mask_index) - sprite_get_bbox_top(mask_index), top = -4; top < height; top++)
		{
			array[i] = _arr1;
			var check_1 = _function(_col + (_arr2 * checkside), _arr1 + top);
			var check_2 = !_function(_col + (_arr2 * checkside), (_arr1 + top) - 1);
			if (check_1 && check_2)
			{
				var sex = (_arr1 + top) - 1;
				array[i] = sex;
				break;
			}
		}
		checkside = !checkside;
	}
	
	var pointer1 = array[0];
	var pointer2 = array[1];
	var _angle = 0;
	if (pointer1 != pointer2)
		_angle = point_direction(_col - _arr2, pointer1, _col + _arr2, pointer2);
	return _angle;
}

function scr_checkSlopeAngle()
{
	return scr_checkPositionSolidAngle(x, bbox_bottom, abs(x - bbox_left), abs(x - bbox_right) - 1, (bbox_bottom - bbox_top) / 2, -90, undefined, true);
}
