accel = 0;
canleave = 0;
image_speed = 0;
if (global.playerCharacter == Characters.Pizzelle)
	sprite_index = spr_player_rankwait;
if (global.rank != "p")
	alarm[3] = 180;
else
	alarm[3] = 46;

depth = -6;
totalalpha = 0;
event = 0;
mallowspr = global.MallowFollow;
chocospr = global.ChocoFollow;
crackspr = global.CrackFollow;
wormspr = global.WormFollow;
candyspr = global.CandyFollow;
drawmallow = false;
drawchoco = false;
drawcrack = false;
drawworm = false;
drawcandy = false;
mallowdex = 0;
chocodex = 0;
crackdex = 0;
wormdex = 0;
candydex = 0;
shake1 = false;
shake2 = false;
shake3 = false;
shake4 = false;
shake5 = false;
scale1 = 0;
scale2 = 0;
scale3 = 0;
scale4 = 0;
scale5 = 0;
card1 = 0;
card2 = 0;
card3 = 0;
sevent = 0;
cshake1 = false;
cshake2 = false;
cshake3 = false;
card1spr = (global.secretfound > 0) ? spr_rankcardflipped : spr_rankcard;
card2spr = (global.secretfound > 1) ? spr_rankcardflipped : spr_rankcard;
card3spr = (global.secretfound > 2) ? spr_rankcardflipped : spr_rankcard;
carddex1 = 0;
carddex2 = 0;
carddex3 = 0;
cakedex = 0;
countpoint = global.Collect;
dex = rank_checker(global.rank);
flash = false;
pshake = false;
pspeed = 0;
counting = false;
rscale = 1;
stampani = 0;
stampdex = 0;
rankdex = dex + 1;
playerdex = 0;
hatdex = 0;
hatunlock = false;
hatappear = false;
hatdisappear = true;
hatmsg = "balls";
hatmsgx = 500;
hatmsgy = 600;
stampsnd = 0;
inicollect = global.Collect / 30;
collected = "0";
for (var i = 0; i < 10; i++)
	colors[i] = choose(0, 1, 2, 3, 4, 5, 6);
bgx = 0;
bgy = 0;
bgspr = bg_rank;
bgdex = 0;
paltime = 0;
rankpal = spr_rankpal;
showjan = 1;
janspr = spr_rankrudejanitor;
janscale = 0;
jandraw = 0;
otherjanspr = spr_rankotherjanitor;
otherjanscale = 0;
otherjandraw = 0;
clipy = 809;
goup = false;

if global.Treasure
{
	janspr = spr_rankrudejanitor;
	jandraw = 1;
}
else
	janspr = spr_null;

if (global.lapcount > 0)
{
	otherjanspr = spr_rankotherjanitor;
	otherjandraw = 1;
}
else
	otherjanspr = spr_null;

setcolors = function(_r, _g, _b, _r2, _g2, _b2)
{
	realcol = 
	{
		r: _r,
		g: _g,
		b: _b,
		r2: _r2,
		g2: _g2,
		b2: _b2
	};
};

afterimagesetup = function()
{
	shader_set(shd_afterimage);
	var colorblend1 = shader_get_uniform(shd_afterimage, "blendcolor1");
	shader_set_uniform_f(colorblend1, realcol.r / 255, realcol.g / 255, realcol.b / 255);
	var colorblend2 = shader_get_uniform(shd_afterimage, "blendcolor2");
	shader_set_uniform_f(colorblend2, realcol.r2 / 255, realcol.g2 / 255, realcol.b2 / 255);
};
