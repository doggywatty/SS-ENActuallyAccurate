var _is_region_active = false;
var _region = -4;
var _debugZOOM = false;
if (global.DebugMode == DebugType.Dev && keyboard_check(ord("C")))
	_debugZOOM = true;

var region_active = false;
with obj_cameraRegion
{
	region_active = Region_active && activationCode();
	if (region_active)
		_region = id;
}

if (region_active && _region.ClampRight)
	Camera_width = lerp(Camera_width, _region.x + _region.sprite_width, 0.2);
else
	Camera_width = lerp(Camera_width, room_width, 0.1);

if (region_active && _region.ClampBottom)
	Camera_height = lerp(Camera_height, _region.y + _region.sprite_height, 0.2);
else
	Camera_height = lerp(Camera_height, room_height, 0.1);

if (region_active && _region.ClampLeft)
	Camera_xorigin = lerp(Camera_xorigin, _region.x, 0.2);
else
	Camera_xorigin = lerp(Camera_xorigin, 0, 0.1);

if (region_active && _region.ClampTop)
	Camera_yorigin = lerp(Camera_yorigin, _region.y, 0.2);
else
	Camera_yorigin = lerp(Camera_yorigin, 0, 0.1);

if (region_active && !_debugZOOM)
	cam_lzoom = lerp(cam_lzoom, _region.zoom, 0.2);
else if !_debugZOOM
	cam_lzoom = lerp(cam_lzoom, 1, 0.1);

if region_active
	cam_langle = lerp(cam_langle, -_region.image_angle, 0.2);
else
	cam_langle = lerp(cam_langle, 0, 0.1);

if !cameraLock
{
	with obj_parent_player
	{
		global.targetCamX = x;
		global.targetCamY = y - 32;
		if inBackgroundLayer
			global.targetCamY += global.BgInstanceLayerOffset;
	}
}
