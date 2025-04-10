var do_hop = false;
with helpSpr
{
	if (sprite_animation_end())
		do_hop = true;
}
helpSpr.update();
if (do_hop && sprite_index != spr_confecticage_hop)
{
	fmod_event_set3DPosition(helpSound, (x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), 0);
	fmod_studio_event_instance_start(helpSound);
	image_index = 0;
	sprite_index = spr_confecticage_hop;
}
