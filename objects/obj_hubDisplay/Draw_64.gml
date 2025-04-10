if !showDisplay
	exit;
if !surface_exists(displaySurface)
	displaySurface = surface_create(tvwidth, tvheight);

var surf_mask = surface_create(tvwidth, tvheight);
surface_set_target(surf_mask);
draw_clear_alpha(c_black, 0);
gpu_set_blendmode(bm_subtract);
draw_sprite(spr_tvdisplay_frame, 1, 0, 0);
surface_reset_target();
gpu_set_blendmode(bm_normal);
draw_set_alpha(1);
draw_set_color(c_white);
surface_set_target(displaySurface);
draw_clear_alpha(c_white, 0);
draw_sprite(tvspr, tvind, 0, 0);

var dp = buffering ? targetPage : currentPage;
var pg = getPage(dp);
pg.draw();
var l = pg.getContent(0);
var p = struct_get(l, "properties");
if (dp == lastPage)
{
	draw_sprite(spr_tvdisplay, 4, 0, 0);
	draw_set_font(global.npcfont);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	
	var yy = 128;
	var ypad = 50;
	var xx = (tvwidth / 8) + 32;
	var tpad = 60;
	draw_sprite(spr_tvdisplay_icon_conf, 0, xx, yy);
	draw_text_scribble(xx + tpad, yy - 4, string($"[c_black]{p.confCount}/{p.confMax}"));
	yy += ypad;
	
	draw_sprite(spr_tvdisplay_icon_secret, 0, xx, yy);
	draw_text_scribble(xx + tpad, yy - 4, string($"[c_black]{p.secCount}/{p.secMax}"));
	yy += ypad;
	
	draw_sprite(spr_tvdisplay_icon_treasure, 0, xx, yy);
	draw_text_scribble(xx + tpad, yy - 4, string($"[c_black]{p.treasureCount}/{p.treasureMax}"));
	yy += ypad;
	
	draw_sprite(spr_tvdisplay_icon_misc, 2, xx, yy);
	draw_text_scribble(xx + tpad, yy - 4, string($"[c_black]{p.palCount}/{p.palMax}"));
	yy += ypad;
	
	draw_sprite(spr_tvdisplay_icon_misc, 4, xx, yy);
	draw_text_scribble(xx + tpad, yy - 4, string($"[c_black]{p.taskCount}/{p.taskMax}"));
}
else
	drawLevel(l);

draw_sprite(spr_tvdisplay_channel, dp, tvwidth / 8, tvheight - 54);
var goff = round(sin(current_time / 1000) / 1.9);
var cy = (scanline.y > 0) ? scanline.y : (tvheight - 85);
draw_sprite_ext(spr_CRTEffect, 0, 32, 65 + goff, tvwidth - 64, cy / 3, 0, c_black, 0.05);

if buffering
{
	var yy = scanline.y + 64;
	if (!is_undefined(screenCapture) && sprite_exists(screenCapture))
		draw_sprite_part(screenCapture, 0, 0, yy, tvwidth, tvheight - yy, 0, yy);
	scanline.draw(tvwidth / 2, yy);
}

gpu_set_blendmode(bm_subtract);
draw_surface(surf_mask, 0, 0);
gpu_set_blendmode(bm_normal);
surface_reset_target();
draw_set_color(c_white);
draw_set_alpha(1);
draw_sprite(spr_tvdisplay_frame, 1, paddingX + offsetX, paddingY + offsetY);
draw_surface(displaySurface, paddingX + offsetX, paddingY + offsetY);
draw_sprite(spr_tvdisplay_frame, 0, paddingX + offsetX, paddingY + offsetY);
surface_free(surf_mask);
