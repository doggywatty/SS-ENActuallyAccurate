canCollide = function(player = obj_parent_player)
{
    switch player
    {
        case obj_parent_player:
        case obj_player1:
        case obj_player2:
            return player.state != States.minecart && player.state != States.minecart_bump && player.state != States.minecart_launched;
            break;
        default:
            return true;
            break;
    }
};
image_speed = 0.05;
