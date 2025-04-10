canCollide = function(player = obj_parent_player)
{
    return false;
};

event_inherited();
scr_collision_init();
grav = 0.5;
dhsp = 0;
dvsp = 0;
spinspeed = 0;
image_speed = 0;
image_index = global.PainterTopperIndex;

if isDemo && global.InternalLevelName == "none"
    instance_destroy();
