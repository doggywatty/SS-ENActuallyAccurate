function ChefTask(_taskKey, _conditionType, _taskSprite, _taskIndex, _taskCondition) constructor
{
	static setPersistent = function(_persistent)
	{
		persistent = _persistent;
		return self;
	};
	
	taskKey = _taskKey;
	conditionType = _conditionType;
	taskSprite = _taskSprite;
	taskIndex = _taskIndex;
	taskCondition = _taskCondition;
	persistent = false;
	return self;
}

function OutfitTask(_taskKey, _taskChar, _conditionType, _taskFunc) : ChefTask(_taskKey, _conditionType, spr_paletteUnlock, 0, _taskFunc) constructor
{
	taskCharacter = _taskChar;
}

function ExhibitionNightSecretTask(_taskKey, _taskChar, _secretsCount) : OutfitTask(_taskKey, _taskChar, ConditionType.EndLevel, -4) constructor
{
	neededSecrets = _secretsCount;
	taskCondition = function()
	{
		var _levels = ["entryway", "steamy", "mineshaft", "molasses"];
		var _secrets = 0;
		ini_open(global.SaveFileName);
		for (var i = 0; i < array_length(_levels); i++)
		{
			for (var j = 0; j < 3; j++)
			{
				_secrets += ini_read_real("Secret", _levels[i] + string(j + 1), 0);
				if (_secrets >= neededSecrets)
				{
					ini_close();
					return true;
				}
			}
		}
		ini_close();
		return false;
	};
}

function scr_award_chef_task(taskKey, taskSprite, taskIndex)
{
	ini_open(global.SaveFileName);
	var prevUnlocked = ini_read_real("ChefTasks", taskKey, false);
	ini_write_real("ChefTasks", taskKey, 1);
	ini_close();
	obj_hudManager.saveAlpha = 10;
	if !prevUnlocked
		ds_queue_enqueue(obj_achievementTracker.chefUnlockQueue, [taskSprite, taskKey, ConditionType.InLevel, taskIndex]);
	show_debug_message($"Chef Task Unlocked: {taskKey}");
}

function scr_award_palette(taskKey, taskChar)
{
	ini_open("optionData.ini");
	var prevUnlocked = ini_read_real("Palettes", taskKey, false);
	ini_write_real("Palettes", taskKey, 1);
	ini_close();
	obj_hudManager.saveAlpha = 10;
	if !prevUnlocked
	{
		ds_queue_enqueue(obj_achievementTracker.chefUnlockQueue, [spr_paletteUnlock, taskKey, taskChar, 0]);
		with obj_paletteChangerMirror
			event_perform(ev_create, 0);
	}
	show_debug_message($"Chef Task Unlocked: {taskKey}");
}

function scr_check_end_level_chef_tasks()
{
	with obj_achievementTracker
	{
		for (var i = 0; i < array_length(activeChefTasks); i++)
		{
			var current_task = activeChefTasks[i];
			if (current_task.conditionType == ConditionType.EndLevel && current_task.taskCondition())
			{
				scr_award_chef_task(current_task.taskKey, current_task.taskSprite, current_task.taskIndex);
				if (current_task.persistent && array_contains(persistentTasks, current_task))
				{
					var ind = array_get_index(persistentTasks, current_task);
					if (ind != -1)
						array_delete(persistentTasks, ind, 1);
				}
			}
		}
		for (var p = 0; p < array_length(activeExhibitionNightSecretTasks); p++)
		{
			var current_task = activeExhibitionNightSecretTasks[p];
			with current_task
			{
				if (conditionType == ConditionType.EndLevel && taskCondition())
				{
					scr_award_palette(taskKey, taskCharacter);
					array_delete(other.activeChefTasks, p, 1);
				}
			}
		}
	}
}

function scr_reset_achievement_tracker()
{
	with obj_achievementTracker
		event_perform(ev_create, 0);
}

function scr_task_notify(_taskKey, taskArr = [])
{
	var task = undefined;
	var arrays = [obj_achievementTracker.activeChefTasks, obj_achievementTracker.activeExhibitionNightSecretTasks];
	var check_array = arrays[0];
	var palette = false;
	
	if !instance_exists(obj_achievementTracker)
		exit;
	
	for (var a = 0; a < array_length(arrays); a++)
	{
		for (var i = 0; i < array_length(arrays[a]); i++)
		{
			var t = arrays[a][i];
			if (t.taskKey == _taskKey)
			{
				task = t;
				check_array = arrays[a];
				palette = a == 1;
				break;
			}
		}
	}
	
	if is_undefined(task)
		exit;
	
	trace($"Task Notified: {_taskKey}");
	
	with obj_achievementTracker
	{
		var ind = array_get_index(check_array, task);
		if (ind >= 0 && task.conditionType == ConditionType.OnCheck && task.taskCondition(taskArr))
		{
			if (palette)
				scr_award_palette(task.taskKey, task.taskCharacter);
			else
				scr_award_chef_task(task.taskKey, task.taskSprite, task.taskIndex);
			array_delete(check_array, ind, 1);
		}
	}
}

function scr_get_palettes(statement = true)
{
	var pals = [
		new ExhibitionNightSecretTask("palette_PZ_exhibitionred", Characters.Pizzelle, 3),
		new ExhibitionNightSecretTask("palette_PZ_exhibitionblack", Characters.Pizzelle, 6),
		new ExhibitionNightSecretTask("palette_PZ_exhibitionpurple", Characters.Pizzelle, 9),
		new ExhibitionNightSecretTask("palette_PZ_noise", Characters.Pizzelle, 12),
	new OutfitTask("palette_PZ_exhibitionbrain", Characters.Pizzelle, ConditionType.OnCheck, function()
	{
		ini_open(global.SaveFileName);
		var judge = ini_read_string("Game", "Judgment", "none");
		ini_close();
		return judge != "none";
	}), new OutfitTask("palette_PZ_exhibitionbraingold", Characters.Pizzelle, ConditionType.OnCheck, function()
	{
		ini_open(global.SaveFileName);
		var judge = ini_read_string("Game", "Judgment", "none");
		ini_close();
		return judge == "perfect" || judge == "holyshit";
	}), new OutfitTask("palette_PZ_exhibitionpaper", Characters.Pizzelle, ConditionType.InLevel, function()
	{
		if (instance_exists(obj_exhibitiontrashcan))
			return obj_exhibitiontrashcan.sprite_index == spr_trashcan_score || obj_exhibitiontrashcan.sprite_index == spr_trashcan_full;
		else
			return false;
	}), new OutfitTask("palette_PZ_exhibitionentryway", Characters.Pizzelle, ConditionType.InLevel, function()
	{
		var room_list_index = array_get_index(obj_achievementTracker.constructionClutterCleared, room);
		if room_list_index < 0
			return false;
		
		var instance_checks = [obj_parent_clutterDestroyable, obj_parent_clutterSmallDestroyable];
		var found_instances = 0;
		
		for (var i = 0; i < array_length(instance_checks); i++)
		{
			with (instance_checks[i])
			{
				if (object_index != obj_paintertopper)
					found_instances++;
			}
		}
		
		if (found_instances <= 0)
			array_delete(obj_achievementTracker.constructionClutterCleared, room_list_index, 1);
		
		if (array_length(obj_achievementTracker.constructionClutterCleared) <= 0)
			return true;
		
		return false;
	}), new OutfitTask("palette_PZ_exhibitionsteamy", Characters.Pizzelle, ConditionType.InLevel, function()
	{
		if (!obj_parent_player.savedCottonSolid)
			obj_achievementTracker.cottonBlockTime = 0;
		
		return obj_achievementTracker.cottonBlockTime >= 5;
	}), new OutfitTask("palette_PZ_exhibitionmineshaft", Characters.Pizzelle, ConditionType.InLevel, function()
	{
		if (obj_parent_player.grounded)
			obj_achievementTracker.bouncedOnFred = 0;
		
		return obj_achievementTracker.bouncedOnFred >= 5;
	}), new OutfitTask("palette_PZ_exhibitionmolasses", Characters.Pizzelle, ConditionType.InLevel, function()
	{
		return obj_achievementTracker.drownedEnemies >= 3;
	})];
	
	if statement
	{
		ini_open("optionData.ini");
		var _palettes = array_filter(pals, function(_Key, value)
		{
			return !ini_read_real("Palettes", _Key.taskKey, false);
		});
		ini_close();
		obj_achievementTracker.activeExhibitionNightSecretTasks = _palettes;
	}
	
	return pals;
}

function scr_get_chef_tasks(_level, statement = true)
{
	var tasks = [];
	switch _level
	{
		case "entryway":
			tasks[0] = new ChefTask("task_cc_all_breakables", ConditionType.InLevel, spr_bakertasks_entry, 0, function()
			{
				var room_list_index = array_get_index(obj_achievementTracker.constructionBreakablesRooms, room);
				if room_list_index != -1
				{
					var breakables_to_check = [obj_secretdestroyable, obj_secretdestroyable_big, obj_secretdestroyable_metal];
					var breakables_still_present = 0;
					for (var i = 0; i < array_length(breakables_to_check); i++)
					{
						if (instance_exists(breakables_to_check[i]))
							breakables_still_present += instance_number(breakables_to_check[i]);
					}
					if (breakables_still_present <= 0)
					{
						array_delete(obj_achievementTracker.constructionBreakablesRooms, room_list_index, 1);
						show_debug_message($"Cleared room {room_get_name(room)} of destroyables!");
						show_debug_message($"{array_length(obj_achievementTracker.constructionBreakablesRooms)} more rooms to clear.");
					}
				}
				return array_length(obj_achievementTracker.constructionBreakablesRooms) == 0;
			});
			tasks[1] = new ChefTask("task_cc_speedrun", ConditionType.InLevel, spr_bakertasks_entry, 1, function()
			{
				var near_harry = false;
				with obj_gummyharry
				{
					if (abs(obj_parent_player.x - x) < 450)
						near_harry = true;
				}
				return global.LevelMinutes < 2 && room == entryway_11 && near_harry;
			});
			tasks[2] = new ChefTask("task_cc_no_slip", ConditionType.EndLevel, spr_bakertasks_entry, 2, function()
			{
				return !obj_achievementTracker.constructHasSlipped;
			});
			break;
		case "steamy":
			tasks[0] = new ChefTask("task_ct_clock_room", ConditionType.InLevel, spr_bakertasks_steamy, 0, function()
			{
				return room == steamy_sideroom;
			});
			tasks[1] = new ChefTask("task_ct_all_witches", ConditionType.InLevel, spr_bakertasks_steamy, 1, function()
			{
				var room_list_index = array_get_index(obj_achievementTracker.cottonWitchRooms, room);
				if room_list_index != -1
				{
					if !instance_exists(obj_cottonwitch)
					{
						array_delete(obj_achievementTracker.cottonWitchRooms, room_list_index, 1);
						show_debug_message($"Cleared room {room_get_name(room)} of cottonwitches!");
						show_debug_message($"{array_length(obj_achievementTracker.cottonWitchRooms)} more rooms to clear.");
					}
				}
				return array_length(obj_achievementTracker.cottonWitchRooms) == 0;
			});
			tasks[2] = new ChefTask("task_ct_few_cotton_blocks", ConditionType.InLevel, spr_bakertasks_steamy, 2, function()
			{
				with obj_parent_player
				{
					if place_meeting(x, y, obj_cottonsolid)
					{
						var cotton_solid_id = instance_place(x, y, obj_cottonsolid);
						if !array_contains(obj_achievementTracker.cottonMarkedBlocks, cotton_solid_id)
						{
							if (room != steamy_secret_1 && room != steamy_secret_2 && room != steamy_secret_3)
							{
								obj_achievementTracker.cottonBlocksUsed++;
								show_debug_message($"Increasing total to {obj_achievementTracker.cottonBlocksUsed} cotton blocks drilled through.");
							}
							else
								show_debug_message("Ignoring cotton block because it's in a secret.");
							
							var cotton_solids_to_add = [cotton_solid_id];
							for (var i = 0; i < array_length(cotton_solids_to_add); i++)
							{
								with obj_cottonsolid
								{
									if !array_contains(cotton_solids_to_add, id) && distance_to_object(cotton_solids_to_add[i]) < 5
										cotton_solids_to_add[array_length(cotton_solids_to_add)] = id;
								}
							}
							
							for (var i = 0; i < array_length(cotton_solids_to_add); i++)
								obj_achievementTracker.cottonMarkedBlocks[array_length(obj_achievementTracker.cottonMarkedBlocks)] = cotton_solids_to_add[i];
						}
					}
				}
				
				return obj_achievementTracker.cottonBlocksUsed <= 10 && global.panic;
			});
			break;
		case "mineshaft":
			tasks[0] = new ChefTask("task_sm_all_miners", ConditionType.InLevel, spr_bakertasks_mines, 0, function()
			{
				var room_list_index = array_get_index(obj_achievementTracker.gnomeMinerRooms, room);
				if room_list_index != -1
				{
					var all_miners_used = true;
					with obj_gnomeRefiner
					{
						if !array_contains(obj_achievementTracker.gnomeMinersSatisfied, id)
							all_miners_used = false;
					}
					
					if all_miners_used
					{
						array_delete(obj_achievementTracker.gnomeMinerRooms, room_list_index, 1);
						show_debug_message($"All gnomes in {room_get_name(room)} have been satisfied!");
						show_debug_message($"{array_length(obj_achievementTracker.gnomeMinerRooms)} more rooms to clear.");
					}
				}
				return array_length(obj_achievementTracker.gnomeMinerRooms) == 0;
			});
			tasks[1] = new ChefTask("task_sm_minecart_nohit", ConditionType.EndLevel, spr_bakertasks_mines, 1, function()
			{
				return !obj_achievementTracker.hitInMinecart;
			});
			tasks[2] = new ChefTask("task_sm_slug", ConditionType.OnCheck, spr_bakertasks_mines, 2, function(_taskFunc)
			{
				obj_achievementTracker.slugsWhacked++;
				return obj_achievementTracker.slugsWhacked >= 5;
			});
			break;
		case "molasses":
			tasks[0] = new ChefTask("task_ms_all_geyser", ConditionType.InLevel, spr_bakertasks_molasses, 0, function()
			{
				var room_list_index = array_get_index(obj_achievementTracker.geyserSpawnerRooms, room);
				if room_list_index != -1
				{
					var all_geysers_activated = true;
					with obj_geyserspawner
					{
						if !array_contains(obj_achievementTracker.geyserSpawnerSpawned, id)
							all_geysers_activated = false;
					}
					if all_geysers_activated
					{
						array_delete(obj_achievementTracker.geyserSpawnerRooms, room_list_index, 1);
						show_debug_message($"All geysers {room_get_name(room)} have been activated!");
						show_debug_message($"{array_length(obj_achievementTracker.geyserSpawnerRooms)} more rooms to clear.");
					}
				}
				return array_length(obj_achievementTracker.geyserSpawnerRooms) == 0;
			});
			tasks[1] = new ChefTask("task_ms_guardian_parry", ConditionType.InLevel, spr_bakertasks_molasses, 1, function()
			{
				return obj_achievementTracker.guardianSupertaunted >= 3;
			});
			tasks[2] = new ChefTask("task_ms_catch", ConditionType.InLevel, spr_bakertasks_molasses, 2, function()
			{
				if obj_parent_player.grounded
					obj_achievementTracker.flingFrogSequence = [];
				if (array_length(obj_achievementTracker.flingFrogSequence) >= 3)
				{
					var seq = obj_achievementTracker.flingFrogSequence;
					var len = array_length(seq);
					if (seq[len - 1] == seq[len - 3] && seq[len - 1] != seq[len - 2])
						return true;
				}
				return false;
			});
			break;
		case "demoEN":
			tasks[0] = new ChefTask("task_en_all_s", ConditionType.EndLevel, spr_bakertasks_en_ranks, 0, function()
			{
				var lvlArr = ["entryway", "steamy", "mineshaft", "molasses"];
				var res = true;
				ini_open(global.SaveFileName);
				for (var i = 0; i < array_length(lvlArr); i++)
				{
					var lv = lvlArr[i];
					var r = string_lower(ini_read_string("Ranks", lv, ""));
					if (r != "s" && r != "p")
					{
						res = false;
						break;
					}
				}
				ini_close();
				return res;
			}).setPersistent(true);
			tasks[1] = new ChefTask("task_en_all_p", ConditionType.EndLevel, spr_bakertasks_en_ranks, 1, function()
			{
				var lvlArr = ["entryway", "steamy", "mineshaft", "molasses"];
				var res = true;
				ini_open(global.SaveFileName);
				for (var i = 0; i < array_length(lvlArr); i++)
				{
					var lv = lvlArr[i];
					var r = string_lower(ini_read_string("Ranks", lv, ""));
					if r != "p"
					{
						res = false;
						break;
					}
				}
				ini_close();
				return res;
			}).setPersistent(true);
			break;
	}
	if statement
	{
		ini_open(global.SaveFileName);
		for (var i = 0; i < array_length(tasks); i++)
		{
			if (ini_read_string("ChefTasks", tasks[i].taskKey, 0) == 0)
			{
				array_push(obj_achievementTracker.activeChefTasks, tasks[i]);
				if (tasks[i].persistent)
					array_push(obj_achievementTracker.persistentTasks, tasks[i]);
			}
		}
		ini_close();
	}
	return tasks;
}
