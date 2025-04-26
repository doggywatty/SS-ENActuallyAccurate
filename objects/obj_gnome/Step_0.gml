don += 0.35;
if ((place_meeting(x, y, obj_donut_mines_collect) || (place_meeting(x, y, obj_parent_player) && global.Donutfollow)) && ds_list_find_index(global.SaveRoom, id) == -1)
{
    with instance_place(x, y, obj_parent_donut)
        instance_destroy();
    ds_list_add(global.SaveRoom, id);
    global.ComboTime = 60;
    sprite_index = spr_gnomeMinerBlowingUp;
    image_index = 0;
    image_xscale *= -1;
}

if (sprite_index == spr_gnomeMinerBlowingUp)
{
    image_index = 0;
    instance_create(x, y, obj_bombExplosion);
    sprite_index = spr_gnomeMinerBlewUp;
    image_xscale *= -1;
    with obj_gnomeTNTBlock
    {
        if (colorID == other.colorID)
            alarm[0] = random_range(15, 50);
    }
    camera_shake_add(20, 40);
}

if (sprite_index == spr_gnomeMinerBlewUp && floor(image_index) >= (image_number - 1))
{
    image_index = 0;
    sprite_index = spr_gnomeMinerIdle;
}
