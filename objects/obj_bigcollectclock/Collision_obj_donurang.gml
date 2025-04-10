event_play_multiple("event:/SFX/general/collect", x, y);
scr_queueTVAnimation(global.TvSprPlayer_Happy, 150);
var val = 100;
create_small_number((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), string(val));
global.Collect += val;
global.ComboTime = 60;
create_collect_effect(x, y, sprite_index, val);
scr_ghostcollectible();
instance_destroy();
