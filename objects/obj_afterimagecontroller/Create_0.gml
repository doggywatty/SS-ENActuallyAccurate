enum AfterImageType
{
	DEFAULT = 0,
	MACH3 = 1,
	MACH3ALT = 2,
	FIRE = 3,
	UNKNOWN_BLUE = 4,
	UNKNOWN_PINK = 5,
	UNKNOWN_ORANGE = 6,
	BADDIE = 7,
	WALLKICK = 8
}

depth = 1;
color_arr[AfterImageType.DEFAULT] = 
{
	light: c_white,
	dark: c_black
};
color_arr[AfterImageType.MACH3] = 
{
	light: #30a8f8,
	dark: #0f3979
};
color_arr[AfterImageType.MACH3ALT] = 
{
	light: #e85098,
	dark: #5f0920
};
color_arr[AfterImageType.FIRE] = 
{
	light: #f87018,
	dark: #a84000
};
color_arr[AfterImageType.UNKNOWN_BLUE] = 
{
	light: #30a8f8,
	dark: #30a8f8
};
color_arr[AfterImageType.UNKNOWN_PINK] = 
{
	light: #e85098,
	dark: #e85098
};
color_arr[AfterImageType.WALLKICK] = 
{
	light: #872cd2,
	dark: #200239
};
color_arr[AfterImageType.UNKNOWN_ORANGE] = 
{
	light: #f87018,
	dark: #f87018
};
color_arr[AfterImageType.BADDIE] = 
{
	light: #e03000,
	dark: #e03000
};
global.BlinkTrail = false;
blinkingBuffer = 3;
