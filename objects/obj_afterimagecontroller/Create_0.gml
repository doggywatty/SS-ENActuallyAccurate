enum afterimagetypes
{
	plain = 0,
	mach3effect_1 = 1,
	mach3effect_2 = 2,
	fireass = 3,
	pureblue = 4,
	purepink = 5,
	unknownorange = 6,
	baddie = 7,
	wallkick = 8
}

depth = 1;
color_arr[afterimagetypes.plain] = 
{
	light: c_white,
	dark: c_black
};
color_arr[afterimagetypes.mach3effect_1] = 
{
	light: #30a8f8,
	dark: #0f3979
};
color_arr[afterimagetypes.mach3effect_2] = 
{
	light: #e85098,
	dark: #5f0920
};
color_arr[afterimagetypes.fireass] = 
{
	light: #f87018,
	dark: #a84000
};
color_arr[afterimagetypes.pureblue] = 
{
	light: #30a8f8,
	dark: #30a8f8
};
color_arr[afterimagetypes.purepink] = 
{
	light: #e85098,
	dark: #e85098
};
color_arr[afterimagetypes.wallkick] = 
{
	light: #872cd2,
	dark: #200239
};
color_arr[afterimagetypes.unknownorange] = 
{
	light: #f87018,
	dark: #f87018
};
color_arr[afterimagetypes.baddie] = 
{
	light: #e03000,
	dark: #e03000
};
global.BlinkTrail = false;
blinkingBuffer = 3;
