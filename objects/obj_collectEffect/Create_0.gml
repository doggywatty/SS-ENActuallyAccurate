var cam_x = camera_get_view_x(view_camera[0]);
var cam_y = camera_get_view_y(view_camera[0]);
depth = -10;
image_speed = 0;
image_index = 0;
var original_distance = point_distance(cam_x, cam_y, xstart, ystart);
var original_direction = point_direction(cam_x, cam_y, xstart, ystart);
drawx = lengthdir_x(original_distance, original_direction);
drawy = lengthdir_y(original_distance, original_direction);
drawxscale = 1;
drawyscale = 1;
biggening = true;
targetx = 128;
targety = 96;

if !choosed
{
	playerID = obj_parent_player;
	switch global.playerCharacter
	{
		default:
			sprite_index = choose(spr_collect1, spr_collect2, spr_collect3, spr_collect4, spr_collect5);
			break;
	}
	use_palette = true;
}
