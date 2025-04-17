alarm[0] = 60;
shake = 12;
sprite_index = spr_blotchsplotch_dead;

with instance_create(x, y, obj_baddieDead)
{
    canrotate = false;
    sprite_index = spr_blotchsplotch_deadwing;
    image_index = 0;
    image_xscale = other.image_xscale;
    vsp = -4;
    hsp = -4;
}

with instance_create(x, y, obj_baddieDead)
{
    canrotate = false;
    sprite_index = spr_blotchsplotch_deadwing;
    image_index = 0;
    image_xscale = other.image_xscale;
    vsp = -4;
    hsp = 4;
}
