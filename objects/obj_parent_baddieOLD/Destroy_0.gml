if (ds_list_find_index(global.BaddieRoom, id) != -1 && !importantEnemy)
	exit;

repeat 3
{
	with (create_debris(x, y, choose(spr_slapstar, spr_baddieGibs)))
	{
		hsp = random_range(-5, 5);
		vsp = random_range(-10, 10);
	}
}

create_particle(x, y + 30, spr_bangEffect);
camera_shake_add(3, 3);
enemyDeath_SpawnBody();

if (global.InternalLevelName == "dance")
	instance_create(x, y, obj_enemyFirework);

event_play_oneshot("event:/SFX/player/punch", x, y);
event_play_oneshot("event:/SFX/enemies/kill", x, y);
global.ComboTime = 60;

if importantEnemy
	exit;

if giveScore
{
	obj_parent_player.superTauntBuffer++;
	global.Combo++;
	var _score = 10 + floor(global.Combo / 2);
	global.Collect += _score;
	global.ComboScore += _score;
}

ds_list_add(global.BaddieRoom, id);

if escapeEnemy
	ds_list_add(global.EscapeRoom, id);
