event_inherited();
with instance_create(x, y - sprite_yoffset, obj_baddieDead)
{
    vsp = random_range(-7, -10);
    hsp = random_range(5, 10) * other.DestroyedBy.image_xscale;
    rotatevalue = random_range(5, 10);
    rotatedirection = other.DestroyedBy.image_xscale;
    canrotate = true;
    sprite_index = spr_clutterTrash_destroyed;
    image_index = 1;
    image_speed = 0;
}
