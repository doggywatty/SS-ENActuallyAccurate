if (state == States.frozen)
{
    if (other.state != States.oldtaunt && other.state != States.frozen && other.state != States.noclip && other.state != States.taunt)
    {
        with other
        {
            other.x = other.xstart;
            other.y = other.ystart;
            scr_taunt_storeVariables();
            state = States.oldtaunt;
            other.playerID = id;
        }
        state = States.titlescreen;
    }
}

