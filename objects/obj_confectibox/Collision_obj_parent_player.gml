with obj_creamThief
{
	hsp = 0;
	vsp = 0;
	state = States.frozen;
	sprite_index = spr_creamthief_lose;
	ds_list_add(global.SaveRoom, id, false);
	instance_create(x, y, obj_creamThiefCar);
	event_play_oneshot("event:/SFX/general/winrace");
}

var _content = instance_create(x + (sprite_width / 2), y + (sprite_height / 2), BoxContent);
if (object_get_parent(_content.object_index) == obj_parent_confecti)
{
	create_particle((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), spr_taunteffect).particle_depth(_content.depth + 1);
	event_play_oneshot("event:/SFX/general/collectfollower");
	helptimer = -1;
	global.ToppinTotal += 1;
	var confecti_prompt_type = (global.ToppinTotal >= 5) ? "last_confecti_found" : "confecti_found";
	var confecti_prompt = ((global.InternalLevelName == "tutorial") ? "prompt_tut_" : "prompt_") + confecti_prompt_type;
	var _string = lang_get(confecti_prompt, [global.ToppinTotal]);
	scr_queueToolTipPrompt(_string);
	global.Collect += 1000;
	scr_queueTVAnimation(global.TvSprPlayer_Happy, 150);
	create_small_number((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), 1000);
	global.ComboFreeze = 15;
	global.ComboTime = 60;
}
repeat 6
	create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_confecticage_debris);

instance_destroy();
ds_list_add(global.SaveRoom, id);
