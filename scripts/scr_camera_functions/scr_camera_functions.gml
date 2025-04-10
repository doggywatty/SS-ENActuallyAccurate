function point_in_camera(px, py, _cam)
{
	var cam_x = camera_get_view_x(_cam);
	var cam_y = camera_get_view_y(_cam);
	var cam_w = camera_get_view_width(_cam);
	var cam_h = camera_get_view_height(_cam);
	return point_in_rectangle(px, py, cam_x, cam_y, cam_x + cam_w, cam_y + cam_h);
}

function bbox_in_camera(sx1, _cam, dx1 = 0)
{
	var cam_x = camera_get_view_x(_cam);
	var cam_y = camera_get_view_y(_cam);
	var cam_w = camera_get_view_width(_cam);
	var cam_h = camera_get_view_height(_cam);
	return bbox_in_rectangle(sx1, cam_x - dx1, cam_y - dx1, cam_x + cam_w + dx1, cam_y + cam_h + dx1);
}

function camera_get_position_struct(_cam, _pos = -4) constructor
{
	var _cam_x = camera_get_view_x(_cam);
	var _cam_y = camera_get_view_y(_cam);
	var _cam_width = camera_get_view_width(_cam);
	var _cam_height = camera_get_view_height(_cam);
	centeredcam_x = _cam_x + (_cam_width / 2);
	centeredcam_y = _cam_y + (_cam_height / 2);
	cam_x = _cam_x;
	cam_y = _cam_y;
	if _pos != -4
	{
		centeredcam_x -= _pos[0];
		centeredcam_y -= _pos[1];
	}
}

function screen_flash(_screen)
{
	global.screenflash = _screen;
}

function pummel_dim()
{
}

function camera_shake_add(_val1, _val2room, _val3 = 0)
{
	with obj_camera
		ds_list_add(cameraShakeList, new addCameraShake(_val1, _val2room / room_speed, _val3));
}

function camera_shake_clearAll(_cam = false)
{
	with obj_camera
	{
		for (var i = 0; i < ds_list_size(cameraShakeList); i++)
		{
			with (ds_list_find_value(cameraShakeList, i))
			{
				shakeTime = 0;
				if _cam
				{
					shakeMag = 0;
					ds_list_set(other.cameraShakeList, i, undefined);
					ds_list_delete(other.cameraShakeList, i);
				}
				else
				{
				}
			}
		}
	}
}
