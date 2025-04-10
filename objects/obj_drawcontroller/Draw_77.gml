for (var i = 0; i < ds_list_size(global.BgInstancesList); i++)
{
	with (ds_list_find_value(global.BgInstancesList, i))
	{
		y -= global.BgInstanceLayerOffset;
		x -= (camera_get_view_x(view_camera[0]) * 0.05);
		y -= (camera_get_view_y(view_camera[0]) * 0.05);
	}
}

with obj_parent_player
{
	if inBackgroundLayer
	{
		y -= global.BgInstanceLayerOffset;
		x -= (camera_get_view_x(view_camera[0]) * 0.05);
		y -= (camera_get_view_y(view_camera[0]) * 0.05);
	}
}
