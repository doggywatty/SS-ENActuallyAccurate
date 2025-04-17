if !instance_exists(obj_minesgem)
	instance_create(x, y, obj_minesgem);

var player = other.id;
var saveroom_ind = ds_list_find_index(global.SaveRoom, id);
var gems_refined = ds_list_find_value(global.SaveRoom, saveroom_ind + 1);
if (player.minesGemCount > 0 && gemsRefined < 4)
{
	with obj_minesgempiece
		instance_destroy();
	with obj_minesgem
	{
		refined = true;
		image_index = 0;
		playerID = player;
		gemCount = playerID.minesGemCount;
		sprite_index = spr_minesgemrefined;
		alarm[1] = 30;
		idleGem = false;
	}
	image_index = 0;
	sprite_index = spr_gnomeMinerAppreciate;
	var collect_amount = 50 * player.minesGemCount;
	gemsRefined += player.minesGemCount;
	if (gemsRefined >= 4)
	{
		event_play_oneshot("event:/SFX/gnome/thanks", x, y);
		collect_amount += 50;
		if !array_contains(obj_achievementTracker.gnomeMinersSatisfied, id)
			obj_achievementTracker.gnomeMinersSatisfied[array_length(obj_achievementTracker.gnomeMinersSatisfied)] = id;
		with instance_create(x, y, obj_collect_giver)
		{
			collect_sprite = spr_gem_points;
			collect = 50;
		}
	}
	else
		event_play_oneshot("event:/SFX/gnome/inspect", x, y);
	
	event_play_oneshot("event:/SFX/general/refineGem", x, y);
	global.ComboTime = 60;
	create_small_number(x, y, string(collect_amount));
	obj_player1.minesGemCount = 0;
	ds_list_set(global.SaveRoom, saveroom_ind + 1, gemsRefined);
}
