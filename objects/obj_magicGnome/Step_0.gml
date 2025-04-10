var target_player = get_nearestPlayer();
if (distance_to_object(target_player) <= 350 || global.LevelMinutes >= 1)
{
	if (ds_list_find_index(global.SaveRoom, id) == -1)
	{
		ds_list_add(global.SaveRoom, id);
		event_play_oneshot("event:/SFX/general/teleporterstart", x, y);
		create_particle(x, y, spr_parryeffect);
	}
	instance_destroy();
}
