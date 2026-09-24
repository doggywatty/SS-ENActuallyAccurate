// TODO: document
function scr_checkPositionSolidAngle(_x, _y, _offset_left, _offset_right, _max_dist, _direction, _filter = Exclude.NONE, _shrink_width = false)
{
    var point_a = 
    {
        x: _x,
        y: _y,
        xstart: _x,
        ystart: _y,
        targetX: _x,
        targetY: _y
    };
    var point_b = 
    {
        x: _x,
        y: _y,
        xstart: _x,
        ystart: _y,
        targetX: _x,
        targetY: _y
    };
    var _check = false;
    var _dist = _offset_left;
    
    while (!_check)
    {
        point_a.x = round(point_a.xstart + lengthdir_x(_offset_left, 90 + _direction));
        point_a.y = round(point_a.ystart + lengthdir_y(_offset_left, 90 + _direction));
        point_a.targetX = round(point_a.x + lengthdir_x(_max_dist, _direction));
        point_a.targetY = round(point_a.y + lengthdir_y(_max_dist, _direction));
        
        while (point_distance(point_a.x, point_a.y, point_a.targetX, point_a.targetY) > 0)
        {
            if (position_meeting_collision(point_a.x, point_a.y, _filter))
            {
                _check = true;
                break;
            }
            
            point_a.x += lengthdir_x(1, _direction);
            point_a.y += lengthdir_y(1, _direction);
            
            if (point_distance(point_a.x, 0, point_a.targetX, 0) <= 1)
                point_a.x = point_a.targetX;
            
            if (point_distance(0, point_a.y, 0, point_a.targetY) <= 1)
                point_a.y = point_a.targetY;
        }
        
        if (_shrink_width && _offset_left != -_dist && !_check)
        {
            _offset_left = approach(_offset_left, -_dist, 1);
        }
        else if (!_check)
        {
            point_a.x = point_a.xstart + lengthdir_x(_dist, 90 + _direction);
            point_a.y = point_a.ystart + lengthdir_y(_dist, 90 + _direction);
            point_a.targetX = round(point_a.x + lengthdir_x(_max_dist, _direction));
            point_a.targetY = round(point_a.y + lengthdir_y(_max_dist, _direction));
            _check = true;
        }
    }
    
    _check = false;
    _dist = _offset_right;
    
    while (!_check)
    {
        point_b.x = round(point_b.xstart + lengthdir_x(_offset_right, -90 + _direction));
        point_b.y = round(point_b.ystart + lengthdir_y(_offset_right, -90 + _direction));
        point_b.targetX = round(point_b.x + lengthdir_x(_max_dist, _direction));
        point_b.targetY = round(point_b.y + lengthdir_y(_max_dist, _direction));
        
        while (point_distance(point_b.x, point_b.y, point_b.targetX, point_b.targetY) > 0)
        {
            if (position_meeting_collision(point_b.x, point_b.y, _filter))
            {
                _check = true;
                break;
            }
            
            point_b.x += lengthdir_x(1, _direction);
            point_b.y += lengthdir_y(1, _direction);
            
            if (point_distance(point_b.x, 0, point_b.targetX, 0) <= 1)
                point_b.x = point_b.targetX;
            
            if (point_distance(0, point_b.y, 0, point_b.targetY) <= 1)
                point_b.y = point_b.targetY;
        }
        
        if (_shrink_width && _offset_right != -_dist && !_check)
        {
            _offset_right = approach(_offset_right, -_dist, 1);
        }
        else if (!_check)
        {
            point_b.x = point_b.xstart + lengthdir_x(_dist, -90 + _direction);
            point_b.y = point_b.ystart + lengthdir_y(_dist, -90 + _direction);
            point_b.targetX = round(point_b.x + lengthdir_x(_max_dist, _direction));
            point_b.targetY = round(point_b.y + lengthdir_y(_max_dist, _direction));
            _check = true;
        }
    }
    
    var _angle = point_direction(point_a.x, point_a.y, point_b.x, point_b.y) - 180;
    return _angle;
}

/// @desc Returns true if object collision collides with a given triangle
/// @param  {real} sx The x position to check for.
/// @param  {real} sy The y position to check for.
/// @param  {real} x1 x-coordinate of 1st point of triangle.
/// @param  {real} y1 y-coordinate of 1st point of triangle.
/// @param  {real} x2 x-coordinate of 2nd point of triangle.
/// @param  {real} y2 y-coordinate of 2nd point of triangle.
/// @param  {real} x3 x-coordinate of 3rd point of triangle.
/// @param  {real} y3 y-coordinate of 3rd point of triangle.
/// @returns {bool}

function triangle_meeting(sx, sy, x1, y1, x2, y2, x3, y3) {
	var old_x = x;
	var old_y = y;
	x = sx;
	y = sy;
	
	var result = (rectangle_in_triangle(bbox_left, bbox_top, bbox_right, bbox_bottom, x1, y1, x2, y2, x3, y3) > 0);
	x = old_x;
	y = old_y;	
	
	return result;
}

/// @function bbox_in_rectangle()
/// @description This function will check if an object's bounding box is in a rectangle's bounds.
function bbox_in_rectangle(obj, dx1, dy1, dx2, dy2) {	
	if (!instance_exists(obj)) {
		return false;
	}
	return rectangle_in_rectangle(obj.bbox_left, obj.bbox_top, obj.bbox_right, obj.bbox_bottom, dx1, dy1, dx2, dy2);
}

function conveyorBelt_hsp()
{
    if (place_meeting(x, y + 1, obj_conveyorBelt) && vsp >= 0 && grounded)
    {
        var rail_inst = instance_place(x, y + 1, obj_conveyorBelt);
        return rail_inst.movespeed * sign(rail_inst.image_xscale);
    }
    
    return 0;
}

function scr_conveyorBeltKinematics()
{
    useConveyorFlag = true;
}


/// @description Checks for collisions in the 8 pixels adjacent to the instance.
/// @param {object} obj The object to check for collisions with.
/// @returns {boolean} True if a collision is found, false otherwise.

function place_meeting_adjacent(obj) {
    // Check each adjacent pixel for a collision.
    return(    (place_meeting(x, y, obj)) // Ontop   
			|| (place_meeting(x - 1, y, obj))  // Left
			|| (place_meeting(x + 1, y, obj))  // Right
			|| (place_meeting(x, y - 1, obj))  // Top
			|| (place_meeting(x, y + 1, obj))  // Bottom
			|| (place_meeting(x - 1, y - 1, obj))  // Top-left
			|| (place_meeting(x + 1, y - 1, obj))  // Top-right
			|| (place_meeting(x - 1, y + 1, obj))  // Bottom-left
			|| (place_meeting(x + 1, y + 1, obj))); // Bottom-right
			
	// Forgive me, for I have sinned....
}

/// @description Checks for collisions in the 8 pixels adjacent to the instance.
/// @param {object} obj The object to check for collisions with.
/// @returns {boolean} True if a collision is found, false otherwise.

function place_meeting_collision_adjacent(exclude) {
    // Check each adjacent pixel for a collision.
    return(    (place_meeting_collision(x, y, exclude)) // Ontop   
			|| (place_meeting_collision(x - 1, y, exclude))  // Left
			|| (place_meeting_collision(x + 1, y, exclude))  // Right
			|| (place_meeting_collision(x, y - 1, exclude))  // Top
			|| (place_meeting_collision(x, y + 1, exclude))  // Bottom
			|| (place_meeting_collision(x - 1, y - 1, exclude))  // Top-left
			|| (place_meeting_collision(x + 1, y - 1, exclude))  // Top-right
			|| (place_meeting_collision(x - 1, y + 1, exclude))  // Bottom-left
			|| (place_meeting_collision(x + 1, y + 1, exclude))); // Bottom-right
			
	// Forgive me, for I have sinned....
}

/// @desc Check if a flag is set
/// @param flags The combined flags
/// @param flagToCheck The flag to check
function isCollisionFlagSet(flags, flagToCheck) {
    return (flags & flagToCheck) == flagToCheck;
}
