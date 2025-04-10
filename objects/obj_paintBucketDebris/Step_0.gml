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
    random_set_seed(global.RandomSeed + (x + hsp) + (y + vsp));
    
    repeat 3
        create_destroyable_smoke(x + hsp + irandom_range(-5, 5), y + vsp + irandom_range(-5, 5), choose(49240, 16273576, 16295984, 12512));
    
    random_set_seed(global.RandomSeed);
    event_play_oneshot("event:/SFX/player/splat", x + hsp, y + vsp);
    instance_destroy();
}
