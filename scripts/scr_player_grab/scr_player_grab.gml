function state_player_grab()
{
	static afterimage_timer = 2;
	
	move = key_left + key_right;
	var forceThrow = false;
	if (sprite_index != spr_swingDing)
	{
		if (grounded && vsp > 0 && (sprite_index == spr_haulingFall || sprite_index == spr_haulingJump))
		{
			image_index = 0;
			sprite_index = spr_haulingLand;
		}
		if (grounded && sprite_index != spr_haulingIntro && !(sprite_index == spr_haulingLand && move == 0))
			sprite_index = (move == 0) ? spr_haulingIdle : spr_haulingWalk;
		if (!grounded && sprite_index != spr_haulingJump && sprite_index != spr_haulingIntro)
			sprite_index = spr_haulingFall;
		
		if (sprite_animation_end())
		{
			if (sprite_index == spr_haulingIntro || sprite_index == spr_haulingLand)
				sprite_index = spr_haulingIdle;
			if (sprite_index == spr_haulingJump)
				sprite_index = spr_haulingFall;
		}
	}
	
	hsp = xscale * movespeed;
	if (sprite_index != spr_swingDing)
	{
		if (dir != xscale)
		{
			dir = xscale;
			movespeed = 2;
			slamHurt = 0;
		}
		if grounded
			jumpStop = false;
		if (move != 0)
		{
			movespeed = approach(movespeed, 7, 0.5);
			xscale = move;
			if (grounded && !stepEffectBuffer--)
			{
				instance_create(x, y + 43, obj_puffEffect);
				event_play_oneshot("event:/SFX/player/step", x, y);
				stepEffectBuffer = 20;
			}
		}
		else
			movespeed = 0;
		if (move != 0 && bump_wall(move))
			movespeed = 0;
		if (!key_jump2 && !jumpStop && vsp < 0.5 && !stompAnim)
		{
			vsp /= 20;
			jumpStop = true;
		}
		if (scr_solid(x, y - 1) && !jumpStop && jumpAnim)
		{
			vsp = grav;
			jumpStop = true;
		}
	}
	else
	{
		if grounded
			movespeed = approach(movespeed, 0, 0.5);
		if (movespeed <= 0)
			sprite_index = spr_haulingIdle;
		if (floor(image_index) == 0)
		{
			if !swingDingBuffer
				event_play_oneshot("event:/SFX/player/spin", x, y);
			swingDingBuffer = 5;
		}
		else if (swingDingBuffer > 0)
			swingDingBuffer--;
		if (bump_wall(xscale) && !place_meeting(x + xscale, y, obj_destructibles))
			forceThrow = true;
		
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
	scr_conveyorBeltKinematics();
	if (can_jump && inputBufferJump > 0 && !key_down && vsp > 0 && sprite_index != spr_swingDing)
	{
		fmod_studio_event_instance_start(sndJump);
		inputBufferJump = 0;
		sprite_index = spr_haulingJump;
		image_index = 0;
		instance_create(x, y, obj_highJumpCloud1, 
		{
			playerID: id
		});
		vsp = -11;
		grav = 0.3;
	}
	
	if (inputBufferSlap > 0 || forceThrow)
	{
		if (move != 0)
			move = xscale;
		inputBufferSlap = 0;
		state = States.finishingblow;
		movespeed = hsp;
		if (sprite_index == spr_swingDing)
			sprite_index = spr_swingDingEnd;
		else if key_up
			sprite_index = spr_suplexmashUppercut;
		else
			sprite_index = choose(spr_suplexmash1, spr_suplexmash2, spr_suplexmash3, spr_suplexmash4);
		image_index = 0;
	}
	
	if (key_down && !grounded)
	{
		sprite_index = spr_piledriver;
		vsp = -6;
		state = States.superslam;
		image_index = 0;
		image_speed = 0.35;
	}
	
	if (key_down && grounded)
	{
		if instance_exists(baddieGrabbedID)
		{
			with baddieGrabbedID
			{
				state = States.charge;
				image_index = 0;
				x = other.x;
				y = other.y;
			}
		}
		state = States.crouch;
		landAnim = false;
		crouchAnim = true;
		image_index = 0;
		idle = 0;
	}
	image_speed = 0.35;
}
