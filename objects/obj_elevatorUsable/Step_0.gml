with (obj_parent_player)
{
	if (place_meeting(x, y, other.id) && !instance_exists(obj_fadeoutTransition) && key_up && grounded && !instance_exists(obj_cutsceneManager) && (state == PlayerState.normal || state == PlayerState.Sjumpprep || state == PlayerState.mach2 || state == PlayerState.mach3) && state != PlayerState.door && state != PlayerState.victory && state != PlayerState.comingoutdoor && state != PlayerState.actor)
	{
		obj_camera.chargeCameraX = 0;
		targetElevatorRoom = other.targetRoom;
		targetRoom = mineshaft_elevator;
		targetDoor = other.targetDoor;
		event_play_oneshot("event:/SFX/elevator/enter");
		
		if (ds_list_find_index(global.SaveRoom, other.id) == -1)
			ds_list_add(global.SaveRoom, other.id);
		
		with (other)
		{
			var _cutscene = cutscene_create([cutscene_elevator_prestart, cutscene_elevator_start, cutscene_elevator_premiddle, cutscene_elevator_middle, cutscene_elevator_preend, cutscene_elevator_end]);
			cutscene_declare_actor(id, "ELEVATOR");
		}
	}
}

var arrow_condition = place_meeting(x, y, obj_parent_player) && obj_parent_player.state == PlayerState.normal && obj_parent_player.grounded;
manage_up_arrow(arrow_condition);
y += vsp;
