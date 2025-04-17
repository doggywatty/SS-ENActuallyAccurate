with obj_teleporter
{
    if (trigger == other.trigger && reciever)
    {
        obj_dogMount.x = x;
        obj_dogMount.y = y - 20;
        alarm[2] = 10;
    }
}

alarm[1] = 10;
