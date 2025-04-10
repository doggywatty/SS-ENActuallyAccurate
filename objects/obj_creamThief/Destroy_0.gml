var deadID = string($"{id}Killed");
if (ds_list_find_index(global.SaveRoom, deadID) != -1)
	exit;
repeat 3
{
	instance_create(x, y, obj_slapstar);
	instance_create(x, y, obj_baddieGibs);
}

create_particle(x, y + 30, spr_bangEffect);
create_particle(x, y, spr_genericPoofEffect);
camera_shake_add(3, 3);

with instance_create(x, y, obj_baddieDead)
{
	image_xscale = other.image_xscale;
	image_blend = other.image_blend;
	sprite_index = spr_creamthief_heartattack;
}

event_play_oneshot("event:/SFX/enemies/thiefDead", x, y);
event_play_oneshot("event:/SFX/player/punch", x, y);
event_play_oneshot("event:/SFX/enemies/kill", x, y);
ds_list_add(global.SaveRoom, deadID);
