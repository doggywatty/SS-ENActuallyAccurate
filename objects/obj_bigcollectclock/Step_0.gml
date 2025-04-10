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

if (laughing == true)
    image_alpha -= 0.05;
if (image_alpha <= 0)
    instance_destroy();
