function state_player_superslam()
{
    static cloudeffect = 8;
    static mach3effect = 5;
    static piledrivereffect = 15;
    
    if (dir != xscale)
    {
        dir = xscale;
        movespeed = 0;
    }
    
    move = key_left + key_right;
    if (move != 0)
        xscale = move;
    
    hsp = move * movespeed;
    movespeed = (move == 0) ? 0 : 5;
    if (vsp >= 0)
    {
        vsp += 0.5;
        if !mach3effect--
        {
            with (create_afterimage(choose(AfterImageType.mach3effect1, AfterImageType.mach3effect2), xscale, true))
                basicAfterimage = false;
            
            mach3effect = 5;
        }
        if !cloudeffect--
        {
            create_particle(x + irandom_range(-25, 25), y + irandom_range(-10, 35), spr_cloudEffect);
            cloudeffect = 8;
        }
        if (vsp >= 17 && !piledrivereffect--)
        {
            instance_create(x, y, obj_piledrivereffect, 
            {
                playerID: id
            });
            piledrivereffect = 15;
        }
    }
    
    if (freeFallSmash >= 10 && sprite_index != spr_piledriverland)
    {
        if !instance_exists(groundpoundEffect)
        {
            groundpoundEffect = instance_create(x, y + 32, obj_groundPoundEffect, 
            {
                playerID: id
            });
        }
    }
    if (sprite_index == spr_piledriver && vsp > 0)
        freeFallSmash++;
    else
        freeFallSmash = -14;
    
    machTwo = 0;
    if (sprite_index == spr_piledriverIntro && sprite_animation_end())
    {
        sprite_index = spr_piledriver;
        image_index = 0;
    }
    
    move = 0;
    hsp = 0;
    if (sprite_index == spr_piledriverIntro || sprite_index == spr_piledriver)
    {
        move = key_left + key_right;
        hsp = move * movespeed;
    }
    
    if ((sprite_index == spr_piledriver || sprite_index == spr_piledriverIntro) && grounded && !place_meeting(x, y + 1, obj_destructibles) && vsp > 0)
    {
        sprite_index = spr_piledriverland;
        image_index = 0;
        event_play_oneshot("event:/SFX/player/groundpound", x, y);
        jumpAnim = true;
        jumpStop = false;
        hsp = 0;
        create_particle(x, y + 35, spr_bangEffect);
        create_particle(x, y + 3, spr_groundpoundLandEffect);
        instance_create(x, y, obj_landcloud);
        freefallstart = 0;
        if (freeFallSmash >= 10)
        {
            camera_shake_add(10, 30);
            with obj_parent_enemy
            {
                if (bbox_in_camera(id, view_camera[0]) && grounded && id != other.baddieGrabbedID)
                {
                    state = States.charge;
                    baddieStunTimer = 120;
                    vsp = -11;
                    image_xscale *= -1;
                    hsp = 0;
                }
            }
        }
        else
            camera_shake_add(20, 40);
    }
    
    jumpAnim = true;
    landAnim = false;
    machSlideAnim = true;
    crouchAnim = true;
    if (sprite_index == spr_piledriverland)
    {
        if (sprite_animation_end())
        {
            jumpStop = false;
            state = States.jump;
            grounded = false;
            sprite_index = spr_piledriverJump;
            image_index = 0;
            vsp = -11;
            grav = 0.3;
            with baddieGrabbedID
            {
                x = other.x;
                y = other.y;
                scr_instakillEnemy(id, other.id);
            }
            baddieGrabbedID = -4;
        }
    }
    
    if (move != 0)
    {
        if (movespeed < 6)
            movespeed += 0.25;
        else if (floor(movespeed) == 5)
            movespeed = 6;
    }
    else
        movespeed = 0;
    
    if (movespeed > 6)
        movespeed -= 0.1;
    if (vsp < 0)
        image_speed = 0.35;
    else
        image_speed = 0.5;
}

