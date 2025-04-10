if (state == States.frozen && other.state != States.comingoutdoor
&& other.hsp == 0 && other.grounded && other.key_up2)
{
    state = States.normal;
    playerID = other.id;
    other.state = States.actor;
    other.key_up2 = 0;
    other.movespeed = 0;
    other.hsp = 0;
    other.sprite_index = other.spr_idle;
    other.image_speed = 0.35;
}

