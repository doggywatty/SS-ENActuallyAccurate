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

enum states
{
	frozen,
	normal,
	titlescreen,
	Nhookshot,
	slap,
	charge,
	cheesepep,
	cheeseball,
	cheesepepstick,
	boxxedpep,
	pistalaim,
	climbwall,
	climbdownwall,
	knightpepslopes,
	portal,
	secondjump,
	chainsawbump,
	handstandjump,
	gottreasure,
	knightpep,
	knightpepattack,
	meteorpep,
	bombpep,
	grabbing,
	chainsawpogo,
	shotgunjump,
	stunned,
	highjump,
	chainsaw,
	facestomp,
	timesup,
	machroll,
	pistol,
	shotgun,
	machfreefall,
	throwing,
	superslam,
	slam,
	skateboard,
	grind,
	grab,
	punch,
	backkick,
	uppunch,
	shoulder,
	backbreaker,
	bossdefeat,
	bossintro,
	ufofloat,
	ufodash,
	pizzathrow,
	gameover,
	Sjumpland,
	freefallprep,
	runonball,
	boulder,
	keyget,
	tackle,
	slipnslide,
	ladder,
	jump,
	victory,
	comingoutdoor,
	Sjump,
	Sjumpprep,
	crouch,
	crouchjump,
	crouchslide,
	mach1,
	mach2,
	mach3,
	machslide,
	bump,
	hurt,
	freefall,
	freefallland,
	noclip,
	door,
	barrelnormal,
	barrelfall,
	barrelmach1,
	barrelmach2,
	barrelfloat,
	barrelcrouch,
	barrelslipnslide,
	barrelroll,
	current,
	finishingblow,
	cotton,
	uppercut,
	pal,
	shocked,
	bushdisguise,
	parry,
	talkto,
	puddle,
	tumble,
	cottondrill,
	cottonroll,
	fling,
	breakdance,
	minecart,
	squished,
	machtumble,
	pizzano_rocketfist,
	pizzano_mach,
	pizzano_kungfu,
	pizzano_pummel,
	fireass,
	geyser,
	actor,
	donothing,
	changing,
	coneboy_inhale,
	coneboy_inhale114,
	coneboy_inhale115,
	coneboy_kick,
	gumbob_propeller,
	gumbob_mixnbrew,
	pizzano_twirl,
	pizzano_machtwirl,
	pizzano_shoulderbash,
	pizzano_wallcling,
	mini,
	ufodashOLD,
	flushed,
	hooks,
	trick,
	hang,
	costumenormal,
	costumegrab,
	costumebreeze,
	costumechuck,
	bottlerocket,
	holdbomb,
	unused_1,
	unused_2,
	donut,
	drown,
	climbceiling,
	frostburn,
	frostburnwallrun,
	frostburnspin,
	frostburnbump,
	seacream,
	seacreamjump,
	seacreamstick,
	gumballoon,
	rupertnormal,
	rupertslide,
	rupertjump,
	rupertstick,
	unused_3,
	honey,
	supergrab,
}

enum PlayerCharacter
{
	PIZZELLE,
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

enum enemystates
{
	normal,
	attack = 2,
	thrown = 4,
	idle = 856,
	walk,
	turn,
	Throw,
	scared,
	stun,
	grabbed,
	hit,
	panicWait,
	frozen,
	secretWait,
	cherryWait,
	charge,
	stationary,
	charcherry,
	slugjump = 872,
	slugparry,
	float,
	thief,
	eyescreamWait,
	eyescream,
	rage,
	eyescreamInitial,
	inhale = 881,
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