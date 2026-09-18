depth = 0;
image_speed = 0.35;
playerID = -4;
step_function = -4;
followPlayer = false;

particle_imgspd = function(arg0)
{
	image_speed = arg0;
	return self;
};

particle_depth = function(arg0)
{
	depth = arg0;
	return self;
};

particle_scale = function(arg0, arg1)
{
	image_xscale = arg0;
	image_yscale = arg1;
	return self;
};

particle_followobj = function(arg0)
{
	if (instance_exists(arg0))
	{
		playerID = arg0;
		followPlayer = true;
		x = playerID.x;
		y = playerID.y;
	}
	
	return self;
};
