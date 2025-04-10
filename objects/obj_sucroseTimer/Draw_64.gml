var timerx = 480;
var timery = 490;
var minsx = timerx - 65;
var secx = timerx + 15;
var minsy = timery - 15;
var timeinsecs = floor(target_fill / 60);
var mins = max(floor(timeinsecs / 60), 0);
var secs = max(timeinsecs % 60, 0);
var gaining_time = timer > target_fill;
var display_mins = string(abs(mins));
var display_secs = string(abs(secs));
if (secs < 10)
	display_secs = "0" + display_secs;
draw_set_font(global.timerfont);
draw_set_halign(fa_left);
draw_sprite_ext(gaining_time ? spr_timer_gain : spr_timer, secs % 2, 480, timery, 1, 1, 0, c_white, 1);
if (mins < 10)
	display_mins = "0" + display_mins;
draw_set_color(gaining_time ? #60D048 : #F80000);
draw_text(minsx, minsy, display_mins);
draw_text(secx, minsy + 1, display_secs);
draw_set_color(c_white);
