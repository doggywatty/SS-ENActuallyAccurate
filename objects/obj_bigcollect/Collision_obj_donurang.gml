event_play_multiple("event:/SFX/general/collectbig", xorigin + (sprite_width / 2), yorigin + (sprite_height / 2));
scr_queueTVAnimation(global.TvSprPlayer_Happy, 150);
var val = 100;
create_small_number(xorigin + (sprite_width / 2), yorigin + (sprite_height / 2), string(val));
global.Collect += val;
global.ComboTime = 60;
create_collect_effect(x, y, sprite_index, val);
scr_ghostcollectible(false);
instance_destroy();
