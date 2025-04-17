enum States
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

enum Characters
{
	Pizzelle = 0	
}

enum OptionMenu
{
	Base = 0,
	Video = 1,
	Audio = 2,
	Game = 3,
	Language = 4,
	Controls = 5,
	Keyboard = 6,
	Gamepad = 7,
	Deadzones = 8
}

enum OldOptionType
{
	Toggle = 0,
	Slider = 1,
	MultiChoice = 2,
	Press = 3
}

enum OptionType
{
	Normal = 2,
	Button = 6,
	Slider = 7	
}

enum ComboState
{
	Off = 0,
	Dropping = 1,
	On = 2
}

enum AfterImageType
{
	plain = 0,
	mach3effect1 = 1,
	mach3effect2 = 2,
	fireass = 3,
	pureblue = 4,
	purepink = 5,
	unknownorange = 6,
	baddie = 7,
	wallkick = 8	
}

enum Exclude
{
	NONE = 0,
	SLOPES = 1,
	SOLIDS = 2,
	MOVING = 4,
	PLATFORMS = 8,
	MOVINGANDPLATFORMS = 12,
	ALL = 15	
}

enum DebugType
{
	None = 0,
	Playtest = 1,
	Dev = 2	
}

enum MusicNote
{
	B3 = 0,
	C4 = 1,
	CS4 = 2,
	D4 = 3,
	DS4 = 4,
	E4 = 5,
	F4 = 6,
	FS4 = 7,
	G4 = 8,
	GS4 = 9,
	A4 = 10,
	AS4 = 11,
	B4 = 12,
	C5 = 13,
	CS5 = 14,
	D5 = 15,
	DS5 = 16,
	E5 = 17,
	F5 = 18,
	FS5 = 19,
	G5 = 20,
	GS5 = 21,
	A5 = 22,
	AS5 = 23,
	B5 = 24,
	C6 = 25,
	CS6 = 26,
	D6 = 27,
	DS6 = 28,
	E6 = 29,
	F6 = 30,
	FS6 = 31,
	G6 = 32,
	GS6 = 33,
	A6 = 34,
	AS6 = 35,
	B6 = 36,
	C7 = 37,
	CS7 = 38,
	D7 = 39,
	DS7 = 40,
	E7 = 41,
	F7 = 42,
	FS7 = 43,
	G7 = 44,
	GS7 = 45,
	A7 = 46,
	AS7 = 47,
	B7 = 48
}

enum EnemyStates
{
	idle = 856,
	walk = 857,
	turn = 858,
	thro = 859,
	scared = 860,
	stun = 861,
	grabbbed = 862,
	hit = 863,
	panicWait = 864,
	frozen = 865,
	secretWait = 866,
	cherrywait = 867,
	charge = 868,
	unknownreset = 869,
	charcherry = 870,
	unknown1 = 871,
	slugjump = 872,
	slugparry = 873,
	float = 874,
	thief = 875,
	eyescreamwait = 876,
	eyescream = 877,
	rage = 878,
	eyescreampopout = 879,
	inhaled = 881
}

enum BuilderBears
{
	ted = 0,
	tedAlt = 1,
	sarah = 2,
	jack = 3,
	karen = 4	
}

enum RopeType
{
	top = 0,
	bottom = 1	
}

enum ConditionType
{
	InLevel = 0,
	EndLevel = 1,
	OnCheck = 2
}

enum Deadzones
{
	Master,
	Vertical,
	Horizontal,
	Press,
	SJump,
	Crouch
}

enum StickPressed
{
	Released,
	JustPressed,
	Pressed
}

enum UnknownTitlecard
{
	Zero,
	One,
	Two,
	Three,
	Four,
	Five,
	Six,
	Seven,
	Eight
}

#macro isDemo 0 + 1
#macro vk_capslock 20
#macro u undefined

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

