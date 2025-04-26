depth = obj_hudManager.depth - 1;
global.RespawnBlockMoving = true;
state = 0;
staticdex = 0;
chardex = irandom_range(0, sprite_get_number(spr_technicaldifficulty_pizzy));
alarm[0] = 80;
event_play_oneshot("event:/SFX/ui/tvswitch");