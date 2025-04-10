depth = 0;
image_speed = 0.35;
playerID = -4;
step_function = -4;
followPlayer = false;

particle_imgspd = function(_img_spd)
{
    image_speed = _img_spd;
    return self;
};

particle_depth = function(_depth)
{
    depth = _depth;
    return self;
};

particle_scale = function(_img_xscale, _img_yscale)
{
    image_xscale = _img_xscale;
    image_yscale = _img_yscale;
    return self;
};

particle_followobj = function(_playerID)
{
    if instance_exists(_playerID)
    {
        playerID = _playerID;
        followPlayer = true;
        x = playerID.x;
        y = playerID.y;
    }
    return self;
};
