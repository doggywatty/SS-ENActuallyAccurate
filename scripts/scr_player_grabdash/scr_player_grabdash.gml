function state_player_grabdash()
{
	static sparkle_effect = 0;
	static afterimage_timer = 2;
	
	move = key_left + key_right;
	landAnim = false;
	var _falling_sprites = [spr_suplexdashFall, spr_suplexdashFallIntro];
	if (floatyGrab-- > 0)
	{
		vsp = min(vsp, 0);
		if (sparkle_effect-- < 0)
		{
			sparkle_effect = 5;
			with instance_create(x, y, obj_bangEffect)
			{
				depth = -8;
				image_xscale = choose(1, -1);
				sprite_index = spr_shineeffect;
				image_speed = 0.35;
			}
		}
	}
	else if (!grounded && sprite_index != spr_suplexdashFallIntro && sprite_index != spr_suplexdashFall)
	{
		sprite_index = spr_suplexdashFallIntro;
		image_index = 0;
	}
	if ((sprite_index == spr_suplexdashFallIntro && sprite_animation_end()) || (!grounded && sprite_index == spr_suplexdashGround))
		sprite_index = spr_suplexdashFall;
	if (floatyGrab < 15 && key_down && vsp < 6)
	{
		vsp = 6;
		floatyGrab = 0;
	}
	if (movespeed < 10)
		movespeed = approach(movespeed, 10, 0.5);
	
	hsp = xscale * movespeed;
	scr_conveyorBeltKinematics();
	if (!key_jump2 && !jumpStop && vsp < 0.5)
	{
		vsp /= 20;
		jumpStop = true;
	}
	if (grounded && vsp > 0)
	{
		jumpStop = false;
		floatyGrab = 18;
	}
	momentum = true;
	dir = xscale;
	if (move != xscale && move != 0)
	{
		state = States.jump;
		image_index = 0;
		sprite_index = spr_suplexdashCancel;
		jumpAnim = true;
		momentum = false;
		machTwo = 0;
		floatyGrab = 0;
		xscale *= -1;
		event_play_oneshot("event:/SFX/player/grabcancel", x, y);
	}
	if (inputBufferJump > 0 && can_jump)
	{
		image_index = 0;
		sprite_index = spr_longJump_intro;
		instance_create(x, y, obj_jumpdust, 
		{
			playerID: id
		});
		state = States.mach2;
		jumpStop = false;
		vsp = -11;
		grav = 0.3;
		fmod_studio_event_instance_start(sndJump);
		fmod_studio_event_instance_start(sndRollGetUp);
		inputBufferJump = 0;
	}
	if (scr_solid(x + xscale, y, true) && !place_meeting(x + xscale, y, obj_destructibles))
	{
		var _ledge = snap_to_ledge();
		if !_ledge && !place_meeting(x + xscale, y, obj_destructibles)
		{
			if (!grounded || slopeCheck(x + xscale, y))
			{
				verticalMovespeed = 7;
				if (vsp > 0 && place_meeting(x + xscale, y, obj_icyWall))
					verticalMovespeed -= vsp;
				grabClimbBuffer = 10;
				inputBufferJump = 0;
				state = States.climbwall;
				floatyGrab = 18;
			}
			else
			{
				jumpStop = true;
				state = States.jump;
				floatyGrab = 18;
				vsp = -4;
				sprite_index = spr_player_PZ_suplexDash_bump;
				image_index = 0;
				event_play_oneshot("event:/SFX/player/splat", x, y);
			}
		}
	}
	image_speed = 0.3;
	if (!instance_exists(obj_slidecloud) && grounded && movespeed > 5)
	{
		instance_create(x, y, obj_slidecloud, 
		{
			image_xscale: xscale
		});
	}
	if (sprite_index == spr_suplexdashIntro && sprite_animation_end())
	{
		if grounded
			sprite_index = spr_suplexdashGround;
		else
		{
			sprite_index = spr_suplexdashFallIntro;
			image_index = 0;
		}
	}
	if (grounded && ((sprite_index == spr_suplexdashGround && sprite_animation_end())
	|| array_contains(_falling_sprites, sprite_index)))
	{
		image_speed = 0.35;
		grav = 0.5;
		if key_attack
		{
			state = States.mach2;
			sprite_index = spr_mach2;
			floatyGrab = 0;
		}
		else
		{
			sprite_index = spr_idle;
			image_index = 0;
			momentum = true;
			state = States.normal;
			floatyGrab = 0;
			jumpStop = true;
		}
	}
	
	if (inputBufferSlap > 0 && !key_down || !grounded && animation_end_old(U, 2))
	{
		fmod_studio_event_instance_start(sndCrouchslide);
		sprite_index = spr_grabDashTumble;
		image_index = 0;
		image_speed = 0.2;
		if !grounded && floatyGrab > 0
		{
			vsp = -6;
			floatyGrab = 0;
		}
		state = States.machtumble2;
		inputBufferSlap = 0;
		movespeed = max(movespeed, 12);
		with instance_create(x, y, obj_jumpdust)
			image_xscale = other.xscale;
	}
	if key_down
	{
		if grounded
		{
			grav = 0.5;
			sprite_index = spr_crouchslipintro;
			image_index = 0;
			fmod_studio_event_instance_start(sndCrouchslide);
			state = States.machroll;
			with instance_create(x, y, obj_jumpdust)
				image_xscale = other.xscale;
			movespeed = 11;
			crouchSlipBuffer = 25;
			crouchSlipAntiBuffer = 0;
		}
	}
	
	afterimage_timer = max(afterimage_timer - 1, 0);
	if (afterimage_timer <= 0)
	{
		with (create_afterimage(AfterImageType.plain, xscale, 0))
		{
			image_index = max(other.image_index - 1, 0);
			vanish = true;
			gonealpha = 0.8;
			alarm[0] = 1;
			alarm[1] = 60;
		}
		afterimage_timer = 2;
	}
}
