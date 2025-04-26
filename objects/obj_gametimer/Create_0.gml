if instance_number(object_index) > 1
{
	instance_destroy();
	exit;
}
depth = -180;
global.SaveFrames = 0;
global.SaveSeconds = 0;
global.SaveMinutes = 0;
global.LevelFrames = 0;
global.LevelSeconds = 0;
global.LevelMinutes = 0;
in_level = false;
freeze_timer = true;
stop_timer = true;
ls_buffer = -1;
ls_buffer_start = 0;
use_livesplit = false;

livesplitInit = function()
{
	if (buffer_exists(ls_buffer))
		buffer_delete(ls_buffer);
	for (var p_i = 0, p_c = parameter_count(); p_i <= p_c; p_i++)
	{
		var p_s = string_lower(parameter_string(p_i));
		switch p_s
		{
			case "--livesplit":
			case "-livesplit":
				use_livesplit = true;
				break;
		}
	}
	if global.option_livesplit_enabled
		use_livesplit = true;
	if !use_livesplit
		return 0;
	
	trace("Initializing Livesplit Buffer");
	ls_buffer = buffer_create(2048, buffer_fixed, 1);
	buffer_fill(ls_buffer, 0, buffer_u8, 0, buffer_get_size(ls_buffer));
	buffer_seek(ls_buffer, buffer_seek_start, 0);
	var MAGIC = [
		29, 138, 192, 91, 180, 25, 83, 62, 93, 130, 232, 179, 171, 58, 54, 168, 128, 49, 242,
		41, 155, 20, 159, 173, 163, 187, 254, 101, 98, 124, 174, 209
	];
	MAGICsize = array_length(MAGIC);
	for (var Mi = 0, Ml = MAGICsize; Mi < Ml; Mi++)
		buffer_write(ls_buffer, buffer_u8, MAGIC[Mi]);
	
	buffer_seek(ls_buffer, buffer_seek_start, 0);
	buffer_poke(ls_buffer, MAGICsize, buffer_text, "4.0.1.0");
	buffer_poke(ls_buffer, MAGICsize + 32, buffer_string, lang_get("version"));
	ls_buffer_start = MAGICsize + 96;
	show_debug_message("BUFFER ADDRESS = " + string(buffer_get_address(ls_buffer)));
	show_debug_message("END!");
};

saveTime = function(_file = global.SaveFileName)
{
	ini_open(_file);
	ini_write_real("Game", "frames", global.SaveFrames);
	ini_write_real("Game", "seconds", global.SaveSeconds);
	ini_write_real("Game", "minutes", global.SaveMinutes);
	ini_close();
};

makeString = function(str1, str2, str3)
{
	var s_str = "";
	var m_str = "";
	var dsec_prec = global.option_speedrun_timer ? 3 : 2;
	var dsec_str = string_format(str3 / 60, 1, dsec_prec);
	dsec_str = string_delete(dsec_str, 1, 2);
	
	while (string_length(dsec_str) != dsec_prec)
	{
		var len = string_length(dsec_str);
		if (len < dsec_prec)
			dsec_str += "0";
		else if (len > dsec_prec)
			dsec_str = string_delete(dsec_str, string_length(dsec_str), 1);
	}
	
	var s_real = floor(str2);
	str1 = floor(str1 + floor(s_real / 60));
	s_real = s_real % 60;
	if (s_real < 10)
		s_str = $"0{s_real}";
	else
		s_str = string(s_real);
	
	var hours = floor(str1 / 60);
	str1 %= 60;
	if (str1 < 10)
		m_str = $"0{str1}";
	else
		m_str = string(str1);
	
	var days = floor(hours / 24);
	hours = hours % 24;
	if (hours < 10)
		hours = $"0{hours}";
	else
		hours = string(hours);
	
	var timer_string = $"{hours}:{m_str}:{s_str}.{dsec_str}";
	if (days > 0)
		timer_string = $"{days}:{timer_string}";
	return timer_string;
};

addTime = function(_arr1 = [], _arr2 = [], _arr3 = [], _arr4 = [])
{
	var rs = 0;
	while (array_length(_arr4) > 0)
		rs += (array_pop(_arr4) * 60 * 60);
	while (array_length(_arr3) > 0)
		rs += (array_pop(_arr3) * 60);
	while (array_length(_arr2) > 0)
		rs += array_pop(_arr2);
	while (array_length(_arr1) > 0)
		rs += (array_pop(_arr1) / 60);
	return rs;
};

livesplitInit();
