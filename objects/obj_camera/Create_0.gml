sndRankUp = fmod_createEventInstance("event:/SFX/ui/rankup");
sndRankDown = fmod_createEventInstance("event:/SFX/ui/rankdown");
depth = -100;
n = 0;
maxtime = 0;
oldPointCollect = 0;
global.EscapeTime = 4000;
greyscalefade = 0;
finalApplicationSurface = -4;
pointCollectShake = 0;
Camera_width = room_width;
Camera_height = room_height;
Camera_xorigin = 0;
Camera_yorigin = 0;
global.ClassicCameraShake = 0;
global.ClassicCameraShakeAcc = 3 / room_speed;
DrawY = 0;
DrawHUD = false;
image_speed = 0.35;
NextFreeze = false;
angle = 0;
angledir = 1;
frame = 0;
global.pizza = 0;
global.PizzaMeter = 0;
global.pillarhunger = 4000;
global.screenflash = 0;
cameraLock = false;
timestop = 1;
zoom = 0;
chargeCameraX = 0;
chargeCameraY = 0;
alpha = 1;
global.currentrank = "D";
lastRank = "D";
rankbubblesurface = -4;
bubblescale = 0;
global.CameraViewWidth = camera_get_view_width(view_camera[0]);
global.CameraViewHeight = camera_get_view_height(view_camera[0]);
global.MaxEscapeTime = 0;
pizzaindex = 0;
cameraXOffset = 0;
cameraYOffset = 0;
frozen = false;
freezetype = false;
freezeval = 0;
global.hitstunalarm = 0;
global.defaulttime = 70;
global.SwitchActivated = false;
global.keyPiece = 0;
Cam_x = 0;
Cam_y = 0;
cam_angle = 0;
cam_zoom = 1;
cam_langle = 0;
cam_lzoom = 1;
cam_w = camera_get_view_width(view_camera[0]);
cam_h = camera_get_view_height(view_camera[0]);
audio_listener_position(obj_parent_player.x, obj_parent_player.y, 0);
audio_listener_orientation(0, 0, 1000, 0, -1, 0);
audio_falloff_set_model(audio_falloff_inverse_distance);
timer_index = 0;
coneball_index = 0;
timer_out = 180;
timer_in = 180;
timer_y = 100;
cameraShakeList = ds_list_create();
painterdex = 0;
pizdex = 0;

addCameraShake = function(_shakeMag, _shakeDecel, _shakeTime) constructor
{
	shakeMag = _shakeMag;
	shakeDecel = _shakeDecel;
	shakeTime = _shakeTime;
};

cakeHud = 
{
	xstart: 121,
	ystart: 78,
	x: 121,
	y: 78,
	pointX: 16,
	pointY: -65,
	sprite_index: spr_cakehud,
	image_number: sprite_get_number(spr_cakehud),
	image_index: 0,
	image_speed: 0,
	hudBounce: [0, 1, 2, 3, 4, 5, 3, 0, -1, -2, -3, -2, -1, 0],
	pointColors: [0]
};

drawCakeHudTopping = function(_sprite, _collect)
{
	if (global.Collect > _collect)
		draw_sprite(_sprite, cakeHud.image_index, cakeHud.x, cakeHud.y);
};
