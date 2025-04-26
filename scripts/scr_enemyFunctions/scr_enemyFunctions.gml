function scr_enemy_playerisnear(dist_left = 350, dist_up = 60, dist_right = dist_left, dist_down = dist_up, player = obj_player1, _x = x, _y = y)
{
	var rect_x1 = _x - dist_left;
	var rect_y1 = _y - dist_up;
	var rect_x2 = _x + dist_right;
	var rect_y2 = _y + dist_down;
	return point_in_rectangle(player.x, player.y, rect_x1, rect_y1, rect_x2, rect_y2);
}

function scr_enemy_grabUpdatePosition(_pos)
{
	image_xscale = -_pos.xscale;
	if (baddieStunTimer < 200)
		baddieStunTimer = 200;
	_pos.baddieGrabbedID = id;
	with _pos
	{
		if !global.freezeframe && state != States.frozen && state != States.grab
		&& state != States.finishingblow && state != States.charge && state != States.superslam
		{
			other.x = x;
			other.y = y;
			other.state = States.charge;
			other.image_index = 0;
		}
	}
	var player_state = global.freezeframe ? _pos.frozenState : _pos.state;
	if (player_state == States.grab)
	{
		var walk_bobbingy = 0;
		var walk_bobbingx = 0;
		if (_pos.sprite_index == _pos.spr_haulingWalk)
		{
			var yoffsets = [0, 2, 3, 9, 12, 0, -7, -6, -5, -3, 6, 5, 2];
			var xoffsets = [-4, -4, -3, -3, -2, -7, -10, -9, -8, -6, -3, -3, -3];
			walk_bobbingy = yoffsets[floor(_pos.image_index)];
			walk_bobbingx = xoffsets[floor(_pos.image_index)] * _pos.image_xscale;
		}
		var _yoff = -56 + walk_bobbingy;
		if (_pos.sprite_index == _pos.spr_haulingIntro)
		{
			var yoffsets = [-13, -35, -60, -55, -56];
			_yoff = yoffsets[floor(_pos.image_index)];
		}
		if (_pos.sprite_index == _pos.spr_haulingLand)
		{
			var yoffsets = [-31, -49, -53, -55];
			_yoff = yoffsets[floor(_pos.image_index)];
		}
		if (_pos.sprite_index == _pos.spr_haulingJump)
		{
			var yoffsets = [-22, -41, -62, -58];
			_yoff = yoffsets[floor(_pos.image_index)];
		}
		if (_pos.sprite_index == _pos.spr_haulingFall)
		{
			var yoffsets = [-58, -58, -58];
			_yoff = yoffsets[floor(_pos.image_index)];
		}
		y = _pos.y + _yoff;
		x = _pos.x + walk_bobbingx;
		image_xscale = -_pos.xscale;
	}
	if (player_state == States.charge)
	{
		x = _pos.x;
		switch (floor(_pos.image_index))
		{
			case 0:
			case 8:
				x += (_pos.xscale * 20);
				break;
			case 1:
			case 7:
				x += (_pos.xscale * 10);
				break;
			case 3:
			case 5:
				x += (_pos.xscale * -10);
				break;
			case 4:
				x += (_pos.xscale * -20);
				break;
		}
		y = _pos.y;
	}
	yscale = (player_state == States.superslam) ? -1 : 1;
	if (player_state == States.superslam)
	{
		if (_pos.sprite_index != _pos.spr_piledriverland)
		{
			x = _pos.x - (_pos.xscale * 10);
			y = _pos.y - 60;
		}
		else
		{
			x = _pos.x;
			y = _pos.y;
		}
	}
	if (player_state == States.finishingblow && state != States.climbwall)
	{
		x = _pos.x + (60 * _pos.xscale);
		y = _pos.y;
		scr_enemyFinishingBlowPos(_pos);
	}
}

function scr_enemyFinishingBlowPos(_pos)
{
	var _dist = abs(x - _pos.x);
	x = _pos.x;
	var try_x = 0;
	while !place_meeting_collision(x + _pos.xscale, y)
	{
		try_x++;
		if (try_x > _dist)
			break;
		x += _pos.xscale;
	}
}

function scr_enemy_turn_trigger()
{
	turnTimer = turnTimerMax;
	if !is_undefined(baddieSpriteTurn)
	{
		hsp = 0;
		image_index = 0;
		sprite_index = baddieSpriteTurn;
		state = States.normal;
	}
	else
	{
		image_xscale *= -1;
		hsp = 0;
		movespeed = 0;
	}
}

function scr_enemyDestroyableCheck(_xstart = xstart, _ystart = ystart)
{
	if place_meeting(_xstart, _ystart, obj_bigdestructibles)
	{
		xstart = _xstart;
		ystart = _ystart;
		state = States.machtumble;
		return true;
	}
	return false;
}

function scr_scareenemy()
{
	if global.freezeframe
		exit;
	var player_object = get_nearestPlayer();
	if (!jumpedFromBlock && scr_enemy_playerisnear(400, 130, undefined, 90, player_object)
	&& collision_line(x, y, player_object.x, player_object.y, obj_solid, false, true) == -4
	&& (player_object.state == States.mach3 || ((player_object.state == States.doughmount
	&& object_index != obj_fancypancake) && abs(movespeed) >= 12)
	|| player_object.state == States.doughmountspin || (player_object.movespeed >= 10
	&& player_object.state == States.minecart)))
	{
		if (state != States.run && state != States.climbwall && state != States.charge
		&& state != States.stun)
		{
			state = States.run;
			sprite_index = baddieSpriteScared;
			if chance(5)
				event_play_oneshot("event:/SFX/enemies/enemyrarescream", x, y);
			if (x != player_object.x)
				image_xscale = getFacingDirection(x, player_object.x);
			hsp = 0;
			if (vsp < 0)
				vsp = 0;
			if (grav != 0 && grounded)
				vsp = -3;
			image_index = 0;
		}
		var max_buf = 80;
		var min_buf = 50;
		baddieScareBuffer = 100;
	}
}
