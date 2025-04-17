if (fadealpha > 1)
{
    fadein = 1;
    if (room != rank_room)
    {
        room_goto_fixed(rank_room);
        with obj_parent_player
        {
            x = other.PlayerX;
            y = other.PlayerY;
        }
    }
}
if (fadein == 0)
    fadealpha += 0.1;
else if (fadein == 1)
    fadealpha -= 0.1;
with obj_parent_player
{
    if (room == rank_room && other.fadealpha <= 0)
    {
        if (distance_to_point(480, 270) > 2)
        {
            other.PlayerX = lerp(other.PlayerX, 480, 0.05);
            other.PlayerY = lerp(other.PlayerY, 270, 0.05);
        }
        else
        {
            other.PlayerX = 480;
            other.PlayerY = 270;
        }
        x = other.PlayerX;
        y = other.PlayerY;
    }
}
