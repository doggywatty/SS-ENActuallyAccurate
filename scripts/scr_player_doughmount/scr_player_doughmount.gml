function state_player_doughmount()
{
	inputBuffer = max(inputBuffer - 1, 0);
	hsp = movespeed;
	move = key_left + key_right;
	image_speed = 0.35;
	scr_conveyorBeltKinematics();
	
	if (move != 0 && inputBuffer <= 0)
	{
		if (move == xscale)
			movespeed = approach(movespeed, xscale * 12, 0.65);
		else
			movespeed = approach(movespeed, 0, 0.45);
		if (movespeed != 0 && place_meeting_collision(x + sign(xscale), y, Exclude.SLOPES)
		&& !place_meeting(x + sign(xscale), y, obj_destructibles)
		&& !place_meeting(x + sign(xscale), y, obj_chocofrog))
		{
			inputBuffer = 5;
			movespeed = -(movespeed - (movespeed / 1.5));
			event_play_oneshot("event:/SFX/player/bumpwall", x, y);
			repeat 4
				instance_create(x, y, obj_slapstar);
		}
		if (abs(movespeed) < 3 && move != 0)
			image_speed = 0.35;
		else if (abs(movespeed) > 3 && abs(movespeed) < 6)
			image_speed = 0.45;
		else
			image_speed = 0.6;
	}
	else if (inputBuffer > 0 && grounded)
		movespeed = approach(movespeed, 0, 0.75);
	else
		movespeed = approach(movespeed, 0, 0.45);
	if (inputBufferJump > 0 && can_jump)
	{
		inputBufferJump = 0;
		vsp = -10;
		if (place_meeting(x, y, obj_kettle))
			vsp = -20;
	}
	
	if (grounded && sprite_index == spr_player_PZ_dogMount_inflate_fall)
		sprite_index = spr_player_PZ_dogMount;
	if (move == 0 && inputBuffer == 0 && sprite_index != spr_player_PZ_dogMount_skid && sprite_index != spr_player_PZ_dogMount_spin && sprite_index != spr_player_PZ_dogMount_inflate_fall && sprite_index != spr_player_PZ_dogMount_inflate_jump)
		sprite_index = spr_player_PZ_dogMount_idle;
	if (move != 0 && sprite_index != spr_player_PZ_dogMount_skid && sprite_index != spr_player_PZ_dogMount_spin && sprite_index != spr_player_PZ_dogMount_inflate_fall && sprite_index != spr_player_PZ_dogMount_inflate_jump)
		sprite_index = spr_player_PZ_dogMount;
	if (move != 0 && xscale != move)
	{
		xscale = move;
		if (sprite_index != spr_player_PZ_dogMount_inflate_jump && sprite_index != spr_player_PZ_dogMount_inflate_fall)
		{
			image_index = 0;
			sprite_index = spr_player_PZ_dogMount_skid;
		}
	}
	if (sprite_index == spr_player_PZ_dogMount_skid && sprite_animation_end())
		sprite_index = spr_player_PZ_dogMount;
	if (sprite_index == spr_player_PZ_dogMount_inflate_jump && sprite_animation_end())
		sprite_index = spr_player_PZ_dogMount_inflate_fall;
	if (inputBufferSlap > 0)
	{
		image_index = 0;
		inputBufferSlap = 0;
		sprite_index = spr_player_PZ_dogMount_spin;
		state = States.doughmountspin;
		movespeed = abs(movespeed);
		vsp = -5;
		movespeed = 12;
	}
}

function state_player_doughmountspin()
{
	if (inputBuffer > 0)
		inputBuffer--;
	if (movespeed > 18)
		movespeed = 18;
	
	hsp = movespeed * xscale;
	if (vsp > 0 && floor(image_index < 9))
		vsp = 2;
	if (sprite_animation_end() && sprite_index == spr_player_PZ_dogMount_spin)
	{
		image_index = 0;
		sprite_index = spr_player_PZ_dogMount;
		state = States.doughmount;
		movespeed *= xscale;
	}
	if (movespeed != 0 && place_meeting_collision(x + sign(xscale), y, Exclude.SLOPES)
	&& (!place_meeting(x + sign(xscale), y, obj_destructibles)
	&& !place_meeting(x + sign(xscale), y, obj_chocofrog)))
	{
		vsp = 2;
		inputBuffer = 5;
		event_play_oneshot("event:/SFX/player/bumpwall", x, y);
		repeat 4
			instance_create(x, y, obj_slapstar);
		image_index = 0;
		sprite_index = spr_player_PZ_dogMount;
		state = States.doughmount;
		movespeed *= xscale;
		movespeed = -(movespeed - (movespeed / 1.5));
	}
	image_speed = 0.6;
}

function state_player_doughmountjump()
{
}

function state_player_doughmountballoon()
{
	image_speed = 0.35;
	if (sprite_index == spr_player_PZ_dogMount_inflate && sprite_animation_end())
		sprite_index = spr_player_PZ_dogMount_inflated;
	move = key_right + key_left;
	hsp = movespeed;
	vsp = min(vsp + 0.1, 2);
	movespeed = approach(movespeed, move * 10, 0.5);
	if key_jump
	{
		sprite_index = spr_player_PZ_dogMount_inflate_jump;
		state = States.doughmount;
		vsp = -20;
		with instance_create(x, y, obj_puffEffect)
			sprite_index = spr_tornadocloud;
	}
}

function state_player_doughmountpancake()
{
	vsp = 0;
	hsp = movespeed * xscale;
	movespeed = approach(movespeed, 20, 0.15);
	sprite_index = spr_dogMount_meteor;
	if (place_meeting_collision(x + xscale, y, Exclude.SLOPES)
	&& !place_meeting(x + xscale, y, obj_destructibles) && !place_meeting(x + xscale, y, obj_chocofrog))
	{
		var test_y = 0;
		test_y -= slope_check_up(x + xscale, y, 32);
		test_y += slope_check_down(x + xscale, y, 3);
		if (test_y != 0)
			y += test_y;
		else
		{
			sprite_index = spr_player_PZ_dogMount_idle;
			state = States.doughmount;
			jumpStop = true;
			movespeed = 0;
		}
	}
	if !instance_exists(obj_chargeEffect) && sprite_index != spr_dive
	{
		instance_create(x, y, obj_chargeEffect, 
		{
			playerID: id
		});
	}
}
