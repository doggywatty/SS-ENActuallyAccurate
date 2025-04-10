if instance_number(obj_music) > 1
{
	var first = instance_find(obj_music, 0);
	if id != first
	{
		instance_destroy();
		exit;
	}
}

addRoomMusic = function(_room, _eventName, _secretEventName, _func)
{
	var temp_struct = {};
	with temp_struct
	{
		eventName = _eventName;
		secretEventName = _secretEventName;
		musicInst = undefined;
		secretMusicInst = undefined;
		musicFunc = undefined;
		
		if !is_undefined(eventName) && is_string(eventName)
			musicInst = fmod_createEventInstance(eventName);
		if !is_undefined(secretEventName) && is_string(secretEventName)
			secretMusicInst = fmod_createEventInstance(secretEventName);
		if !is_undefined(_func) && is_callable(_func)
			musicFunc = method(self, _func);
	}
	ds_map_set(global.RoomMusicMap, _room, temp_struct);
};

global.RoomMusicMap = ds_map_create();
global.EscapeMusicInst = fmod_createEventInstance("event:/music/escape");
global.RankMusicInst = fmod_createEventInstance("event:/music/rank");
global.HarryMusicInst = fmod_createEventInstance("event:/music/harry");
global.RoomMusic = undefined;
global.RoomIsSecret = false;
panicStart = false;
currentSecretStatus = false;
global.CurrentBeat = 0;
addRoomMusic(rm_mainmenu, "event:/music/titlescreen_demo", undefined, function(_room, _parameter, _musicFunc)
{
	var event_state = 0;
	if (instance_exists(obj_mainfileselect) && obj_mainfileselect.abletomove)
		event_state = 1;
	if !is_undefined(event_state)
		fmod_studio_event_instance_set_parameter_by_name(_parameter, "state", event_state, false);
});
addRoomMusic(rm_credits, "event:/music/credits", undefined, undefined);
addRoomMusic(rm_devroom, "event:/music/devroom", undefined, undefined);
addRoomMusic(tutorial_1, "event:/music/tutorial", undefined, undefined);
addRoomMusic(hub_paintstudio, "event:/music/hub", undefined, function(_room, _parameter, _musicFunc)
{
	var event_state = 0;
	if !is_undefined(event_state)
		fmod_studio_event_instance_set_parameter_by_name(_parameter, "state", event_state, false);
});
addRoomMusic(hub_soundTest, undefined, undefined, undefined);
addRoomMusic(hub_demohallway, "event:/music/hub", undefined, function(_room, _parameter, _musicFunc)
{
	var event_state = 0;
	if !is_undefined(event_state)
		fmod_studio_event_instance_set_parameter_by_name(_parameter, "state", event_state, false);
});
addRoomMusic(hub_mindpalace, "event:/music/painterBrain", undefined, undefined);
addRoomMusic(hub_mindvault, "event:/music/harry", undefined, undefined);
addRoomMusic(hub_molasses, "event:/music/hub", undefined, function(_room, _parameter, _musicFunc)
{
	var event_state = 0;
	if !is_undefined(event_state)
		fmod_studio_event_instance_set_parameter_by_name(_parameter, "state", event_state, false);
});
addRoomMusic(entryway_1, "event:/music/w1/entryway", "event:/music/w1/entryway_secret", undefined);
addRoomMusic(steamy_1, "event:/music/w1/cottontown", "event:/music/w1/cottontown_secret", function(_room, _parameter, _musicFunc)
{
	var event_state = undefined;
	switch _room
	{
		case steamy_1:
		case steamy_7:
			event_state = 0;
			break;
		case steamy_8:
			event_state = 1;
			break;
		case steamy_sideroom:
			event_state = 2;
			break;
	}
	if !is_undefined(event_state)
		fmod_studio_event_instance_set_parameter_by_name(_parameter, "state", event_state, false);
});
addRoomMusic(molasses_1, "event:/music/w2/molasses", "event:/music/w2/molasses_secret", function(_room, _parameter, _musicFunc)
{
	var event_state = undefined;
	switch _room
	{
		case molasses_1:
		case molasses_6:
			event_state = 0;
			break;
		case molasses_7:
			event_state = 1;
			break;
	}
	if !is_undefined(event_state)
		fmod_studio_event_instance_set_parameter_by_name(_parameter, "state", event_state, false);
	
	var frog = false;
	with obj_flingFrog
	{
		if (bbox_in_camera(self, view_camera[0], 100))
		{
			frog = true;
			break;
		}
	}
	
	var player_state = get_playerState();
	if (player_state == States.fling || player_state == States.fling_launch)
		frog = true;
	fmod_studio_event_instance_set_parameter_by_name(_parameter, "frog", frog, false);
});
addRoomMusic(mineshaft_1, "event:/music/w1/mines", "event:/music/w1/mines_secret", function(_room, _parameter, _musicFunc)
{
	var event_state = global.minesProgress;
	if !is_undefined(event_state)
		fmod_studio_event_instance_set_parameter_by_name(_parameter, "state", event_state, false);
});
addRoomMusic(mountain_intro, "event:/music/w2/mountain", "event:/music/w2/mountain_secret", function(_room, _parameter, _musicFunc)
{
	var event_state = undefined;
	switch _room
	{
		case mountain_intro:
		case mountain_1:
		case mountain_5:
			event_state = 0;
			break;
		case mountain_6:
			event_state = 1;
			break;
	}
	if !is_undefined(event_state)
		fmod_studio_event_instance_set_parameter_by_name(_parameter, "state", event_state, false);
});
addRoomMusic(cafe_1, "event:/music/w2/cafe", "event:/music/w2/cafe_secret", undefined);
