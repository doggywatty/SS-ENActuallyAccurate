if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	if (place_meeting(x, y - 64, obj_parent_player))
	{
		with (obj_parent_player)
		{
			if (state == PlayerState.doughmount || state == PlayerState.doughmountspin)
			{
				with (other)
					event_user(0);
				
				movespeed = abs(movespeed);
				state = PlayerState.normal;
				
				if (key_attack)
				{
					movespeed = max(movespeed, 10);
					state = PlayerState.mach2;
				}
				
				sprite_index = spr_idle;
				instance_create(x, y, obj_poofeffect);
				image_index = 0;
			}
		}
	}
	
	if (place_meeting(x, y - 1, obj_dogMount))
	{
		instance_destroy(obj_dogMount);
		event_user(0);
	}
}
