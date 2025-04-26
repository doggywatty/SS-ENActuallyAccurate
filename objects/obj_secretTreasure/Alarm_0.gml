scr_queueTVAnimation(global.TvSprPlayer_Happy, 150);
global.Collect += 3000;
global.PizzaMeter += 5;
create_small_number(x, y, "3000");
global.ComboTime = 60;
global.Treasure = true;
with playerID
{
    scr_taunt_setVariables();
    move = key_right + key_left;
    if (move != 0)
        xscale = sign(move);
}

instance_destroy();
