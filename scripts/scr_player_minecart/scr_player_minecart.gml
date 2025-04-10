function state_player_minecart()
{
	static afterimage_timer = 2;
	static spark_timer = 1;
	mask_index = spr_mask_minecart;
	var check1 = place_meeting_collision(x, y) || place_meeting(x, y, obj_minecartSlowdown_crouch);
	mask_index = spr_mask_minecartcrouch;
	var check2 = !place_meeting_collision(x, y) && !place_meeting(x, y, obj_minecartSlowdown_crouch);
	var _cutscene = [
		spr_player_PZ_minecart_turn, spr_player_PZ_minecart_turnidle, spr_player_PZ_minecart_bounce
	];
	if (array_contains(_cutscene, sprite_index))
	{
		image_speed = 0.35;
		hsp = 0;
		if (sprite_animation_end() && sprite_index == spr_player_PZ_minecart_turn)
			sprite_index = spr_player_PZ_minecart_turnidle;
		exit;
	}
	
	if ((check1 && (check2 || bumpBuffer >= 0)) || key_down)
		mask_index = spr_mask_minecartcrouch;
	else
		mask_index = spr_mask_minecart;
	
	move = key_left + key_right;
	var _xscale = xscale;
	if (sprite_index == spr_player_PZ_minecart_spinOut)
	{
		hurted = true;
		if (movespeed > 6)
			movespeed -= 0.25;
		if sprite_animation_end()
			sprite_index = spr_player_PZ_minecart;
	}
	
	if (place_meeting(x, y + 1, obj_minecartRail_Slope))
	{
		with (instance_place(x, y + 1, obj_minecartRail_Slope))
		{
			var slope_acceleration = abs(image_yscale) / abs(image_xscale);
			if _xscale == sign(image_xscale)
			{
				if (other.movespeed > 5)
					other.movespeed -= (0.15 * slope_acceleration);
			}
			else if _xscale == -sign(image_xscale)
			{
				if (other.movespeed < 18)
					other.movespeed += (0.2 * slope_acceleration);
			}
		}
	}
	
	if (sprite_index != spr_player_PZ_minecart_spinOut && sprite_index != spr_player_PZ_minecart_turn)
	{
		if (movespeed < 12)
			movespeed += 0.1;
	}
	
	hsp = xscale * movespeed;
	var _cannot_groundpound = [
		spr_player_PZ_minecart_spinOut, spr_player_PZ_minecart_groundpound,
		spr_player_PZ_minecart_groundpoundstart
	];
	if (!grounded && key_down2 && !array_contains(_cannot_groundpound, sprite_index))
	{
		sprite_index = spr_player_PZ_minecart_groundpoundstart;
		fmod_studio_event_instance_start(sndDive);
		image_index = 0;
		vsp = max(vsp, 20);
	}
	if (inputBufferJump > 0 && can_jump && sprite_index != spr_player_PZ_minecart_spinOut && sprite_index != spr_player_PZ_minecart_turn)
	{
		vsp = -10;
		grounded = false;
		sprite_index = spr_player_PZ_minecart_jump;
		image_index = 0;
		inputBufferJump = 0;
		fmod_studio_event_instance_start(sndMinecartJump);
	}
	
	if (sprite_index == spr_player_PZ_minecart_crouch && mask_index != spr_mask_minecartcrouch && sprite_index != spr_player_PZ_minecart_crouchend)
	{
		image_index = 0;
		sprite_index = spr_player_PZ_minecart_crouchend;
	}
	if (sprite_index != spr_player_PZ_minecart_spinOut)
	{
		var grounded_land_sprite = spr_player_PZ_minecart_land;
		var grounded_sprite = spr_player_PZ_minecart;
		if (mask_index == spr_mask_minecartcrouch && sprite_index != spr_player_PZ_minecart_spinOut && sprite_index != spr_player_PZ_minecart_crouchstart && sprite_index != spr_player_PZ_minecart_crouchend)
		{
			grounded_sprite = spr_player_PZ_minecart_crouch;
			grounded_land_sprite = spr_player_PZ_minecart_groundpoundland;
		}
		else if (sprite_index == spr_player_PZ_minecart_crouch && grounded && sprite_index != spr_player_PZ_minecart_crouchstart && sprite_index != spr_player_PZ_minecart_crouchend)
			sprite_index = spr_player_PZ_minecart;
		if ((sprite_index == spr_player_PZ_minecart || sprite_index == spr_player_PZ_minecart_land) && key_down)
		{
			image_index = 0;
			sprite_index = spr_player_PZ_minecart_crouchstart;
		}
		
		if (sprite_animation_end() && sprite_index == spr_player_PZ_minecart_crouchstart)
			sprite_index = spr_player_PZ_minecart_crouch;
		if (sprite_animation_end() && sprite_index == spr_player_PZ_minecart_groundpoundstart)
			sprite_index = spr_player_PZ_minecart_groundpound;
		if (sprite_animation_end() && (sprite_index == spr_player_PZ_minecart_crouchend || sprite_index == spr_player_PZ_minecart_turnend))
			sprite_index = spr_player_PZ_minecart;
		if grounded
		{
			if (sprite_index != grounded_land_sprite && (sprite_index == spr_player_PZ_minecart_fall || sprite_index == spr_player_PZ_minecart_groundpound || sprite_index == spr_player_PZ_minecart_groundpoundstart || sprite_index == spr_player_PZ_minecart_jump))
			{
				if (sprite_index == spr_player_PZ_minecart_groundpound || sprite_index == spr_player_PZ_minecart_groundpoundstart)
					sprite_index = spr_player_PZ_minecart_groundpoundland;
				else
					sprite_index = grounded_land_sprite;
				event_play_oneshot("event:/SFX/minecart/land", x + hsp, y);
				image_index = 0;
			}
			if ((sprite_index == spr_player_PZ_minecart_land || spr_player_PZ_minecart_groundpoundland) && sprite_animation_end())
				sprite_index = grounded_sprite;
			if (sprite_index != grounded_sprite && sprite_index == spr_player_PZ_minecart)
				sprite_index = grounded_sprite;
		}
		else if (sprite_index != spr_player_PZ_minecart_jump && sprite_index != spr_player_PZ_minecart_groundpound
		&& sprite_index != spr_player_PZ_minecart_groundpoundstart)
			sprite_index = spr_player_PZ_minecart_fall;
		else if (sprite_index == spr_player_PZ_minecart_jump && sprite_animation_end())
			sprite_index = spr_player_PZ_minecart_fall;

		if (sprite_index == spr_player_PZ_minecart)
			image_speed = clamp(movespeed / 24, 0.35, 0.6);
		else if (sprite_index == spr_player_PZ_minecart_groundpoundstart)
			image_speed = 0.6;
		else if (sprite_index == spr_player_PZ_minecart_crouchstart || sprite_index == spr_player_PZ_minecart_crouchend)
			image_speed = 0.5;
		else
			image_speed = 0.35;
	}
	else
		image_speed = 0.35;
	if (sprite_index == spr_player_PZ_minecart_groundpoundland && image_index >= 3 && key_down)
	{
		sprite_index = spr_player_PZ_minecart_crouchstart;
		image_index = 0;
	}
	
	if (scr_solid(x + xscale, y, true) && !place_meeting(x + xscale, y, obj_destructibles) && !place_meeting(x + xscale, y, obj_metalblock) && !place_meeting(x + xscale, y, obj_chocofrog))
	{
		if (place_meeting(x + xscale, y, obj_trainStop))
		{
			sprite_index = spr_player_PZ_geyser;
			state = States.bump;
			hsp = 4 * -xscale;
			vsp = -6;
			machTwo = 0;
			image_index = 0;
			instance_create(x, y, obj_bombExplosion);
			for (var i = 0; i < (sprite_get_number(spr_minecartdebris) - 1); i++)
			{
				with (create_debris(x + random_range(-10, 10), y + random_range(-10, 10), spr_minecartdebris))
					image_index = i;
			}
		}
		else if (bumpBuffer <= 0)
		{
			sprite_index = spr_player_PZ_minecart_fall;
			image_index = 0;
			state = States.minecart_bump;
			event_play_oneshot("event:/SFX/minecart/bump");
			hsp = 8 * -xscale;
			vsp = -5;
			machTwo = 0;
			movespeed = 6;
			bumpBuffer = 8;
		}
	}
	else if (bumpBuffer > 0)
		bumpBuffer = approach(bumpBuffer, 0, 1);
	
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
	
	spark_timer = max(spark_timer - 1, 0);
	if (grounded && spark_timer <= 0)
	{
		create_debris(x + (-image_xscale * 30), y + 43, spr_railSpark);
		spark_timer = 1;
	}
}

function state_player_minecart_bump()
{
	mask_index = spr_mask_minecart;
	if grounded
		state = States.minecart;
}

function state_player_minecart_launched()
{
	mask_index = spr_mask_minecart;
	image_speed = 0.35;
	hsp = movespeed;
	move = key_left + key_right;
	if (sprite_index == spr_player_PZ_minecart_jump && sprite_animation_end())
		sprite_index = spr_player_PZ_minecart_fall;
	var _cannot_groundpound = [
		spr_player_PZ_minecart_jump, spr_player_PZ_minecart_bounce, spr_player_PZ_minecart_spinOut,
		spr_player_PZ_minecart_groundpound, spr_player_PZ_minecart_groundpoundstart
	];
	if (!grounded && key_down2 && !array_contains(_cannot_groundpound, sprite_index))
	{
		sprite_index = spr_player_PZ_minecart_groundpoundstart;
		fmod_studio_event_instance_start(sndDive);
		image_index = 0;
		vsp = max(vsp, 20);
	}
	
	if (sprite_animation_end() && sprite_index == spr_player_PZ_minecart_groundpoundstart)
		sprite_index = spr_player_PZ_minecart_groundpound;
	if (move != 0)
		movespeed = approach(movespeed, move * 6, 0.5);
	else
		movespeed = approach(movespeed, 0, 0.25);
	if (grounded && vsp > 0)
	{
		state = States.minecart;
		movespeed = abs(movespeed);
		instance_create(x, y, obj_jumpdust);
	}
}
