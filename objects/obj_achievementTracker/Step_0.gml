for (var i = array_length(activeChefTasks) - 1; i >= 0; i--)
{
	var current_task = activeChefTasks[i];
	if (current_task.conditionType == ConditionType.InLevel && current_task.taskCondition())
	{
		scr_award_chef_task(current_task.taskKey, current_task.taskSprite, current_task.taskIndex);
		array_delete(activeChefTasks, i, 1);
	}
}

for (var i = array_length(activeExhibitionNightSecretTasks) - 1; i >= 0; i--)
{
	var current_task = activeExhibitionNightSecretTasks[i];
	with (activeExhibitionNightSecretTasks[i])
	{
		if (conditionType == ConditionType.InLevel && taskCondition())
		{
			scr_award_palette(current_task.taskKey, current_task.taskCharacter);
			array_delete(other.activeExhibitionNightSecretTasks, i, 1);
		}
	}
}

if (!ds_queue_empty(chefUnlockQueue) && !instance_exists(obj_achievementNotif))
{
	var task_info = ds_queue_dequeue(chefUnlockQueue);
	instance_create(camera_get_view_width(view_camera[0]) - 100, camera_get_view_height(view_camera[0]) + 200, obj_achievementNotif, 
	{
		sprite_index: task_info[0],
		taskKey: task_info[1],
		clothingCharacter: task_info[2],
		image_index: task_info[3]
	});
	repeat 10
		instance_create(camera_get_view_width(view_camera[0]) - 100, camera_get_view_height(view_camera[0]) - 50, obj_confettiEffect);
}
