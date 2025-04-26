function scr_player_CottonDashSprites(_sprs)
{
	var drill_sprites = [
		spr_player_PZ_werecotton_drill_h, spr_player_PZ_werecotton_drill_dup,
		spr_player_PZ_werecotton_drill_up, spr_player_PZ_werecotton_drill_dup,
		spr_player_PZ_werecotton_drill_h, spr_player_PZ_werecotton_drill_ddown,
		spr_player_PZ_werecotton_drill_down, spr_player_PZ_werecotton_drill_ddown,
		spr_player_PZ_werecotton_drill_h
	];
	if (!place_meeting(x, y, obj_cottonsolid) && !savedCottonSolid)
	{
		if (sprite_index == spr_cottonDashIntro)
		{
			if sprite_animation_end()
				sprite_index = drill_sprites[_sprs];
		}
		else
			sprite_index = drill_sprites[_sprs];
		cottonDebrisTimer = 0;
	}
	else if (place_meeting(x, y, obj_cottonsolid))
	{
		sprite_index = spr_cottondrill;
		if (cottonDebrisTimer == 0)
		{
			with instance_create(x, y, obj_machDustEffect)
				sprite_index = spr_cottondrillfade;
			cottonDebrisTimer = 8;
		}
		if (cottonDebrisTimer > 0)
			cottonDebrisTimer--;
	}
}

function state_player_cottondig()
{
	static cotton_afterimage_timer = 6;
	
	hsp = lengthdir_x(movespeed, cottonDirection);
	vsp = lengthdir_y(movespeed, cottonDirection);
	move = key_right + key_left;
	move2 = key_down - key_up;
	bouncebackspeed = approach(bouncebackspeed, 0, 1);
	scr_player_CottonDashSprites(round(cottonDirection / 45));
	var target_xscale = sign(lengthdir_x(1, cottonDirection));
	xscale = (target_xscale != 0) ? target_xscale : xscale;
	if !place_meeting(x, y, obj_cottonsolid)
	{
		bouncebackspeed = 0;
		if (movespeed < 11)
			movespeed = approach(movespeed, 11, 0.5);
		cottonDashTimer--;
		if (inputBufferJump > 0)
		{
			if groundedCot || grounded
			{
				cottonJumped = 1;
				inputBufferJump = 0;
				vsp = -11;
				grav = 0.3;
				momentum = true;
				jumpStop = true;
				grav = 0.025;
				image_index = 0;
				sprite_index = spr_cottonDoubleJump;
				state = States.cotton;
				instance_create(x, y, obj_highJumpCloud1, 
				{
					playerID: id
				});
				event_play_oneshot("event:/SFX/cotton/doublejump", x, y);
				groundedCot = false;
				if grounded
					cottonHasDashed = false;
				exit;
			}
		}
	}
	else if place_meeting(x, y, obj_cottonsolid)
	{
		movespeed = approach(movespeed, 14, 0.5);
		var angle_diff = 0;
		if (move != 0 || move2 != 0)
			angle_diff = angle_difference(cottonDirection, point_direction(0, 0, move, move2));
		
		cottonDirection += (0.15 * -angle_diff);
		if (abs(angle_diff) > 90)
			movespeed = 11;
		
		cottonDirection = wrap(cottonDirection, 0, 360);
		if !savedCottonSolid
		{
			var rep = irandom_range(4, 6);
			repeat rep
				create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_cottondebris);
		}
		savedCottonSolid = true;
		cottonDashTimer = 0;
		groundedCot = true;
	}
	
	with obj_achievementTracker
	{
		var dt = delta_time / power(10, 6);
		cottonBlockTime += dt;
		if !other.savedCottonSolid
			cottonBlockTime = 0;
	}
	
	if (!savedCottonSolid && scr_solid(x + sign(hsp), y, true) && !place_meeting(x + sign(hsp), y, obj_destructibles))
	{
		var _ledge = snap_to_ledge();
		if !_ledge && !savedCottonSolid && !place_meeting(x + sign(hsp), y, obj_destructibles)
			cottonDashTimer = 0;
	}
	if (!savedCottonSolid && scr_solid(x, y + sign(vsp), false) && !place_meeting(x, y + sign(vsp), obj_destructibles))
	{
		var _ledge = 0;
		_ledge -= slope_check_left(x, y + sign(vsp), bbox_right - bbox_left);
		_ledge += slope_check_right(x, y + sign(vsp), bbox_right - bbox_left);
		var check_ledge_slide = sprite_index != spr_player_PZ_werecotton_drill_ddown || sign(xscale) == sign(_ledge);
		if _ledge != 0 && check_ledge_slide
		{
			if (!scr_solid(x, y + sign(vsp), true) && sprite_index == spr_player_PZ_werecotton_drill_down)
			{
				xscale = sign(_ledge);
				sprite_index = spr_player_PZ_werecotton_drill_ddown;
				hsp = (vsp / 2) * xscale;
				cottonDirection = point_direction(0, 0, xscale, 1);
			}
			x += _ledge;
			with obj_camera
				cameraXOffset = -_ledge;			
		}
		else if !savedCottonSolid && !place_meeting(x, y + sign(vsp), obj_destructibles)
			cottonDashTimer = 0;
	}
	if (cottonDashTimer <= 0 && !place_meeting(x, y, obj_cottonsolid))
	{
		bouncebackspeed = 0;
		cottonForceBump = 2;
		momentum = true;
		jumpStop = true;
		sprite_index = spr_cottonDashOut;
		image_index = 0;
		movespeed = abs(hsp);
		if savedCottonSolid
		{
			sprite_index = spr_player_PZ_werecotton_spin;
			var rep = irandom_range(4, 6);
			repeat rep
				create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_cottondebris);
			savedCottonSolid = false;
			cottonHasDashed = false;
			hsp = lengthdir_x(15, round(cottonDirection / 45) * 45);
			vsp = lengthdir_y(15, round(cottonDirection / 45) * 45);
			movespeed = 0;
			if (lengthdir_x(1, round(cottonDirection / 45) * 45) != 0)
			{
				if (round(cottonDirection / 45) <= 4)
					vsp = min(-8, vsp);
				movespeed = abs(hsp);
			}
		}
		state = States.cotton;
		dir = xscale;
	}
	
	cotton_afterimage_timer = max(cotton_afterimage_timer - 1, 0);
	if (cotton_afterimage_timer <= 0 && !place_meeting(x, y, obj_cottonsolid))
	{
		instance_create(x, y, obj_cottonAfterEffect, 
		{
			playerID: id
		});
		cotton_afterimage_timer = 6;
	}
}
