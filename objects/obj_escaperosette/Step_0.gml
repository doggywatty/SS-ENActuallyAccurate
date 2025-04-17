switch state
{
    case 0:
        x = -100;
        y = -100;
        visible = false;
        if (global.panic && point_distance(xstart, ystart, obj_parent_player.x, obj_parent_player.y) <= 375)
        {
            with obj_escaperosette
                state = 0;
            
            state = 1;
            vsp = 20;
            sprite_index = fallspr;
            x = xstart;
            y = camera_get_view_y(view_camera[0]) - 100;
        }
        break;
    case 1:
        visible = true;
        y += vsp;
        if (vsp < 20)
            vsp += 0.5;
        if (y >= ystart)
        {
            y = ystart;
            state = 2;
            sprite_index = pointspr;
            image_index = 0;
        }
        break;
}
