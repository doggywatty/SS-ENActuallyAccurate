if (global.DebugMode == debugmode.debug && keyboard_check(ord("C")))
{
	cam_zoom -= 0.1;
	cam_lzoom = cam_zoom;
}
