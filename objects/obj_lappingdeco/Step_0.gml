depth = 900;
var _parallax = [0.25, 0.25];
switch sprite_index
{
	case bg_lappingdeco2:
		_parallax = [0.15, 0.15];
		break;
	case bg_lappingdeco3:
		_parallax = [0.1, 0.1];
		break;
}
drawx = x + ((x - (camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2))) * -_parallax[0]);
drawy = y + ((y - (camera_get_view_y(view_camera[0]) + (camera_get_view_y(view_camera[0]) / 2))) * -_parallax[1]);
