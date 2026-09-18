function cutscene_create(arg0)
{
	global.cutsceneManager = instance_create(0, 0, obj_cutsceneManager);
	
	with (global.cutsceneManager)
	{
		show_debug_message("Cutscene Manager: QUEUED FUNCTIONS");
		Event = arg0[0];
		show_debug_message($"Cutscene Manager: [{arg0[0]}], [Event: 0]");
		
		for (var i = 1; i < array_length(arg0); i++)
		{
			ds_queue_enqueue(Cutscene, arg0[i]);
			show_debug_message($"Cutscene Manager: [{arg0[i]}], [Event: {i}]");
		}
	}
	
	return global.cutsceneManager;
}

function cutscene_event_end()
{
	with (global.cutsceneManager)
	{
		if (!ds_queue_empty(Cutscene))
		{
			var _event = ds_queue_dequeue(Cutscene);
			Event = _event;
			show_debug_message("Cutscene Manager: NEW EVENT");
		}
		else
		{
			instance_destroy();
		}
	}
}

function cutscene_declare_actor(arg0, arg1)
{
	with (global.cutsceneManager)
	{
		if (ds_exists(ActorMap, ds_type_map))
			ds_map_set(ActorMap, arg1, arg0);
	}
	
	return true;
}

function cutscene_get_actor(arg0)
{
	with (global.cutsceneManager)
	{
		if (ds_exists(ActorMap, ds_type_map))
			return ds_map_find_value(ActorMap, arg0);
	}
	
	return false;
}
