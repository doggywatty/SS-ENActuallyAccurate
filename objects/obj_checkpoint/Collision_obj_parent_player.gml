if !Checkpointactivated
{
    with obj_checkpoint
        Checkpointactivated = false;
    
    Checkpointactivated = true;
    if visible
        event_play_multiple("event:/SFX/general/checkpoint", (x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2));
}
