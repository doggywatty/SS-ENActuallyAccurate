function directory_get_files(dir_path, ext_pattern)
{
	var fileArr = [];
	var file = file_find_first($"{dir_path}*{ext_pattern}", 0);
	while file != ""
	{
		array_push(fileArr, file);
		file = file_find_next();
	}
	file_find_close();
	return fileArr;
}

function scr_lang_make_struct(_file)
{
	var filePath = string_concat(working_directory, "lang/", _file);
	var b = buffer_load(filePath);
	var text = string_split(buffer_read(b, buffer_text), "\n", true);
	buffer_delete(b);
	var json = "{\n";
	for (var i = 0; i < array_length(text); i++)
	{
		var l = text[i];
		var c;
		for (c = 1; string_char_at(l, c) == "\t"; c++)
		{
		}
		if (string_char_at(l, c) != "#")
		{
			if (string_pos(":", l) != 0)
				l = string_replace(l, "\r", ",\n");
			json += l;
		}
	}
	json += "\n}";
	var res = undefined;
	try
	{
		res = json_parse(json);
	}
	catch (_exception)
	{
		trace("Failed to parse lang json!");
		global.langError = "Could not parse lang file!";
		res = undefined;
	}
	if variable_struct_exists(res, "langFolder")
		res.langDictionary = scr_lang_get_dictionary(res.langFolder);
	else
		res.langDicitonary = {};
	return res;
}

function scr_lang_get_dictionary(_file)
{
	var filePath = string_concat(working_directory, "lang/", _file, "/", "Dictionary.json");
	if !file_exists(filePath)
		return {};
	var b = buffer_load(filePath);
	try
	{
		var json = buffer_read(b, buffer_text);
		return json_parse(json);
	}
	catch (_ex)
	{
		global.langError = string($"Unable to load sprite dictionary lang/{_file}/Dictionary.json");
		return {};
	}
}

function scr_lang_dictionary_fonts_add(_file, _allFonts)
{
	trace("Creating lang font dictionary");
	var fontDict = [];
	if (struct_exists(_allFonts, "Fonts"))
		fontDict = _allFonts.Fonts;
	if (array_length(fontDict) < 1)
	{
		trace("Could not find any defined fonts for current language");
		exit;
	}
	var basePath = string($"{working_directory}lang/");
	var path = string_concat(basePath, _file, "/Fonts");
	var init = false;
	if !instance_exists(obj_langSpriteLoader)
		instance_create(0, 0, obj_langSpriteLoader);
	if (is_undefined(ds_map_find_value(global.langFonts, global.langName)))
	{
		ds_map_set(global.langFonts, global.langName, {});
		init = true;
	}
	var font_struct_default = ds_map_find_value(global.langFonts, "_DEFAULT_FONTS");
	var font_struct = ds_map_find_value(global.langFonts, global.langName);
	if init
	{
		for (var i = 0; i < array_length(fontDict); i++)
		{
			try
			{
				var st = fontDict[i];
				if (!(is_struct(st) && struct_exists(st, "name") && struct_exists(st, "sprite")
				&& struct_exists(st, "map") && struct_exists(st, "separation")))
					continue;

				var nm = struct_get(st, "name");
				var map = struct_get(st, "map");
				var _spr = struct_get(st, "sprite");
				var sep = struct_get(st, "separation");
				var f = string($"{path}/{_spr}.png");
				if (!struct_exists(font_struct_default, nm) || _spr == "default")
					continue;
				if !file_exists(f)
				{
					trace($"Unable to find lang font {f}");
					global.langError = string($"Unable to find lang font {f}");
					continue;
				}
				trace($"Creating lang font {f}");
				var n = string_length(map);
				var prop = true;
				if (variable_struct_exists(st, "nonprop"))
				{
					var pv = variable_struct_get(st, "nonprop");
					pv = string_lower(string(pv));
					if (pv == "t" || pv == "true" || pv == 1)
						prop = false;
				}
				
				var xo = 0;
				if variable_struct_exists(st, "xoff")
				{
					var xv = variable_struct_get(st, "xoff");
					if is_real(xv)
						xo = xv;
				}
				
				var yo = 0;
				if variable_struct_exists(st, "yoff")
				{
					var yv = variable_struct_get(st, "yoff");
					if is_real(yv)
						yo = yv;
				}
				var s = sprite_add(f, n, false, false, xo, yo);
				var font = __scribble_font_add_sprite_ext(s, map, prop, sep);
				variable_struct_set(font_struct, nm, font);
			}
			catch (ex)
			{
				global.langError = string($"Failed to implement font from {global.langName}");
				continue;
			}
		}
	}
	
	var font_arr = struct_get_names(font_struct_default);
	for (var i = 0; i < array_length(font_arr); i++)
	{
		var fname = font_arr[i];
		var lang_font = struct_get(font_struct, fname);
		var default_font = struct_get(font_struct_default, fname);
		if !variable_global_exists(fname)
			continue;
		if is_undefined(lang_font)
			variable_global_set(fname, default_font);
		else
			variable_global_set(fname, lang_font);
	}
}

function scr_lang_fonts_init()
{
	var st = {};
	var fnt_arr = [
		["font", global.font], ["smallfont", global.smallfont],
		["creditsfont", global.creditsfont], ["collectfont", global.collectfont],
		["candlefont", global.candlefont], ["rankcombofont", global.rankcombofont],
		["bubblefont", global.bubblefont], ["timerfont", global.timerfont],
		["combofont", global.combofont], ["lapfont", global.lapfont],
		["dialogfont", global.dialogfont], ["buttonfont", global.buttonfont],
		["promptfont", global.promptfont], ["npcfont", global.npcfont],
		["npcsmallfont", global.npcsmallfont], ["keyDrawFont", global.keyDrawFont]
	];
	for (var i = 0; i < array_length(fnt_arr); i++)
		variable_struct_set(st, fnt_arr[i][0], fnt_arr[i][1]);
	ds_map_set(global.langFonts, "_DEFAULT_FONTS", st);
}

function scr_lang_dictionary_keys_add(_file, _allKeys)
{
	trace("Creating lang specific key sprites");
	var keyDict = [];
	if (struct_exists(_allKeys, "Keys"))
		keyDict = _allKeys.Keys;
	if (array_length(keyDict) < 1)
	{
		trace("Could not find any defined keys for current language");
		exit;
	}
	
	var define_keys = false;
	var basePath = string($"{working_directory}lang/");
	var path = string_concat(basePath, _file, "/Keys");
	var init = false;
	if !instance_exists(obj_langSpriteLoader)
		instance_create(0, 0, obj_langSpriteLoader);
	if (is_undefined(ds_map_find_value(global.langKeySprites, global.langName)))
	{
		ds_map_set(global.langKeySprites, global.langName, []);
		init = true;
	}
	
	var arr = ds_map_find_value(global.langKeySprites, global.langName);
	if init
	{
		for (var i = 0; i < array_length(keyDict); i++)
		{
			var st = keyDict[i];
			if (!(is_struct(st) && struct_exists(st, "name") && struct_exists(st, "map")))
				continue;
			var nm = struct_get(st, "name");
			var map = struct_get(st, "map");
			var f = string($"{path}/{nm}.png");
			if !file_exists(f)
			{
				trace($"Unable to find lang key {f}");
				global.langError = string($"Unable to find lang key {f}");
			}
			else
			{
				trace($"Creating keysprite {f}");
				var n = string_length(map);
				var s = sprite_add(f, n, false, false, 16, 16);
				array_push(arr, [nm, s, map]);
			}
		}
	}
	for (var i = 0; i < array_length(arr); i++)
	{
		var infoArr = arr[i];
		var keyName = infoArr[0];
		var keySprite = infoArr[1];
		var keyMap = infoArr[2];
		for (var j = 0; j < string_length(keyMap); j++)
		{
			var k = string_upper(string_char_at(keyMap, j + 1));
			scr_input_icon_add([ord(k)], keySprite, j);
		}
	}
}

function scr_lang_dictionary_sprites_add(_fileSpr, _allSprs)
{
	trace("Creating sprite dictionary");
	scr_lang_dictionary_sprites_clear();

	var spriteArr = [];
	var spriteDict = undefined;
	if (struct_exists(_allSprs, "Sprites"))
	{
		spriteDict = _allSprs.Sprites[0];
		spriteArr = struct_get_names(spriteDict);
	}
	if is_undefined(spriteDict)
		exit;
	var basePath = string($"{working_directory}lang/");
	if !instance_exists(obj_langSpriteLoader)
		var ld = instance_create(0, 0, obj_langSpriteLoader);
	for (var i = 0; i < array_length(spriteArr); i++)
	{
		var s = spriteArr[i];
		var p = struct_get(spriteDict, s);
		if (string_lower(p) == "default")
			continue;
		var spr = scr_lang_sprite_add(s, p, string_concat(basePath, _fileSpr, "/Sprites"));
		if (spr != "default")
			ds_map_set(global.langSpritesAsync, spr, s);
	}
}

function scr_lang_sprite_add(_spr, _spr1, _spr2)
{
	var f = string($"{_spr2}/{_spr1}.png");
	var s = asset_get_index(_spr);
	if !file_exists(f) || !sprite_exists(s)
	{
		trace($"Unable to find lang sprite {f}");
		global.langError = string($"Unable to find lang sprite {f}");
		return "default";
	}
	trace($"Creating sprite {f} for {_spr}");
	var n = sprite_get_number(s);
	var _xo = sprite_get_xoffset(s);
	var _yo = sprite_get_yoffset(s);
	return sprite_add_ext(f, n, _xo, _yo, true);
}

function scr_lang_dictionary_sprites_clear()
{
	var keys = ds_map_keys_to_array(global.langSprites);
	for (var i = 0; i < array_length(keys); i++)
	{
		var key = keys[i];
		var s = ds_map_find_value(global.langSprites, key);
		lang_sprite_check_persistence(key, key);
		array_push(global.langSpritesTemp, s);
		ds_map_delete(global.langSprites, key);
	}
	trace("Cleared lang sprite dictionary");
}

function scr_lang_set_file(_file)
{
	var prev_lang_struct = global.langStruct;
	global.langStruct = scr_lang_make_struct(_file);
	if is_undefined(global.langStruct)
		global.langStruct = prev_lang_struct;
	global.langName = string_copy(_file, 1, string_length(_file) - 4);
	scr_lang_dictionary_sprites_add(global.langStruct.langFolder, global.langStruct.langDictionary);
	scr_lang_dictionary_fonts_add(global.langStruct.langFolder, global.langStruct.langDictionary);
	scr_lang_dictionary_keys_add(global.langStruct.langFolder, global.langStruct.langDictionary);
	scr_initKeyNameMap();
	trace($"Loaded new lang file ({_file})");
	return true;
}

function scr_lang_reload()
{
	scr_lang_dictionary_sprites_clear();
	scr_lang_init();
}

function scr_lang_init()
{
	global.langStruct = {};
	global.langFiles = [];
	global.langError = ""
	if !variable_global_exists("langSpritesAsync")
		global.langSpritesAsync = ds_map_create();
	if !variable_global_exists("langSprites")
		global.langSprites = ds_map_create();
	if !variable_global_exists("langFonts")
	{
		global.langFonts = ds_map_create();
		scr_lang_fonts_init();
	}
	if !variable_global_exists("langKeySprites")
		global.langKeySprites = ds_map_create();
	if !variable_global_exists("langSpritesTemp")
		global.langSpritesTemp = [];
	global.langDefault = scr_lang_make_struct("EN.txt");
	if is_undefined(global.langDefault)
		global.langDefault = {};
	scr_lang_initvals();
	ini_open("optionData.ini");
	global.langName = ini_read_string("Settings", "lang", "EN");
	ini_close();
	var _dir = string_concat(working_directory, "lang/");
	global.langFiles = directory_get_files(_dir, ".txt");
	trace("Found Lang Files: ", json_stringify(global.langFiles, true));
	if (array_contains(global.langFiles, string($"{global.langName}.txt")))
		scr_lang_set_file($"{global.langName}.txt");
	else if (array_length(global.langFiles) > 0)
		scr_lang_set_file(global.langFiles[0]);
	else
		global.langError = "Could not find any files in lang folder!";
	trace("Initiated language: ", lang_get("language"));
}

function lang_key_exists(_langKey)
{
	if (is_undefined(global.langDefault) || !variable_struct_exists(global.langDefault, _langKey))
		return false;
	return true;
}

function lang_get(_lang, _cont = undefined)
{
	var content = "";
	if (is_undefined(global.langStruct) || !variable_struct_exists(global.langStruct, _lang))
	{
		if !is_undefined(global.langDefault) && variable_struct_exists(global.langDefault, _lang)
		{
			content = variable_struct_get(global.langDefault, _lang);
			if (string_length(global.langError) < 1)
				global.langError = string($"Could not find value \"{_lang}\" for lang {global.langName}!");
		}
		else if (string_length(global.langError) < 1)
			global.langError = string($"No such lang key exists \"{_lang}\"!");
	}
	else
		content = variable_struct_get(global.langStruct, _lang);
	if !is_undefined(_cont)
	{
		for (var i = 0; i < array_length(_cont); i++)
		{
			var c = 1, s = string(_cont[i]);
			while (c <= string_length(content))
			{
				if (string_char_at(content, c) == "/")
				{
					var digit = string_digits(string_copy(content, c + 1, 1));
					if (real(digit) == (i + 1))
					{
						content = string_delete(content, c, 2);
						content = string_insert(s, content, c);
					}
					else
						c++;
				}
				else
					c++;
			}
		}
	}
	return content;
}

function lang_group_replace(_leng, _brackets = ["{", "}"], _lang_vals = global.lang_values)
{
	var result = "";
	var len = string_length(_leng);
	var captured = false;
	var buffer = "";
	var delimOpen = _brackets[0];
	var len_open = string_length(delimOpen);
	var delimClose = _brackets[1];
	var len_close = string_length(delimClose);
	for (var i = 1; i <= len; i++)
	{
		if (!captured && string_copy(_leng, i, len_open) == delimOpen)
		{
			captured = true;
			i += (len_open - 1);
		}
		else if (captured && string_copy(_leng, i, len_close) == delimClose)
		{
			captured = false;
			if (ds_map_exists(_lang_vals, buffer))
				result += ds_map_find_value(_lang_vals, buffer);
			else
				result += (delimOpen + buffer + delimClose);
			buffer = "";
			i += (len_close - 1);
		}
		else if captured
			buffer += string_char_at(_leng, i);
		else
			result += string_char_at(_leng, i);
	}
	return result;
}

function lang_transform_string(_brackets)
{
	var result = lang_group_replace(_brackets, ["{", "}"], global.lang_values);
	return result;
}

function lang_get_sprite(_langspr)
{
	if !variable_struct_exists(global.langStruct, "langDictionary")
	{
		trace("Requested sprite from a language with no dictionary!");
		return _langspr;
	}
	var s = ds_map_find_value(global.langSprites, _langspr);
	if !is_undefined(s)
		return s;
	return _langspr;
}

function lang_sprite_check_persistence(_sprcheck, _pauseBorder)
{
	switch _sprcheck
	{
		case spr_newpause_border:
			with obj_pause
				pauseBorder = _pauseBorder;
			break;
	}
}

function scr_lang_initvals()
{
	if !variable_global_exists("lang_values")
		global.lang_values = ds_map_create();
	var initArr = [
		["s", "[shake]"],
		["u", "[wave]"]
	];
	for (var i = 0; i < array_length(initArr); i++)
	{
		var pair = initArr[i];
		ds_map_set(global.lang_values, array_get(pair, 0), pair[1]);
	}
}

function font_get_sprite(_sprinfo, _sprindname = false)
{
	var res = font_get_info(_sprinfo).spriteIndex;
	if (res != -1 && _sprindname)
		return sprite_get_name(res);
	return res;
}
