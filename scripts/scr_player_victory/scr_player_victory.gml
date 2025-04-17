function state_player_victory()
{
	hsp = 0;
	machTwo = 0;
	jumpAnim = true;
	landAnim = false;
	crouchAnim = true;
	image_speed = 0.35;
	
	if sprite_animation_end()
	{
		image_speed = 0;
		if !place_meeting(x, y, obj_startGate) && room != rm_titlecard
		{
			if sprite_index == spr_victory
			{
				if !instance_exists(obj_fadeoutTransition)
				{
					event_play_oneshot("event:/SFX/general/door");
					instance_create(x, y, obj_fadeoutTransition);
				}
			}
			else if !instance_exists(obj_fadeoutTransition)
				instance_create(x, y, obj_fadeoutTransition);
		}
		else if (!instance_exists(obj_titlecard) && !instance_exists(obj_fadeoutTransition)
		&& (sprite_index == spr_entergate || sprite_index == spr_enterpainting))
		{
			var level_info = ds_map_find_value(global.GameLevelMap, global.InternalLevelName);
			if (level_info.titleCardInfo != -4)
			{
				with instance_create(x, y, obj_titlecard)
					info = level_info.titleCardInfo;
			}
			else
			{
				with instance_create(x, y, obj_fadeoutTransition)
					levelStart = true;
			}
		}
	}
	
	if place_meeting(x, y, obj_startGate)
	{
		if isDemo && global.InternalLevelName != "tutorial"
			sprite_index = spr_enterpainting;
		else
			sprite_index = spr_entergate;
		with instance_place(x, y, obj_startGate)
		{
			other.x = approach(other.x, x, 5);
			other.y = approach(other.y, bbox_bottom - (other.bbox_bottom - other.y), 5);
		}
	}
	
	if place_meeting(x, y, obj_parent_door)
	{
		sprite_index = spr_victory;
		with instance_place(x, y, obj_parent_door)
			other.x = approach(other.x, (x - sprite_xoffset) + (sprite_width / 2), 2);
	}
	
	global.ComboFreeze = 15;
	global.ComboTime = 60;
}
