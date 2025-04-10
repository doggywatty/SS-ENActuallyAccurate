function state_player_normal()
{
	static breakdance_effect = 10;
	var idle_sprites = [spr_idle1, spr_idle2, spr_idle3, spr_idle4, spr_idle5, spr_idle6];
	
	if (dir != xscale)
	{
		dir = xscale;
		movespeed = 2;
	}
	
	machTwo = 0;
	move = key_left + key_right;
	hsp = move * movespeed;
	scr_conveyorBeltKinematics();
	
	var _idle_spr = spr_idle;
	var _move_spr = spr_move;
	var _dontidle = false;
	var _dontStep = false;
	
	if (global.InternalLevelName == "fudge")
	{
		_idle_spr = spr_player_PZ_idle_freezing;
		_dontidle = true;
	}
	
	var soundtest_check = instance_exists(obj_soundTest) && obj_soundTest.musicPlaying;
	if soundtest_check
	{
		_idle_spr = spr_player_PZ_idle_dance;
		_move_spr = spr_player_PZ_walk_dance;
		_dontidle = true;
		_dontStep = true;
	}
	
	if global.panic
	{
		_idle_spr = spr_player_PZ_idle_escape;
		if instance_exists(obj_coneball_timesUp)
			_idle_spr = spr_player_PZ_idle_timesUp;
	}
	
	if (global.Combo >= 10)
	{
		_idle_spr = spr_smallComboIdle;
		_move_spr = spr_smallComboWalk;
	}
	
	if (global.Combo >= 50)
	{
		_idle_spr = spr_bigComboIdle;
		_move_spr = spr_bigComboWalk;
	}
	
	if (windingAnim > 0)
	{
		windingAnim -= 5;
		_idle_spr = spr_player_PZ_tired;
	}
	
	if key_taunt
	{
		if (breakdanceBuffer++ >= 10)
		{
			idle = 0;
			windingAnim = 0;
			machSlideAnim = false;
			landAnim = false;
			slamHurt = 0;
			breakdanceSpeed = approach(breakdanceSpeed, 0.6, 0.005);
			_idle_spr = spr_player_PZ_idle_breakdance;
			_move_spr = spr_player_PZ_idle_breakdance;
			_dontidle = true;
			_dontStep = true;
			
			if (array_contains(idle_sprites, sprite_index))
			{
				image_index = 0;
				sprite_index = _idle_spr;
			}
		}
	}
	else
	{
		breakdanceBuffer = 0;
		breakdanceSpeed = 0.25;
	}
	
	if (breakdanceSpeed >= 0.5)
	{
		if (!instance_exists(obj_breakdanceBoomBox))
		{
			create_particle(x, y, spr_genericPoofEffect);
			
			with (instance_create(x, y, obj_breakdanceBoomBox, 
			{
				playerID: id
			}))
				vsp = -11;
		}
		breakdance_effect--;
	}
	
	if (breakdance_effect <= 0)
	{
		instance_create(x + irandom_range(-70, 70), y + irandom_range(-70, 70), obj_breakdanceEffects);
		breakdance_effect = 10;
	}
	
	if ((!machSlideAnim && !landAnim) || sprite_animation_end())
	{
		machSlideAnim = false;
		landAnim = false;
		
		if (move == 0 && (!array_contains(idle_sprites, sprite_index) || sprite_animation_end()))
		{
			if (slamHurt)
			{
				slamHurt--;
				if (sprite_animation_end() && sprite_index == spr_groundPoundEnd_intro)
					sprite_index = (sprite_index == spr_groundPoundEnd_intro) ? spr_groundPoundEnd : spr_diveBombEnd;
			}
			else
			{
				if (sprite_index != _idle_spr)
					image_index = 0;
				sprite_index = _idle_spr;
			}
			
			if (sprite_index != spr_player_PZ_walk_breakdance && sprite_index != spr_player_PZ_idle_breakdance && !_dontidle && sprite_index != spr_player_PZ_tired)
			{
				if (idle < 300)
					idle++;
				else
				{
					sprite_index = idle_sprites[irandom(array_length(idle_sprites) - 1)];
					image_index = 0;
					idle = 0;
					if chance(25)
						fmod_studio_event_instance_start(voiceIdle);
				}
			}
		}
		
		if (move != 0)
		{
			slamHurt = 0;
			if (sprite_index != _move_spr)
				image_index = 0;
			sprite_index = _move_spr;
		}
	}
	else
	{
		if slamHurt
			sprite_index = spr_diveBombEnd_intro;
		if landAnim
			sprite_index = (move == 0) ? spr_land : spr_land2;
		if machSlideAnim
			sprite_index = spr_machslideend;
	}
	
	if (scr_solid(x + move, y, true))
		movespeed = 0;
	
	jumpStop = false;
	
	if !grounded && !key_jump
	{
		sprite_index = shotgunAnim ? spr_shotgun_fall : spr_fall;
		jumpAnim = false;
		state = States.jump;
		image_index = 0;
	}
	
	if (can_jump && inputBufferJump > 0 && !key_down && (!key_attack || scr_solid(x + xscale, y, true)))
	{
		fmod_studio_event_instance_start(sndJump);
		sprite_index = shotgunAnim ? spr_shotgun_jump : spr_jump;
		instance_create(x, y, obj_highJumpCloud1, 
		{
			playerID: id
		});
		vsp = -11;
		grav = 0.3;
		state = States.jump;
		image_index = 0;
		freefallstart = 0;
		jumpAnim = true;
		jumpStop = false;
		inputBufferJump = 0;
		stompAnim = 0;
	}
	
	if (move != 0)
	{
		if (movespeed < 7)
			movespeed = approach(movespeed, 7, 0.5);
	}
	else
		movespeed = 0;
	
	if (movespeed > 7)
		movespeed = approach(movespeed, 7, 0.1);
	
	momentum = false;
	
	if (move != 0)
	{
		xscale = move;
		
		if (movespeed < 3 && move != 0)
			image_speed = 0.35;
		else if (movespeed > 3 && movespeed < 6)
			image_speed = 0.45;
		else
			image_speed = 0.6;
	}
	else
		image_speed = 0.35;
	
	if (sprite_index == spr_player_PZ_walk_breakdance || sprite_index == spr_player_PZ_idle_breakdance)
		image_speed = breakdanceSpeed;
	
	if ((key_down && grounded && !place_meeting(x, y, obj_hubDisplay) && !place_meeting(x, y, obj_paletteChangerMirror)) || scr_solid(x, y - 1))
	{
		state = States.crouch;
		landAnim = false;
		crouchAnim = true;
		image_index = 0;
		idle = 0;
	}
	
	if (grounded && move != 0 && vsp >= 0)
	{
		if (!stepEffectBuffer--)
		{
			instance_create(x, y + 43, obj_puffEffect);
			if !_dontStep
				event_play_oneshot("event:/SFX/player/step", x, y);
			if (sprite_index == spr_player_PZ_walk_dance)
				stepEffectBuffer = 8;
			else
				stepEffectBuffer = 12;
		}
	}
	
	do_grab(States.normal);
	do_taunt(States.normal);
	
	if (key_attack && grounded && !scr_solid(x + xscale, y, true))
	{
		switch global.playerCharacter
		{
			default:
				machTwo = 0;
				movespeed = max(movespeed, 6);
				sprite_index = spr_mach1;
				image_index = 0;
				jumpAnim = true;
				state = States.mach2;
				break;
		}
	}
	
	if (prevSpriteIndex != sprite_index && sprite_index == spr_idle && state == States.normal)
		image_index = 0;
}
