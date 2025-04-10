function fmod_init(_max_channels, init_flags = FMOD_INIT.NORMAL, studio_init_flags = FMOD_STUDIO_INIT.NORMAL)
{
    return fmod_studio_system_init(_max_channels, init_flags, studio_init_flags);
}

function fmod_loadBank(_filename, studio_load_bank_flags = FMOD_STUDIO_LOAD_BANK.NORMAL)
{
	return fmod_studio_system_load_bank_file(_filename, studio_load_bank_flags);
}

function fmod_createEventInstance(_path)
{
	var event_description = fmod_studio_system_get_event(_path);
	var event_instance = fmod_studio_event_description_create_instance(event_description);
	array_push(global.FMOD_EventInstances, [event_instance, fmod_studio_event_description_get_path(event_description)]);
	return event_instance;
}

function fmod_event_getParameter(_path, _name)
{
	var param = fmod_studio_event_instance_get_parameter_by_name(_path, _name);
	return param.value;
}

function fmod_event_set3DPosition(_path, _x, _y, _z = 0)
{
	var attributes = global.FMOD_default3DAttributes;
	attributes.position = 
	{
		x: _x,
		y: _y,
		z: _z
	};
	fmod_studio_event_instance_set_3d_attributes(_path, attributes);
}

function fmod_global_getParameter(_name)
{
	var param = fmod_studio_system_get_parameter_by_name(_name);
	return param.value;
}

function fmod_getEventLength(_path)
{
	var event_description = fmod_studio_system_get_event(_path);
	return fmod_studio_event_description_get_length(event_description);
}

function fmod_event_setPause_all(_setstate)
{
	for (var i = 0; i < array_length(global.FMOD_EventInstances); i++)
	{
		if (fmod_studio_event_instance_is_valid(global.FMOD_EventInstances[i][0]))
			fmod_studio_event_instance_set_paused(global.FMOD_EventInstances[i][0], _setstate);
	}
}

function fmod_event_release_all()
{
	for (var i = 0; i < array_length(global.FMOD_EventInstances); i++)
	{
		if (fmod_studio_event_instance_is_valid(global.FMOD_EventInstances[i][0]))
			fmod_studio_event_instance_release(global.FMOD_EventInstances[i][0]);
	}
}

function fmod_event_stop_all(_setstate)
{
	for (var i = 0; i < array_length(global.FMOD_EventInstances); i++)
	{
		if (fmod_studio_event_instance_is_valid(global.FMOD_EventInstances[i][0]))
			fmod_studio_event_instance_stop(global.FMOD_EventInstances[i][0], _setstate);
	}
}

function fmod_event_getEventPath(_path)
{
	var event_description = fmod_studio_event_instance_get_description(_path);
	return fmod_studio_event_description_get_path(event_description);
}
