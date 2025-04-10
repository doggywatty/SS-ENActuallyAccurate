function state_player_frostburnnormal()
{
	jumpedOnce = false;
	doubleJumped = false;
	tripleJumped = false;
	momentum = false;
	move = key_left + key_right;
	hsp = xscale * movespeed;
	
	var top_speed = 8;
	if (move == xscale)
	{
		if (movespeed < top_speed)
			movespeed = approach(movespeed, top_speed, grounded ? 0.4 : 0.8);
	}
	else
		movespeed = approach(movespeed, 0, (move == -xscale) ? 1 : 0.4);
	if (movespeed <= 0 && (move == -xscale || sign(hsp) == -xscale))
	{
		if grounded
		{
			image_index = 0;
			sprite_index = spr_player_PZ_frostburn_turn;
			movespeed = 0;
			xscale *= -1;
		}
		else
		{
			movespeed = 0;
			xscale *= -1;
		}
	}
	
	if (sprite_index == spr_player_PZ_frostburn_turn && sprite_animation_end())
		sprite_index = spr_player_PZ_frostburn_walk_slow;
	if (sprite_index == spr_player_PZ_frostburn_jump && sprite_animation_end())
		sprite_index = spr_player_PZ_frostburn_fall;
	if (sprite_index == spr_player_PZ_frostburn_fall && grounded)
	{
		sprite_index = spr_player_PZ_frostburn_land;
		image_index = 0;
	}
	if (sprite_index == spr_player_PZ_frostburn_land && (sprite_animation_end() || move != 0))
		sprite_index = spr_player_PZ_frostburn_idle;
	if (sprite_index != spr_player_PZ_frostburn_turn && sprite_index != spr_player_PZ_frostburn_land && sprite_index != spr_player_PZ_frostburn_jump && grounded)
	{
		sprite_index = (move == 0) ? spr_player_PZ_frostburn_idle : spr_player_PZ_frostburn_walk_slow;
		if (sprite_index == spr_player_PZ_frostburn_walk_slow && movespeed >= top_speed)
			sprite_index = spr_player_PZ_frostburn_walk;
	}
	if (sprite_index != spr_player_PZ_frostburn_jump && !grounded)
		sprite_index = spr_player_PZ_frostburn_fall;
	if (inputBufferJump > 0 && can_jump)
	{
		inputBufferJump = 0;
		jumpStop = false;
		image_index = 0;
		sprite_index = spr_player_PZ_frostburn_jump;
		fmod_studio_event_instance_start(sndJump);
		instance_create(x, y, obj_highJumpCloud1, 
		{
			playerID: id
		});
		vsp = -10;
	}
	image_speed = 0.35;
}

function state_player_frostburnslide()
{
	momentum = false;
	hsp = xscale * movespeed;
	move = key_left + key_right;
	if (!key_jump2 && !jumpStop && vsp < 0.5 && !stompAnim)
	{
		vsp /= 2;
		jumpStop = true;
	}
	if (grounded && vsp > 0)
		jumpStop = false;
	if (key_jump2 && inputBufferJump > 0 && jumpedOnce == false)
	{
		vsp = -12;
		instance_create(x, y, obj_highJumpCloud1, 
		{
			playerID: id
		});
		fmod_studio_event_instance_start(sndJump);
		sprite_index = spr_player_PZ_frostburn_doubleJump_intro;
		image_index = 0;
		inputBufferJump = -1;
		jumpedOnce = true;
	}
	if (grounded && inputBufferJump == -1)
	{
		inputBufferJump = 0;
		jumpedOnce = false;
	}
	if (key_jump2 && inputBufferJump > 0 && !can_jump && !doubleJumped && !grounded && jumpedOnce == true)
	{
		jumpStop = true;
		doubleJumped = true;
		vsp = -14;
		image_index = 0;
		sprite_index = spr_player_PZ_frostburn_doubleJump_intro;
		with (instance_create(x, y, obj_highJumpCloud1, 
		{
			playerID: id
		}))
			image_xscale = other.xscale;
		fmod_studio_event_instance_start(sndJump);
		state = States.frostburnjump;
		movespeed = hsp;
	}
	if (grounded && movespeed < 14)
		player_slopeMomentum(0.25, 0);
	if ((sprite_index != spr_player_PZ_frostburn_doubleJump_intro && sprite_index != spr_player_PZ_frostburn_doubleJump) || (grounded && vsp > 0))
		sprite_index = spr_player_PZ_frostburn_walk;
	if (sprite_animation_end() && sprite_index == spr_player_PZ_frostburn_doubleJump_intro)
	{
		image_index = 0;
		sprite_index = spr_player_PZ_frostburn_doubleJump;
	}
	if (!grounded && vsp >= terminalVelocity)
	{
		movespeed = hsp;
		state = States.frostburnjump;
		flash = true;
		momentum = true;
		sprite_index = spr_player_PZ_frostburn_spin;
	}
	
	if (place_meeting_collision(x + sign(hsp), y, Exclude.SLOPES)
	&& !place_meeting(x + sign(hsp), y, obj_destructibles) && !place_meeting(x + sign(hsp), y, obj_chocofrog)
	&& !place_meeting(x + sign(hsp), y, obj_metalblock))
	{
		if !grounded
		{
			vsp = 0;
			image_index = 0;
			sprite_index = spr_player_PZ_frostburn_wallCling;
			state = States.frostburnstick;
			xscale = sign(hsp);
		}
		else
		{
			event_play_oneshot("event:/SFX/player/bumpwall", x, y);
			sprite_index = spr_player_PZ_frostburn_walk_fall;
			state = States.frostburnjump;
			vsp = -4;
			xscale = -sign(hsp);
			movespeed = xscale * 5;
			instance_create(x + (10 * xscale), y + 10, obj_bumpEffect);
		}
	}
	image_speed = 0.5;
}

function state_player_frostburnjump()
{
	static blue_aft = 0;
	if (sprite_index != spr_player_PZ_frostburn_spin && sprite_animation_end())
	{
		image_index = 0;
		switch sprite_index
		{
			case spr_player_PZ_frostburn_jump:
				sprite_index = spr_player_PZ_frostburn_fall;
				break;
			case spr_player_PZ_frostburn_doubleJump_intro:
				sprite_index = spr_player_PZ_frostburn_doubleJump;
				break;
			case spr_player_PZ_frostburn_wallJump_intro:
				sprite_index = spr_player_PZ_frostburn_wallJump;
				break;
		}
	}
	if (key_jump2 && inputBufferJump > 0 && !can_jump && !doubleJumped)
	{
		jumpStop = true;
		doubleJumped = true;
		vsp = -14;
		image_index = 0;
		sprite_index = spr_player_PZ_frostburn_doubleJump_intro;
		with (instance_create(x, y, obj_highJumpCloud1, 
		{
			playerID: id
		}))
			image_xscale = other.xscale;
		fmod_studio_event_instance_start(sndJump);
	}
	
	if (vsp >= terminalVelocity || sprite_index == spr_player_PZ_frostburn_spin || ((doubleJumped || sprite_index == spr_player_PZ_frostburn_wallJump || sprite_index == spr_player_PZ_frostburn_wallJump_intro) && vsp >= 1 && !tripleJumped))
	{
		jumpStop = true;
		if (sprite_index != spr_player_PZ_frostburn_spin)
		{
			flash = true;
			sprite_index = spr_player_PZ_frostburn_spin;
		}
		vsp += 0.5;
		vsp = min(vsp, 40);
		if !instance_exists(groundpoundEffect)
		{
			groundpoundEffect = instance_create(x, y + 32, obj_groundPoundEffect, 
			{
				playerID: id
			});
		}
		if (vsp > 17 && !instance_exists(obj_piledrivereffect) && !tripleJumped)
		{
			instance_create(x, y, obj_piledrivereffect, 
			{
				playerID: id
			});
		}
		blue_aft++;
		if (blue_aft >= 6)
		{
			create_afterimage(AfterImageType.mach3effect1, xscale);
			blue_aft = 0;
		}
		image_speed = clamp(floor(abs(vsp) / 20) * 0.5, 0, 0.5) + 0.4;
	}
	else
		image_speed = 0.35;
	
	hsp = movespeed;
	move = key_left + key_right;
	if (!key_jump2 && !jumpStop && vsp < 0.5 && !stompAnim)
	{
		vsp /= 2;
		jumpStop = true;
	}
	if (grounded && vsp > 0)
		jumpStop = false;
	if (move != 0)
		movespeed = approach(movespeed, move * 8, 0.65);
	else
		movespeed = approach(movespeed, 0, 0.65);
	
	if (place_meeting_collision(x + sign(hsp), y, Exclude.SLOPES))
	{
		if (key_jump2 && move != 0 && move == sign(hsp))
		{
			vsp = 0;
			image_index = 0;
			sprite_index = spr_player_PZ_frostburn_wallCling;
			state = States.frostburnstick;
			xscale = sign(hsp);
		}
		else
			movespeed = 0;
	}
	if (grounded && vsp > 0)
	{
		jumpedOnce = false;
		doubleJumped = false;
		tripleJumped = false;
		if (sprite_index == spr_player_PZ_frostburn_spin && !place_meeting(x, y + 1, obj_destructibles)
		&& !place_meeting(x, y + 1, obj_metalblock) && !place_meeting(x, y + 1, obj_chocofrog))
		{
			if (slopeCheck(x, y))
			{
				movespeed = 11;
				xscale = -slopeMomentum_direction();
				with (instance_create(x, y, obj_jumpdust))
					image_xscale = other.xscale;
				state = States.frostburnslide;
			}
			else
			{
				event_play_oneshot("event:/SFX/player/groundpound", x, y);
				image_index = 0;
				movespeed = 0;
				state = States.frostburnstick;
				jumpAnim = true;
				jumpStop = false;
				with obj_parent_enemy
				{
					if (bbox_in_camera(id, view_camera[0]) && grounded)
					{
						vsp = -7;
						hsp = 0;
					}
				}
				camera_shake_add(10, 30);
				combo = 0;
				instance_create(x, y, obj_landcloud);
				freefallstart = 0;
				image_index = 0;
				sprite_index = spr_player_PZ_frostburn_land_spin;
				flash = true;
			}
		}
		else if (sprite_index != spr_player_PZ_frostburn_spin)
		{
			if slopeCheck(x, y)
			{
				movespeed = 8;
				xscale = -slopeMomentum_direction();
				with (instance_create(x, y, obj_jumpdust))
					image_xscale = other.xscale;
				state = States.frostburnslide;
			}
			else
			{
				state = States.frostburnnormal;
				if (sign(hsp) != 0)
					xscale = sign(hsp);
				movespeed = abs(movespeed);
				hsp = xscale * movespeed;
			}
		}
	}
}

function state_player_frostburnstick()
{
	doubleJumped = false;
	tripleJumped = false;
	jumpStop = true;
	momentum = false;
	hsp = 0;
	vsp = 0;
	
	if (!place_meeting_collision(x + xscale, y, Exclude.SLOPES) && sprite_index == spr_player_PZ_frostburn_wallCling)
	{
		sprite_index = spr_player_PZ_frostburn_walk_fall;
		xscale *= -1;
		movespeed = xscale * 5;
		state = States.frostburnjump;
	}
	if sprite_animation_end()
	{
		if (sprite_index == spr_player_PZ_frostburn_wallCling)
		{
			sprite_index = spr_player_PZ_frostburn_wallJump_intro;
			image_index = 0;
			xscale *= -1;
			vsp = -13;
			movespeed = xscale * 10;
			state = States.frostburnjump;
		}
		else
		{
			state = States.frostburnnormal;
			sprite_index = spr_player_PZ_frostburn_idle;
			freeFallSmash = 0;
		}
	}
	image_speed = (sprite_index == spr_player_PZ_frostburn_wallCling) ? 0.5 : 0.35;
}
