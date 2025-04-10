var _bigtimerx = 30;
var _bigtimery = drawbigy - sprite_get_height(spr_cafetime);
draw_sprite(spr_cafetime, 0, 0, drawy);
draw_sprite(spr_cocoatime, 0, 800, drawy);
draw_set_font(global.cafefont);
draw_set_halign(fa_left);

if (global.cafeseconds < 10)
	draw_text(_bigtimerx, _bigtimery, string(global.cafeminutes) + ":" + "0" + string(global.cafeseconds));
else
	draw_text(_bigtimerx, _bigtimery, string(global.cafeminutes) + ":" + string(global.cafeseconds));

var _smalltimerx = 815;
var _smalltimery = drawtexty - 225;
draw_set_font(global.cafefontsmall);
draw_set_halign(fa_left);

if (global.cafesecondssmall < 10)
	draw_text(_smalltimerx, _smalltimery, string(global.cafeminutessmall) + ":" + "0" + string(global.cafesecondssmall));
else
	draw_text(_smalltimerx, _smalltimery, string(global.cafeminutessmall) + ":" + string(global.cafesecondssmall));
