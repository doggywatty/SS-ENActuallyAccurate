if (global.DebugMode == DebugMode.debug && keyboard_check(ord("C")))
{
	cam_zoom -= 0.1;
	cam_lzoom = cam_zoom;
}
