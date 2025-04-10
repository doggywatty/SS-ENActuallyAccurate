function scr_confecti_taunt()
{
	image_speed = 0;
	sprite_index = spr_taunt;
	
	if (obj_parent_player.state != States.taunt)
	{
		state = States.frozen;
		image_speed = 0.35;
	}
	
	var supertaunts = [
		obj_parent_player.spr_supertaunt1, obj_parent_player.spr_supertaunt2,
		obj_parent_player.spr_supertaunt3, obj_parent_player.spr_supertaunt4
	];
	if (array_contains(supertaunts, obj_parent_player.sprite_index))
	{
		sprite_index = spr_supertaunt;
		image_index = 0;
		image_speed = 0.35;
		state = States.titlescreen;
		with obj_confectitaunt
		{
			if o_id == other.id
				instance_destroy();
		}
	}
}
