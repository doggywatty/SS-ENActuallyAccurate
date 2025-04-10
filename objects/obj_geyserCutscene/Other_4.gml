var _check = false;
if global.panic
{
	with obj_parent_player
	{
		if (place_meeting(roomStartX, roomStartY, other))
			_check = true;
	}
}
if _check
{
	var _cutscene = cutscene_create([cutscene_geyser_start, cutscene_geyser_middle, cutscene_geyser_end]);
	cutscene_declare_actor(id, "GEYSER");
	sprite_index = spr_geyserCutscene_Activated;
	image_index = 0;
}
