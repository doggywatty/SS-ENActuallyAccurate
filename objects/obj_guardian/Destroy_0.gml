with instance_create(x, y, obj_baddieDead)
{
    image_xscale = other.image_xscale;
    image_blend = other.image_blend;
    sprite_index = spr_guardianohbye;
}
create_particle(x, y + 30, spr_bangEffect);
create_particle(x, y, spr_genericPoofEffect);
event_play_oneshot("event:/SFX/player/punch", x, y);
event_play_oneshot("event:/SFX/enemies/kill", x, y);
