function scr_judgment_assign()
{
	var per = scr_completion_percent(global.SaveFileName);
	ini_open(global.SaveFileName);
	var j = "disappointing";
	var judgement = ini_read_string("Game", "Judgment", "noone");
	if (per >= 100)
		j = "perfect";
	else if (per >= 50)
		j = "fine";
	if (global.SaveMinutes < 20)
		j = "fast";
	if (global.SaveMinutes < 45 && per >= 101)
		j = "holyshit";
	if (judgement == "holyshit")
		j = "holyshit";
	
	ini_write_string("Game", "Judgment", j);
	ini_close();
	trace($"Save File Judgment: {j}");
	return scr_judgment_get(j);
}

function scr_judgment_get(_judgmentval)
{
	var j = ds_map_find_value(global.judgment_map, _judgmentval);
	return j ?? ds_map_find_value(global.judgment_map, "none");
}

function scr_judgment_read(_judgmentfile)
{
	if !file_exists(_judgmentfile)
		return scr_judgment_get("none");
	ini_open(_judgmentfile);
	var p = ini_read_string("Game", "Judgment", "none");
	ini_close();
	return scr_judgment_get(p);
}

function saveJudgment() constructor
{
	static setProperties = function(_properties)
	{
		properties = _properties;
		return self;
	};
	
	properties = 
	{
		title: "",
		titlespr: spr_null,
		titleindex: 0,
		splash: spr_null,
		splashindex: 0,
		filespr: spr_null,
		fileindex: 0
	};
	return self;
}

function add_judgment(_judgment, _judgprops)
{
	var j = new saveJudgment().setProperties(_judgprops);
	j.properties.title = lang_get($"judgment_title_{_judgment}");
	j.properties.dialog = [lang_get("judgmentinfo_default")];
	for (var i = 1; lang_key_exists($"judgmentinfo_{_judgment}_{i}"); i++)
	{
		var dg = lang_get($"judgmentinfo_{_judgment}_{i}");
		array_push(j.properties.dialog, dg);
	}
	array_push(j.properties.dialog, lang_get("judgmentinfo_ending"));
	ds_map_set(global.judgment_map, _judgment, j);
	return j;
}


function scr_judgment_init()
{
	if !variable_global_exists("judgment_map")
	{
		global.judgment_map = ds_map_create();
		add_judgment("none", 
		{
			title: "none",
			titlespr: spr_null,
			titleindex: 0,
			splash: spr_null,
			splashindex: 0,
			filespr: spr_null,
			fileindex: 0
		});
	}
	else
	{
		var default_judgment = ds_map_find_value(global.judgment_map, "none");
		ds_map_clear(global.judgment_map);
		ds_map_set(global.judgment_map, "none", default_judgment);
	}
	add_judgment("disappointing", 
	{
		title: "disappointing",
		titlespr: spr_null,
		titleindex: 0,
		splash: spr_null,
		splashindex: 0,
		filespr: spr_judgment_files,
		fileindex: 0
	});
	add_judgment("fine", 
	{
		title: "fine",
		titlespr: spr_null,
		titleindex: 0,
		splash: spr_null,
		splashindex: 0,
		filespr: spr_judgment_files,
		fileindex: 1
	});
	add_judgment("perfect", 
	{
		title: "perfect",
		titlespr: spr_null,
		titleindex: 0,
		splash: spr_null,
		splashindex: 0,
		filespr: spr_judgment_files,
		fileindex: 2
	});
	add_judgment("fast", 
	{
		title: "fast",
		titlespr: spr_null,
		titleindex: 0,
		splash: spr_null,
		splashindex: 0,
		filespr: spr_judgment_files,
		fileindex: 3
	});
	add_judgment("holyshit", 
	{
		title: "holyshit",
		titlespr: spr_null,
		titleindex: 0,
		splash: spr_null,
		splashindex: 0,
		filespr: spr_judgment_files,
		fileindex: 4
	});
}
