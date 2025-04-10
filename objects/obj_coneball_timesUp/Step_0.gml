if !noConeballRoom
{
	if !event_instance_isplaying(sndMoving)
		fmod_studio_event_instance_start(sndMoving);
	else
		fmod_quick3D(sndMoving);
	
	if (image_alpha >= 1)
	{
		var dir = point_direction(x, y, obj_parent_player.x, obj_parent_player.y);
		if !global.freezeframe
		{
			x = approach(x, obj_parent_player.x, lengthdir_x(8, dir));
			y = approach(y, obj_parent_player.y, lengthdir_y(8, dir));
		}
	}
	else
		image_alpha += 0.01;
	
	var pid = instance_place(x, y, obj_parent_player);
	if (pid > 0 && !pid.cutscene && !instance_exists(obj_fadeoutTransition)
	&& !instance_exists(obj_endlevelfade) && image_alpha >= 1)
	{
		with pid
		{
			instance_destroy(obj_fadeoutTransition);
			scr_levelSet();
			targetDoor = "A";
			global.panic = 0;
			global.greyscalefade = 0;
			room = timesuproom;
			state = States.timesup;
			sprite_index = spr_Timesup;
			image_index = 0;
			event_play_oneshot("event:/music/timesup");
		}
		instance_destroy();
	}
}

savedCamX = x - camera_get_view_x(view_camera[0]);
savedCamY = y - camera_get_view_y(view_camera[0]);
