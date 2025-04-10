canCollide = function(player = obj_parent_player)
{
    switch player
    {
        case obj_parent_player:
        case obj_player1:
        case obj_player2:
            return player.state != States.cottondig && player.sprite_index != spr_player_PZ_werecotton_spin;
            break;
        default:
            return true;
            break;
    }
};

