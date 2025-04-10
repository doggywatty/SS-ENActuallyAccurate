accel = 0;
canleave = 0;
image_speed = 0;
sprite_index = spr_player_PZ_enter;
image_index = image_number - 1;
total_time = 400;
alarm[3] = 180;
if global.rank == "p"
	alarm[3] = 46;
depth = -6;
event = 0;
subevent = 0;
event_buffer = 0;
confecti_collected = [
	global.MallowFollow, global.ChocoFollow, global.CrackFollow, global.WormFollow, global.CandyFollow
];
confecti_index = array_create(5, 0);
confecti_sprites = [
	spr_confecti1rank, spr_confecti2rank, spr_confecti3rank, spr_confecti4rank, spr_confecti5rank
];
confecti_sprite_lose = [
	spr_confecti1rank_lose, spr_confecti2rank_lose, spr_confecti3rank_lose,
	spr_confecti4rank_lose, spr_confecti5rank_lose
];
confecti_sprite_collected = [
	spr_confecti1rank_collected, spr_confecti2rank_collected, spr_confecti3rank_collected,
	spr_confecti4rank_collected, spr_confecti5rank_collected
];
secrets_collected = global.SecretsFound;
secrets_sprite = [spr_rankcard, spr_rankcard, spr_rankcard];
secrets_collected_visual = array_create(3, 0);
secrets_shake = array_create(3, 0);
secrets_scale = array_create(3, 1);
score_total = global.Collect;
score_shake = 0;
score_total_visual = 0;
score_cake_index = 0;
score_total_colors = [];
saved_total_string = "";
score_highscore_index = 0;
collect_sound = fmod_createEventInstance("event:/SFX/ui/rankCollect");
combo_shown = false;
damage_shown = false;
flash = false;
bgx = 0;
bgy = 0;
bgAlpha = 0;
clipboardY = 810;
rankdex = 0;
rank_text_sprite = -4;
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
bgdex = 0;
showRank = function(_rank = global.rank)
{
	with obj_parent_player
		visible = false;
	alarm[7] = 250;
	flash = true;
	switch _rank
	{
		case "p":
			alarm[7] = 300;
			flash = false;
			sprite_index = spr_rankP;
			setcolors(188, 108, 143, 134, 40, 66);
			bgdex = 0;
			break;
		case "s":
			sprite_index = spr_rankS;
			setcolors(182, 116, 25, 143, 83, 0);
			bgdex = 5;
			break;
		case "a":
			sprite_index = spr_rankA;
			setcolors(178, 78, 78, 99, 43, 29);
			bgdex = 4;
			break;
		case "b":
			sprite_index = spr_rankB;
			setcolors(121, 159, 221, 51, 95, 196);
			bgdex = 3;
			break;
		case "c":
			sprite_index = spr_rankC;
			setcolors(103, 190, 84, 67, 122, 28);
			bgdex = 2;
			break;
		case "d":
			sprite_index = spr_rankD;
			setcolors(109, 121, 134, 84, 87, 99);
			bgdex = 1;
			break;
	}
	image_speed = 0.45;
	image_index = 0;
	x = camera_get_view_width(view_camera[0]) / 2;
	y = camera_get_view_height(view_camera[0]) / 2;
	var _text = [spr_rankD_text, spr_rankC_text, spr_rankB_text, spr_rankA_text, spr_rankS_text, -4];
	rankdex = rank_checker(_rank);
	rank_text_sprite = lang_get_sprite(_text[rankdex]);
	score_cake_index = rankdex;
};

revealSecret = function()
{
	secrets_collected_visual[subevent] = secrets_collected[subevent];
	if (secrets_collected_visual[subevent])
	{
		secrets_scale[subevent] = 3;
		event_play_oneshot("event:/SFX/ui/rankSecret");
		if !array_contains(secrets_collected_visual, false)
			event_play_oneshot("event:/SFX/general/secretfound");
	}
	else
		secrets_shake[subevent] = 3;
	subevent++;
	event_buffer = 20;
	if (subevent >= array_length(secrets_collected_visual))
	{
		event++;
		subevent = 0;
		event_buffer = 40;
	}
};

revealConfecti = function()
{
	confecti_sprites[subevent] = confecti_collected[subevent] ? confecti_sprite_collected[subevent] : confecti_sprite_lose[subevent];
	if (confecti_collected[subevent])
		event_play_oneshot("event:/SFX/ui/rankConfecti");
	else
		event_play_oneshot("event:/SFX/ui/rankConfectilose");
	confecti_index[subevent] = 0;
	subevent++;
	event_buffer = 20;
	if (subevent >= array_length(confecti_collected))
	{
		event++;
		subevent = 0;
		event_buffer = 40;
	}
};
