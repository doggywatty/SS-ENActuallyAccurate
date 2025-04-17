event_inherited();
onewayDeathSprite = spr_lemonheadblockdead;
onewayRank = 1;
solidid = -4;
if (ds_list_find_index(global.SaveRoom, id) == -1)
{
    with instance_create(x, y, obj_solid)
    {
        other.solidid = id;
        image_xscale = other.image_xscale;
        image_yscale = other.sprite_height / 32;
        mask_index = spr_onewaysolidMASK;
    }
}
image_speed = 0.35;
