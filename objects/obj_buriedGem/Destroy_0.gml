if (ds_list_find_index(global.SaveRoom, id) != -1 || playerID == -4)
	exit;
if (playerID.minesGemCount < 4)
{
	with instance_create(x, y + 32, obj_minesgempiece)
	{
		playerID = other.playerID;
		count = playerID.minesGemCount;
	}
	playerID.minesGemCount += 1;
}
if !instance_exists(obj_minesgem)
{
	with instance_create(x, y, obj_minesgem)
	{
		playerID = other.playerID;
		gemCount = playerID.minesGemCount - 1;
		if !instance_exists(obj_minesgempiece)
			gemCount = playerID.minesGemCount;
	}
}
with obj_minesgem
{
	refined = false;
	collected = false;
}
var val = playerID.minesGemCount;
fmod_studio_system_set_parameter_by_name("collectedGems", val, true);
event_play_multiple("event:/SFX/general/gemCollect", x, y);
global.ComboTime += 10;
ds_list_add(global.SaveRoom, id);
