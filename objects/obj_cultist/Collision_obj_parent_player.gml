var cultist = id;
with other
{
	if (!is_undefined(scr_transformationCheck(state)))
	{
		event_play_oneshot("event:/SFX/general/cultist");
		state = States.normal;
		other.sprite_index = spr_cultist_pray;
		
		if key_attack
		{
			if (abs(movespeed < 10))
				movespeed = 10;
			else
				movespeed = abs(movespeed);
			state = States.mach2;
		}
		
		transfoSound = undefined;
		oldTransfoSound = undefined;
		sprite_index = spr_idle;
		instance_create(x, y, obj_poofeffect);
		image_index = 0;
		fmod_studio_system_set_parameter_by_name("transfo", false, false);
		
		with (instance_create(x - 540, camera_get_view_y(view_camera[0]) - 100, obj_devilboy))
			cultistID = cultist;
		
		if (ds_list_find_index(global.SaveRoom, other.id) == -1)
		{
			ds_list_add(global.SaveRoom, other.id);
			for (var i = 0; i < 500; i += 25)
				create_collect_effect(other.x + irandom_range(-60, 60), other.y + irandom_range(-60, 60), undefined, 25);
			
			event_play_multiple("event:/SFX/general/collect", x, y);
			global.Collect += 500;
			global.ComboTime = 60;
			create_small_number(x, y, 500);
		}
	}
}
