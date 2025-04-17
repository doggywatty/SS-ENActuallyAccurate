with obj_teleporter
{
    if (trigger == other.trigger && reciever)
    {
        obj_parent_player.x = x;
        obj_parent_player.y = y - 20;
        alarm[2] = 10;
    }
}

alarm[1] = 10;
