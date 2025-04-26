repeat 3
{
	instance_create(x, y, obj_slapstar);
	instance_create(x, y, obj_baddieGibs);
}

instance_create(x, y + 30, obj_bangEffect);
camera_shake_add(3, 3);
enemyDeath_SpawnBody();
obj_parent_player.superTauntBuffer++;
global.Combo++;
var _score = 10 + floor(global.Combo / 2);
create_small_number(x, y, string(_score));
global.Collect += _score;
global.ComboTime = 60;
with obj_sucroseTimer
	timer += time_in_frames(0, 3);
ds_list_add(global.BaddieRoom, id);
