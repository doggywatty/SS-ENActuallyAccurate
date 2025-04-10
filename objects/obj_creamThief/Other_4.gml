var _raceOver = ds_list_find_index(global.SaveRoom, id) != -1;
var _ind = ds_list_find_index(global.SaveRoom, id);
var _won = ds_list_find_value(global.SaveRoom, _ind + 1);
var _killed = ds_list_find_index(global.SaveRoom, string($"{id}Killed")) != -1;
if _raceOver
{
	with obj_creamThiefLoseTrigger
	{
		other.x = bbox_left + ((bbox_right - bbox_left) / 2);
		other.y = y;
	}
	with obj_racelight
		finale = true;
	sprite_index = _won ? spr_creamthief_victory : spr_creamthief_lose;
	vsp = 30;
	scr_collision();
	state = States.frozen;
	instance_create(x, y, obj_creamThiefCar);
}
if _killed
{
	instance_destroy();
	exit;
}
