taskIcons = {};
ini_open(global.SaveFileName);

for (var i = 0; i < array_length(levelArr); i++)
{
	var tasks = scr_get_chef_tasks(levelArr[i], false);
	for (var j = 0; j < array_length(tasks); j++)
	{
		var completed_task = ini_read_string("ChefTasks", tasks[j].taskKey, "0") != "0";
		addTask(levelArr[i], new taskIcon(tasks[j], completed_task));
	}
	
	if (global.InternalLevelName == levelArr[i])
		selectV = i;
	else
		selectV = 0;
}

ini_close();
ini_open("optionData.ini");

var palArr = scr_get_palettes(false);
for (var i = 0; i < array_length(palArr); i++)
{
	var p = palArr[i];
	var unlocked_outfit = ini_read_string("Palettes", p.taskKey, "0") != "0";
	addOutfit(new taskIcon(p, unlocked_outfit));
}

ini_close();
outfitRows = ceil(array_length(outfitArr) / 3);
