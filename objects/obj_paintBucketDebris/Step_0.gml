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
    create_particle(x + hsp, y + vsp, spr_bangEffect);
    instance_create(x + hsp, y + vsp, obj_tilePaintSplatter);
	event_play_oneshot("event:/SFX/general/paintbucket", x + hsp, y + vsp);
    instance_destroy();
}
