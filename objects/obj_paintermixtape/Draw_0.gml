if (obj_parent_player.state == States.actor && obj_parent_player.sprite_index == obj_parent_player.spr_gotTreasure)
{
    treasureEffect.draw(playerID.x, playerID.y - 40).update();
    draw_sprite(sprite_index, image_index, x, y + 20);
}
else
    draw_sprite(sprite_index, image_index, x, y + bobsin);
