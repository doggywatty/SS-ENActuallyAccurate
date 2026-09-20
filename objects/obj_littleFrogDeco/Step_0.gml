if (sprite_index == spr_lilfrogdude_taunt)
{
	if (obj_parent_player.state != PlayerState.taunt)
		scr_taunt_setVariables();
	
	exit;
}

if (sprite_index == spr_lilfrogdude_jump && sprite_animation_end())
	sprite_index = spr_lilfrogdude_fall;

if (grounded)
{
	hsp = 0;
	sprite_index = spr_lilfrogdude_idle;
}
else if (sprite_index != spr_lilfrogdude_jump && sprite_index != spr_lilfrogdude_taunt)
{
	sprite_index = spr_lilfrogdude_fall;
}

if (place_meeting_collision(x + image_xscale, y) && !grounded)
{
	image_xscale *= -1;
	hsp = image_xscale * irandom_range(1, 5);
}

if (grounded && jumpTimer-- < 0)
	event_user(0);

if (grounded && (get_nearestPlayer(x, y).state == PlayerState.taunt && bbox_in_camera(self, view_camera[0], 50)))
{
	scr_taunt_storeVariables();
	sprite_index = spr_lilfrogdude_taunt;
}

if (place_meeting(x, y, obj_geyservertical))
{
	sprite_index = spr_lilfrogdude_fall;
	
	if (vsp > -8)
		vsp = -9;
	else
		vsp = approach(vsp, -18, 0.8);
	
	hsp = approach(hsp, 0, 0.3);
	wetTimer = approach(wetTimer, wetTimerMax, 15);
}
else
{
	wetTimer = approach(wetTimer, 0, 15);
}
