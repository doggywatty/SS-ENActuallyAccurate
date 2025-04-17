if (hsp != 0)
    hsp = approach(hsp, 0, 0.25);

with obj_parent_player
{
    if (sprite_index != spr_petdog)
        other.visible = true;
}

if (state == 1)
{
    image_blend = c_gray;
    x = approach(x, instance_nearest(x, y, obj_lips).x, cbspeed);
    y = approach(y, instance_nearest(x, y, obj_lips).y, cbspeed);
    cbspeed = approach(cbspeed, 20, 1);
}
