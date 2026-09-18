function scr_enemy_playerisnear(arg0 = 350, arg1 = 60, arg2 = arg0, arg3 = arg1, arg4 = obj_player1, arg5 = x, arg6 = y)
{
	var rect_x1 = arg5 - arg0;
	var rect_y1 = arg6 - arg1;
	var rect_x2 = arg5 + arg2;
	var rect_y2 = arg6 + arg3;
	return point_in_rectangle(arg4.x, arg4.y, rect_x1, rect_y1, rect_x2, rect_y2);
}

function scr_enemy_grabUpdatePosition(arg0)
{
	image_xscale = -arg0.xscale;
	
	if (baddieStunTimer < 200)
		baddieStunTimer = 200;
	
	arg0.baddieGrabbedID = id;
	
	with (arg0)
	{
		if (!global.freezeframe && state != states.frozen && state != states.handstandjump && state != states.bossdefeat && state != states.slap && state != states.secondjump)
		{
			other.x = x;
			other.y = y;
			other.state = states.slap;
			other.image_index = 0;
		}
	}
	
	var player_state = global.freezeframe ? arg0.frozenState : arg0.state;
	
	if (player_state == states.handstandjump)
	{
		var walk_bobbingy = 0;
		var walk_bobbingx = 0;
		
		if (arg0.sprite_index == arg0.spr_haulingWalk)
		{
			var yoffsets = [0, 2, 3, 9, 12, 0, -7, -6, -5, -3, 6, 5, 2];
			var xoffsets = [-4, -4, -3, -3, -2, -7, -10, -9, -8, -6, -3, -3, -3];
			walk_bobbingy = yoffsets[floor(arg0.image_index)];
			walk_bobbingx = xoffsets[floor(arg0.image_index)] * arg0.image_xscale;
		}
		
		var _yoff = -56 + walk_bobbingy;
		
		if (arg0.sprite_index == arg0.spr_haulingIntro)
		{
			var yoffsets = [-13, -35, -60, -55, -56];
			_yoff = yoffsets[floor(arg0.image_index)];
		}
		
		if (arg0.sprite_index == arg0.spr_haulingLand)
		{
			var yoffsets = [-31, -49, -53, -55];
			_yoff = yoffsets[floor(arg0.image_index)];
		}
		
		if (arg0.sprite_index == arg0.spr_haulingJump)
		{
			var yoffsets = [-22, -41, -62, -58];
			_yoff = yoffsets[floor(arg0.image_index)];
		}
		
		if (arg0.sprite_index == arg0.spr_haulingFall)
		{
			var yoffsets = [-58, -58, -58];
			_yoff = yoffsets[floor(arg0.image_index)];
		}
		
		y = arg0.y + _yoff;
		x = arg0.x + walk_bobbingx;
		image_xscale = -arg0.xscale;
	}
	
	if (player_state == states.slap)
	{
		x = arg0.x;
		
		switch (floor(arg0.image_index))
		{
			case 0:
			case 8:
				x += (arg0.xscale * 20);
				break;
			case 1:
			case 7:
				x += (arg0.xscale * 10);
				break;
			case 3:
			case 5:
				x += (arg0.xscale * -10);
				break;
			case 4:
				x += (arg0.xscale * -20);
				break;
		}
		
		y = arg0.y;
	}
	
	yscale = (player_state == states.secondjump) ? -1 : 1;
	
	if (player_state == states.secondjump)
	{
		if (arg0.sprite_index != arg0.spr_piledriverland)
		{
			x = arg0.x - (arg0.xscale * 10);
			y = arg0.y - 60;
		}
		else
		{
			x = arg0.x;
			y = arg0.y;
		}
	}
	
	if (player_state == states.bossdefeat && state != states.cheesepep)
	{
		x = arg0.x + (60 * arg0.xscale);
		y = arg0.y;
		scr_enemyFinishingBlowPos(arg0);
	}
}

function scr_enemyFinishingBlowPos(arg0)
{
	var _dist = abs(x - arg0.x);
	x = arg0.x;
	var try_x = 0;
	
	while (!place_meeting_collision(x + arg0.xscale, y))
	{
		try_x++;
		
		if (try_x > _dist)
			break;
		
		x += arg0.xscale;
	}
}

function scr_enemy_turn_trigger()
{
	turnTimer = turnTimerMax;
	
	if (!is_undefined(baddieSpriteTurn))
	{
		hsp = 0;
		image_index = 0;
		sprite_index = baddieSpriteTurn;
		state = states.normal;
	}
	else
	{
		image_xscale *= -1;
		hsp = 0;
		movespeed = 0;
	}
}

function scr_enemyDestroyableCheck(arg0 = xstart, arg1 = ystart)
{
	if (place_meeting(arg0, arg1, obj_bigdestructibles))
	{
		xstart = arg0;
		ystart = arg1;
		state = states.cheesepepstick;
		return true;
	}
	
	return false;
}

function scr_scareenemy()
{
	if (global.freezeframe)
		exit;
	
	var player_object = get_nearestPlayer();
	
	if (!jumpedFromBlock && scr_enemy_playerisnear(400, 130, undefined, 90, player_object) && collision_line(x, y, player_object.x, player_object.y, obj_solid, false, true) == -4 && (player_object.state == states.shotgun || ((player_object.state == states.punch && object_index != obj_fancypancake) && abs(movespeed) >= 12) || player_object.state == states.backkick || (player_object.movespeed >= 10 && player_object.state == states.victory)))
	{
		if (state != states.Nhookshot && state != states.cheesepep && state != states.slap && state != states.charge)
		{
			state = states.Nhookshot;
			sprite_index = baddieSpriteScared;
			
			if (chance(5))
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
