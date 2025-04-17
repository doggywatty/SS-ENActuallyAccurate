if (other.state == States.minecart && !other.hurted && other.sprite_index != spr_player_PZ_minecart_spinOut)
{
    with other
    {
        sprite_index = spr_player_PZ_minecart_spinOut;
        image_index = 0;
        instance_create(x, y, obj_bumpEffect);
        instance_create(x, y, obj_spikehurteffect);
        alarm[7] = 120;
        hurted = true;
        alarm[5] = 2;
        event_play_oneshot("event:/SFX/minecart/spin", x, y);
        if chance(50)
            fmod_studio_event_instance_start(voiceHurt);
    }
    with obj_achievementTracker
        hitInMinecart = true;
}

