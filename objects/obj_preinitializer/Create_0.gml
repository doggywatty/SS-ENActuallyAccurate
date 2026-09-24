scr_gameInit();
depth = 5;
draw_flush();
randomize();
window_center();
var temparray = ["Player", "Baddies", "HUD", "Structure", "Hub", "effectsGroup", "titleGroup"];
textureLoaderList = ds_list_create();

for (var i = 0; i < array_length(temparray); i++)
	ds_list_set(textureLoaderList, i, texturegroup_get_textures(temparray[i]));

DslistMax = ds_list_size(textureLoaderList);
alarm[0] = 3;
rareRoach = chance(2);
loadSpriteCount = sprite_get_number(spr_bodyloadbar) - 1;
imageIndexArray = array_create(loadSpriteCount + 1, 0);
global.texturesToLoad = [];
global.loadedTextures = [];
texture_debug_messages(true);

enum PlayerState
{
	frozen = 0,
	normal = 1,
	titlescreen = 2,
	run = 3,
	charge = 4,
	stun = 5,
	climbwall = 6,
	wallkick = 7,
	machtumble = 8,
	freezeframe = 9,
	grabdash = 10,
	timesup = 11,
	machroll = 12,
	tackle = 13,
	swingclub = 14,
	superslam = 15,
	grind = 16,
	grab = 17,
	taunt = 18,
	gameover = 19,
	ceilingCrash = 20,
	freefallprep = 21,
	slipnslide = 22,
	ladder = 23,
	jump = 24,
	victory = 25,
	comingoutdoor = 26,
	Sjump = 27,
	Sjumpprep = 28,
	crouch = 29,
	crouchjump = 30,
	mach1 = 31,
	mach2 = 32,
	mach3 = 33,
	machslide = 34,
	bump = 35,
	hurt = 36,
	freefall = 37,
	freefallland = 38,
	hang = 39,
	door = 40,
	doughmount = 41,
	doughmountspin = 42,
	doughmountjump = 43,
	doughmountballoon = 44,
	doughmountpancake = 45,
	finishingblow = 46,
	cotton = 47,
	uppercut = 48,
	pal = 49,
	shocked = 50,
	parry = 51,
	talkto = 52,
	puddle = 53,
	tumble = 54,
	gotkey = 55,
	cottondrill = 56,
	cottonroll = 57,
	cottondig = 58,
	fling = 59,
	breakdance = 60,
	minecart = 61,
	minecart_launched = 62,
	minecart_bump = 63,
	squished = 64,
	machtumble2 = 65,
	dodgetumble = 66,
	fireass = 67,
	fireassdash = 68,
	geyser = 69,
	actor = 70,
	donothing = 71,
	changing = 72,
	rocketlauncher = 73,
	oldtaunt = 74,
	trick = 75,
	noclip = 76,
	costumenormal = 77,
	costumegrab = 78,
	costumebreeze = 79,
	costumechuck = 80,
	bottlerocket = 81,
	unknown1 = 82,
	unknown2 = 83,
	unknown3 = 84,
	drown = 85,
	unknownrun = 86,
	unknown4 = 87,
	frostburnnormal = 88,
	frostburnslide = 89,
	frostburnjump = 90,
	frostburnstick = 91,
	supergrab = 92,
	fling_launch = 93,
	freeflight = 94,
	burrow = 100,
	charcherryrun = 101
}

enum PlayerCharacter
{
	PIZZELLE,
}

enum enemystates
{
	normal,
	attack = 2,
	thrown = 4,
	idle = 856,
	walk = 857,
	turn = 858,
	Throw = 859,
	scared = 860,
	stun = 861,
	grabbed = 862,
	hit = 863,
	panicWait = 864,
	frozen = 865,
	secretWait = 866,
	cherryWait = 867,
	charge = 868,
	unknownreset = 869,
	charcherry = 870,
	unknown1 = 871,
	slugjump = 872,
	slugparry = 873,
	float = 874,
	thief = 875,
	eyescreamWait = 876,
	eyescream = 877,
	rage = 878,
	eyescreamInitial = 879,
	inhaled = 881
}

enum debugmode
{
	off,
	playtest,
	debug,
}

enum ropetypes
{
	top,
	bottom,
}

enum buildercharacters
{
	ted,
	tedAlt,
	sarah,
	jack,
	karen,
}

enum displaystates
{
	entering,
	settling,
	active,
}

enum GnomeColors
{
	Red = 0,
	Green = 1,
	Blue = 2,
	Orange = 3,
	Peach = 4,
	Purple = 5	
}

#macro isDemo true
#macro vk_dollarsign 16
#macro vk_forwardslash 17
#macro vk_percent 32
#macro vk_rightanglebracket 37
#macro vk_asterisk 39
#macro vk_semicolon 186
#macro vk_equals 187
#macro vk_comma 188
#macro vk_dash 189
#macro vk_dot 190
#macro vk_rightslash 191
#macro vk_backtick 192
#macro vk_leftbrace 219
#macro vk_2leftslashes 220
#macro vk_rightbracket 221
#macro vk_apostrophe 222
#macro vk_capslock 20