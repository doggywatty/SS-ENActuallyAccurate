DrawHUD = true;

if (room == timesuproom || room == rank_room || room == rm_credits || room == rm_titlecard
|| room == hub_demohallway || room == hub_paintstudio || room == mineshaft_elevator || is_hub()
|| is_tutorial())
	DrawHUD = false;

if (get_panic())
{
	global.ClassicCameraShake = 1;
	global.ClassicCameraShakeAcc = 3 / room_speed;
}

if (get_panic() && !global.freezeframe && !is_tutorial())
{
	if (global.EscapeTime > global.MaxEscapeTime)
		global.MaxEscapeTime = global.EscapeTime;
	if (global.EscapeTime > 0)
		global.EscapeTime--;
	if ((global.EscapeTime > 0 && (abs(global.EscapeTime) % 60) == 0) && global.Collect >= 5)
	{
		var _oldcollect = global.Collect;
		global.Collect -= 5;
		instance_create(x, y, obj_pointLoseNumber, 
		{
			image_blend: c_red,
			number: string(global.Collect - _oldcollect)
		});
	}
	
	if (global.panic && global.EscapeTime <= 0 && room != timesuproom)
	{
		if !instance_exists(obj_coneball_timesUp)
			instance_create(obj_parent_player.x, obj_parent_player.y, obj_coneball_timesUp);
	}
	else
		global.greyscalefade = approach(global.greyscalefade, 0, 0.015);
}

if (frozen && !global.freezeframe)
{
	for (var i = 0; i < 3; i++)
		alarm_set(i, frozenAlarm[i]);
	frozen = false;
}

global.ClassicCameraShake = approach(global.ClassicCameraShake, 0, global.ClassicCameraShakeAcc);
lspd = 0.25;
cam_angle = lerp(cam_angle, cam_langle, lspd);
cam_zoom = lerp(cam_zoom, cam_lzoom, lspd);
camera_set_view_angle(view_camera[0], cam_angle + camera_get_view_angle(view_camera[0]));
var vw = cam_w * cam_zoom;
var vh = cam_h * cam_zoom;
camera_set_view_size(view_camera[0], vw, vh);

if (instance_exists(obj_parent_player) && obj_parent_player.state != States.timesup && obj_parent_player.state != States.gameover)
{
	var target = 
	{
		x: global.targetCamX,
		y: global.targetCamY
	};
	var _cam_x = target.x - (vw / 2);
	var _cam_y = target.y - (vh / 2);
	_cam_x += cameraXOffset;
	_cam_y += cameraYOffset;
	var shake_value_x = 0;
	var shake_value_y = 0;
	
	if !global.freezeframe
	{
		var _player = obj_parent_player;
		var _targetcharge = 0;
		var _tspeed = 6;
		if (_player.state == States.mach2 || _player.state == States.mach3 || _player.state == States.minecart || _player.state == States.minecart_bump)
		{
			_targetcharge = _player.xscale * ((_player.movespeed / 4) * 50);
			_tspeed = 0.3;
			if (sign(chargeCameraX) != _player.xscale || (_player.state == States.minecart || _player.state == States.minecart_bump))
				_tspeed = 3;
		}
		else if (abs(_player.hsp) >= 16 && _player.state != States.climbwall && _player.state != States.Sjump)
		{
			_targetcharge = sign(_player.hsp) * ((_player.movespeed / 4) * 50);
			_tspeed = 2;
			if (sign(chargeCameraX) != sign(_player.hsp) && sign(_player.hsp) != 0)
				_tspeed = 8;
		}
		else if (_player.state == States.machslide)
			_tspeed = 10;
		chargeCameraX = approach(chargeCameraX, _targetcharge, _tspeed);
	}
	
	_cam_x += chargeCameraX;
	_cam_x = clamp(_cam_x, Camera_xorigin, Camera_width - vw);
	_cam_y = clamp(_cam_y, Camera_yorigin, Camera_height - vh);
	_cam_x = clamp(_cam_x, 0, room_width - vw);
	_cam_y = clamp(_cam_y, 0, room_height - vh);
	shake_value_x += (global.ClassicCameraShake * random_range(-1, 1));
	shake_value_y += (global.ClassicCameraShake * random_range(-1, 1));
	
	for (var i = 0; i < ds_list_size(cameraShakeList); i++)
	{
		with (ds_list_find_value(cameraShakeList, i))
		{
			if (shakeTime == 0 && !global.freezeframe)
				shakeMag = approach(shakeMag, 0, shakeDecel);

			shake_value_x += random_range(-shakeMag, shakeMag);
			shake_value_y += random_range(-shakeMag, shakeMag);
			
			if (shakeMag <= 0)
			{
				ds_list_set(other.cameraShakeList, i, undefined);
				ds_list_delete(other.cameraShakeList, i);
			}
			else if (shakeTime > 0)
				shakeTime = approach(shakeTime, 0, 1);
		}
	}
	
	if !global.ScreenShake
	{
		shake_value_x = 0;
		shake_value_y = 0;
	}
	
	Cam_x = _cam_x;
	Cam_y = _cam_y;
	camera_set_view_pos(view_camera[0], Cam_x + shake_value_x, Cam_y + shake_value_y);
	cameraXOffset = approach(cameraXOffset, 0, 4);
	cameraYOffset = approach(cameraYOffset, 0, 4);
}

if (obj_parent_player.y < (180 + obj_camera.Cam_y) && obj_parent_player.x < (350 + obj_camera.Cam_x))
	DrawY = lerp(DrawY, -300, 0.15);
else
	DrawY = lerp(DrawY, 0, 0.15);

pointCollectShake = approach(pointCollectShake, 0, 20 / room_speed);

if (is_hub() || !scr_roomcheck())
{
	global.currentrank = "D";
	lastRank = global.currentrank;
	bubblescale = 0;
}
else
{
	if (global.Collect < global.crank)
		global.currentrank = "D";
	else if (global.Collect < global.brank)
		global.currentrank = "C";
	else if (global.Collect < global.arank)
		global.currentrank = "B";
	else if (global.Collect < global.srank)
		global.currentrank = "A";
	else if (global.Collect >= global.srank)
	{
		if !global.ComboLost && global.secretfound > 2 && global.lapcount >= 1 && global.Treasure
			global.currentrank = "P";
		else
			global.currentrank = "S";
	}
	
	if lastRank != global.currentrank
	{
		bubblescale = 2;
		var rank_snd = sndRankUp;
		var rank_index = rank_checker(string_lower(global.currentrank));
		var oldrank_index = rank_checker(string_lower(lastRank));
		var event_state = oldrank_index;
		if (oldrank_index > rank_index)
		{
			rank_snd = sndRankDown;
			event_state = rank_index;
		}
		if DrawHUD
		{
			fmod_studio_event_instance_start(rank_snd);
			fmod_studio_event_instance_set_parameter_by_name(rank_snd, "state", event_state, false);
		}
		lastRank = global.currentrank;
	}
}

bubblescale = approach(bubblescale, 0, 0.2);
global.screenflash -= 1;
audio_listener_position(camera_get_view_x(view_camera[0]) + (cam_w / 2), camera_get_view_y(view_camera[0]) + (cam_h / 2), 0);

with cakeHud
{
	var c_threshold = floor(global.Combo / 5);
	var target_speed = clamp(c_threshold / sprite_get_number(spr_comboTitles), 0, 1);
	if (target_speed != image_speed && (animation_end_old() || image_speed <= 0))
	{
		image_speed = target_speed;
		image_index -= (image_number - 1);
	}
	image_index += image_speed;
}
