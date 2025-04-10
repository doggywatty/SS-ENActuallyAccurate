var target_player = get_nearestPlayer();
if (waitTimer > 0)
	waitTimer--;
if (grabBuffer > 0)
	grabBuffer--;

candyindex = wrap(candyindex + 0.35, 0, sprite_get_number(spr_flingFrogGrab) - 1);
if (sprite_index == spr_flingfrogmadstart && sprite_animation_end())
	sprite_index = spr_flingfrogmad;
if (grabbedPlayer != -4)
{
	if !event_instance_isplaying(pullSND)
		fmod_studio_event_instance_start(pullSND);
	if (sprite_index != spr_flingfrogmad && sprite_index != spr_flingfrogmadstart)
	{
		image_index = 0;
		sprite_index = spr_flingfrogmadstart;
	}
}
else
{
	sprite_index = spr_flingFrog;
	fmod_studio_event_instance_stop(pullSND, false);
}
if event_instance_isplaying(pullSND)
	fmod_quick3D(pullSND);
if (grabbedPlayer == -4)
{
	if (distance_to_object(target_player) <= grabRange)
	{
		var _player_dir = point_direction(xstart, ystart, target_player.x, target_player.y);
		targetX = lengthdir_x(90, _player_dir);
		targetY = lengthdir_y(90, _player_dir);
		hsp = 0;
		vsp = 0;
		if isReady
		{
			x = round(xstart + targetX);
			y = round(max(ystart + targetY, ystart));
		}
		else
		{
			x = round(lerp(x, xstart + targetX, 0.2));
			y = round(lerp(y, ystart + targetY, 0.2));
			
			if (x == round(xstart + targetX) && y == round(ystart + targetY))
				isReady = true;
		}
	}
	else
	{
		isReady = false;
		x = round(lerp(x, xstart, 0.2));
		y = round(lerp(y, ystart + 53, 0.2));
		flingInputStarted = false;
	}
	
	if (waitTimer <= 0 && place_meeting(x, y, target_player) && !scr_solid(x, y) && target_player.state != States.fling)
	{
		grabbedPlayer = target_player;
		grabBuffer = grabBufferMax;
		hsp = clamp(abs(grabbedPlayer.hsp / 2), 0, 12) * sign(grabbedPlayer.hsp);
		vsp = clamp((grabbedPlayer.vsp / 2) + 5, -5, 10);
		with grabbedPlayer
		{
			if !instance_exists(obj_candifiedeffect1)
			{
				instance_create(x, y, obj_candifiedeffect1);
				event_play_multiple("event:/SFX/player/psychicfrogstart", x, y);
			}
			state = States.fling;
			movespeed = 0;
			hsp = 0;
			vsp = 0;
			x = other.x;
			y = other.y;
		}
		with obj_achievementTracker
			flingFrogSequence[array_length(flingFrogSequence)] = other.id;
	}
	exit;
}

if (grabbedPlayer != -4)
{
	with grabbedPlayer
	{
		x = other.x;
		y = other.y;
		if (sprite_index != spr_player_PZ_flinged)
			sprite_index = spr_player_PZ_flinged_start;
		
		state = States.fling;
		if !instance_exists(obj_candifiedeffect2)
			instance_create(x, y, obj_candifiedeffect2);
		
		movespeed = 0;
		hsp = 0;
	}
	
	var h_move = grabbedPlayer.key_left + grabbedPlayer.key_right;
	var v_move = grabbedPlayer.key_down;
	if (h_move != 0 || v_move != 0)
		flingBallDestAngle = approach(flingBallDestAngle, angleArr[1 + h_move], 8);
	
	while (abs(flingBallDestAngle - flingBallAngle) > 180)
	{
		if (flingBallDestAngle > flingBallAngle)
			flingBallDestAngle -= 360;
		else
			flingBallDestAngle += 360;
	}
	
	if (grabBuffer <= 0)
	{
		if flingInputStarted
		{
			flingBallRadius = lerp(flingBallRadius, 60, 0.2);
			flingBallAngle = lerp(flingBallAngle, flingBallDestAngle, 0.2);
		}
		if (h_move != 0 || v_move != 0)
		{
			if !flingInputStarted
			{
				flingBallRadius = point_distance(x, y, xstart, ystart + 70);
				flingBallAngle = darctan2((ystart + 70) - ystart, x - xstart);
				flingInputStarted = true;
			}
			if (abs(x - xstart) > 10 || abs(y - (ystart + 70)) > 10)
				flingPrepared = true;
		}
		var cdir = point_direction(x, y, xstart, ystart + 70);
		flingDir = round_nearest(cdir, angleArr);
	}
	if flingInputStarted
	{
		hsp = 0;
		vsp = 0;
		x = lerp(x, xstart + (flingBallRadius * dcos(flingBallAngle)), 0.2);
		y = lerp(y, ystart + 70 + (flingBallRadius * dsin(flingBallAngle)), 0.2);
	}
	else
	{
		var target_direction = point_direction(x, y, xstart, ystart + 70);
		var m_speed = point_distance(x, y, xstart, ystart + 70) / 20;
		hsp += lengthdir_x(min(m_speed, 0.5), target_direction);
		vsp += lengthdir_y(min(m_speed, 0.5), target_direction);
		hsp = lerp(0, hsp, lerp(0.9, 1, min(point_distance(x, y, xstart, ystart + 70) / 120, 1)));
		vsp = lerp(0, vsp, lerp(0.9, 1, min(point_distance(x, y, xstart, ystart + 70) / 120, 1)));
		x += hsp;
		y += vsp;
	}
	
	x = clamp(x, xstart - 280, xstart + 280);
	if (flingPrepared && (grabbedPlayer.key_left == 0 && grabbedPlayer.key_right == 0 && grabbedPlayer.key_down == 0))
	{
		with grabbedPlayer
		{
			event_play_multiple("event:/SFX/player/psychicfrogend", x, y);
			y = other.ystart + 70;
			x = other.xstart;
			state = States.fling_launch;
			jumpStop = true;
			hsp = lengthdir_x(min(other.flingBallRadius / 60, 1) * 15, other.flingDir);
			vsp = lengthdir_y(min(other.flingBallRadius / 60, 1) * 15, other.flingDir);
			if (abs(hsp) < 1)
				hsp = 0;
			
			movespeed = abs(hsp);
			if (movespeed != 0)
				sprite_index = spr_player_PZ_flinged_up_start;
			else
				sprite_index = spr_player_PZ_flinged_straightup;
			if (sign(hsp) != 0)
				xscale = sign(hsp);
			
			flingDashTimer = other.flingDashLength;
			grounded = false;
		}
		grabbedPlayer = -4;
		waitTimer = 25;
		flingPrepared = false;
		flingInputStarted = false;
	}
	exit;
}
