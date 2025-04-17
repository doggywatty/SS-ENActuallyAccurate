if (!obj_parent_player.superTauntCharged)
    instance_destroy();
with obj_parent_enemy
{
    if (bbox_in_camera(id, view_camera[0]) && !invincibleBaddie)
    {
        debris = false;
        camera_shake_add(10, 30);
        instance_destroy();
        with instance_create(x, y, obj_shake)
        {
            sprite_index = other.baddieSpriteDead;
            paletteSprite = other.paletteSprite;
            paletteSelect = other.paletteSelect;
            alarm[0] = 30;
        }
    }
}
