global.MyCollisionList = ds_list_create();

/// @desc With this function you can check a place for collision objects. 
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {ID.DsList} list The DS list to use to store the IDs of colliding platforms.
/// @param {real} [exclude] Using the EXLCUDE flags you can exclude types of objects. Ex: (Exclude.SLOPES|Exclude.PLATFORMS). You can also invert it like so: (~Exclude.MOVING).
/// @returns {real} The number of instances found to be in collision.
function instance_place_list_collision(xx, yy, exclude = Exclude.NONE, list = undefined) {
	var collided = 0;
	// Exclude specific types of collisions
	var check_slopes = !isCollisionFlagSet(exclude, Exclude.SLOPES),
		check_solids = !isCollisionFlagSet(exclude, Exclude.SOLIDS),
		check_platforms = !isCollisionFlagSet(exclude, Exclude.PLATFORMS),
		check_moving = !isCollisionFlagSet(exclude, Exclude.MOVING);

	
	if (check_solids) { // Basic Solid Collisions and Backside of Slopes
		collided += instance_place_list_solid(xx, yy, undefined, list);
		collided += instance_place_list_slopeSolid(xx, yy, undefined, list);
	}
	
	if (check_slopes) { // Sloped Collisions
		if (check_solids) {
			collided += instance_place_list_slope(xx, yy, undefined, list);
		}
		
		if (check_platforms) {
			collided += instance_place_list_slopePlatform(xx, yy, undefined, list);		
		}
	}
	if (check_platforms) { // Semisolid Collisions
		collided += instance_place_list_platform(xx, yy, undefined, list);
		collided += instance_place_list_sidePlatform(xx, yy, undefined, list);
	}
	if (check_moving) { // Moving Platforms
		collided += instance_place_list_platform(xx, yy, obj_movingPlatform, list);
	}
	return collided;
}

/// @desc With this function you can check a place for collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {real} [exclude] Using the EXLCUDE flags you can exclude types of objects. Ex: (Exclude.SLOPES|Exclude.PLATFORMS). You can also invert it like so: (~Exclude.MOVING).
/// @returns {bool}
function place_meeting_collision(xx, yy, exclude = Exclude.NONE) {
	// Exclude specific types of collisions
	var 
	check_slopes = Exclude.SLOPES&exclude != Exclude.SLOPES,
	check_solids = Exclude.SOLIDS&exclude != Exclude.SOLIDS,
	check_platforms = Exclude.PLATFORMS&exclude != Exclude.PLATFORMS,
	check_moving = Exclude.MOVING&exclude != Exclude.MOVING;

	
	if (check_solids) { // Basic Solid Collisions and Backside of Slopes
		if (place_meeting_solid(xx, yy)) { // Basic Solids			
			return true;
		}		

		if (place_meeting_slopeSolid(xx, yy)) { // Slope Backsides
			return true;
		}		
	}
	
	if (check_slopes) { // Sloped Collisions
		
		if (check_solids) {
			if (place_meeting_slope(xx, yy, false)) { // Basic Slope Collisions
				return true;
			}
		}
		
		if (check_platforms) {
			if (place_meeting_slopePlatform(xx, yy)) { // Sloped Semisolid Collisions
				return true;
			}			
		}
	}
	if (check_platforms) { // Semisolid Collisions
		if (place_meeting_platform(xx, yy)) {
			return true;
		}
		if (place_meeting_sidePlatform(xx, yy)) {
			return true;
		}
	}
	/*if (check_moving) { // Moving Platforms
		if (place_meeting_movingPlatform(xx, yy)) {
			return true;
		}
	}*/
	return false;
}	

/// @desc With this function you can check a position for collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {real} [exclude] Using the EXLCUDE flags you can exclude types of objects. Ex: (Exclude.SLOPES|Exclude.PLATFORMS). You can also invert it like so: (~Exclude.MOVING).
/// @returns {bool}
function position_meeting_collision(xx, yy, exclude = Exclude.NONE)
{
	var old_mask = mask_index;
		mask_index = spr_pixel;
	var check_collision = (place_meeting_collision(xx, yy, exclude));	
		mask_index = old_mask;
	return check_collision;	
}	

/// @desc With this function you can check a place for basic solid collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {Asset.GMObject|Id.Instance} [obj] The object to check for. (Optional)
/// @param {ID.DsList} [list] The DS list to use to store the IDs of colliding solids. (Optional)
/// @returns {real} The number of instances found to be in collision.
function instance_place_list_solid(xx, yy, obj = obj_solid, list = undefined)
{
    var collided = 0;
    var col_number = instance_place_list(xx, yy, obj, global.MyCollisionList, false);
    if (col_number > 0)
    {
        for (var i = 0; i < col_number; i++)
        {
            var col_object = ds_list_find_value(global.MyCollisionList, i);
            var special_colcheck = true;
            if (variable_instance_exists(col_object, "canCollide"))
                special_colcheck = col_object.canCollide(col_object, id);
            if special_colcheck
            {
                collided++;
                if !is_undefined(list)
                    ds_list_add(list, col_object.id);
                else
                    break;
            }
        }
        ds_list_clear(global.MyCollisionList);
    }
    return collided;
}

/// @desc With this function you can check a place for basic solid collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {Asset.GMObject|Id.Instance} [obj] The object to check for. (Optional)
/// @returns {bool}
function place_meeting_solid(xx, yy, obj = obj_solid)
{
	return (instance_place_list_solid(xx, yy, obj) > 0);
}

/// @desc With this function you can check a position for basic solid collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {Asset.GMObject|Id.Instance} [obj] The object to check for. (Optional)
/// @returns {bool}
function position_meeting_solid(xx, yy, obj = obj_solid)
{
	var old_mask = mask_index;
		mask_index = spr_pixel;
	var check_collision = (instance_place_list_solid(xx, yy, obj) > 0);
		mask_index = old_mask;
	return check_collision;
}

/// @desc With this function you can check a place for platform collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {Asset.GMObject|Id.Instance} [obj] The object to check for. (Optional)
/// @param {ID.DsList} [list] The DS list to use to store the IDs of colliding platforms. (Optional)
/// @returns {real} The number of instances found to be in collision.
function instance_place_list_platform(xx, yy, obj = obj_platform, list = undefined)
{   
    var collided = 0;
    var col_number = instance_place_list(xx, yy, obj, global.MyCollisionList, false);
    if (col_number > 0)
    {
        for (var i = 0; i < col_number; i++)
        {
            var col_object = ds_list_find_value(global.MyCollisionList, i);
            var special_colcheck = true;
            if variable_instance_exists(col_object, "canCollide")
                special_colcheck = col_object.canCollide(col_object, id);
            
            var platform_check = (sign(col_object.image_yscale) <= -1) ? (yy <= y) : (yy >= y);
            if (special_colcheck && platform_check && !place_meeting(xx, y, col_object))
            {
                collided++;
                if !is_undefined(list)
                    ds_list_add(list, col_object.id);
                else
                    break;
            }
        }
        ds_list_clear(global.MyCollisionList);
    }
    return collided;
}

/// @desc With this function you can check a place for side platform collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {Asset.GMObject|Id.Instance} [obj] The object to check for. (Optional)
/// @param {ID.DsList} [list] The DS list to use to store the IDs of colliding platforms. (Optional)
/// @returns {real} The number of instances found to be in collision.
function instance_place_list_sidePlatform(xx, yy, obj = obj_sidePlatform, list = undefined)
{
	var collided = 0;
	var col_number = instance_place_list(xx, yy, obj, global.MyCollisionList, false);
	if col_number > 0
	{
		for (var i = 0; i < col_number; i++)
		{
			var col_object = ds_list_find_value(global.MyCollisionList, i);
			var special_colcheck = true;
			if variable_instance_exists(col_object, "canCollide")
				special_colcheck = col_object.canCollide(col_object, id);
			
			var s_platform_check = (sign(col_object.image_xscale) < 0) ? (xx >= x) : (xx <= x);
			if special_colcheck && s_platform_check && !place_meeting(x, yy, col_object)
			{
				collided++;
				if !is_undefined(list)
					ds_list_add(list, col_object.id);
				else
					break;
			}
		}
		ds_list_clear(global.MyCollisionList);
	}
	return collided;
}

/// @desc With this function you can check a place for platform collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {Asset.GMObject|Id.Instance} [obj] The object to check for. (Optional)
/// @returns {bool}
function place_meeting_platform(xx, yy, obj = obj_platform)
{
	return (instance_place_list_platform(xx, yy, obj) > 0);
}

/// @desc With this function you can check a position for platform collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {Asset.GMObject|Id.Instance} [obj] The object to check for. (Optional)
/// @returns {bool}
function position_meeting_platform(xx, yy, obj = obj_platform)
{
	var old_mask = mask_index;
		mask_index = spr_pixel;
	var check_collision = (instance_place_list_platform(xx, yy, obj) > 0);
		mask_index = old_mask;
	return check_collision;
}	

/// @desc With this function you can check a place for side platform collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {Asset.GMObject|Id.Instance} [obj] The object to check for. (Optional)
/// @returns {bool}
function place_meeting_sidePlatform(xx, yy, obj = obj_sidePlatform)
{
	return (instance_place_list_sidePlatform(xx, yy, obj) > 0);
}

/// @desc With this function you can check a position for side platform collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {Asset.GMObject|Id.Instance} [obj] The object to check for. (Optional)
/// @returns {bool}
function position_meeting_sidePlatform(xx, yy, obj = obj_sidePlatform)
{
	var old_mask = mask_index;
		mask_index = spr_pixel;
	var check_collision = (instance_place_list_sidePlatform(xx, yy, obj) > 0);
		mask_index = old_mask;
	return check_collision;
}	

/// @desc With this function you can check a place for sloped platform collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {Asset.GMObject|Id.Instance} [obj] The object to check for. (Optional)
/// @param {ID.DsList} [list] The DS list to use to store the IDs of colliding sloped platforms. (Optional)
/// @returns {real} The number of instances found to be in collision.
function instance_place_list_slopePlatform(xx, yy, _exclude = obj_slopePlatform, list = undefined)
{
	var old_x = x;
	var old_y = y;
	var old_bbox_top = bbox_top;
	var old_bbox_bottom = bbox_bottom;
	x = xx;
	y = yy;
	var collided = 0;
	var slopeplatform_number = instance_place_list(x, y, _exclude, global.MyCollisionList, false);
	if (slopeplatform_number > 0)
	{
		for (var i = 0; i < slopeplatform_number; i++)
		{
			var col_object = ds_list_find_value(global.MyCollisionList, i);
			var _can_collide = true;
			if (variable_instance_exists(col_object, "canCollide"))
				_can_collide = col_object.canCollide(col_object, id);
			if (_can_collide)
			{
				var object_side = (col_object.image_xscale > 0) ? bbox_right : bbox_left;
				object_side = (object_side - x) + old_x;
				var player_pos = point_direction(col_object.x + col_object.sprite_width, col_object.y + col_object.sprite_height, x, y);
				var _xx = col_object.x + sign(col_object.image_xscale);
				var _yy = col_object.y;
				var w = col_object.sprite_width;
				var h = col_object.sprite_height;
				var _check1;
				if (col_object.image_yscale > 0)
					_check1 = (col_object.image_xscale > 0) ? (player_pos <= 180 && player_pos >= 90) : (player_pos <= 90 && player_pos >= 0);
				else
					_check1 = (col_object.image_xscale > 0) ? (player_pos <= 270 && player_pos >= 180) : ((player_pos <= 360 || player_pos <= 0) && player_pos >= 270);
				var _check2 = !triangle_meeting(old_x, old_y, _xx, _yy + h, _xx + w, _yy, _xx + w, _yy + h);
				var _check3 = (col_object.image_xscale > 0) ? (object_side <= col_object.bbox_left) : (object_side >= col_object.bbox_right);
				if (_check1 && (_check2 || _check3) && ((col_object.image_yscale > 0)
				? (old_bbox_bottom <= col_object.bbox_bottom) : (old_bbox_top >= col_object.bbox_top))
				&& triangle_meeting(x, y, _xx, _yy + h, _xx + w, _yy, _xx + w, _yy + h))
				{
					collided++;
					if (!is_undefined(list))
						ds_list_add(list, col_object.id);
					else
						break;
				}
			}
		}
		ds_list_clear(global.MyCollisionList);
	}
	x = old_x;
	y = old_y;
	return collided;
}

/// @desc With this function you can check a place for sloped platform collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {Asset.GMObject|Id.Instance} [obj] The object to check for. (Optional)
/// @returns {bool}
function place_meeting_slopePlatform(xx, yy, obj = obj_slopePlatform)
{
	return (instance_place_list_slopePlatform(xx, yy, obj) > 0);
}

/// @desc With this function you can check a position for sloped platform collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {Asset.GMObject|Id.Instance} [obj] The object to check for. (Optional)
/// @returns {bool}
function position_meeting_slopePlatform(xx, yy, obj = obj_slopePlatform)
{
	var old_mask = mask_index;
		mask_index = spr_pixel;
	var check_collision = (instance_place_list_slopePlatform(xx, yy, obj) > 0);
		mask_index = old_mask;
	return check_collision;
}		

/// @desc With this function you can check a place for slope collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {Asset.GMObject*}{Id.Instance*} [obj] The object to check for. (Optional)
/// @param {ID.DsList} [list] The DS list to use to store the IDs of colliding slopes. (Optional)
/// @returns {real} The number of instances found to be in collision.
function instance_place_list_slope(xpos, ypos, _object = obj_slope, list = undefined)
{
	var collided = 0;
	var col_number = instance_place_list(xpos, ypos, _object, global.MyCollisionList, false);
	if col_number > 0
	{
		for (var i = 0; i < col_number; i++)
		{
			var col_object = ds_list_find_value(global.MyCollisionList, i);
			var special_colcheck = true;
			if variable_instance_exists(col_object, "canCollide")
				special_colcheck = col_object.canCollide(col_object, id);
			var _xx = col_object.x + sign(col_object.image_xscale);
			var _yy = col_object.y;
			var w = col_object.sprite_width;
			var h = col_object.sprite_height;
			if (special_colcheck && triangle_meeting(xpos, ypos, _xx, _yy + h, _xx + w, _yy, _xx + w, _yy + h))
			{
				collided++;
				if !is_undefined(list)
					ds_list_add(list, col_object.id);
				else
					break;
			}
		}
		ds_list_clear(global.MyCollisionList);
	}
	return collided;
}

/// @desc With this function you can check a place for slope collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {bool} [check_slopePlatform] Toggle to check for Sloped Platforms.
/// @param {Asset.GMObject*}{Id.Instance*} [obj] The object to check for. (Optional)
/// @returns {bool}
function place_meeting_slope(xx, yy, check_slopePlatform = true, obj = obj_slope)
{
	var _check2 = (check_slopePlatform ? place_meeting_slopePlatform(xx, yy) : false);
	return (instance_place_list_slope(xx, yy, obj) > 0 || _check2);
}

/// @desc With this function you can check a position for slope collision objects.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {Asset.GMObject*}{Id.Instance*} [obj] The object to check for. (Optional)
/// @returns {bool}
function position_meeting_slope(xx, yy, obj = obj_slope)
{
	var old_mask = mask_index;
		mask_index = spr_pixel;
	var check_collision = (instance_place_list_slope(xx, yy, obj) > 0);
		mask_index = old_mask;
	return check_collision;
}	

/// @desc With this function you can check a place for a collision with slope's backside.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {Asset.GMObject*}{Id.Instance*} [obj] The object to check for. (Optional)
/// @param {ID.DsList} [list] The DS list to use to store the IDs of colliding slopes. (Optional)
/// @returns {real} The number of instances found to be in collision.
function instance_place_list_slopeSolid(xx, yy, obj = obj_slope, list = undefined)
{
	var collided = 0;
	var col_number = instance_place_list(xx, yy, obj, global.MyCollisionList, false);
	if col_number > 0
	{
		for (var i = 0; i < col_number; i++)
		{
			var col_object = ds_list_find_value(global.MyCollisionList, i);
			var special_colcheck = true;
			if variable_instance_exists(col_object, "canCollide")
				special_colcheck = col_object.canCollide(col_object, id);
			var check_dir = xx - x;
			var check_1 = sign(col_object.image_xscale) == -check_dir;
			var check_2 = (col_object.image_yscale < 0) ? (bbox_bottom <= col_object.bbox_top) : (bbox_top >= col_object.bbox_bottom);
			var _xx = col_object.x + sign(col_object.image_xscale);
			var _yy = col_object.y;
			var w = col_object.sprite_width;
			var h = col_object.sprite_height;
			if (special_colcheck && (check_1 || check_2)
			&& triangle_meeting(xx, yy, _xx, _yy + h, _xx + w, _yy, _xx + w, _yy + h))
			{
				collided++;
				if !is_undefined(list)
					ds_list_add(list, col_object.id);
				else
					break;
			}
		}
		ds_list_clear(global.MyCollisionList);
	}
	return collided;
}

/// @desc With this function you can check a place for a collision with slope's backside.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {Asset.GMObject*}{Id.Instance*} [obj] The object to check for. (Optional)
/// @returns {bool}
function place_meeting_slopeSolid(xx, yy, obj = obj_slope)
{
	return (instance_place_list_slopeSolid(xx, yy, obj) > 0);
}

/// @desc With this function you can check a position for a collision with slope's backside.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {Asset.GMObject*}{Id.Instance*} [obj] The object to check for. (Optional)
/// @returns {bool}
function position_meeting_slopeSolid(xx, yy, obj = obj_slope)
{
	var old_mask = mask_index;
		mask_index = spr_pixel;
	var check_collision = (instance_place_list_slopeSolid(xx, yy, obj) > 0);
		mask_index = old_mask;
	return check_collision;
}		

