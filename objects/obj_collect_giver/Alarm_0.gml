collect -= 10;
global.Collect += 10;
event_play_multiple("event:/SFX/general/collect", x, y);
create_collect_effect(x, y, collect_sprite, 10);

if (collect > 0)
	alarm[0] = 5;
else
	instance_destroy();
