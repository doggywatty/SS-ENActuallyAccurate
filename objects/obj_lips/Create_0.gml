depth = 1;
suck = false;
caught = false;
alarm[0] = 100;
enemyDeath_SpawnBody = function()
{
    with instance_create(x, y, obj_baddieDead)
    {
        canrotate = true;
        image_xscale = other.image_xscale;
        image_blend = other.image_blend;
        sprite_index = other.baddieSpriteDead;
    }
};
baddieSpriteDead = spr_lips_idle;
