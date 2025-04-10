var reserved_gates = [];
var available_critics = [spr_paintCritic_1, spr_paintCritic_2, spr_paintCritic_3, spr_paintCritic_4];

with obj_paintcritic
{
	var i = array_get_index(available_critics, sprite_index);
	if (i != -1)
	{
		array_delete(available_critics, i, 1);
		if (targetGate != -4)
			array_push(reserved_gates, targetGate);
	}
}

var lv = "";
with (instance_nearest(x, y, obj_startGate))
{
	lv = level;
	other.targetGate = id;
	
	if (array_contains(reserved_gates, id))
	{
		instance_destroy(other);
		exit;
	}
}

ini_open(global.SaveFileName);
var found_rank = string_lower(ini_read_string("Ranks", lv, ""));
ini_close();
if (found_rank == "" || instance_exists(obj_tutorialBlock))
	instance_destroy();

var si = irandom_range(0, array_length(available_critics) - 1);
if (lv == "tutorial")
{
	sprite_index = spr_grandpacone;
	image_speed = 0.35;
}
else
	sprite_index = available_critics[si];

var xo = (sprite_get_width(spr_npcbubble) / 2) + 16;
var yo = (sprite_get_height(spr_npcbubble) / 2) + 16;
textbubble = instance_create(x - ((abs(sprite_width / 2) + xo) * image_xscale), bbox_top - yo, obj_npcbubble);
with textbubble
{
	if (lv == "tutorial")
	{
		text = lang_get("democritic_icepop");
		image_xscale = -other.image_xscale;
	}
	else
	{
		text = lang_get($"democritic_{array_get_index(other.criticArr, other.sprite_index) + 1}_{found_rank}");
		image_xscale = -other.image_xscale;
	}
}
