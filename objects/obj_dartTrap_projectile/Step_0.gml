x += (dcos(image_angle) * sign(image_xscale) * velocity);
y += (dsin(image_angle) * velocity);

if (!bbox_in_camera(id, view_camera[0], 128) && !parried)
    instance_destroy();
else if (!bbox_in_rectangle(id, -128, -128, room_width + 128, room_height + 128))
    instance_destroy();

if (!instance_exists(ownerID))
{
    with instance_create(x, y, obj_baddieDead)
    {
        canrotate = true;
        image_xscale = other.image_xscale;
        image_blend = other.image_blend;
        sprite_index = spr_dartDead;
        hsp = sign(image_xscale) * other.velocity;
        vsp = 0;
    }
    
    instance_destroy();
}
