ini_open(global.SaveFileName);
rank = ini_read_string("Ranks", level, "none");
var _rank = rank;
highscore = ini_read_string("Highscore", level, "0");
secrets = [false, false, false];

for (var i = 0; i < 3; i++)
	secrets[i] = ini_read_real("Secret", level + string(i + 1), 0) ? true : false;

levelName = ds_map_find_value(global.GameLevelMap, level).visualName;

for (var i = 0; i < array_length(confectiSprites); i++)
{
	var collected = ini_read_real("Confecti", level + string(i + 1), 0);
	if collected && !hideDetails
	{
		var offset = (i - 2) * 40;
		instance_create(x + offset, y - 46, obj_gate_confecti, confectiSprites[i]);
	}
}

for (var i = 0; i < array_length(secretCanvas); i++)
{
	var gatespeeds = [-1.1, 0, 1.1];
	var gatedelays = [0, 2, 4];
	secretCanvas[i].visible = 0;
	if (secrets[i])
	{
		secretCanvas[i].hsp = gatespeeds[i];
		secretCanvas[i].vsp = -8;
		secretCanvas[i].sprite_index = spr_gatesecretfall;
		secretCanvas[i].image_speed = 0.35;
	}
}

for (var i = 0; i < string_length(highscore); i++)
{
	gatePointDisplay.pointText[i] = 
	{
		palette: choose(0, 1, 2, 3, 4, 5, 6),
		y: -64 * (i + 1)
	};
}

with gateRankBubble
{
	visible = false;
	bubbleScale = 1;
	switch _rank
	{
		case "p": sprite_index = spr_rankbubble_pfilled; break;
		case "s": sprite_index = spr_rankbubble_sfilled; break;
		case "a": sprite_index = spr_rankbubble_a; break;
		case "b": sprite_index = spr_rankbubble_b; break;
		case "c": sprite_index = spr_rankbubble_c; break;
		default: sprite_index = spr_rankbubble_d; break;
	}
}

ini_close();
