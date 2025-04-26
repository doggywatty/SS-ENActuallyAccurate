if !active
	exit;

dialogAlpha = approach(dialogAlpha, (progression == 1) ? 1 : 0, 0.05);

if (dialogAlpha >= 1 && typist.get_paused())
	typist.unpause();
else
	typist.pause();

draw_set_halign(fa_left);
draw_set_alpha(dialogAlpha);
draw_set_color(c_white);
draw_sprite(spr_dialobox_temp, 0, 0, 0);

if (!chatty && dialogAlpha >= 1)
	continueIcon.draw(870, 160).update();

if (array_length(dialogEvents) > 0)
{
	var text = dialogEvents[dialogCurrent];
	text.align(0, 0);
	text.blend(0, dialogAlpha);
	text.draw(40, 40, typist);
}

draw_set_color(c_white);
draw_set_alpha(1);
