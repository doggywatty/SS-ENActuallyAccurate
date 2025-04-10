with other
{
    if (key_up && !place_meeting_collision(other.x + (other.sprite_width / 2), round(y), Exclude.MOVINGANDPLATFORMS) && !inputLadderBuffer && (state == States.normal || state == States.uppercut || state == States.mach2 || state == States.mach3 || state == States.mach1 || state == States.jump) && state != States.hurt && state != States.machslide && state != States.freefall && state != States.freefallland)
    {
        hsp = 0;
        vsp = 0;
        state = States.ladder;
        x = other.x + (other.sprite_width / 2);
        y = round(y);
        
        if ((y % 2) == 1)
            y -= 1;
    }
}

