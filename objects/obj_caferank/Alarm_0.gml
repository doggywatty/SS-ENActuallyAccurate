if (collect > 0)
{
	var difference = (collect >= 10) ? 10 : collect;
	global.Collect += difference;
	with obj_parent_player
	{
		create_small_number(x, y, string(difference));
		create_collect_effect(x, y, spr_collect5, difference);
	}
	
	collect -= difference;
	global.ComboTime += difference;
	global.ComboTime = clamp(global.ComboTime, 0, 60);
	event_play_multiple("event:/SFX/general/collect", x, y);
}
