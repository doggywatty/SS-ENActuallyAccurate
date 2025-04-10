function state_player_cotton()
{
	static cotton_afterimage_timer = 6;
	if (sprite_index == spr_cottonIntroLeft || sprite_index == spr_cottonIntroRight)
	{
		hsp = 0;
		vsp = 0;
		movespeed = 0;
		image_speed = 0.35;
		global.ComboFreeze = 15;
		if sprite_animation_end()
		{
			camera_shake_add(5, 10);
			xscale = targetxscale;
			image_index = 0;
			sprite_index = spr_cottonIntroScream;
		}
		exit;
	}
	if (sprite_index == spr_cottonIntroScream)
	{
		hsp = 0;
		vsp = 0;
		movespeed = 0;
		image_speed = 0.35;
		global.ComboFreeze = 15;
		if sprite_animation_end()
			sprite_index = spr_cottonIdle;
		exit;
	}
	
	move = key_left + key_right;
	move2 = key_down - key_up;
	hsp = xscale * movespeed;
	if (grounded && vsp >= 0)
	{
		momentum = false;
		cottonHasDashed = false;
		groundedCot = true;
	}
	
	if (move == xscale)
		movespeed = approach(movespeed, 9, (movespeed < 9) ? 0.85 : 0.5);
	else if (move == -xscale)
	{
		if (movespeed <= 0)
		{
			xscale = move;
			movespeed = 0;
		}
		movespeed = approach(movespeed, 0, 0.7);
	}
	else
		movespeed = approach(movespeed, 0, grounded ? 0.7 : 0.5);
	
	if (place_meeting_solid(x + xscale, y) && !place_meeting_slope(x + xscale, y))
	{
		if (movespeed < 10 && (place_meeting(x + xscale, y, obj_destructibles) || place_meeting(x + xscale, y, obj_chocofrog)))
			movespeed = 0;
		else if (!place_meeting(x + xscale, y, obj_destructibles) && !place_meeting(x + xscale, y, obj_chocofrog))
		{
			movespeed = 0;
			momentum = false;
		}
	}
	
	if (inputBufferJump > 0 && !place_meeting(x, y, obj_cottonsolid))
	{
		if groundedCot
		{
			cottonJumped = 1;
			inputBufferJump = 0;
			vsp = -12;
			grav = 0.025;
			image_index = 0;
			sprite_index = grounded ? spr_cottonJump : spr_cottonDoubleJump;
			instance_create(x, y, obj_highJumpCloud1, 
			{
				playerID: id
			});
			event_play_oneshot(grounded ? "event:/SFX/cotton/jump" : "event:/SFX/cotton/doublejump", x, y);
			if !grounded
				groundedCot = false;
		}
	}
	
	if (inputBufferSlap > 0 && (!cottonHasDashed || key_down))
	{
		inputBufferSlap = 0;
		image_index = 0;
		sprite_index = spr_cottonDashIntro;
		cottonHasDashed = true;
		cottonDirection = (xscale >= 1) ? 0 : 180;
		if (move != 0 || move2 != 0)
			cottonDirection = point_direction(0, 0, move, move2);
		cottonDirection = round(cottonDirection / 45) * 45;
		movespeed = max(10, movespeed);
		hsp = 0;
		vsp = 0;
		state = States.cottondig;
		cottonDashTimer = 30;
		grav = 0;
		grounded = false;
		event_play_oneshot("event:/SFX/cotton/attack", x, y);
	}
	
	if (vsp > 5 && !key_down)
		vsp -= 1;
	else
		vsp = min(vsp, 12);
	
	var sprite_transitions = [
		[spr_cottonDashOut, spr_cottonFall],
		[spr_cottonJump, spr_cottonFall],
		[spr_cottonDoubleJump, spr_cottonDoubleJumpFall]
	];
	if (!place_meeting(x, y, obj_cottonsolid))
	{
		for (var i = 0; i < array_length(sprite_transitions); i++)
		{
			if (sprite_index == sprite_transitions[i][0] && sprite_animation_end())
			{
				sprite_index = sprite_transitions[i][1];
				image_index = 0;
				break;
			}
		}
	}
	
	if (sprite_index == spr_cottonIdle && move != 0)
	{
		image_index = 0;
		sprite_index = spr_cottonWalk;
	}
	
	var move_sprites = [spr_cottonWalk];
	if (move == 0 && array_contains(move_sprites, sprite_index))
	{
		image_index = 0;
		sprite_index = spr_cottonIdle;
	}
	
	var jump_sprites = [
		spr_cottonJump, spr_cottonDoubleJump, spr_cottonFall,
		spr_cottonDoubleJumpFall, spr_player_PZ_werecotton_spin
	];
	if (grounded && vsp >= 0 && array_contains(jump_sprites, sprite_index))
	{
		sprite_index = (move == 0) ? spr_cottonLand : spr_cottonLandWalk;
		image_index = 0;
		cottonJumped = 0;
		instance_create(x, y, obj_landcloud);
		event_play_oneshot("event:/SFX/player/step", x, y);
	}
	
	var landing_transitions = [
		[spr_cottonLand, spr_cottonIdle],
		[spr_cottonLandWalk, spr_cottonWalk]
	];
	for (var i = 0; i < array_length(landing_transitions); i++)
	{
		if (sprite_index == landing_transitions[i][0] && sprite_animation_end())
		{
			sprite_index = landing_transitions[i][1];
			image_index = 0;
			break;
		}
	}
	
	var air_sprites = [
		spr_cottonJump, spr_cottonDoubleJump, spr_cottonDashOut, spr_player_PZ_werecotton_drill_h,
		spr_player_PZ_werecotton_drill_down, spr_player_PZ_werecotton_drill_up,
		spr_player_PZ_werecotton_drill_dup, spr_player_PZ_werecotton_drill_ddown,
		spr_player_PZ_werecotton_drill_up, spr_cottonFall, spr_cottonDoubleJumpFall,
		spr_player_PZ_werecotton_spin
	];
	if (!grounded && !array_contains(air_sprites, sprite_index))
		sprite_index = spr_cottonFall;
	if (state != States.cottondrill)
	{
		if (!key_jump2 && !jumpStop && vsp < 0.5)
		{
			vsp /= 20;
			jumpStop = true;
		}
		if (grounded && vsp > 0)
		{
			jumpStop = false;
			doubleJumped = false;
		}
	}
	
	if (sprite_index == spr_cottonWalk)
		image_speed = clamp((movespeed / 6) * 0.65, 0.35, 0.55);
	else
		image_speed = 0.35;
	
	if (sprite_index == spr_player_PZ_werecotton_spin && (place_meeting(x, y, obj_cottonsolid) || (place_meeting(x + hsp, y, obj_cottonsolid) && move == sign(hsp)) || (place_meeting(x, y + vsp, obj_cottonsolid) && move2 == sign(vsp))))
	{
		state = States.cottondig;
		sprite_index = spr_cottondrill;
		cottonDirection = point_direction(0, 0, hsp, vsp);
		movespeed = round(abs(point_distance(0, 0, hsp, vsp)));
		movespeed = max(12, movespeed);
		cottonDirection = round(cottonDirection / 45) * 45;
		var rep = irandom_range(4, 6);
		repeat rep
			create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_cottondebris);
		cottonDashTimer = 30;
		grav = 0.2;
		grounded = false;
	}
	if (sprite_animation_end() && sprite_index == spr_player_PZ_werecotton_spin)
		sprite_index = spr_player_PZ_werecotton_fall;
	
	cotton_afterimage_timer = max(cotton_afterimage_timer - 1, 0);
	if (cotton_afterimage_timer <= 0 && sprite_index == spr_player_PZ_werecotton_spin)
	{
		instance_create(x, y, obj_cottonAfterEffect, 
		{
			playerID: id
		});
		cotton_afterimage_timer = 6;
	}
}
