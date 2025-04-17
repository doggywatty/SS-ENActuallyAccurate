with obj_parent_player
{
    if (hsp != 0 && (floor(image_index) % 4) == 0 && grounded)
        create_debris(x, y + 43, spr_snowparticles);
}
