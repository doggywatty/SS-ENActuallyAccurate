scr_collision();
if (distance_to_object(obj_parent_player) < 400)
    pissedboost = 0;
else
    pissedboost = distance_to_object(obj_parent_player) / 10;

hsp = movespeed * xscale;
xscale = sign(obj_parent_player.x - x);

with (instance_place(x + xscale, y, obj_destructibles))
    instance_destroy();
with (instance_place(x + xscale, y, obj_metalblock))
    instance_destroy();

if ((obj_parent_player.x - staprange) > x || (obj_parent_player.x + staprange) < x)
{
    sprite_index = spr_thewalker_move;
    movespeed = approach(movespeed, 5 + pissedboost, 0.3);
}
else if !pissedboost
{
    sprite_index = spr_thewalker_idle;
    movespeed = approach(movespeed, 0, 0.3);
}

image_speed = 0.3 + (movespeed * 0.02);
