switch room
{
	case hub_demohallway:
	case hub_paintstudio:
	case hub_molasses:
		addLevel("entryway", 0).setIcon(spr_tvdisplay_levels, 0);
		addLevel("steamy", 1).setIcon(spr_tvdisplay_levels, 1);
		addLevel("mineshaft", 2).setIcon(spr_tvdisplay_levels, 2);
		addLevel("molasses", 3).setIcon(spr_tvdisplay_levels, 3);
		break;
}

var pg = getPage(array_length(displayPages));
var e = new displayElement();
e.properties = 
{
	isLevel: false,
	confCount: 0,
	confMax: 0,
	secCount: 0,
	secMax: 0,
	taskCount: 0,
	taskMax: 0,
	palCount: 0,
	palMax: 0,
	treasureCount: 0,
	treasureMax: 0
};

var realLevels = ["entryway", "steamy", "mineshaft", "molasses"];
var p = e.properties;
ini_open(global.SaveFileName);
for (var i = 0; i < array_length(realLevels); i++)
{
	var lv = realLevels[i];
	p.treasureCount += ini_read_real("Treasure", lv, 0);
	p.treasureMax++;
	for (var s = 0; s < 3; s++)
		p.secCount += ini_read_real("Secret", lv + string(s + 1), 0) ? 1 : 0;
	
	p.secMax += 3;
	for (var c = 1; c <= 5; c++)
	{
		p.confCount += ini_read_real("Confecti", string($"{lv}{c}"), 0);
		p.confMax++;
	}
}

var taskedAreas = array_concat(realLevels, ["demoEN"]);
for (var i = 0; i < array_length(taskedAreas); i++)
{
	var tasks = scr_get_chef_tasks(taskedAreas[i], false);
	for (var j = 0; j < array_length(tasks); j++)
	{
		p.taskCount += ini_read_real("ChefTasks", tasks[j].taskKey, 0) == 1;
		p.taskMax++;
	}
}

ini_close();
ini_open("optionData.ini");

var pal = scr_get_palettes(false);
for (var i = 0; i < array_length(pal); i++)
{
	p.palCount += ini_read_real("Palettes", pal[i].taskKey, 0) == 1;
	p.palMax++;
}

ini_close();
array_push(pg.contentArr, e);
lastPage = array_length(displayPages) - 1;
