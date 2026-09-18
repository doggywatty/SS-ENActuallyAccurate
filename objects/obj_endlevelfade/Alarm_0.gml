if (global.InternalLevelName == "tutorial")
{
	global.InternalLevelName = "none";
	instance_create(x, y, obj_fadeoutTransition, 
	{
		levelStart: true,
		goToHub: true
	});
	alarm[0] = -1;
	instance_destroy();
	exit;
}

instance_create_depth(PlayerX, PlayerY, -6, obj_rank);
PlayerX = 480;
PlayerY = 270;
