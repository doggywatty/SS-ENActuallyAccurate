switch state
{
    case 0:
        global.RespawnBlockMoving = true;
        staticdex += 0.35;
        if (staticdex >= (sprite_get_number(spr_static_tech) - 1))
            state = 1;
        break;
    
    case 2:
        global.RespawnBlockMoving = false;
        staticdex -= 0.35;
        if (staticdex <= 0)
            instance_destroy();
        break;
}
global.ComboFreeze = 2;