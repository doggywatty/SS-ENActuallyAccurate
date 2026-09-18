function point_in_camera(arg0, arg1, arg2)
{
	var cam_x = camera_get_view_x(arg2);
	var cam_y = camera_get_view_y(arg2);
	var cam_w = camera_get_view_width(arg2);
	var cam_h = camera_get_view_height(arg2);
	return point_in_rectangle(arg0, arg1, cam_x, cam_y, cam_x + cam_w, cam_y + cam_h);
}

function bbox_in_camera(arg0, arg1, arg2 = 0)
{
	var cam_x = camera_get_view_x(arg1);
	var cam_y = camera_get_view_y(arg1);
	var cam_w = camera_get_view_width(arg1);
	var cam_h = camera_get_view_height(arg1);
	return bbox_in_rectangle(arg0, cam_x - arg2, cam_y - arg2, cam_x + cam_w + arg2, cam_y + cam_h + arg2);
}

function camera_get_position_struct(arg0, arg1 = -4) constructor
{
	var _cam_x = camera_get_view_x(arg0);
	var _cam_y = camera_get_view_y(arg0);
	var _cam_width = camera_get_view_width(arg0);
	var _cam_height = camera_get_view_height(arg0);
	centeredcam_x = _cam_x + (_cam_width / 2);
	centeredcam_y = _cam_y + (_cam_height / 2);
	cam_x = _cam_x;
	cam_y = _cam_y;
	
	if (arg1 != -4)
	{
		centeredcam_x -= arg1[0];
		centeredcam_y -= arg1[1];
	}
}

function screen_flash(arg0)
{
	global.screenflash = arg0;
}

function pummel_dim()
{
}

function camera_shake_add(arg0, arg1, arg2 = 0)
{
	with (obj_camera)
		ds_list_add(cameraShakeList, new addCameraShake(arg0, arg1 / room_speed, arg2));
}

function camera_shake_clearAll(arg0 = false)
{
	with (obj_camera)
	{
		for (var i = 0; i < ds_list_size(cameraShakeList); i++)
		{
			with (ds_list_find_value(cameraShakeList, i))
			{
				shakeTime = 0;
				
				if (arg0)
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
