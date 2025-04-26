var music_desc = musicArray[currentSelection].songDescription;
var music_composer = musicArray[currentSelection].songComposer;
var bonus = [
	"Aw, Fudge! (Bonus)", "Fudge It All! (Bonus)",
	"what the fudge? it's a secret! (Bonus)", "Run the Dog (Bonus)",
	"Sugarcube Hailstorm (Bonus)", "Painter's Theme (Bonus)",
	"What's that Smell? (Bonus)", "Painter's Brain",
	"Painter's Mixtape", "Samba de Spire"
];
draw_set_font(global.SoundTestFont);
draw_set_font(global.npcfont);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var c = 0;
var npspr = lang_get_sprite(spr_nowplaying);
if array_contains(bonus, music_desc)
{
	c = c_white;
	npspr = lang_get_sprite(spr_nowplayingbonus);
}

var final_text = string_concat(music_desc, " - ", music_composer);
if (musicArray[currentSelection].hasSpecial && specialToggle)
	final_text = string_concat(music_desc, " - ", musicArray[currentSelection].specialComposer, "\n(", musicArray[currentSelection].specialDesc, ")");

draw_sprite(npspr, image_index, room_width / 2, 0);
scribble(final_text).starting_format(font_get_name(global.SoundTestFont), c).align(1, 1).draw(room_width / 2, 62);