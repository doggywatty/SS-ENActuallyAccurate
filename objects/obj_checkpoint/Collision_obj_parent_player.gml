if (!Checkpointactivated)
{
	with (obj_checkpoint)
		Checkpointactivated = false;
	
	Checkpointactivated = true;
	
	if (visible)
		event_play_multiple("event:/SFX/general/checkpoint", xorigin + (sprite_width / 2), yorigin + (sprite_height / 2));
}
