if (laughing == false)
{
	event_play_multiple("event:/SFX/enemies/bearLaugh", xorigin + (sprite_width / 2), yorigin + (sprite_height / 2));
	event_play_multiple("event:/SFX/general/collectbig", xorigin + (sprite_width / 2), yorigin + (sprite_height / 2));
	scr_queueTVAnimation(global.TvSprPlayer_Happy, 150);
	var val = 50;
	create_small_number(xorigin + (sprite_width / 2), yorigin + (sprite_height / 2), string(val));
	global.Collect += val;
	global.ComboTime = 60;
	scr_ghostcollectible();
	laughing = true;
	sprite_index = spr_bigcollectclocklaugh;
}
