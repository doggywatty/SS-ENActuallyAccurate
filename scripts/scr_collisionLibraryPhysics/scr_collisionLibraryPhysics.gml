#macro bbox_width (bbox_right - bbox_left)
#macro bbox_height (bbox_bottom - bbox_top)
function scr_collision_init()
{
    grounded = false;
    groundedSlope = false;
    terminalVelocity = 10;
    onMovingPlatform = -4;
    grav = 0;
    hsp = 0;
    vsp = 0;
    prevHsp = 0;
    prevVsp = 0;
    fracHsp = 0;
    fracVsp = 0;
    hspCarry = 0;
    vspCarry = 0;
    true_hsp = 0;
    true_vsp = 0;
    conveyorHsp = 0;
    useConveyorFlag = false;
    downSlope = true;
}

function scr_collision()
{
	var _old_grounded = grounded;
	grounded = false;
	groundedSlope = false;
	onMovingPlatform = -4;
	var conveyor_hsp = 0;
	if useConveyorFlag
		conveyor_hsp = conveyorHsp;
	
	useConveyorFlag = false;
	var true_hsp = hsp;
	var true_vsp = vsp;
	var final_hsp = hsp + hspCarry + conveyor_hsp;
	var final_vsp = vsp + vspCarry;
	hsp = absfloor(final_hsp);
	vsp = absfloor(final_vsp);
	var whole_integer = 0;
	fracHsp += (final_hsp - hsp);
	if (abs(fracHsp) >= 1)
	{
		whole_integer = absfloor(fracHsp);
		hsp += whole_integer;
		fracHsp -= whole_integer;
	}
	
	fracVsp += (final_vsp - vsp);
	if (abs(fracVsp) >= 1)
	{
		whole_integer = absfloor(fracVsp);
		vsp += whole_integer;
		fracVsp -= whole_integer;
	}
	
	var remaining_vsp = vsp;
	var move_steps = ceil(abs(vsp) / bbox_height);
	repeat move_steps
	{
		var move_vsp = clamp(abs(remaining_vsp), 0, bbox_bottom - bbox_top) * sign(remaining_vsp);
		if place_meeting_collision(x, y + move_vsp)
		{
			while !place_meeting_collision(x, y + sign(move_vsp))
				y += sign(move_vsp);
			move_vsp = 0;
			true_vsp = 0;
			fracVsp = 0;
			vsp = 0;
			break;
		}
		y += move_vsp;
		remaining_vsp -= move_vsp;
	}
	
	var remaining_hsp = hsp;
	move_steps = ceil(abs(hsp) / bbox_width);
	repeat move_steps
	{
		var move_hsp = clamp(abs(remaining_hsp), 0, bbox_right - bbox_left) * sign(remaining_hsp);
		var on_ground = place_meeting_collision(x, y + 1);
		if (place_meeting_collision(x + move_hsp, y))
		{
			repeat (abs(move_hsp))
			{
				y -= slope_check_up(x + sign(move_hsp), y);
				if !place_meeting_collision(x + sign(move_hsp), y)
					x += sign(move_hsp);
				else
				{
					move_hsp = 0;
					true_hsp = 0;
					remaining_hsp = 0;
					fracHsp = 0;
					hsp = 0;
					break;
				}
			}
			break;
		}
		
		x += move_hsp;
		if (downSlope && on_ground && vsp >= 0 && !place_meeting_collision(x, y + 1) && place_meeting_collision(x, y + abs(move_hsp) + 1))
		{
			while !place_meeting_collision(x, y + 1)
				y++;
		}
		remaining_hsp -= move_hsp;
	}
	
	hsp = true_hsp;
	vsp = true_vsp;
	hspCarry = 0;
	vspCarry = 0;
	if vsp < terminalVelocity
		vsp += grav;
	
	grounded = place_meeting_collision(x, y + 1);
	groundedSlope = place_meeting_slope(x, y + 1);
	if !grounded && _old_grounded && instance_exists(onMovingPlatform)
	{
		hspCarry = (onMovingPlatform.x - onMovingPlatform.xprevious) / 2;
		vspCarry = (onMovingPlatform.y - onMovingPlatform.yprevious) / 2;
	}
	prevHsp = hsp;
	prevVsp = vsp;
}

/// @desc Handles movement of object affected by MOVING PLATFORMS.
/// @param {any*} obj The ID of the object affected.
/// @param {any*} platform_id The ID of the MOVING platform.
/// @param {bool} [collisions] Toggles checking of collisions.
function kinematics_movingPlatforms(obj, platform_id, collisions = true)
{
	with platform_id
	{
		var _hsp = round(x - xprevious);
		var _vsp = round(y - yprevious);		
		if !collisions // Ignore Collisions
		{
			with obj
			{
				x += _hsp;
				y += _vsp;
			}
		}
		else // Collision Checks
		{
			with obj
			{
				repeat(abs(_hsp))
				{	
					if (!place_meeting_collision(x + sign(_hsp), y))
						x += sign(_hsp); 
					else
					{
						_hsp = 0;
						break;
					}
				}
				repeat(abs(_vsp))
				{	
					if (!place_meeting_collision(x, y + sign(_vsp)))
						y += sign(_vsp); 
					else
					{
						_vsp = 0;
						break;
					}
				}
			}
		}
	}
}

/// @desc Returns by how much (in pixel) upwards until a valid surface is found. Used in slope collisions.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {real} [max_units] The max amount of pixels to check.
/// @returns {real}
function slope_check_up(x_pos, y_pos, max_units = 2)
{
	// Move up slope
	for (var i = max_units; i > 0; --i)
	{
		var _check = true;
		var _z = (i - 1);
		repeat (i - 1)
		{
			if (!place_meeting_collision(x_pos, y_pos - _z)) {
				_check = false;
			}
			_z--;
		}
		if (place_meeting_collision(x_pos, y_pos) && _check && !place_meeting_collision(x_pos, y_pos - i)) {
			return i;
		}
	}
	return 0;	
}

/// @desc Returns by how much (in pixel) downwards until a valid surface is found. Used in slope collisions.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {real} [max_units] The max amount of pixels to check.
/// @returns {real}
function slope_check_down(x_pos, y_pos, max_units = 2)
{
	// Move down slope
	for (var i = 1; i < max_units + 1; ++i)
	{
		var _check = true;
		var _z = 1;
		repeat (i) {
			if (place_meeting_collision(x_pos, y_pos + _z)) {
				_check = false;
			}
			_z++;
		}			
		if (!place_meeting_collision(x_pos, y_pos) && _check && place_meeting_collision(x_pos, y_pos + (i + 1))) {
			return i;
		}
	}	
	return 0;	
}

/// @desc Returns by how much (in pixel) to the left until a valid surface is found. Used in slope collisions.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {real} [max_units] The max amount of pixels to check.
/// @returns {real}
function slope_check_left(x_pos, y_pos, max_units = 3)
{
	// Move to the left
	for (var i = 0; i < max_units; ++i)
	{
		if (place_meeting_collision(x_pos, y_pos) && !place_meeting_collision(x_pos - i, y_pos)) {
			return i;
		}
	}
	return 0;	
}

/// @desc Returns by how much (in pixel) to the right until a valid surface is found. Used in slope collisions.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {real} [max_units] The max amount of pixels to check.
/// @returns {real}
function slope_check_right(x_pos, y_pos, max_units = 3)
{
	// Move to the Right
	for (var i = 0; i < max_units; ++i)
	{
		if (place_meeting_collision(x_pos, y_pos) && !place_meeting_collision(x_pos + i, y_pos)) {
			return i;
		}
	}
	return 0;		
}	

/// @desc Returns by how much (in pixel) going down until a valid surface is found. Used in slope collisions.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {real} [max_units] The max amount of pixels to check.
/// @returns {real}
function reverseSlope_check_down(x_pos, y_pos, max_units = 3)
{
	// Move to the Bottom
	for (var i = 0; i < max_units; ++i)
	{
		if (place_meeting_collision(x_pos, y_pos) && !place_meeting_collision(x_pos, y_pos + i)) {
			return i;
		}
	}
	return 0;	
}

/// @desc Returns by how much (in pixel) going up until a valid surface is found. Used in slope collisions.
/// @param {any*} x The x position to check.
/// @param {any*} y The y position to check.
/// @param {real} [max_units] The max amount of pixels to check.
/// @returns {real}
function reverseSlope_check_up(x_pos, y_pos, max_units = 3)
{
	// Move to the Top
	for (var i = 0; i < max_units; ++i)
	{
		if (!place_meeting_collision(x_pos, y_pos) && !place_meeting_collision(x_pos, y_pos - i) && place_meeting_collision(x_pos, y_pos - (i + 1))) {
			return i;
		}		
	}
	return 0;		
}	
