if grounded
{
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
    
    depth = (place_meeting(x, y, obj_destructibles) || place_meeting(x, y, obj_metalblock)) ? 102 : 2;
}

if (state == 0)
    scr_collision();
else if (state == 1)
{
    x = playerID.x;
    y = playerID.y - 40;
    image_xscale = playerID.xscale;
    if (playerID.state != States.grab)
        state = 0;
}

