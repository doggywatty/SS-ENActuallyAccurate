alarm[0] = -1;
staticdex = sprite_get_number(spr_static_tech) - 1;
state = 2;
event_play_oneshot("event:/SFX/ui/tvswitchback");
obj_camera.cameraLock = false;

with obj_parent_player
{
    scr_playerrespawn(false);
	movespeed = 0;
    hsp = 0;
    vsp = 0;
    
    if (other.drowned)
        wetTimer = wetTimerMax;
}
