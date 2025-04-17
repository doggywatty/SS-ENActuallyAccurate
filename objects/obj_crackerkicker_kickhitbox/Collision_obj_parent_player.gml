if (place_meeting(x, y, obj_parryhitbox) || global.freezeframe)
    exit;
with other.id
{
    if (instance_exists(other.baddieID) && !cutscene && scr_transformationCheck(state) == undefined && !hurted && state != States.door && state != States.victory && state != States.comingoutdoor && state != States.noclip && state != States.tumble && state != States.fling && state != States.fling_launch && state != States.dodgetumble && state != States.cotton && state != States.cottondrill && state != States.cottonroll && sprite_index != spr_tumbleend)
    {
        state = States.tumble;
        image_speed = 0.35;
        xscale = other.baddieID.image_xscale;
        movespeed = 10;
        vsp = 0;
        sprite_index = spr_tumble;
    }
}
if instance_exists(baddieID)
    baddieID.baddieInvincibilityBuffer = 50;
