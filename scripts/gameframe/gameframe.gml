#region prototypes
globalvar mq_game_frame_button; mq_game_frame_button=[undefined,undefined,undefined,undefined,0,0,0,undefined,undefined,undefined,0,undefined,0,undefined,undefined,undefined];
globalvar mq_gameframe_delayed_item; mq_gameframe_delayed_item=[undefined,undefined,0,undefined,undefined,undefined,undefined];
#endregion
#region metatype
globalvar gameframe_std_haxe_type_markerValue; gameframe_std_haxe_type_markerValue=[];
globalvar mt_game_frame_button;
globalvar mt_gameframe_delayed_item;
globalvar mt_gameframe_std_haxe_class;
//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDI
(function() {
mt_game_frame_button=new gameframe_std_haxe_class(7,"game_frame_button");
mt_gameframe_delayed_item=new gameframe_std_haxe_class(8,"gameframe_delayed_item");
mt_gameframe_std_haxe_class=new gameframe_std_haxe_class(-1,"gameframe_std_haxe_class");
})();
#endregion
#region gameframe
function gameframe_log(_args1) {
if (!gameframe_debug) exit;
var _s="[Gameframe]";
var __g=0;
while (__g < argument_count) {
var _arg=argument[__g];
__g++;
_s += " " + gameframe_std_Std_stringify(_arg);
}
show_debug_message(_s);
}
function gameframe_update() {
if (!gameframe_is_ready) exit;
gameframe_effective_scale=display_get_dpi_x() / 96 / gameframe_dpi_scale;
gameframe_mouse_over_frame=false;
gameframe_delayed_update();
gameframe_cover_ensure();
if (window_get_fullscreen() || gameframe_isFullscreen_hx) {
gameframe_tools_keyctl_reset();
exit;
}
gameframe_tools_keyctl_update();
if (!gameframe_isMaximized_hx && gameframe_has_native_extension && gameframe_delayed_frame_index > 3 && !gameframe_get_shadow()) gameframe_set_shadow(true);
var _mx=(window_mouse_get_x() | 0);
var _my=(window_mouse_get_y() | 0);
var _gw=window_get_width();
var _gh=window_get_height();
var __borderWidth=(gameframe_isMaximized_hx?0:gameframe_border_width);
var __titleHeight=gameframe_caption_get_height();
var __buttons_x=gameframe_button_get_combined_offset(_gw);
var __flags=0;
var __titleHit=false;
var __hitSomething=true;
var _resizePadding=gameframe_resize_padding;
if (!point_in_rectangle(_mx,_my,__buttons_x,__borderWidth,_gw - __borderWidth - ((gameframe_isMaximized_hx?0:_resizePadding)),__borderWidth + __titleHeight)) {
if (!gameframe_isMaximized_hx && gameframe_can_resize && !point_in_rectangle(_mx,_my,_resizePadding,_resizePadding,_gw - _resizePadding,_gh - _resizePadding)) {
if (_mx < _resizePadding) __flags |= 1;
if (_my < _resizePadding) __flags |= 2;
if (_mx >= _gw - _resizePadding) __flags |= 4;
if (_my >= _gh - _resizePadding) __flags |= 8;
} else if (point_in_rectangle(_mx,_my,0,0,_gw,__titleHeight)) {
__titleHit=true;
} else __hitSomething=false;
}
gameframe_mouse_over_frame=__hitSomething;
if (gameframe_drag_flags==0) {
var __cursor=gameframe_default_cursor;
if (gameframe_can_input && gameframe_can_resize) switch (__flags) {
case 1:case 4:__cursor=cr_size_we; break;
case 2:case 8:__cursor=cr_size_ns; break;
case 3:case 12:__cursor=cr_size_nwse; break;
case 6:case 9:__cursor=cr_size_nesw; break;
}
gameframe_set_window_cursor(__cursor);
}
gameframe_button_update(__buttons_x,__borderWidth,__titleHeight,_mx,_my);
if (gameframe_can_input && mouse_check_button_pressed(1)) {
if (__titleHit) {
var __now=current_time;
if (__now < gameframe_last_title_click_at + gameframe_double_click_time) {
if (gameframe_isMaximized_hx) gameframe_restore(); else gameframe_maximize();
} else {
gameframe_last_title_click_at=__now;
if (gameframe_isMaximized_hx) gameframe_drag_start(32); else gameframe_drag_start(16);
}
} else if (__flags != 0 && gameframe_can_resize) {
gameframe_drag_start(__flags);
}
}
if (gameframe_can_input) {
if (mouse_check_button_released(1)) gameframe_drag_stop(); else gameframe_drag_update();
} else if (gameframe_drag_flags != 0) {
gameframe_drag_stop();
}
}
function gameframe_init() {
gameframe_is_ready=true;
gameframe_has_native_extension=gameframe_check_native_extension();
gameframe_double_click_time=(gameframe_has_native_extension?gameframe_get_double_click_time():500);
gameframe_double_click_time=500;
gameframe_init_native();
gameframe_tools_rect_get_window_rect(gameframe_restoreRect_hx);
gameframe_button_add_defaults();
gameframe_set_shadow(true);
}
#endregion
#region game_frame_button
function game_frame_button_create(_name,_icon,_subimg,_onClick) {
var _this=[mt_game_frame_button];
array_copy(_this,1,mq_game_frame_button,1,15);
_this[@15]=game_frame_button_draw_icon_default;
_this[@14]=game_frame_button_draw_underlay_default;
_this[@13]=game_frame_button_update_default;
_this[@12]=game_frame_button_get_width_default;
_this[@10]=0.;
_this[@9]=true;
_this[@8]=false;
_this[@7]=false;
_this[@6]=0;
_this[@5]=0;
_this[@1]=_name;
_this[@3]=_icon;
_this[@4]=_subimg;
_this[@11]=_onClick;
return _this;
}
function game_frame_button_get_width_default(_b) {
return sprite_get_width(_b[3]);
}
function game_frame_button_update_default(_b) {
}
function game_frame_button_draw_underlay_default(_b,_x,_y,_width,_height) {
var _alpha1;
if (_b[9]) {
if (_b[8]) {
_alpha1=0.7;
_b[@10]=1;
} else {
var _dt=delta_time / 1000000;
if (_b[7]) {
if (_b[10] < 1) _b[@10]=min(_b[10] + _dt / gameframe_button_fade_time,1);
} else if (_b[10] > 0) {
_b[@10]=max(_b[10] - _dt / gameframe_button_fade_time,0);
}
_alpha1=_b[10] * 0.3;
}
} else _alpha1=0.;
draw_sprite_stretched_ext(gameframe_spr_pixel,0,_x,_y,_width,_height,gameframe_blend,gameframe_alpha * _alpha1);
}
function game_frame_button_draw_icon_default(_b,_x,_y,_width,_height) {
var _icon=_b[3];
var _scale=gameframe_effective_scale;
draw_sprite_ext(_icon,_b[4],(_x + ((_width - sprite_get_width(_icon) * _scale) div 2) + (sprite_get_xoffset(_icon) * _scale | 0)),_y + ((_height - sprite_get_height(_icon) * _scale) div 2) + (sprite_get_yoffset(_icon) * _scale | 0),_scale,_scale,0,gameframe_blend,gameframe_alpha * ((_b[9]?1:0.3)));
}
function game_frame_button_set_name(_this,_value) {
_this[@1]=_value;
}
function game_frame_button_get_name(_this) {
return _this[1];
}
function game_frame_button_set_custom(_this,_value) {
_this[@2]=_value;
}
function game_frame_button_get_custom(_this) {
return _this[2];
}
function game_frame_button_set_icon(_this,_value) {
_this[@3]=_value;
}
function game_frame_button_get_icon(_this) {
return _this[3];
}
function game_frame_button_set_subimg(_this,_value) {
_this[@4]=_value;
}
function game_frame_button_get_subimg(_this) {
return _this[4];
}
function game_frame_button_set_margin_left(_this,_value) {
_this[@5]=_value;
}
function game_frame_button_get_margin_left(_this) {
return _this[5];
}
function game_frame_button_set_margin_right(_this,_value) {
_this[@6]=_value;
}
function game_frame_button_get_margin_right(_this) {
return _this[6];
}
function game_frame_button_set_hover(_this,_value) {
_this[@7]=_value;
}
function game_frame_button_get_hover(_this) {
return _this[7];
}
function game_frame_button_set_pressed(_this,_value) {
_this[@8]=_value;
}
function game_frame_button_get_pressed(_this) {
return _this[8];
}
function game_frame_button_set_enabled(_this,_value) {
_this[@9]=_value;
}
function game_frame_button_get_enabled(_this) {
return _this[9];
}
function game_frame_button_set_fade(_this,_value) {
_this[@10]=_value;
}
function game_frame_button_get_fade(_this) {
return _this[10];
}
function game_frame_button_set_click(_this,_value) {
_this[@11]=_value;
}
function game_frame_button_get_click(_this) {
return _this[11];
}
function game_frame_button_set_get_width(_this,_value) {
_this[@12]=_value;
}
function game_frame_button_get_get_width(_this) {
return _this[12];
}
function game_frame_button_set_update(_this,_value) {
_this[@13]=_value;
}
function game_frame_button_get_update(_this) {
return _this[13];
}
function game_frame_button_set_draw_underlay(_this,_value) {
_this[@14]=_value;
}
function game_frame_button_get_draw_underlay(_this) {
return _this[14];
}
function game_frame_button_set_draw_icon(_this,_value) {
_this[@15]=_value;
}
function game_frame_button_get_draw_icon(_this) {
return _this[15];
}
#endregion
#region gameframe_button
function gameframe_button_get_combined_width() {
var _w=0;
var __g=0;
var __g1=gameframe_button_array;
while (__g < array_length(__g1)) {
var _b=__g1[__g];
__g++;
_w += _b[5] + _b[12](_b) + _b[6];
}
return ceil(_w * gameframe_effective_scale);
}
function gameframe_button_get_combined_offset(_windowWidth) {
return _windowWidth - ((gameframe_isMaximized_hx?0:gameframe_border_width)) - gameframe_button_get_combined_width();
}
function gameframe_button_reset() {
var __g=0;
var __g1=gameframe_button_array;
while (__g < array_length(__g1)) {
var _b=__g1[__g];
__g++;
_b[@7]=false;
_b[@10]=0.;
_b[@8]=false;
}
}
function gameframe_button_update(_x,_y,_height,_mx,_my) {
var _over_row=_mx >= _y && _my < _y + _height;
if (_over_row) {
if (gameframe_has_native_extension) {
_over_row=gameframe_mouse_in_window();
} else {
var _wx=window_get_x();
var _wy=window_get_y();
var _dmx=display_mouse_get_x();
var _dmy=display_mouse_get_y();
_over_row=_dmx >= _wx && _dmy >= _wy && _dmx < _wx + window_get_width() && _dmy < _wy + window_get_height();
}
}
if (gameframe_button_wait_for_movement) {
if (_mx != gameframe_button_wait_for_movement_x || _my != gameframe_button_wait_for_movement_y) gameframe_button_wait_for_movement=false; else _over_row=false;
}
var _dpiScale=gameframe_effective_scale;
var _pressed=mouse_check_button_pressed(1);
var _released=mouse_check_button_released(1);
var _disable=gameframe_drag_flags != 0 || !gameframe_can_input;
var _i=0;
for (var __g1=array_length(gameframe_button_array); _i < __g1; _i++) {
var _button=gameframe_button_array[_i];
_button[13](_button);
_x += _button[5] * _dpiScale;
var _width=_button[12](_button) * _dpiScale;
if (_disable || !_button[9]) {
_button[@7]=false;
_button[@8]=false;
} else if (_over_row && _mx >= _x && _mx < _x + _width) {
_button[@7]=true;
if (_pressed) _button[@8]=true;
} else _button[@7]=false;
if (_released && _button[8] && _button[7]) {
_button[@8]=false;
_button[11](_button);
}
_x += _width + _button[6] * _dpiScale;
}
}
function gameframe_button_draw(_x,_y,_height) {
var _dpiScale=gameframe_effective_scale;
var _i=0;
for (var __g1=array_length(gameframe_button_array); _i < __g1; _i++) {
var _button=gameframe_button_array[_i];
_x += _button[5] * _dpiScale;
var _width=_button[12](_button) * _dpiScale;
_button[14](_button,_x,_y,_width,_height);
_button[15](_button,_x,_y,_width,_height);
_x += _width + _button[6] * _dpiScale;
}
}
function gameframe_button_add_defaults() {
gameframe_button_array=[];
//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDI
var _minimize=game_frame_button_create("minimize",gameframe_spr_buttons,0,function(_button) {
gameframe_minimize()
});
if (!gameframe_has_native_extension) _minimize[@9]=false;
array_push(gameframe_button_array,_minimize);
//PADDINGPADDINGPADD
var _maxrest=game_frame_button_create("maxrest",gameframe_spr_buttons,1,function(_button) {
if (gameframe_isMaximized_hx) gameframe_restore(); else gameframe_maximize();
gameframe_button_reset();
});
//PADDINGPADDI
_maxrest[@13]=function(_b) {
_b[@4]=(gameframe_isMaximized_hx?2:1);
_b[@9]=gameframe_can_resize;
}
array_push(gameframe_button_array,_maxrest);
//PADDINGPADDINGPADDINGPADDINGPADDINGPA
var _close=game_frame_button_create("close",gameframe_spr_buttons,3,function(__) {
game_end()
});
//PADDINGPADDINGPADD
_close[@14]=function(_b,__x,__y,__width,__height) {
var __alpha=0.;
if (_b[8]) {
__alpha=0.7;
_b[@10]=1;
} else {
var _dt=delta_time / 1000000;
if (_b[7]) {
if (_b[10] < 1) {
_b[@10]=max(_b[10],0.5);
_b[@10]=min(_b[10] + _dt / gameframe_button_fade_time,1);
}
} else if (_b[10] > 0) {
_b[@10]=max(_b[10] - _dt / gameframe_button_fade_time,0);
}
__alpha=gameframe_alpha * _b[10];
}
draw_sprite_stretched_ext(gameframe_spr_pixel,0,__x,__y,__width,__height,2298344,__alpha);
}
array_push(gameframe_button_array,_close);
}
#endregion
#region gameframe_tools_rect
function gameframe_tools_rect__new(_x,_y,_w,_h) {
if (_x==undefined) _x=0;
if (_y==undefined) _y=0;
if (_w==undefined) _w=0;
if (_h==undefined) _h=0;
if (false) show_debug_message(argument[3]);
return [_x,_y,_w,_h];
}
function gameframe_tools_rect_get_window_rect(_this1) {
_this1[@0]=window_get_x();
_this1[@1]=window_get_y();
_this1[@2]=window_get_width();
_this1[@3]=window_get_height();
}
function gameframe_tools_rect_set_window_rect(_this1) {
window_set_rectangle(_this1[0],_this1[1],_this1[2],_this1[3]);
}
function gameframe_tools_rect_equals(_this1,_o) {
return _this1[0]==_o[0] && _this1[1]==_o[1] && _this1[2]==_o[2] && _this1[3]==_o[3];
}
function gameframe_tools_rect_set_to(_this1,_o) {
_this1[@0]=_o[0];
_this1[@1]=_o[1];
_this1[@2]=_o[2];
_this1[@3]=_o[3];
}
#endregion
#region gameframe
function gameframe_minimize() {
if (gameframe_is_natively_minimized()) exit;
gameframe_button_reset();
//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDIN
gameframe_delayed_call_impl(function() {
gameframe_button_wait_for_movement=true;
gameframe_button_wait_for_movement_x=window_mouse_get_x();
gameframe_button_wait_for_movement_y=window_mouse_get_y();
gameframe_syscommand(61472);
},1,undefined,undefined,undefined,undefined);
}
function gameframe_minimise() {
if (!gameframe_is_natively_minimized()) {
gameframe_button_reset();
//PADDINGPADDINGPADDINGPADDINGPADDINGPA
gameframe_delayed_call_impl(function() {
gameframe_button_wait_for_movement=true;
gameframe_button_wait_for_movement_x=window_mouse_get_x();
gameframe_button_wait_for_movement_y=window_mouse_get_y();
gameframe_syscommand(61472);
},1,undefined,undefined,undefined,undefined);
}
}
function gameframe_is_minimized() {
return gameframe_is_natively_minimized();
}
function gameframe_is_minimised() {
return gameframe_is_natively_minimized();
}
function gameframe_maximize() {
if (gameframe_isMaximized_hx || gameframe_isFullscreen_hx || window_get_fullscreen()) exit;
gameframe_isMaximized_hx=true;
gameframe_store_rect();
gameframe_maximize_1();
}
function gameframe_maximise() {
if (!(gameframe_isMaximized_hx || gameframe_isFullscreen_hx || window_get_fullscreen())) {
gameframe_isMaximized_hx=true;
gameframe_store_rect();
gameframe_maximize_1();
}
}
function gameframe_is_maximized() {
return gameframe_isMaximized_hx;
}
function gameframe_is_maximised() {
return gameframe_isMaximized_hx;
}
function gameframe_maximize_1() {
var __work=gameframe_tools_mon_get_active()[1];
if (gameframe_debug) gameframe_log("maximize: ",__work);
gameframe_tools_rect_set_window_rect(__work);
gameframe_set_shadow(false);
}
function gameframe_store_rect() {
gameframe_tools_rect_get_window_rect(gameframe_restoreRect_hx);
if (gameframe_debug) gameframe_log("storeRect: ",gameframe_restoreRect_hx);
}
function gameframe_restore(__force) {
if (__force==undefined) __force=false;
if (false) show_debug_message(argument[0]);
if (window_get_fullscreen()) {
window_set_fullscreen(false);
//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDING
gameframe_delayed_call_impl(function() {
gameframe_restore()
},1,undefined,undefined,undefined,undefined);
exit;
}
if (!__force && !gameframe_isMaximized_hx && !gameframe_isFullscreen_hx) exit;
gameframe_isMaximized_hx=false;
gameframe_isFullscreen_hx=false;
var __rect=gameframe_restoreRect_hx;
if (gameframe_debug) gameframe_log("restore: ",__rect);
gameframe_tools_rect_set_window_rect(__rect);
gameframe_set_shadow(true);
}
function gameframe_set_fullscreen(_mode) {
gameframe_set_fullscreen_1(_mode);
}
function gameframe_get_fullscreen() {
if (window_get_fullscreen()) return 1;
if (gameframe_isFullscreen_hx) return 2; else return 0;
}
function gameframe_is_fullscreen_window() {
return !window_get_fullscreen() && gameframe_isFullscreen_hx;
}
function gameframe_set_fullscreen_1(__mode,__wasFullscreen) {
if (__wasFullscreen==undefined) __wasFullscreen=false;
if (false) show_debug_message(argument[1]);
if (gameframe_debug) gameframe_log("setFullscreen(mode:",__mode,", wasfs:",__wasFullscreen,")");
if (__mode==1 || __mode==2) {
gameframe_button_reset();
gameframe_drag_stop();
}
switch (__mode) {
case 1:
if (window_get_fullscreen()) exit;
if (gameframe_isFullscreen_hx) {
gameframe_restore();
//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPAD
gameframe_delayed_call_impl(function() {
gameframe_set_fullscreen_1(1)
},1,undefined,undefined,undefined,undefined);
exit;
} else gameframe_store_rect();
window_set_fullscreen(true);
break;
case 2:
if (window_get_fullscreen()) {
window_set_fullscreen(false);
//PADDINGPADDINGPADDINGPADDI
gameframe_delayed_call_impl(function() {
gameframe_set_fullscreen_1(2,true)
},10,undefined,undefined,undefined,undefined);
exit;
}
if (gameframe_isFullscreen_hx) exit;
gameframe_isFullscreen_hx=true;
if (!gameframe_isMaximized_hx && !__wasFullscreen) gameframe_store_rect();
gameframe_tools_rect_set_window_rect(gameframe_tools_mon_get_active()[0]);
gameframe_set_shadow(false);
break;
default:
if (window_get_fullscreen() && gameframe_isFullscreen_hx) {
window_set_fullscreen(false);
//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDING
gameframe_delayed_call_impl(function() {
gameframe_set_fullscreen_1(0)
},1,undefined,undefined,undefined,undefined);
exit;
}
if (window_get_fullscreen()) {
gameframe_restore();
} else if (gameframe_isMaximized_hx) {
gameframe_isFullscreen_hx=false;
gameframe_maximize_1();
} else gameframe_restore();
}
}
function gameframe_set_window_cursor(_cr1) {
gameframe_current_cursor=_cr1;
if (gameframe_set_cursor) {
if (window_get_cursor() != _cr1) window_set_cursor(_cr1);
}
}
function gameframe_get_border_width() {
if (gameframe_isMaximized_hx) return 0; else return gameframe_border_width;
}
function gameframe_get_drag_flags() {
return gameframe_drag_flags;
}
#endregion
#region gameframe_caption
function gameframe_caption_get_height() {
var _h=(gameframe_isMaximized_hx?gameframe_caption_height_maximized:gameframe_caption_height_normal);
if (_h > 0) return (_h | 0);
return round(-_h * sprite_get_height(gameframe_spr_caption) * gameframe_effective_scale);
}
function gameframe_caption_get_overlap() {
if (window_get_fullscreen() || gameframe_isFullscreen_hx) return 0.;
var _h=gameframe_caption_get_height();
var _rect=application_get_position();
return max(0,_h - _rect[1]) / ((_rect[2] - _rect[0]) / surface_get_width(application_surface));
}
function gameframe_caption_draw_border_default(__x,__y,__width,__height) {
draw_sprite_stretched_ext(gameframe_spr_border,(window_has_focus()?1:0),__x,__y,__width,__height,gameframe_blend,gameframe_alpha);
}
function gameframe_caption_draw_caption_rect_default(__x,__y,__width,__height,__buttons_x) {
draw_sprite_stretched_ext(gameframe_spr_caption,(window_has_focus()?1:0),__x,__y,__width,__height,gameframe_blend,gameframe_alpha * gameframe_caption_alpha);
}
function gameframe_caption_draw_caption_text_default(__x,__y,__width,__height) {
var _dpiScale=gameframe_effective_scale;
var __right=__x + __width;
__x += gameframe_caption_margin * _dpiScale;
var _icon=gameframe_caption_icon;
if (_icon != -1) {
draw_sprite_ext(_icon,-1,(__x + sprite_get_xoffset(_icon) * _dpiScale | 0),__y + ((__height - sprite_get_height(_icon) * _dpiScale) div 2) + sprite_get_yoffset(_icon) * _dpiScale,_dpiScale,_dpiScale,0,c_white,gameframe_caption_alpha * gameframe_alpha);
__x += (sprite_get_width(_icon) + gameframe_caption_icon_margin) * _dpiScale;
}
var _text=gameframe_caption_text;
if (_text=="") exit;
var __newFont=gameframe_caption_font;
var __h=draw_get_halign();
var __v=draw_get_valign();
var __oldFont;
if (__newFont != -1) {
__oldFont=draw_get_font();
draw_set_font(__newFont);
} else __oldFont=-1;
draw_set_halign(gameframe_caption_text_align);
draw_set_valign(fa_top);
var __alpha=draw_get_alpha();
var __textWidth=__right - __x;
draw_set_alpha((gameframe_alpha * gameframe_caption_alpha));
draw_text_ext_transformed((__x + ((gameframe_caption_text_align * __textWidth) div 2)),__y + ((__height - string_height_ext(_text,-1,__textWidth) * _dpiScale) div 2),_text,-1,__textWidth,_dpiScale,_dpiScale,0);
draw_set_alpha(__alpha);
if (__newFont != -1) draw_set_font(__oldFont);
draw_set_halign(__h);
draw_set_valign(__v);
}
#endregion
#region gameframe_cover
function gameframe_cover_ensure() {
var __just_changed=gameframe_cover_check_for_success;
if (__just_changed) gameframe_cover_check_for_success=false;
var __target_rect;
if (window_get_fullscreen()) {
gameframe_cover_can_ignore=false;
exit;
} else if (gameframe_isFullscreen_hx) {
__target_rect=gameframe_tools_mon_get_active()[0];
} else if (gameframe_isMaximized_hx) {
__target_rect=gameframe_tools_mon_get_active()[1];
} else {
gameframe_cover_can_ignore=false;
exit;
}
gameframe_tools_rect_get_window_rect(gameframe_cover_curr_rect);
if (!gameframe_tools_rect_equals(gameframe_cover_curr_rect,__target_rect)) {
if (__just_changed) {
gameframe_cover_can_ignore=true;
gameframe_tools_rect_set_to(gameframe_cover_ignore_rect,__target_rect);
if (gameframe_debug) gameframe_log("[cover] Resize failed - ignoring");
exit;
}
if (gameframe_cover_can_ignore && gameframe_tools_rect_equals(__target_rect,gameframe_cover_ignore_rect)) exit;
if (gameframe_debug) gameframe_log("[cover] Adjusting window rectangle to",__target_rect);
gameframe_tools_rect_set_window_rect(__target_rect);
gameframe_cover_check_for_success=true;
}
}
#endregion
#region gameframe_delayed
function gameframe_delayed_call_impl(_func,_delay,_arg0,_arg1,_arg2,_arg3) {
var _item;
if (ds_stack_empty(gameframe_delayed_pool)) _item=gameframe_delayed_item_create(); else _item=ds_stack_pop(gameframe_delayed_pool);
_item[@1]=_func;
_item[@2]=gameframe_delayed_frame_index + _delay;
_item[@3]=_arg0;
_item[@4]=_arg1;
_item[@5]=_arg2;
_item[@6]=_arg3;
ds_queue_enqueue(gameframe_delayed_queue,_item);
}
function gameframe_delayed_update() {
gameframe_delayed_frame_index += 1;
var _f;
while (!ds_queue_empty(gameframe_delayed_queue)) {
var _head=ds_queue_head(gameframe_delayed_queue);
if (_head[2] > gameframe_delayed_frame_index) break;
ds_queue_dequeue(gameframe_delayed_queue);
_f=_head[1];
_f(_head[3],_head[4],_head[5],_head[6]);
_head[@1]=undefined;
_head[@3]=undefined;
_head[@4]=undefined;
_head[@5]=undefined;
_head[@6]=undefined;
ds_stack_push(gameframe_delayed_pool,_head);
}
}
#endregion
#region gameframe_delayed_item
function gameframe_delayed_item_create() {
var _this=[mt_gameframe_delayed_item];
array_copy(_this,1,mq_gameframe_delayed_item,1,6);
return _this;
}
#endregion
#region gameframe_drag
function gameframe_drag_start(__flags) {
gameframe_drag_flags=__flags;
gameframe_drag_mx=(display_mouse_get_x() | 0);
gameframe_drag_my=(display_mouse_get_y() | 0);
gameframe_drag_left=window_get_x();
gameframe_drag_top=window_get_y();
gameframe_drag_right=gameframe_drag_left + window_get_width();
gameframe_drag_bottom=gameframe_drag_top + window_get_height();
}
function gameframe_drag_stop() {
gameframe_drag_flags=0;
}
function gameframe_drag_set_rect(_x,_y,_w,_h) {
window_set_rectangle(_x,_y,_w,_h);
}
function gameframe_drag_update() {
if (gameframe_drag_flags==0) exit;
var __mx=(display_mouse_get_x() | 0);
var __my=(display_mouse_get_y() | 0);
switch (gameframe_drag_flags) {
case 16:window_set_position(__mx - (gameframe_drag_mx - gameframe_drag_left),__my - (gameframe_drag_my - gameframe_drag_top)); break;
case 32:
if (point_distance(__mx,__my,gameframe_drag_mx,gameframe_drag_my) > 5) {
var __x;
var __y=gameframe_drag_my - gameframe_drag_top;
if (gameframe_drag_mx - gameframe_drag_left < (gameframe_drag_right - gameframe_drag_left) / 2) __x=min(gameframe_drag_mx - gameframe_drag_left,(gameframe_restoreRect_hx[2] >> 1)); else __x=max(gameframe_restoreRect_hx[2] + gameframe_drag_mx - gameframe_drag_right,(gameframe_restoreRect_hx[2] >> 1));
gameframe_isMaximized_hx=false;
window_set_rectangle(__mx - __x,__my - __y,gameframe_restoreRect_hx[2],gameframe_restoreRect_hx[3]);
gameframe_drag_start(16);
}
break;
case 1:
var __x=__mx - (gameframe_drag_mx - gameframe_drag_left);
window_set_rectangle(__x,gameframe_drag_top,gameframe_drag_right - __x,gameframe_drag_bottom - gameframe_drag_top);
break;
case 2:
var __y=__my - (gameframe_drag_my - gameframe_drag_top);
window_set_rectangle(gameframe_drag_left,__y,gameframe_drag_right - gameframe_drag_left,gameframe_drag_bottom - __y);
break;
case 4:window_set_rectangle(gameframe_drag_left,gameframe_drag_top,gameframe_drag_right - gameframe_drag_left - gameframe_drag_mx + __mx,gameframe_drag_bottom - gameframe_drag_top); break;
case 8:window_set_rectangle(gameframe_drag_left,gameframe_drag_top,gameframe_drag_right - gameframe_drag_left,gameframe_drag_bottom - gameframe_drag_top - gameframe_drag_my + __my); break;
case 3:
var __x=__mx - (gameframe_drag_mx - gameframe_drag_left);
var __y=__my - (gameframe_drag_my - gameframe_drag_top);
window_set_rectangle(__x,__y,gameframe_drag_right - __x,gameframe_drag_bottom - __y);
break;
case 9:
var __x=__mx - (gameframe_drag_mx - gameframe_drag_left);
window_set_rectangle(__x,gameframe_drag_top,gameframe_drag_right - __x,gameframe_drag_bottom - gameframe_drag_top - gameframe_drag_my + __my);
break;
case 6:
var __y=__my - (gameframe_drag_my - gameframe_drag_top);
window_set_rectangle(gameframe_drag_left,__y,gameframe_drag_right - gameframe_drag_left - gameframe_drag_mx + __mx,gameframe_drag_bottom - __y);
break;
case 12:window_set_rectangle(gameframe_drag_left,gameframe_drag_top,gameframe_drag_right - gameframe_drag_left - gameframe_drag_mx + __mx,gameframe_drag_bottom - gameframe_drag_top - gameframe_drag_my + __my); break;
}
}
#endregion
#region gameframe.tools.keyctl
function gameframe_tools_keyctl_create_key(_keyCode) {
return [_keyCode,false,false];
}
function gameframe_tools_keyctl_update_key(_key) {
var _down0=_key[1];
var _down1=keyboard_check_direct(_key[0]) != 0;
_key[@2]=!_down0 && _down1;
_key[@1]=_down1;
}
function gameframe_tools_keyctl_reset() {
var _i=0;
for (var __g1=array_length(gameframe_tools_keyctl_keys); _i < __g1; _i++) {
gameframe_tools_keyctl_keys[_i][@1]=false;
}
}
function gameframe_tools_keyctl_update() {
if (!(window_has_focus() && (keyboard_check_direct(91) != 0 || keyboard_check_direct(92) != 0))) {
gameframe_tools_keyctl_reset();
exit;
}
var _i=0;
for (var __g1=array_length(gameframe_tools_keyctl_keys); _i < __g1; _i++) {
gameframe_tools_keyctl_update_key(gameframe_tools_keyctl_keys[_i]);
}
if (gameframe_tools_keyctl_up[2]) {
if (gameframe_can_resize) gameframe_maximize();
} else if (gameframe_tools_keyctl_down[2]) {
if (gameframe_isMaximized_hx) {
if (gameframe_can_resize) gameframe_restore();
} else gameframe_minimize();
}
}
#endregion
#region gameframe_draw
function gameframe_draw() {
if (!gameframe_is_ready) exit;
if (window_get_fullscreen() || gameframe_isFullscreen_hx) exit;
var _gw=window_get_width();
var _gh=window_get_height();
__display_set_gui_maximise_base(browser_width / _gw,browser_height / _gh,_gw % 2 / -2,_gh % 2 / -2);
var __borderWidth=(gameframe_isMaximized_hx?0:gameframe_border_width);
var __titlebarHeight=gameframe_caption_get_height();
var __buttons_x=gameframe_button_get_combined_offset(_gw);
if (!gameframe_isMaximized_hx) gameframe_caption_draw_border(0,0,_gw,_gh);
gameframe_caption_draw_background(__borderWidth,__borderWidth,_gw - __borderWidth * 2,__titlebarHeight,__buttons_x);
gameframe_caption_draw_text(__borderWidth,__borderWidth,__buttons_x - __borderWidth,__titlebarHeight);
gameframe_button_draw(__buttons_x,__borderWidth,__titlebarHeight);
__display_gui_restore();
}
#endregion
#region gameframe_std.Std
function gameframe_std_Std_stringify(_value) {
if (_value==undefined) return "null";
if (is_string(_value)) return _value;
var _n,_i,_s;
if (is_struct(_value)) {
var _e=_value[$"__enum__"];
if (_e==undefined) return string(_value);
var _ects=_e.constructors;
if (_ects != undefined) {
_i=_value.__enumIndex__;
if (_i >= 0 && _i < array_length(_ects)) _s=_ects[_i]; else _s="?";
} else {
_s=instanceof(_value);
if (string_copy(_s,1,3)=="mc_") _s=string_delete(_s,1,3);
_n=string_length(_e.name);
if (string_copy(_s,1,_n)==_e.name) _s=string_delete(_s,1,_n + 1);
}
_s += "(";
var _fields=_value.__enumParams__;
_n=array_length(_fields);
for (_i=-1; ++_i < _n; _s += gameframe_std_Std_stringify(_value[$ _fields[_i]])) {
if (_i > 0) _s += ", ";
}
return _s + ")";
}
if (is_real(_value)) {
_s=string_format(_value,0,16);
if (os_browser != browser_not_a_browser) {
_n=string_length(_s);
_i=_n;
while (_i > 0) {
switch (string_ord_at(_s,_i)) {
case 48:
_i--;
continue;
case 46:_i--; break;
}
break;
}
} else {
_n=string_byte_length(_s);
_i=_n;
while (_i > 0) {
switch (string_byte_at(_s,_i)) {
case 48:
_i--;
continue;
case 46:_i--; break;
}
break;
}
}
return string_copy(_s,1,_i);
}
return string(_value);
}
#endregion
#region gameframe_std.haxe.class
function gameframe_std_haxe_class(_id,_name) constructor {
static superClass=undefined;
static marker=undefined;
static index=undefined;
static name=undefined;
self.superClass=undefined;
self.marker=gameframe_std_haxe_type_markerValue;
self.index=_id;
self.name=_name;
static __class__="class";
}
#endregion
#region gameframe_tools_mon
function gameframe_tools_mon_get_active() {
var __list=gameframe_tools_mon_get_active_list;
if (__list==undefined) {
__list=ds_list_create();
gameframe_tools_mon_get_active_list=__list;
}
var __count=gameframe_get_monitors(__list);
var __cx1=window_get_x() + (window_get_width() div 2);
var __cy1=window_get_y() + (window_get_height() div 2);
var _i=0;
for (var __g1=__count; _i < __g1; _i++) {
var __item=__list[|_i];
var __mntr=__item[0];
if (__cx1 >= __mntr[0] && __cy1 >= __mntr[1] && __cx1 < __mntr[0] + __mntr[2] && __cy1 < __mntr[1] + __mntr[3]) return __item;
}
var __item=__list[|0];
if (__item==undefined) {
__item=gameframe_tools_mon_dummy;
if (__item==undefined) {
__item=[gameframe_tools_rect__new(0,0,display_get_width(),display_get_height()),gameframe_tools_rect__new(0,0,display_get_width(),display_get_height() - 40),0];
gameframe_tools_mon_dummy=__item;
}
__list[|0]=__item;
}
return __item;
}
#endregion
globalvar gameframe_is_ready;
gameframe_is_ready=false;
globalvar gameframe_double_click_time;
globalvar gameframe_last_title_click_at;
gameframe_last_title_click_at=-5000;
globalvar gameframe_button_array;
gameframe_button_array=[];
globalvar gameframe_button_fade_time;
gameframe_button_fade_time=0.2;
globalvar gameframe_button_wait_for_movement;
gameframe_button_wait_for_movement=false;
globalvar gameframe_button_wait_for_movement_x;
gameframe_button_wait_for_movement_x=0.;
globalvar gameframe_button_wait_for_movement_y;
gameframe_button_wait_for_movement_y=0.;
globalvar gameframe_debug;
gameframe_debug=false;
globalvar gameframe_blend;
gameframe_blend=c_white;
globalvar gameframe_alpha;
gameframe_alpha=1.0;
globalvar gameframe_can_input;
gameframe_can_input=true;
globalvar gameframe_can_resize;
gameframe_can_resize=true;
globalvar gameframe_resize_padding;
gameframe_resize_padding=6;
globalvar gameframe_border_width;
gameframe_border_width=2;
globalvar gameframe_spr_border;
gameframe_spr_border=asset_get_index("spr_gameframe_border");
globalvar gameframe_spr_caption;
gameframe_spr_caption=asset_get_index("spr_gameframe_caption");
globalvar gameframe_spr_buttons;
gameframe_spr_buttons=asset_get_index("spr_gameframe_buttons");
globalvar gameframe_spr_pixel;
gameframe_spr_pixel=asset_get_index("spr_gameframe_pixel");
globalvar gameframe_default_cursor;
gameframe_default_cursor=cr_arrow;
globalvar gameframe_set_cursor;
gameframe_set_cursor=true;
globalvar gameframe_current_cursor;
gameframe_current_cursor=cr_arrow;
globalvar gameframe_dpi_scale;
gameframe_dpi_scale=1.;
globalvar gameframe_effective_scale;
gameframe_effective_scale=1.;
globalvar gameframe_has_native_extension;
gameframe_has_native_extension=false;
globalvar gameframe_mouse_over_frame;
gameframe_mouse_over_frame=false;
globalvar gameframe_isMaximized_hx;
gameframe_isMaximized_hx=false;
globalvar gameframe_isFullscreen_hx;
gameframe_isFullscreen_hx=false;
globalvar gameframe_restoreRect_hx;
gameframe_restoreRect_hx=gameframe_tools_rect__new();
globalvar gameframe_caption_text;
gameframe_caption_text=window_get_caption();
globalvar gameframe_caption_alpha;
gameframe_caption_alpha=1;
globalvar gameframe_caption_font;
gameframe_caption_font=-1;
globalvar gameframe_caption_text_align;
gameframe_caption_text_align=0;
globalvar gameframe_caption_icon;
gameframe_caption_icon=-1;
globalvar gameframe_caption_margin;
gameframe_caption_margin=6;
globalvar gameframe_caption_icon_margin;
gameframe_caption_icon_margin=4;
globalvar gameframe_caption_height_normal;
gameframe_caption_height_normal=-1;
globalvar gameframe_caption_height_maximized;
gameframe_caption_height_maximized=-0.66667;
globalvar gameframe_caption_draw_border;
gameframe_caption_draw_border=gameframe_caption_draw_border_default;
globalvar gameframe_caption_draw_background;
gameframe_caption_draw_background=gameframe_caption_draw_caption_rect_default;
globalvar gameframe_caption_draw_text;
gameframe_caption_draw_text=gameframe_caption_draw_caption_text_default;
globalvar gameframe_cover_check_for_success;
gameframe_cover_check_for_success=false;
globalvar gameframe_cover_ignore_rect;
gameframe_cover_ignore_rect=gameframe_tools_rect__new();
globalvar gameframe_cover_can_ignore;
gameframe_cover_can_ignore=false;
globalvar gameframe_cover_curr_rect;
gameframe_cover_curr_rect=gameframe_tools_rect__new();
globalvar gameframe_delayed_queue;
gameframe_delayed_queue=ds_queue_create();
globalvar gameframe_delayed_pool;
gameframe_delayed_pool=ds_stack_create();
globalvar gameframe_delayed_frame_index;
gameframe_delayed_frame_index=0;
globalvar gameframe_drag_flags;
gameframe_drag_flags=0;
globalvar gameframe_drag_mx;
gameframe_drag_mx=0;
globalvar gameframe_drag_my;
gameframe_drag_my=0;
globalvar gameframe_drag_left;
gameframe_drag_left=0;
globalvar gameframe_drag_top;
gameframe_drag_top=0;
globalvar gameframe_drag_right;
gameframe_drag_right=0;
globalvar gameframe_drag_bottom;
gameframe_drag_bottom=0;
globalvar gameframe_tools_keyctl_up;
gameframe_tools_keyctl_up=gameframe_tools_keyctl_create_key(38);
globalvar gameframe_tools_keyctl_down;
gameframe_tools_keyctl_down=gameframe_tools_keyctl_create_key(40);
globalvar gameframe_tools_keyctl_keys;
gameframe_tools_keyctl_keys=[gameframe_tools_keyctl_up,gameframe_tools_keyctl_down];
globalvar gameframe_tools_mon_get_active_list;
gameframe_tools_mon_get_active_list=undefined;
globalvar gameframe_tools_mon_dummy;
gameframe_tools_mon_dummy=undefined;
