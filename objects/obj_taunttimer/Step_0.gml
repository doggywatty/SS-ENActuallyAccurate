if ((obj_parent_player.x > (x - 200) && obj_parent_player.x < (x + 200)) && (y <= (obj_parent_player.y + 200) && y >= (obj_parent_player.y - 200)))
{
    if (timer != -2)
        timer -= 0.1;
    
    if (timer == -2 && obj_parent_player.state == States.taunt)
        timer = 20;
    
    if (timer == -2 && obj_parent_player.state != States.taunt)
    {
        with obj_parent_player
            scr_hurtplayer();
        
        if (obj_parent_player.state != States.hurt)
            timer = 20;
    }
}

