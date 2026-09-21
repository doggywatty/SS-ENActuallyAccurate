function state_player_talkto()
{
	hsp = 0;
	vsp = 0;
	sprite_index = spr_idle;
	image_speed = 0.35;
	
	if (key_taunt2 || (!instance_exists(obj_dialogue) && !instance_exists(obj_dialogue_choices)))
		state = PlayerState.normal;
}
