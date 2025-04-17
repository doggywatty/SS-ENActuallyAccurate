speaking = place_meeting(x, y, obj_parent_player);
sprite_index = speaking ? speak : idle;
if (voice_cooldown > speaking)
	voice_cooldown--;

mytex_x -= 0.5;
mytex_x %= sprite_get_width(mytex);
mytex_y = wave(-5, 5, 5, 20);
propdex += 0.35;
propdex %= 3;
if global.panic
	text = lang_get("icepop_default_escape");
var thought_fade = distance_to_object(obj_parent_player) / 125;
with obj_painterbubble
	fade = thought_fade;
