event_inherited();
with instance_create(x, y + 16, obj_explosiveBarrelDebris)
{
    vsp = random_range(-7, -10);
    hsp = 11 * other.DestroyedBy.image_xscale;
    rotatevalue = random_range(5, 10);
    rotatedirection = other.DestroyedBy.image_xscale;
    canrotate = true;
    sprite_index = spr_explosiveBarrel_destroyed;
    image_speed = 0;
}
