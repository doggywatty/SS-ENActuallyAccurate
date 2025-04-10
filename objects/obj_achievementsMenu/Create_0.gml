depth = -99;
scrollFactor = 0;
bgx = 0;
bgy = 0;
currentPage = 0;
maxPage = 1;
selectH = 0;
selectV = -1;
taskPadX = 200;
taskPadY = 200;
scr_input_varinit();
levelArr = ["demoEN", "entryway", "steamy", "mineshaft", "molasses"];
floorArr = ["demoEN"];
outfitArr = [];
outfitRows = 0;
taskIcons = {};

taskIcon = function(_task, _isCompleted = false) constructor
{
	static get = function(_task)
	{
		return struct_get(task, _task);
	};
	x = 0;
	y = 0;
	task = _task;
	isCompleted = _isCompleted;
};

addTask = function(_task, _taskArr)
{
	if (is_undefined(variable_struct_get(taskIcons, _task)))
		variable_struct_set(taskIcons, _task, []);
	var arr = variable_struct_get(taskIcons, _task);
	array_push(arr, _taskArr);
	return arr;
};

addOutfit = function(_outfit)
{
	array_push(outfitArr, _outfit);
};

event_user(0);
