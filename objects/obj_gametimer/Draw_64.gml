if (!global.option_timer_type || room == rm_disclaimer || room == rm_initializer || room == rm_introVideo
|| room == rm_preinitializer || room == rm_startupLogo || room == rm_mainmenu
|| (!global.option_speedrun_timer && (instance_exists(obj_inputController)
&& (obj_inputController.showtext || obj_inputController.disconnectScreen))))
	exit;

var timer_arr = [];
if (global.option_timer_type >= 2)
	array_push(timer_arr, makeString(global.SaveMinutes, global.SaveSeconds, global.SaveFrames));
if (in_level && global.option_timer_type != 2)
	array_push(timer_arr, makeString(global.LevelMinutes, global.LevelSeconds, global.LevelFrames));

draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
draw_set_color(c_white);
draw_set_font(global.smalltimerfont);

var ty = 0;
for (var i = 0; i < array_length(timer_arr); i++)
{
	draw_text(944, 532 - ty, timer_arr[i]);
	ty += (string_height("1") + 4);
}
