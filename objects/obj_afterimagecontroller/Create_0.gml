enum afterimagetypes
{
	basic,
	blue,
	pink,
	orange,
	blueSolid,
	pinkSolid,
	orangeSolid,
	red,
	palette,
}

depth = 1;
color_arr[afterimagetypes.basic] = 
{
	light: c_white,
	dark: 0
};
color_arr[afterimagetypes.blue] = 
{
	light: 16295984,
	dark: 7944463
};
color_arr[afterimagetypes.pink] = 
{
	light: 9982184,
	dark: 2099551
};
color_arr[afterimagetypes.orange] = 
{
	light: 1601784,
	dark: 16552
};
color_arr[afterimagetypes.blueSolid] = 
{
	light: 16295984,
	dark: 16295984
};
color_arr[afterimagetypes.pinkSolid] = 
{
	light: 9982184,
	dark: 9982184
};
color_arr[afterimagetypes.palette] = 
{
	light: 13773959,
	dark: 3736096
};
color_arr[afterimagetypes.orangeSolid] = 
{
	light: 1601784,
	dark: 1601784
};
color_arr[afterimagetypes.red] = 
{
	light: 12512,
	dark: 12512
};
global.BlinkTrail = false;
blinkingBuffer = 3;
