function cutscene_judgment_init()
{
	cutscene_create([
		cutscene_start_player, cutscene_judgment_playermove, cutscene_judgment_start,
		cutscene_judgment_dialog, cutscene_judgment_flick, cutscene_judgment_end
	]);
	
	with obj_parent_player
	{
		cutscene_declare_actor(id, "PLAYER");
		visible = true;
		image_speed = 0.35;
		image_index = 0;
		xscale = 1;
		image_xscale = 1;
	}
	
	var cr = #718701;
	cr.Region_active = true;
	with obj_judgmentpainter
	{
		cutscene_declare_actor(id, "PAINTER");
		targetPlayer = cutscene_get_actor("PLAYER");
		x = cr.x + cr.sprite_width;
		y = cr.y + cr.sprite_width;
	}
}

function cutscene_judgment_playermove()
{
	with cutscene_get_actor("PLAYER")
	{
		if (place_meeting_collision(x + 32, y + 1))
		{
			x += 3;
			sprite_index = spr_move;
		}
		else
		{
			sprite_index = spr_idle;
			image_index = 0;
			image_speed = 0.35;
			cutscene_event_end();
		}
	}
}

function cutscene_judgment_start()
{
	with obj_judgmentpainter
	{
		if !active
		{
			givenJudgment = scr_judgment_assign();
			var d = array_clone(givenJudgment.properties.dialog);
			ini_open(global.SaveFileName);
			if (ini_read_real("Treasure", "mindpalace", 0) > 0)
				array_push(d, lang_get("judgmentinfo_additional"));
			ini_close();
			for (var i = 0; i < array_length(d); i++)
			{
				var s = scribble(d[i]).wrap(sprite_get_width(spr_dialobox_temp) - 80).line_spacing(30).starting_format(font_get_sprite(global.npcfont, true)).align(0, 0);
				array_push(dialogEvents, s);
			}
		}
		active = true;
		visible = true;
	}
	cutscene_event_end();
}

function cutscene_judgment_dialog()
{
	with obj_judgmentpainter
	{
		if finished
		{
			var cr = #718701;
			cr.Region_active = false;
			with obj_secret_brainBlock
			{
				instance_change(obj_secretdestroyable_metal, true);
				debrisSprite = spr_painterbraindebris;
				smokeColor = [ #A90861, #E95098, #E18BB2 ];
			}
			cutscene_event_end();
		}
	}
}

function cutscene_judgment_flick()
{
	static afterimage_timer = 2;
	with obj_parent_player
	{
		targetRoom = rm_credits;
		sprite_index = spr_player_PZ_flicked;
		x -= 18;
		y = ystart + random_range(-1, 1);
		if !instance_exists(obj_chargeEffect)
			instance_create(x, y, obj_chargeEffect);
		afterimage_timer = max(afterimage_timer - 1, 0);
		if (afterimage_timer <= 0)
		{
			with (create_afterimage(AfterImageType.plain, xscale, 0))
			{
				image_index = max(other.image_index - 1, 0);
				vanish = true;
				gonealpha = 0.8;
				alarm[0] = 1;
				alarm[1] = 60;
			}
			afterimage_timer = 2;
		}
		check_and_destroy(x - 18, y, obj_destructibles);
		check_and_destroy(x - 18, y, obj_metalblock);
		if (x <= -100)
		{
			x = -100;
			cutscene_event_end();
		}
	}
}

function cutscene_judgment_end()
{
	with instance_create(0, 0, obj_fadeoutTransition)
		fadespeed = 0.02;
	cutscene_event_end();
}

function cutscene_mindpalacedoor_prestart()
{
	var _seenCutscene = false;
	ini_open(global.SaveFileName);
	_seenCutscene = ini_read_real("Game", "mindpalace_door_cutscene", false);
	ini_close();
	if _seenCutscene
	{
		with obj_door
			visible = true;
		ds_queue_clear(Cutscene);
	}
	cutscene_event_end();
}

function cutscene_mindpalacedoor_start()
{
	with cutscene_new_actor(256, 1120, spr_door_mindpalace2, "DOOR")
		depth = 110;
	with obj_door
		visible = false;
	with obj_parent_player
	{
		state = States.actor;
		hsp = 0;
		vsp = 0;
		visible = false;
	}
	obj_camera.cameraLock = true;
	timer = 0;
	event_play_oneshot("event:/SFX/general/mindpalacedoorrise");
	cutscene_event_end();
}

function cutscene_mindpalacedoor_mid()
{
	static cloudEffect = 2;
	var _door = cutscene_get_actor("DOOR");
	var _finish = false;
	with _door
	{
		y = approach(y, 992, 1);
		x = xstart + irandom_range(-4, 4);
		if !cloudEffect--
		{
			create_particle(random_range(bbox_left, bbox_right), 1088, choose(spr_cloudEffect, spr_bigcloudeffect));
			cloudEffect = 8;
		}
		if (y == 992)
		{
			_finish = true;
			x = xstart;
		}
	}
	if _finish
		cutscene_event_end();
}

function cutscene_mindpalacedoor_end()
{
	instance_destroy(cutscene_get_actor("DOOR"));
	with obj_parent_player
	{
		state = States.comingoutdoor;
		image_index = 0;
		sprite_index = spr_walkfront;
		visible = true;
		hsp = 0;
		vsp = 0;
		image_blend = c_black;
	}
	
	obj_camera.cameraLock = false;
	with obj_door
		visible = true;
	
	ini_open(global.SaveFileName);
	ini_write_real("Game", "mindpalace_door_cutscene", true);
	ini_close();
	cutscene_event_end();
}
