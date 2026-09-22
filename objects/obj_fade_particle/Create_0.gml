//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPAD
depth = 0;
image_speed = 0.35;
playerID = noone;
step_function = noone;
followPlayer = false;
particle_imgspd = function(_imgspd)
{
	image_speed = _imgspd;
	return self;
};
//
particle_depth = function(_depth)
{
	depth = _depth;
	return self;
};
//P
particle_scale = function(_img_xscale, _img_yscale)
{
	image_xscale = _img_xscale;
	image_yscale = _img_yscale;
	return self;
};
//PADDINGPA
particle_followobj = function(_playerID)
{
	if (instance_exists(_playerID))
	{
		playerID = _playerID;
		followPlayer = true;
		x = playerID.x;
		y = playerID.y;
	}
	return self;
};
