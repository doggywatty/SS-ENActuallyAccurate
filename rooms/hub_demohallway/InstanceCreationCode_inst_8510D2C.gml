/*
	the tutorial gate entrycard display parameters (layout: [sprite, image, xscale, yscale, x, y])
	so the titlecard parameters thing is useless and also is unused
*/
enum EntrycardBg
{
	image = 2,
	scaleX = 4,
	scaleY = 8
}

enum EntrycardTitle
{
	image = 0,
	scaleX = 5,
	scaleY = 6
}

targetRoom = tutorial_1;
targetDoor = "A";
level = "tutorial";
hideDetails = true;
sprite_index = spr_tutorial_startgate;
details = default_gate_scroll(spr_tutorial_stargateBG);
info = 
{
	backgroundInfo: [spr_entrycard_bg, EntrycardBg.image, EntrycardBg.scaleX, EntrycardBg.scaleY, 0, 0],
	titleInfo: [spr_entrycard_title, EntrycardTitle.image, EntrycardTitle.scaleX, EntrycardTitle.scaleY, 672, 160],
	titlecardSong: "event:/music/w1/entryway_titlecard"
};
