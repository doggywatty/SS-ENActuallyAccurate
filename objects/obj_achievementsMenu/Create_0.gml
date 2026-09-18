depth = -99;
scrollFactor = 0;
bgx = 0;
bgy = 0;
currentPage = 0;
maxPage = 1;
selectH = 0;
selectV = 0;
taskPadX = 200;
taskPadY = 200;
scr_input_varinit();
levelArr = ["demoEN", "entryway", "steamy", "mineshaft", "molasses"];
floorArr = ["demoEN"];
outfitArr = [];
outfitRows = 0;
taskIcons = {};

taskIcon = function(arg0, arg1 = false) constructor
{
	static get = function(arg0)
	{
		return struct_get(task, arg0);
	};
	
	x = 0;
	y = 0;
	task = arg0;
	isCompleted = arg1;
};

addTask = function(arg0, arg1)
{
	if (is_undefined(variable_struct_get(taskIcons, arg0)))
		variable_struct_set(taskIcons, arg0, []);
	
	var arr = variable_struct_get(taskIcons, arg0);
	array_push(arr, arg1);
	return arr;
};

addOutfit = function(arg0)
{
	array_push(outfitArr, arg0);
};

event_user(0);
