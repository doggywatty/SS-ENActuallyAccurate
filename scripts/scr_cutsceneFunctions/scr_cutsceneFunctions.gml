function cutscene_create(_cutscene)
{
	global.cutsceneManager = instance_create(0, 0, obj_cutsceneManager);
	with global.cutsceneManager
	{
		show_debug_message("Cutscene Manager: QUEUED FUNCTIONS");
		Event = _cutscene[0];
		show_debug_message($"Cutscene Manager: [{_cutscene[0]}], [Event: 0]");
		for (var i = 1; i < array_length(_cutscene); i++)
		{
			ds_queue_enqueue(Cutscene, _cutscene[i]);
			show_debug_message($"Cutscene Manager: [{_cutscene[i]}], [Event: {i}]");
		}
	}
	return global.cutsceneManager;
}

function cutscene_event_end()
{
	with global.cutsceneManager
	{
		if !ds_queue_empty(Cutscene)
		{
			var _event = ds_queue_dequeue(Cutscene);
			Event = _event;
			show_debug_message("Cutscene Manager: NEW EVENT");
		}
		else
			instance_destroy();
	}
}

function cutscene_declare_actor(_cutsceneActor, _objActorKey)
{
	with global.cutsceneManager
	{
		if ds_exists(ActorMap, ds_type_map)
			ds_map_set(ActorMap, _objActorKey, _cutsceneActor);
	}
	return true;
}

function cutscene_get_actor(_cutsceneActor)
{
	with global.cutsceneManager
	{
		if ds_exists(ActorMap, ds_type_map)
			return ds_map_find_value(ActorMap, _cutsceneActor);
	}
	return false;
}
