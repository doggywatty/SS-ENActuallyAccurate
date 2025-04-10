hsp = 0;
vsp = 0;
index = -1;
dead = false;
flash = false;
sprite_index = spr_null;
image_speed = 0.35;
image_index = 0;
spr_dead = spr_null;
x = -100;
y = -100;
playerPalette = false;

onClick = function()
{
    if dead
        exit;
    
    dead = true;
    flash = true;
    alarm[0] = 0.15 * room_speed;
    sprite_index = spr_dead;
    image_speed = 0;
    image_index = 0;
    
    with obj_creditsDemo
    {
        if (currentCategory <= array_length(killCounterArr))
            killCounterArr[currentCategory]++;
    }
    
    create_particle(x, y, spr_bangEffect);
    event_play_oneshot("event:/SFX/enemies/kill");
    hsp = random_range(10, 15) * sign(random_range(-1, 1));
    vsp = random_range(-5, -10);
};
