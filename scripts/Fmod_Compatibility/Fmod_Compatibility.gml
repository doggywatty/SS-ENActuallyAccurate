/// @desc Shortcut to fmod_studio_system_init
/// @param {real} max_channels
/// @param {Struct.FMOD_INIT} [studio_flags]=FMOD_INIT.NORMAL
/// @param {Struct.FMOD_STUDIO_INIT} [core_flags]=FMOD_STUDIO_INIT.NORMAL
/// @returns {real}
function fmod_init(max_channels, studio_flags = FMOD_INIT.NORMAL, core_flags = FMOD_STUDIO_INIT.NORMAL) {
	return fmod_studio_system_init(max_channels, studio_flags, core_flags);
}

/// @desc Shortcut to fmod_studio_system_load_bank_file
/// @param {string} filename
/// @param {Struct.FMOD_STUDIO_LOAD_BANK} [flags]=FMOD_STUDIO_LOAD_BANK.NORMAL
/// @returns {real}
function fmod_loadBank(filename, flags = FMOD_STUDIO_LOAD_BANK.NORMAL) {
	return fmod_studio_system_load_bank_file(filename, flags);
}

/// @desc Creates an FMOD Event instance
/// @param {string} event Event to make an instance of
/// @returns {real} Instance reference
function fmod_createEventInstance(event) {
	var event_description = fmod_studio_system_get_event(event)
	var event_instance = fmod_studio_event_description_create_instance(event_description)
	array_push(global.FMOD_EventInstances, [event_instance, fmod_studio_event_description_get_path(event_description)])
	return event_instance;
}

/// @desc Shortcut to value of fmod_studio_event_instance_get_parameter_by_name
/// @param {real} event_instance_ref
/// @param {string} name
/// @returns {real} Instance reference
function fmod_event_getParameter(event_instance_ref, name) {
	var param = fmod_studio_event_instance_get_parameter_by_name(event_instance_ref, name)
	return param.value;
}


/// @desc Sets 3D position of event instance
/// @param {real} event_instance_ref Reference to event instance
/// @param {any*} x
/// @param {any*} y
/// @param {real} [z]=0
function fmod_event_set3DPosition(event_instance_ref, _x, _y, _z = 0) {
	var attributes = global.FMOD_default3DAttributes
	attributes.position = 
	{
		x: _x,
		y: _y,
		z: _z
	}
	fmod_studio_event_instance_set_3d_attributes(event_instance_ref, attributes)
}

/// @desc Shortcut to value of fmod_studio_system_get_parameter_by_name
/// @param {string} name
/// @reutrns {real}
function fmod_global_getParameter(name) {
	var param = fmod_studio_system_get_parameter_by_name(name)
	return param.value;
}

/// @desc Shortcut to fmod_studio_event_description_get_length
/// @param {string} path
/// @reutrns {real}
function fmod_getEventLength(path) {
	var event_description = fmod_studio_system_get_event(path)
	return fmod_studio_event_description_get_length(event_description);
}

/// @desc Pauses all tracked instances
/// @param {Bool} pause
function fmod_event_setPause_all(pause) {
	for (var i = 0; i < array_length(global.FMOD_EventInstances); i++) {
		if (fmod_studio_event_instance_is_valid(global.FMOD_EventInstances[i][0]))
			fmod_studio_event_instance_set_paused(global.FMOD_EventInstances[i][0], pause)
	}
}

/// @desc Releases all tracked instances
function fmod_event_release_all() {
	for (var i = 0; i < array_length(global.FMOD_EventInstances); i++) {
		if (fmod_studio_event_instance_is_valid(global.FMOD_EventInstances[i][0]))
			fmod_studio_event_instance_release(global.FMOD_EventInstances[i][0])
	}
}
/// @desc Stops all tracked instances
/// @param {Enum.FMOD_STUDIO_STOP_MODE} mode
function fmod_event_stop_all(mode) {
	for (var i = 0; i < array_length(global.FMOD_EventInstances); i++) {
		if (fmod_studio_event_instance_is_valid(global.FMOD_EventInstances[i][0]))
			fmod_studio_event_instance_stop(global.FMOD_EventInstances[i][0], mode)
	}
}

/// @desc Shortcut to fmod_studio_event_description_get_path
/// @param {string} path
function fmod_event_getEventPath(path) {
	var event_description = fmod_studio_event_instance_get_description(path)
	return fmod_studio_event_description_get_path(event_description);
}