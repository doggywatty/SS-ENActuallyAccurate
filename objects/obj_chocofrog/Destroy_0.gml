if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	event_play_oneshot("event:/SFX/enemies/kill");
	event_play_oneshot((object_index == obj_chocofrog) ? "event:/SFX/general/frogdeathbig" : "event:/SFX/general/frogdeath", x, y);
	obj_parent_player.superTauntBuffer++;
	global.Combo++;
	var _score = 10 + floor(global.Combo / 2);
	global.Collect += _score;
	global.ComboScore += _score;
	global.ComboTime = 60;
	global.ComboFreeze = 15;
	create_particle((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), spr_bangEffect);
	repeat 3
	{
		with create_debris(x, y, spr_slapstar)
		{
			hsp = random_range(-5, 5);
			vsp = random_range(-10, 10);
		}
	}
	with (instance_create((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), obj_baddieDead))
		sprite_index = other.deadSpr;
	ds_list_add(global.SaveRoom, id);
}
