global.fontDefault = __scribble_font_add_sprite_ext(spr_font, "AÁÀÂÃBCÇDEÉÊFGHIÍJKLMNÑOÓÔÕPQRSTUÚVWXYZ!¡.,1234567890:?¿_-�", 1, 0);
global.promptfont = __scribble_font_add_sprite_ext(spr_promptfont, "AÁÀÂÃBCÇDEÉÊFGHIÍJKLMNÑOÓÔÕPQRSTUÚVWXYZaáàâãbcçdeéêfghiíjklmnñoóôõpqrstuúvwxyz.,:!¡0123456789?¿'\"\\�_-[]▼()&#风雨廊桥전태양*яиБжидГзвбнль", 1, 0);
global.smallfont = __scribble_font_add_sprite_ext(spr_smallfont, "AÁÀÂÃBCÇDEÉÊFGHIÍJKLMNÑOÓÔÕPQRSTUÚVWXYZ.?!¡1234567890\"-:_�", 1, 0);
global.npcfont = __scribble_font_add_sprite_ext(spr_npcfont, "AÁÀÂÃBCÇDEÉÊFGHIÍJKLMNÑOÓÔÕPQRSTUÚVWXYZaáàâãbcçdeéêfghiíjklmnñoóôõpqrstuúvwxyz!¡,.:0123456789'?¿-()\"_/�", 1, 2);
global.npcsmallfont = __scribble_font_add_sprite_ext(spr_npcsmallfont, "AÁÀÂÃBCÇDEÉÊFGHIÍJKLMNÑOÓÔÕPQRSTUÚVWXYZaáàâãbcçdeéêfghiíjklmnñoóôõpqrstuúvwxyz!¡.,:0123456789'?¿-\"()/_�", true, 1);
global.SoundTestFont = global.npcfont;
global.smalltimerfont = __scribble_font_add_sprite_ext(spr_smalltimerfont, ".1234567890:", 1, 0);
global.creditsfont = __scribble_font_add_sprite_ext(spr_creditsfont, " ABCDEFGHIJKLMNOPQRSTUVWXYZ.!,abcdefghijklmnopqrstuvwxyz0123456789@#$%^&*(){}[]|:;'/`", 1, 0);
global.collectfont = __scribble_font_add_sprite_ext(spr_fontcollect, "0123456789", 1, 0);
global.candlefont = __scribble_font_add_sprite_ext(spr_fontcandle, "0123456789", 1, 0);
global.candleBigFont = __scribble_font_add_sprite_ext(spr_fontBigCandle, "0123456789", 1, 0);
global.rankcombofont = __scribble_font_add_sprite_ext(spr_fontrankcombo, "0123456789", 1, 0);
global.bubblefont = __scribble_font_add_sprite_ext(spr_bubblefont, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.!<>'?()[]", 1, 0);
global.timerfont = __scribble_font_add_sprite_ext(spr_timer_font, "1234567890", 0, 6);
global.combofont = __scribble_font_add_sprite_ext(spr_tvHUD_comboFont, "0123456789", 1, 2);
global.lapfont = __scribble_font_add_sprite_ext(spr_lap_font, "0123456789", 1, 2);
global.dialogfont = __scribble_font_add_sprite_ext(spr_font_dialogue, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz,.!¡?¿:;\"`'/-_+=1234567890@#$%^&*()[]ÁÉÍÓÚáéíóú", 1, 2);
global.percentageFont = __scribble_font_add_sprite_ext(spr_fontPercentage, "1234567890%", 1, 2);
global.buttonfont = __scribble_font_add_sprite_ext(spr_buttonfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZ$%&*()/", 1, 0);
global.cafefont = __scribble_font_add_sprite_ext(spr_cafefontbig, "0123456789:", 1, 0);
global.cafefontsmall = __scribble_font_add_sprite_ext(spr_cafefontsmall, "0123456789:", 1, 0);
global.keyDrawFont = __scribble_font_add_sprite_ext(spr_keyDrawFont, "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+=-*'`,./\\{];", true, 0);
global.MoneyFont = __scribble_font_add_sprite_ext(spr_moneyFont, "0123456789$-", true, 0);
global.smallnumberfont = __scribble_font_add_sprite_ext(spr_smallnumber, "1234567890-+", true, 0);
global.captionfont = font_tahoma;

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
		trace("Failed to parse lang json! :: \n", json);
		global.langError = "Could not parse lang file!";
		res = undefined;
	}
	if !is_undefined(res)
	{
		if (variable_struct_exists(res, "langFolder"))
			res.langDictionary = scr_lang_get_dictionary(res.langFolder);
		else
			res.langDictionary = {};
	}
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
		global.langError = $"Unable to load sprite dictionary lang/{_file}/Dictionary.json";
		return {};
	}
}

function scr_lang_dictionary_fonts_add(_file, _allFonts)
{
	trace("Creating lang font dictionary");
	var fontDict = [];
	if (struct_exists(_allFonts, "Fonts"))
		fontDict = _allFonts.Fonts;
	var basePath = $"{working_directory}lang/";
	var path = string_concat(basePath, _file, "/Fonts");
	var init = false;
	if !instance_exists(obj_langSpriteLoader)
		instance_create(0, 0, obj_langSpriteLoader);
	if (is_undefined(ds_map_find_value(global.langFonts, global.langName)))
	{
		ds_map_set(global.langFonts, global.langName, {});
		trace("Initializing Font. (First time loading.)");
		if (array_length(fontDict) < 1)
			trace("Could not find any defined fonts for current language");
		else
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
				if (!((is_struct(st) && struct_exists(st, "name") && (struct_exists(st, "sprite")
				&& struct_exists(st, "map") && struct_exists(st, "separation")))
				|| struct_exists(st, "file")))
					continue;

				var nm = struct_get(st, "name");
				var map = struct_get(st, "map");
				var file = struct_get(st, "file");
				var _spr = struct_get(st, "sprite");
				var sep = struct_get(st, "separation");
				var f = $"{path}/{_spr}.png";
				if (!struct_exists(font_struct_default, nm) || _spr == "default")
					continue;
				if (struct_exists(st, "file"))
				{
					f = $"{path}/{file}";
					if (!file_exists(f))
					{
						trace($"Unable to find lang font {f}");
						global.langError = $"Unable to find lang font {f}";
						continue;
					}
					if (!struct_exists(st, "size"))
					{
						trace($"Unable to find size for lang font {f}");
						global.langError = $"Unable to find size for lang font {f}";
						continue;
					}
					
					var isBold = false;
					if (struct_exists(st, "bold"))
						isBold = struct_get(st, "bold");
					
					var isItalic = false;
					if (struct_exists(st, "italic"))
						isItalic = struct_get(st, "italic");
					
					var firstChar = 32;
					if (struct_exists(st, "first"))
						firstChar = struct_get(st, "first");
					
					var lastChar = 128;
					if (struct_exists(st, "last"))
						lastChar = struct_get(st, "last");
					
					trace($"Adding lang font {f}");
					font = font_add(f, struct_get(st, "size"), isBold, isItalic, firstChar, lastChar);
					variable_struct_set(font_struct, nm, font);
				}					
				if !file_exists(f)
				{
					trace($"Unable to find lang font {f}");
					global.langError = $"Unable to find lang font {f}";
					continue;
				}
				trace($"Creating lang font {f}");
				var font_d = struct_get(font_struct_default, nm);
				var sprite_d = font_get_sprite(font_d);
				var n = string_length(map);
				trace($"Font map: {map} ({n})");
				var prop = true;
				if (variable_struct_exists(st, "nonprop"))
				{
					var pv = variable_struct_get(st, "nonprop");
					pv = string_lower(string(pv));
					if (pv == "t" || pv == "true" || pv == 1)
						prop = false;
				}
				
				var xo = sprite_get_xoffset(sprite_d);
				if variable_struct_exists(st, "xoff")
				{
					var xv = variable_struct_get(st, "xoff");
					if is_real(xv)
						xo = xv;
				}
				
				var yo = sprite_get_yoffset(sprite_d);
				if variable_struct_exists(st, "yoff")
				{
					var yv = variable_struct_get(st, "yoff");
					if is_real(yv)
						yo = yv;
				}
				var s = sprite_add(f, n, false, false, xo, yo);
				sprite_collision_mask(s, true, 0, 0, 0, 0, 0, 0, 0);
				var font = __scribble_font_add_sprite_ext(s, map, prop, sep);
				variable_struct_set(font_struct, nm, font);
			}
			catch (ex)
			{
				global.langError = $"Failed to implement font from {global.langName}";
				continue;
			}
		}
		trace($"Updated font map: {json_encode(global.langFonts, true)}");
	}
	
	var font_arr = struct_get_names(font_struct_default);
	for (var i = 0; i < array_length(font_arr); i++)
	{
		var fname = font_arr[i];
		var lang_font = struct_get(font_struct, fname);
		var default_font = struct_get(font_struct_default, fname);
		if !variable_global_exists(fname)
			continue;
		var font_sprite = font_get_sprite(lang_font ?? default_font, true);
		var default_font_sprite = font_get_sprite(default_font, true);
		variable_global_set(fname, lang_font ?? default_font);
		trace($"Set global.{fname} to {variable_global_get(fname)}. Default: {default_font}");
	}
}

function scr_lang_fonts_init()
{
	var st = {};
	var fnt_arr = [
		"fontDefault", "smallfont", "creditsfont", "collectfont", "candlefont", "rankcombofont",
		"bubblefont", "timerfont", "combofont", "lapfont", "dialogfont", "buttonfont", "promptfont",
		"npcfont", "npcsmallfont", "captionfont", "keyDrawFont"
	];
	for (var i = 0; i < array_length(fnt_arr); i++)
	{
		var font_name = fnt_arr[i];
		if !variable_global_exists(font_name)
			continue;
		variable_struct_set(st, font_name, variable_global_get(font_name));
		scribble_add_macro(font_name, scr_lang_get_font_macro(font_name));
	}
	ds_map_set(global.langFonts, "_DEFAULT_FONTS", st);
}

function scr_lang_get_font_macro(font)
{
	return method(
	{
		__fnt: font
	},
	function()
	{
		return $"[{sprite_get_name(font_get_sprite(variable_global_get(__fnt)))}]";
	});
}

function scr_lang_dictionary_keys_add(_file, _allKeys)
{
	trace("Creating lang specific key sprites");
	var keyDict = [];
	if (struct_exists(_allKeys, "Keys"))
		keyDict = _allKeys.Keys;

	var define_keys = false;
	var basePath = $"{working_directory}lang/";
	var path = string_concat(basePath, _file, "/Keys");
	var init = false;
	if !instance_exists(obj_langSpriteLoader)
		instance_create(0, 0, obj_langSpriteLoader);
	if (is_undefined(ds_map_find_value(global.langKeySprites, global.langName)))
	{
		ds_map_set(global.langKeySprites, global.langName, []);
		trace("Initializing Keys. (First time loading.)");
		if (array_length(keyDict) < 1)
			trace("Could not find any defined keys for current language");
		else
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
			var f = $"{path}/{nm}.png";
			if !file_exists(f)
			{
				trace($"Unable to find lang key {f}");
				global.langError = $"Unable to find lang key {f}";
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
	scr_lang_dictionary_sprites_clear();
	trace("Creating sprite dictionary");
	var spriteArr = [];
	var spriteDict = undefined;
	if (struct_exists(_allSprs, "Sprites"))
	{
		spriteDict = _allSprs.Sprites[0];
		spriteArr = struct_get_names(spriteDict);
	}

	if (is_undefined(spriteDict))
	{
		trace("Sprite dictionary for ", global.langName, " was undefined");
		exit;
	}
	else if (array_length(spriteArr) > 0)
		trace("Found sprite dictionary entries for : ", json_stringify(spriteArr, false));

	var basePath = $"{working_directory}lang/";
	if !instance_exists(obj_langSpriteLoader)
		var ld = instance_create(0, 0, obj_langSpriteLoader);
	for (var i = 0; i < array_length(spriteArr); i++)
	{
		var s = spriteArr[i];
		var p = struct_get(spriteDict, s);
		var fp = string_concat(basePath, _fileSpr, "/Sprites");
		
		if (is_struct(p))
		{
			trace("Lang Loading :: Entry is a struct.");
			scr_lang_sprite_add_struct(s, p, fp);
		}
		else if (is_array(p))
		{
			trace("Lang Loading :: Entry is an array.");
			scr_lang_sprite_add_array(s, p, fp);
		}
		else if (string_lower(p) == "default")
			trace("Lang Loading :: Entry is default.");
		else
		{
			var spr = scr_lang_sprite_add(s, p, fp);
			if (spr != "default")
				ds_map_set(global.langSpritesAsync, spr, s);
		}
	}
}

function scr_lang_sprite_add_struct(_langSpr, _pos, _sprType)
{
    var _sp = struct_get(_pos, "sprite");
    if (is_undefined(_sp))
    {
        trace($"Unable to find sprite info for {json_stringify(_pos)}");
        exit;
    }
    
    trace($"Initializing custom load for {_sp} ({_langSpr})");
    var _xo = struct_get(_pos, "xoff");
    var _yo = struct_get(_pos, "yoff");
    
    if (is_array(_sp))
    {
        scr_lang_sprite_add_array(_langSpr, _sp, _sprType, _xo, _yo);
        exit;
    }
    
    var spr = scr_lang_sprite_add(_langSpr, _sp, _sprType, _xo, _yo);
    if (spr != "default")
        ds_map_set(global.langSpritesAsync, spr, _langSpr);
}

function scr_lang_sprite_add_array(_baseSpr, _frameData, _assetPath, _xOffset = undefined, _yOffset = undefined)
{
    var baseSprite = asset_get_index(_baseSpr);
    var fileCheck = true;
    for (var i = 0; i < array_length(_frameData); i++)
    {
        var nm;
        if (is_struct(_frameData[i]))
            nm = struct_get(_frameData[i], "image") ?? "default";
        else
            nm = _frameData[i];
        
        if (nm == "default")
            continue;
        else if !file_exists($"{_assetPath}/{nm}.png")
        {
            fileCheck = false;
            break;
        }
    }
    
    if (!fileCheck || !sprite_exists(baseSprite))
    {
        global.langError = $"Unable to find all assets for lang sprite at {_assetPath}";
        trace(global.langError);
        exit;
    }
    
    var n = sprite_get_number(baseSprite);
    var sw = sprite_get_width(baseSprite);
    var sh = sprite_get_height(baseSprite);
    var sp = sprite_get_speed(baseSprite);
    var spT = sprite_get_speed_type(baseSprite);
    if is_undefined(_xOffset)
        _xOffset = sprite_get_xoffset(baseSprite);
    if is_undefined(_yOffset)
        _yOffset = sprite_get_yoffset(baseSprite);
    
    var builtSprite = undefined;
    var surf = surface_create(sw, sh);
    var _fc = 0;
    for (var i = 0; i < array_length(_frameData); i++)
    {
        var current_frame = _frameData[i];
        var fcount = 1;
        var nm;            
        if (is_struct(current_frame))
        {
            nm = struct_get(current_frame, "image");
            fcount = struct_get(current_frame, "length") ?? 1;
            var repeat_count = struct_get(current_frame, "repeat") ?? 1;
            if (repeat_count > 1)
            {
                var rframe = variable_clone(current_frame);
                struct_set(rframe, "repeat", repeat_count - 1);
                array_insert(_frameData, i + 1, rframe);
            }
        }
        else
            nm = current_frame ?? "default";

        if (nm == "default")
        {
            surface_set_target(surf);
            draw_clear_alpha(c_white, 0);
            draw_sprite(baseSprite, i, _xOffset, _yOffset);
            surface_reset_target();
            if (is_undefined(builtSprite))
                builtSprite = sprite_create_from_surface(surf, 0, 0, sw, sh, false, false, _xOffset, _yOffset);
            else
                sprite_add_from_surface(builtSprite, surf, 0, 0, sw, sh, false, false);
        }
        else
        {
            var f = $"{_assetPath}/{nm}.png";
            if (is_undefined(builtSprite))
                builtSprite = sprite_add(f, fcount, false, false, _xOffset, _yOffset);
            else
            {
                var _tempspr = sprite_add(f, fcount, false, false, _xOffset, _yOffset);
                sprite_merge(builtSprite, _tempspr);
                sprite_delete(_tempspr);
            }
        }
        _fc += fcount;
        if (i >= (array_length(_frameData) - 1) && _fc < n)
            array_push(_frameData, "default");
    }
    surface_free(surf);
    if is_undefined(builtSprite)
        exit;
    trace($"Added extended lang sprite for {_baseSpr} with length {sprite_get_number(builtSprite)}");
    sprite_set_speed(builtSprite, sp, spT);
    ds_map_set(global.langSprites, baseSprite, builtSprite);
    ds_map_set(global.langSpriteKeys, builtSprite, baseSprite);
    lang_sprite_check_persistence(baseSprite, builtSprite);    
}

function scr_lang_sprite_add(_spr, _spr1, _spr2, _x = undefined, _y = undefined)
{
	var f = $"{_spr2}/{_spr1}.png";
	var s = asset_get_index(_spr);
	if !file_exists(f) || !sprite_exists(s)
	{
		trace($"Unable to find lang sprite {f}");
		global.langError = $"Unable to find lang sprite {f}";
		return "default";
	}
	trace($"Creating sprite {f} for {_spr}");
	var n = sprite_get_number(s);
	if is_undefined(_x)
		_x = sprite_get_xoffset(s);
	if is_undefined(_y)
		_y = sprite_get_yoffset(s);
	return sprite_add_ext(f, n, _x, _y, true);
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
	if (is_undefined(global.langStruct))
	{
		global.langStruct = prev_lang_struct;
		if (is_undefined(prev_lang_struct) || !variable_struct_exists(prev_lang_struct, "langDictionary"))
			global.langStruct = global.langDefault;
	}
	if (!variable_struct_exists(global.langStruct, "langFolder") || !variable_struct_exists(global.langStruct, "langDictionary"))
	{
		global.langName = "FAIL";
		trace("FAILED TO GET THE DICTIONARY FOR SELECTED LANGUAGE");
		return false;
	}
	
	global.langName = string_copy(_file, 1, string_length(_file) - 4);
	if (variable_struct_exists(global.langStruct, "langFolder"))
	{
		scr_lang_dictionary_sprites_add(global.langStruct.langFolder, global.langStruct.langDictionary);
		scr_lang_dictionary_fonts_add(global.langStruct.langFolder, global.langStruct.langDictionary);
		scr_lang_dictionary_keys_add(global.langStruct.langFolder, global.langStruct.langDictionary);
	}
	lang_refresh_store();
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
	if !variable_global_exists("langSpriteKeys")
		global.langSpriteKeys = ds_map_create();		
	global.langDefault = scr_lang_make_struct("EN.txt");
	if is_undefined(global.langDefault)
		global.langDefault = {};
	scr_lang_initvals();
	ini_open("optionData.ini");
	global.langName = ini_read_string("Settings", "lang", "none");
	ini_close();
	if (global.langName == "none")
	{
		var os_lang = string_upper(os_get_language());
		var os_region = string_upper(os_get_region());
		switch (os_lang)
		{
			case "ES":
				if (os_region == "ES" || os_region == "ESP")
					os_lang = "ES";
				else
					os_lang = "LATAM";
				break;
			case "PT":
				if (os_region == "BR")
					os_lang = "PTBR";
				else
					os_lang = "PT";
				break;
			case "ZH":
				if (os_region == "HK" || os_region == "MO" || os_region == "TW")
					os_lang = "TC";
				else
					os_lang = "SC";
				break;
		}
		global.langName = os_lang;
	}
	
	ini_close();
	var _dir = string_concat(working_directory, "lang/");
	global.langFiles = directory_get_files(_dir, ".txt");
	trace("Found Lang Files: ", json_stringify(global.langFiles, true));
	if (array_contains(global.langFiles, $"{global.langName}.txt"))
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
				global.langError = $"Could not find value \"{_lang}\" for lang {global.langName}!";
		}
		else if (string_length(global.langError) < 1)
			global.langError = $"No such lang key exists \"{_lang}\"!";
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

function lang_get_sprite_key(_langKey)
{
	if !variable_struct_exists(global.langStruct, "langDictionary")
	{
		trace("Requested sprite from a language with no dictionary!");
		return _langKey;
	}
	
	var s = ds_map_find_value(global.langSpriteKeys, _langKey);
	if !is_undefined(s)
	{
		trace($"Found sprite key {sprite_get_name(s)} for lang sprite {sprite_get_name(_langKey)}");
		return s;
	}
	
	trace($"Couldn't find key for lang sprite {sprite_get_name(_langKey)}");
	return _langKey;
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

function lang_refresh_store()
{
	scr_initKeyNameMap();
	scr_judgment_init();
	if !instance_exists(obj_langSpriteLoader)
		lang_update_layers();
}

function lang_update_layers()
{
	if global.gamePauseState
		instance_activate_object(obj_parallax);
	if !instance_exists(obj_parallax)
		exit;
	for (var i = 0; i < array_length(obj_parallax.layerArray); i++)
	{
		var lay = obj_parallax.layerArray[i];
		if !array_contains(lay.argArr, "lang")
			continue;
		var q = layer_get_all_sprites(lay.id);
		for (var r = 0; r < array_length(q); r++)
		{
			var _sp = q[r];
			var _sn = layer_sprite_get_sprite(_sp);
			var _ls = lang_get_sprite(_sn);
			if global.langUpdated
			{
				var _ky = lang_get_sprite_key(_sn);
				_ls = lang_get_sprite(_ky);
			}
			if (_sn != _ls)
			{
				trace("Lang Layer Update :: Replaced Sprite: ", sprite_get_name(_sn));
				layer_sprite_change(_sp, _ls);
			}
		}
	}
	if global.gamePauseState
		instance_deactivate_object(obj_parallax);
}

function lang_sprite_keymap_clean()
{
	var spriteArr = ds_map_keys_to_array(global.langSpriteKeys);
	for (var i = 0; i < array_length(spriteArr); i++)
	{
		var _sp = spriteArr[i];
		if !sprite_exists(_sp)
			ds_map_delete(global.langSpriteKeys, _sp);
	}
	global.langUpdated = false;
}