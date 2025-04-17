function state_player_slipnslide()
{
    machTwo = 0;
    jumpAnim = true;
    landAnim = false;
    crouchAnim = false;
    hsp = xscale * movespeed;
    movespeed = approach(movespeed, 0, 0.19);
    sprite_index = spr_slippingonice;
    image_speed = 0.35;
    
    if (movespeed <= 0)
    {
        state = States.normal;
        movespeed = 0;
        machTwo = 0;
        image_index = 0;
    }
    
    if (!grounded && vsp >= 0)
    {
        image_index = 0;
        image_speed = 0.35;
        sprite_index = spr_player_PZ_slipSlide_intro;
        state = States.puddle;
        vsp = -11;
        event_play_oneshot("event:/SFX/player/slip", x, y);
    }
    
    if (place_meeting_collision(x + xscale, y) && !place_meeting(x + xscale, y, obj_destructibles))
    {
        sprite_index = spr_player_PZ_fall_outOfControl;
        state = States.jump;
        vsp = -11;
        jumpStop = true;
        movespeed = 0;
    }
    
    if (!instance_exists(obj_slidecloud) && grounded && movespeed > 1.5)
    {
        with instance_create(x, y, obj_slidecloud)
            image_xscale = other.xscale;
    }
}

