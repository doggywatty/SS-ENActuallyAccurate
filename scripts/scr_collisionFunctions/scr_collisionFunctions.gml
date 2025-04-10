/// @desc Checks the angle of the surface of the collided collision object.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {real} pdist_a Distance of Point A from the center point.
/// @param {real} pdist_b Distance of Point B from the center point.
/// @param {real} len Magnitude of the point to check.
/// @param {real} dir Direction of the point to check.
/// @param {real} [exclude] Using the EXCLUDE flags you can exclude types of objects. Ex: (Exclude.SLOPES|Exclude.PLATFORMS). You can also invert it like so: (~Exclude.MOVING).
/// @param {bool} [ukbool] I dunno....
/// @returns {real} Angle of the surface of the collided collision object.
function scr_checkPositionSolidAngle(x, y, pdist_a, pdist_b, len, dir, exclude = Exclude.NONE, ukbool = false)
{
	var point_a = 
	{
		x: x,
		y: y,
		xstart: x,
		ystart: y,
		targetX: x,
		targetY: y
	};
	var point_b = 
	{
		x: x,
		y: y,
		xstart: x,
		ystart: y,
		targetX: x,
		targetY: y
	};
	var _check = false;
	var _dist = pdist_a;
	while !_check
	{
		point_a.x = round(point_a.xstart + lengthdir_x(pdist_a, 90 + dir));
		point_a.y = round(point_a.ystart + lengthdir_y(pdist_a, 90 + dir));
		point_a.targetX = round(point_a.x + lengthdir_x(len, dir));
		point_a.targetY = round(point_a.y + lengthdir_y(len, dir));
		
		while (point_distance(point_a.x, point_a.y, point_a.targetX, point_a.targetY) > 0)
		{
			if (position_meeting_collision(point_a.x, point_a.y, exclude))
			{
				_check = true;
				break;
			}
			
			point_a.x += lengthdir_x(1, dir);
			point_a.y += lengthdir_y(1, dir);
			
			if (point_distance(point_a.x, 0, point_a.targetX, 0) <= 1)
				point_a.x = point_a.targetX;
			
			if (point_distance(0, point_a.y, 0, point_a.targetY) <= 1)
				point_a.y = point_a.targetY;
		}
		
		if (ukbool && pdist_a != -_dist && !_check)
			pdist_a = approach(pdist_a, -_dist, 1);
		else if !_check
		{
			point_a.x = point_a.xstart + lengthdir_x(_dist, 90 + dir);
			point_a.y = point_a.ystart + lengthdir_y(_dist, 90 + dir);
			point_a.targetX = round(point_a.x + lengthdir_x(len, dir));
			point_a.targetY = round(point_a.y + lengthdir_y(len, dir));
			_check = true;
		}
	}
	
	_check = false;
	_dist = pdist_b;
	
	while !_check
	{
		point_b.x = round(point_b.xstart + lengthdir_x(pdist_b, -90 + dir));
		point_b.y = round(point_b.ystart + lengthdir_y(pdist_b, -90 + dir));
		point_b.targetX = round(point_b.x + lengthdir_x(len, dir));
		point_b.targetY = round(point_b.y + lengthdir_y(len, dir));
		
		while (point_distance(point_b.x, point_b.y, point_b.targetX, point_b.targetY) > 0)
		{
			if (position_meeting_collision(point_b.x, point_b.y, exclude))
			{
				_check = true;
				break;
			}
			
			point_b.x += lengthdir_x(1, dir);
			point_b.y += lengthdir_y(1, dir);
			
			if (point_distance(point_b.x, 0, point_b.targetX, 0) <= 1)
				point_b.x = point_b.targetX;
			
			if (point_distance(0, point_b.y, 0, point_b.targetY) <= 1)
				point_b.y = point_b.targetY;
		}
		
		if (ukbool && pdist_b != -_dist && !_check)
			pdist_b = approach(pdist_b, -_dist, 1);
		else if !_check
		{
			point_b.x = point_b.xstart + lengthdir_x(_dist, -90 + dir);
			point_b.y = point_b.ystart + lengthdir_y(_dist, -90 + dir);
			point_b.targetX = round(point_b.x + lengthdir_x(len, dir));
			point_b.targetY = round(point_b.y + lengthdir_y(len, dir));
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
function triangle_meeting(sx, sy, x1, y1, x2, y2, x3, y3)
{
	var old_x = x;
	var old_y = y;
	x = sx;
	y = sy;
	var result = rectangle_in_triangle(bbox_left, bbox_top, bbox_right, bbox_bottom, x1, y1, x2, y2, x3, y3) > 0;
	x = old_x;
	y = old_y;
	return result;
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

function bbox_in_rectangle(sx1, dx1, dy1, dx2, dy2)
{
    if !instance_exists(sx1)
        return false;
    return rectangle_in_rectangle(sx1.bbox_left, sx1.bbox_top, sx1.bbox_right, sx1.bbox_bottom, dx1, dy1, dx2, dy2);
}

function place_meeting_adjacent(obj)
{
    return place_meeting(x, y, obj) || place_meeting(x - 1, y, obj)
	|| place_meeting(x + 1, y, obj) || place_meeting(x, y - 1, obj)
	|| place_meeting(x, y + 1, obj) || place_meeting(x - 1, y - 1, obj)
	|| place_meeting(x + 1, y - 1, obj) || place_meeting(x - 1, y + 1, obj)
	|| place_meeting(x + 1, y + 1, obj);
}

