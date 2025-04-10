if (collectvanish && collectboxid.activated)
{
    x = xstart;
    y = ystart;
    instance_create(x + (sprite_width / 2), y + (sprite_height / 2), obj_puffEffect);
    repeat 3
        instance_create(x + (sprite_width / 2) + random_range(-5, 5), y + (sprite_height / 2) + random_range(-5, 5), obj_puffEffect);
    collectvanish = false;
    in_the_void = false;
}

if (!collectvanish && global.panic)
{
    if (distance_to_object(obj_parent_player) < 26 && !gotowardsPlayer)
        gotowardsPlayer = true;
}

if gotowardsPlayer
{
    move_towards_point(obj_parent_player.x, obj_parent_player.y, movespeed);
    movespeed++;
}
