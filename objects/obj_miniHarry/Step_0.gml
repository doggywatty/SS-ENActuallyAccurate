event_inherited();
enemyAttack_TriggerEvent();

if (state == States.titlescreen && sprite_index == spr_miniharry_run)
{
    canBreakBlocks = true;
    doRedAfterImage = true;
    if !instance_exists(hurtboxID)
    {
        with (instance_create(x, y, obj_forkhitbox, 
        {
            ID: other.id
        }))
        {
            other.hurtboxID = id;
            ID = other.id;
            image_xscale = other.image_xscale;
            image_index = other.image_index;
            depth = -1;
            sprite_index = spr_swordhitbox;
            mask_index = sprite_index;
        }
    }
}

