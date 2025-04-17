instance_destroy();

with instance_create(x, y, obj_baddieDead)
{
    canrotate = true;
    image_xscale = other.image_xscale;
    image_blend = other.image_blend;
    sprite_index = spr_dartDead;
    hsp = sign(image_xscale) * other.velocity;
    vsp = 0;
}
