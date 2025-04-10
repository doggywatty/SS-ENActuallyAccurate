var coneballtimesup = spr_bartimer_showtime;
coneballtimesup = spr_bartimer_blotchspotshowtime;
with HUDObject_tooltipPrompts
{
	if (promptTimer > 0)
	{
		image_alpha = approach(image_alpha, 1, 0.05);
		promptTimer--;
	}
	else
		image_alpha = approach(image_alpha, 0, 0.05);
	
	var _fall = false;
	var timer_coneball = other.HUDObject_timer.elm_coneBall;
	if (timer_coneball.sprite_index == coneballtimesup && timer_coneball.image_index >= (timer_coneball.sprite_image_number - 1))
		_fall = true;
	
	if (!get_panic() || is_tutorial() || _fall)
		y = approach(y, 500, 2);
	else if (other.HUDObject_timer.targetEscapeTime > 0)
		y = approach(y, 425, 0.5);
}

if (is_hub() || !scr_roomcheck() || room == mineshaft_elevator)
	exit;

var target_player = get_primaryPlayer();
if (target_player.y < (190 + obj_camera.Cam_y) && target_player.x > ((camera_get_view_width(view_camera[0]) - 350) + obj_camera.Cam_x))
	moveUpY = round(lerp(moveUpY, -300, 0.15));
else
	moveUpY = round(lerp(moveUpY, 0, 0.15));

with HUDObject_TV
{
	y = ystart + other.moveUpY;
	sprite_image_number = sprite_get_number(sprite_index);
	tvAnimations(target_player);
	
	var do_transition = false;
	if (tvDoingExpression != tvPrevDoingExpression)
	{
		tvPrevDoingExpression = tvDoingExpression;
		do_transition = true;
	}
	if (!do_transition && tvNormalStates != tvPrevNormalStates)
	{
		tvPrevNormalStates = tvNormalStates;
		do_transition = true;
	}
	if (!do_transition && tvForceTransition)
		do_transition = true;
	
	if (sprite_index != queuedSprite)
	{
		if (!transition.activated && (!do_transition || sprite_index == spr_tvHUD_turningOn || sprite_index == spr_tvHUD_turnedOff))
			sprite_index = queuedSprite;
		else
		{
			transition.activated = true;
			tvForceTransition = false;
		}
	}
	
	with transition
	{
		if !activated
		{
			image_index = 0;
			break;
		}
		
		sprite_image_number = sprite_get_number(sprite_index);
		image_index += image_speed;
		if (sprite_animation_end(,, sprite_image_number))
		{
			image_index = wrap(image_index, 0, sprite_image_number);
			activated = !activated;
			with other
				sprite_index = queuedSprite;
		}
	}
	
	with idleScreenSaver
	{
		activated = target_player.playerNoInputBuffer >= target_player.playerNoInputBufferMax;
		if !activated
			break;
		var target_x = keyPositions[keyframeIndex][0];
		var target_y = keyPositions[keyframeIndex][1];
		var target_direction = point_direction(x, y, target_x, target_y);
		x += lengthdir_x(playBackSpeed, target_direction);
		y += lengthdir_y(playBackSpeed, target_direction);
		if (point_distance(x, y, target_x, target_y) <= playBackSpeed)
		{
			keyframeIndex += playbackDirection;
			if (floor(keyframeIndex) >= (keyframeNumber - 1) || keyframeIndex <= 0)
				playbackDirection *= -1;
		}
	}
	with weakSignal
	{
		if (get_panic())
		{
			if (signalBuffer-- < 0)
			{
				image_index = 0;
				signalBuffer = irandom_range(300, 1000);
			}
			if !sprite_animation_end()
				image_index += image_speed;
		}
	}
	
	if (muteIconBuffer-- < 0)
	{
		muteIconAlpha = !muteIconAlpha;
		muteIconBuffer = muteIconBufferMax;
	}
	image_index = wrap(image_index + (image_speed * sprite_get_speed(sprite_index)), 0, sprite_get_number(sprite_index) - 1);
}

with HUDObject_comboMeter
{
	sprite_index = spr_tvHUD_comboMeter;
	y = ystart + other.moveUpY + displayY;
	x = xstart + wave(-5, 5, 2, 20);
	if (!(global.ComboTime > 0 && global.Combo > 0))
	{
		displayY = approach(displayY, displayYMax, 5);
		comboTimeDisplay = 0;
		combofillDisplay = lerp(combofillDisplay, comboTimeDisplay / 60, 0.5);
		displayState = ComboState.Off;
		break;
	}
	switch displayState
	{
		case ComboState.Off:
			displayVSP += 0.5;
			displayY = approach(displayY, 20, displayVSP);
			if (displayY >= 20)
				displayState = ComboState.Dropping;
			break;
		case ComboState.Dropping:
			displayY = lerp(displayY, 0, 0.05);
			if (displayY < 1)
			{
				displayY = 0;
				displayVSP = 0;
				displayState = ComboState.On;
			}
			break;
		case ComboState.On:
			var _setVSP = -1;
			if (global.ComboTime < 30)
			{
				if (global.ComboTime < 15)
					_setVSP = -2;
				displayY += displayVSP;
				displayVSP += 0.5;
				if (displayY > 0)
				{
					displayY = 0;
					displayVSP = _setVSP;
				}
			}
			else
				displayY = approach(displayY, 0, 10);
			break;
	}
	
	comboDisplay = global.Combo;
	var target_combo_time = clamp(global.ComboTime, 0, 60);
	var meter_fill_width = sprite_get_width(spr_tvHUD_comboMeter_fill);
	combofillDisplay = lerp(combofillDisplay, (target_combo_time / 60) * meter_fill_width, 0.5);
	combofillDisplay = clamp(combofillDisplay, 0, meter_fill_width);
	image_index = wrap(image_index + image_speed, 0, sprite_get_number(sprite_index));
	with elm_meterFill
	{
		sprite_image_number = sprite_get_number(sprite_index);
		image_index = wrap(image_index + image_speed, 0, sprite_image_number);
	}
}
with HUDObject_timer
{
	if !global.panic
	{
		y = ystart + 150;
		break;
	}
	if (abs(global.EscapeTime - targetEscapeTime) <= 60)
		targetEscapeTime = approach(targetEscapeTime, global.EscapeTime, 60);
	else
		targetEscapeTime = lerp(targetEscapeTime, global.EscapeTime, 0.03);
	
	y -= ystart;
	if (!get_panic())
		y = approach(y, 150, 4);
	else if (targetEscapeTime > 0)
		y = approach(y, 0, 1);
	
	with elm_coneBall
	{
		sprite_image_number = sprite_get_number(sprite_index);
		image_index += image_speed;
		if (sprite_animation_end(,, sprite_image_number))
		{
			image_index = 0;
			if (sprite_index == coneballtimesup)
			{
				image_index = sprite_image_number - 1;
				other.y = approach(other.y, 150, 1);
			}
		}
		if (other.targetEscapeTime <= 0)
		{
			if (sprite_index != coneballtimesup)
				image_index = 0;
			sprite_index = coneballtimesup;
		}
		else
			sprite_index = spr_bartimer_normalFront;
	}
	
	y += ystart;
	with elm_clockTimer
	{
		sprite_image_number = sprite_get_number(spr_clockTimer);
		image_index = wrap(image_index + image_speed, 0, sprite_image_number);
	}
}
