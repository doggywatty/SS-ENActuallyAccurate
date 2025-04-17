function state_player_pal()
{
    move = key_left2 + key_right2;
    move2 = key_up2 - key_down2;
    
    if (move != 0)
    {
        paletteSelect = wrap(paletteSelect + move, 1, sprite_get_width(paletteSprite) - 1);
        with obj_palexample
        {
            instance_create_depth(x, y, -6, obj_poofeffect);
            sprite_index = spr_pizzelleselectedpal;
            image_index = 0;
        }
    }
    if key_jump
    {
        event_play_oneshot("event:/SFX/ui/confirm");
        tate = States.normal;
        targetRoom = hub_w1;
        targetDoor = "C";
        instance_create(x, y, obj_fadeoutTransition);
    }
    sprite_index = spr_idle;
}

