if (other.state == PlayerState.doughmount || other.state == PlayerState.doughmountspin || other.state == PlayerState.doughmountballoon)
{
	event_play_multiple("event:/SFX/general/collect", x, y);
	create_small_number(xorigin + (sprite_width / 2), yorigin + (sprite_height / 2), "10");
	global.Collect += 10;
	global.PizzaMeter += 1;
	global.ComboTime += 10;
	scr_ghostcollectible(false);
	create_collect_effect(x, y, sprite_index, 10);
	instance_destroy();
}
