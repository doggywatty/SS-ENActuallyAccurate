function state_player_door()
{
	hsp = 0;
	machTwo = 0;
	jumpAnim = true;
	landAnim = false;
	crouchAnim = true;
	if (sprite_index != spr_player_PZ_pipeDown_getIn && sprite_index != spr_player_PZ_pipeUp_getIn)
		sprite_index = spr_lookdoor;
	if sprite_animation_end()
	{
		image_speed = 0;
		if (!instance_exists(obj_fadeoutTransition) && !instance_exists(obj_endlevelfade))
		{
			instance_create(x, y, obj_fadeoutTransition);
			event_play_oneshot("event:/SFX/general/door");
		}
	}
	
	var door_objects = [obj_door, obj_keydoor, obj_keydoorclock];
	for (var i = 0; i < array_length(door_objects); i++)
	{
		var door_obj = door_objects[i];
		if (place_meeting(x, y, door_obj))
		{
			with instance_place(x, y, door_obj)
			{
				switch sprite_index
				{
					default:
						other.x = approach(other.x, (x - sprite_xoffset) + (sprite_width / 2), 2);
						break;
					case spr_door_mindpalace:
					case spr_door_mindpalace2:
						var _inst = instance_place(x, y, obj_parent_doortrigger);
						if instance_exists(_inst)
							other.x = approach(other.x, _inst.x + (_inst.sprite_width / 2), 2);
						break;
				}
			}
		}
	}
	global.ComboFreeze = 15;
}
