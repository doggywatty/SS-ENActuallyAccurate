x = obj_parent_player.x;
y = obj_parent_player.y;
Camera_width = room_width;
Camera_height = room_height;
Camera_xorigin = 0;
Camera_yorigin = 0;
cam_lzoom = 1;
cam_langle = 0;
var _region = -4;
with obj_cameraRegion
{
	if Region_active && activationCode()
	{
		_region = id;
		with other
		{
			if _region.ClampRight
				Camera_width = _region.x + _region.sprite_width;
			if _region.ClampBottom
				Camera_height = _region.y + _region.sprite_height;
			if _region.ClampLeft
				Camera_xorigin = _region.x;
			if _region.ClampTop
				Camera_yorigin = _region.y;
			cam_lzoom = _region.zoom;
			cam_langle = -_region.image_angle;
		}
	}
}

cam_angle = cam_langle;
cam_zoom = cam_lzoom;
camera_set_view_angle(view_camera[0], cam_angle + camera_get_view_angle(view_camera[0]));
var vw = cam_w * cam_zoom;
var vh = cam_h * cam_zoom;
camera_set_view_size(view_camera[0], vw, vh);

if (instance_exists(obj_parent_player) && obj_parent_player.state != States.timesup && obj_parent_player.state != States.gameover)
{
	global.targetCamX = obj_parent_player.x;
	global.targetCamY = obj_parent_player.y - 32;
	var target = 
	{
		x: global.targetCamX,
		y: global.targetCamY
	};
	var _cam_x = target.x - (vw / 2);
	var _cam_y = target.y - (vh / 2);
	var shake_value_x = 0;
	var shake_value_y = 0;
	if !global.freezeframe
	{
		var _player = obj_parent_player;
		var _targetcharge = 0;
		var _tspeed = 0;
		if (_player.state == States.mach2 || _player.state == States.mach3)
		{
			_targetcharge = _player.xscale * _player.movespeed * 16;
			_tspeed = 0.3;
			chargeCameraX = approach(chargeCameraX, _targetcharge, _tspeed);
		}
		else if (abs(_player.hsp) >= 16 && _player.state != States.climbwall && _player.state != States.Sjump)
		{
			_targetcharge = sign(_player.hsp) * abs(_player.hsp) * 16;
			_tspeed = 2;
			if ((_targetcharge > 0 && chargeCameraX < 0) || (_targetcharge < 0 && chargeCameraX > 0))
				_tspeed = 8;
			chargeCameraX = approach(chargeCameraX, _targetcharge, _tspeed);
		}
		else if (_player.state == States.machslide)
			chargeCameraX = approach(chargeCameraX, 0, 10);
		else
			chargeCameraX = approach(chargeCameraX, 0, 6);
	}
	
	_cam_x += chargeCameraX;
	_cam_x = clamp(_cam_x, Camera_xorigin, (Camera_xorigin + Camera_width) - vw);
	_cam_y = clamp(_cam_y, Camera_yorigin, (Camera_yorigin + Camera_height) - vh);
	_cam_x = clamp(_cam_x, 0, room_width - vw);
	_cam_y = clamp(_cam_y, 0, room_height - vh);
	Cam_x = _cam_x;
	Cam_y = _cam_y;
	camera_set_view_pos(view_camera[0], Cam_x + shake_value_x, Cam_y + shake_value_y);
}

scr_escapebgs();
