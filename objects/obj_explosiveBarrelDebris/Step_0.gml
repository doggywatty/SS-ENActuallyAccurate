if (vsp < 20)
    vsp += grav;

x += hsp;
y += floor(vsp);

if !alarm[0]
    alarm[0] = 5;

drawx = x;
drawy = y;

if (place_meeting_collision(x + hsp, y + vsp))
{
    instance_create(x, y, obj_bombExplosionPlayer);
    instance_destroy();
}
