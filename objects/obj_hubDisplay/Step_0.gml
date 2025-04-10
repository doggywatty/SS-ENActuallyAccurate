if (voice_cooldown > place_meeting(x, y, obj_parent_player))
	voice_cooldown--;
if (place_meeting(x, y, obj_parent_player))
{
	image_speed = 0.35;
	sprite_index = spr_tvdisplay_guytalk;
	showDisplay = true;
	if (voice_cooldown <= 0)
	{
		event_play_oneshot("event:/SFX/hub/news", x, y);
		voice_cooldown = 100;
	}
	var inpup = input_check_pressed("up");
	var inpdown = input_check_pressed("down");
	var inp = inpup - inpdown;
	if (inp != 0 && !buffering)
	{
		event_play_oneshot("event:/SFX/ui/displayBuzz");
		var pgLast = currentPage;
		targetPage += inp;
		buffering = true;
		tvind = (inp > 0) ? 3 : 2;
		if (targetPage < 0)
			targetPage = lastPage;
		else if (targetPage > lastPage)
			targetPage = 0;
		if (!surface_exists(displaySurface))
			displaySurface = surface_create(tvwidth, tvheight);
		if (!is_undefined(screenCapture) && sprite_exists(screenCapture))
		{
			sprite_delete(screenCapture);
			screenCapture = undefined;
		}
		screenCapture = sprite_create_from_surface(displaySurface, 0, 0, tvwidth, tvheight, false, false, 0, 0);
		scanline.y = 0;
		targetPage = clamp(targetPage, 0, lastPage);
	}
	offsetY = round(lerp(offsetY, 0, 0.15));
}
else
{
	sprite_index = spr_tvdisplay_guy;
	offsetY = round(lerp(offsetY, offscreenY, 0.2));
	if (offsetY <= -tvheight)
		showDisplay = false;
}

if (buffering || targetPage != currentPage)
{
	buffering = true;
	scanline.update();
	scanline.y += scanspeed;
	if (scanline.y >= 340)
	{
		scanline.y = 0;
		buffering = false;
		currentPage = targetPage;
		tvind = 1;
	}
}

var arrow_condition = place_meeting(x, y, obj_parent_player) && obj_parent_player.state == States.normal && obj_parent_player.grounded;
with manage_up_arrow(arrow_condition)
	sprite_index = spr_updown_arrow;
