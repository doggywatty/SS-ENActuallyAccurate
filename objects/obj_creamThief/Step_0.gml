switch state
{
	case States.frozen:
		hsp = 0;
		if grounded
			vsp = 0;
		if (sprite_index == spr_creamthief_grab && sprite_animation_end())
		{
			sprite_index = spr_creamthief_victory;
			image_xscale = 1;
		}
		image_speed = 0.35;
		break;
	case States.normal:
		if (grounded && vsp >= 0)
		{
			movespeed = approach(movespeed, 9, 0.2);
			canRubberband = true;
			if (!bbox_in_camera(id, view_camera[0]))
				rubberbandMovespeed = approach(rubberbandMovespeed, 4, 0.2);
			else
				rubberbandMovespeed = approach(rubberbandMovespeed, 0, 0.3);
		}
		
		hsp = movespeed * image_xscale;
		if canRubberband
			hsp += (rubberbandMovespeed * image_xscale);
		
		instance_destroy(instance_place(x + hsp, y, obj_chocofrog));
		
		if grounded
		{
			if (sprite_index != spr_creamthief_startRace)
				sprite_index = spr_creamthief_walk;
			if (sprite_index == spr_creamthief_startRace && sprite_animation_end())
				sprite_index = spr_creamthief_walk;
			
			mask_index = spr_player_mask;
			var check1 = place_meeting_collision(x, y);
			mask_index = spr_crouchmask;
			var check2 = !place_meeting_collision(x, y);
			if check1 && check2
				sprite_index = spr_creamthief_slide;
		}
		else if (sprite_index != spr_creamthief_jump || (sprite_animation_end() && sprite_index == spr_creamthief_jump))
			sprite_index = spr_creamthief_fall;
		image_speed = 0.4;
		break;
	case States.titlescreen:
		hsp = movespeed * image_xscale;
		instance_destroy(instance_place(x + hsp, y, obj_destructibles));
		
		if (movespeed < 12)
			movespeed = 12;
		
		if (sprite_animation_end())
		{
			if (sprite_index == spr_creamthief_grabbingStart)
				sprite_index = spr_creamthief_grabbing;
		}
		
		if ((sprite_animation_end() && sprite_index != spr_creamthief_grabbingStart) || sprite_index == spr_creamthief_grabbing)
		{
			if (grounded)
				state = States.normal;
		}
		image_speed = 0.3;
		break;
	case States.run:
		hsp = 0;
		vsp = 0;
		if (tauntTimer <= 0)
			scr_taunt_setVariables();
		tauntTimer--;
		image_speed = 0;
		break;
	case States.stun:
		hsp = 0;
		vsp = 0;
		image_speed = 0.35;
		
		if (floor(image_index) == 11)
		{
			movespeed = 16;
			state = States.normal;
		}
		break;
	case States.charge:
		hsp = movespeed * image_xscale;
		movespeed = approach(movespeed, 0, 0.4);
		if sprite_animation_end()
		{
			image_xscale *= -1;
			image_index = 0;
			sprite_index = spr_creamthief_walk;
			movespeed = 8;
			state = States.normal;
		}
		break;
}

if (hsp != 0)
{
	with (create_afterimage(AfterImageType.plain, image_xscale))
	{
		gonealpha = 0.45;
		alarm[0] = 1;
		alarm[1] = 60;
	}
}

if ((instance_exists(obj_fadeoutTransition) || instance_exists(obj_techdiff)) && sprite_index != spr_creamthief_victory && sprite_index != spr_creamthief_grab && sprite_index != spr_creamthief_lose)
{
	sprite_index = spr_creamthief_idle;
	if state != States.frozen
	{
		instance_create(x, y, obj_poofeffect);
		state = States.frozen;
	}
	
	with obj_racelight
	{
		sprite_index = spr_racelight_deactive;
		active = false;
		if (ds_list_find_index(global.SaveRoom, id))
			ds_list_delete(global.SaveRoom, ds_list_find_index(global.SaveRoom, id));
	}
	
	hsp = 0;
	vsp = 0;
	x = xstart;
	y = ystart;
	
	with obj_creamThiefGoTrigger
		ds_list_delete(global.SaveRoom, ds_list_find_index(global.SaveRoom, id));
}
