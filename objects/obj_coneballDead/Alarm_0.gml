with instance_create(x, y, obj_baddieDead)
{
    canrotate = false;
    sprite_index = other.sprite_index;
    image_xscale = other.image_xscale;
}

event_play_oneshot("event:/SFX/enemies/kill");
instance_destroy();
