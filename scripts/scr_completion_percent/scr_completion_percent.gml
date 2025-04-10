function scr_completion_percent(_name_percent)
{
	if file_exists(_name_percent)
	{
		ini_open(_name_percent);
		var levels = ["entryway", "steamy", "mineshaft", "molasses"];
		var ranks = ["d", "c", "b", "a", "s"];
		var levels_count = 0;
		var confecti_count = 0;
		var secret_count = 0;
		var task_count = 0;
		var rank_count = 0;
		var p_rank_count = 0;
		var treasure_count = 0;
		var completed_tutorial = ini_read_real("Misc", "completedtutorial", 0);
		for (var i = 0; i < array_length(levels); i++)
		{
			if (ini_key_exists("Highscore", levels[i]))
				levels_count++;
			var rank = ini_read_string("Ranks", levels[i], "d");
			if (rank == "p")
			{
				rank_count += 4;
				p_rank_count++;
			}
			else
				rank_count += array_get_index(ranks, rank);
			for (var j = 0; j < 5; j++)
			{
				if (ini_read_real("Confecti", levels[i] + string(j + 1), 0))
					confecti_count++;
			}
			
			for (var j = 0; j < 3; j++)
				secret_count += (ini_read_real("Secret", levels[i] + string(j + 1), 0) ? 1 : 0);
			if (ini_read_real("Treasure", levels[i], 0))
				treasure_count++;
			
			var tasks = scr_get_chef_tasks(levels[i], false);
			for (var j = 0; j < array_length(tasks); j++)
			{
				if (ini_read_real("ChefTasks", tasks[j].taskKey, 0))
					task_count++;
			}
		}
		ini_close();
		
		var completion = 0;
		completion += (1 * completed_tutorial);
		completion += ((9 * levels_count) / 4);
		completion += ((10 * rank_count) / 16);
		completion += ((20 * confecti_count) / 20);
		completion += ((30 * secret_count) / 12);
		completion += ((20 * treasure_count) / 4);
		completion += ((10 * task_count) / 12);
		completion += ((1 * p_rank_count) / 4);
		show_debug_message($"File: {filename_name(_name_percent)}");
		show_debug_message($"Completion of tutorial: { completed_tutorial}");
		show_debug_message($"Number of levels: {levels_count}");
		show_debug_message($"Completion of levels: {levels_count / 4}");
		show_debug_message($"Number of ranks: {rank_count}");
		show_debug_message($"Completion of ranks: {rank_count / 16}");
		show_debug_message($"Number of confecti: {confecti_count}");
		show_debug_message($"Completion of confecti: {confecti_count / 20}");
		show_debug_message($"Number of secrets: {secret_count}");
		show_debug_message($"Completion of secrets: {secret_count / 12}");
		show_debug_message($"Number of treasures: {treasure_count}");
		show_debug_message($"Completion of treasures: {treasure_count / 4}");
		show_debug_message($"Number of tasks: {task_count}");
		show_debug_message($"Completion of tasks: {task_count / 12}");
		show_debug_message($"Number of p-ranks: {p_rank_count}");
		show_debug_message($"Completion of p-ranks: {p_rank_count / 4}");
		show_debug_message($"Completion: {completion}");
		show_debug_message($"Completion Floored: {floor(completion)}");
		return floor(completion);
	}
	else
		return 0;
}

function scr_check_completion(_savefilename = global.SaveFileName)
{
	var levels = ["entryway", "steamy", "mineshaft", "molasses"];
	var count = 0;
	ini_open(_savefilename);
	for (var i = 0; i < array_length(levels); i++)
	{
		var rank = ini_read_string("Ranks", levels[i], "none");
		if (rank != "none")
			count++;
	}
	ini_close();
	return count >= array_length(levels);
}
