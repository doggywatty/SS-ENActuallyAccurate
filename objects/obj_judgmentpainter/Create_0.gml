active = false;
visible = false;
image_speed = 0;
xstart = x;
targetpos = 
{
	x: x,
	y: y
};
x = room_width;
painterExpressionMap = ds_map_create();
painterMood = "normal";
ds_map_add(painterExpressionMap, "normal", 
{
	idlespr: spr_brainpainteridle,
	talkspr: spr_brainpaintertalk
});
ds_map_add(painterExpressionMap, "devious", 
{
	idlespr: spr_brainpainterdevious,
	talkspr: spr_brainpainterdevious
});
ds_map_add(painterExpressionMap, "surprised", 
{
	idlespr: spr_brainpaintersurprised,
	talkspr: spr_brainpaintersurprised
});
ds_map_add(painterExpressionMap, "upset", 
{
	idlespr: spr_brainpainterupset,
	talkspr: spr_brainpainterupset
});
movespeed = 5;
givenJudgment = scr_judgment_get("none");
finished = false;
chatty = false;
progression = 0;
dialogAlpha = 0;
dialogEvents = [];
dialogCurrent = 0;
targetPlayer = undefined;
sounded = 0;
flickpwr = 0;
flickspr = new subSprite(spr_brainpainterhandidle, 0, 0.15, false);
flickspr.visible = false;
continueIcon = new subSprite(spr_dialogbox_next, 0, 0.08, true);
scribble_typists_add_event("j_painter_pose", function(arg0, Mood, arg2)
{
	with obj_judgmentpainter
	{
		var _mood = string(Mood[0]);
		painterMood = _mood;
	}
});
current_talk_inst = -4;
typist = scribble_typist();
typist.pause();
typist.in(1, 0);
typist.function_per_char(function()
{
	static buffer = 0;
	if (buffer >= 3)
	{
		fmod_studio_event_instance_stop(current_talk_inst, false);
		fmod_studio_event_instance_release(current_talk_inst);
		current_talk_inst = fmod_createEventInstance("event:/SFX/hub/painterGiant");
		fmod_studio_event_instance_start(current_talk_inst);
		buffer = 0;
	}
	buffer++;
});
input_advance = false;
