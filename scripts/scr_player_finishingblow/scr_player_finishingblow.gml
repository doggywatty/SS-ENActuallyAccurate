function state_player_finishingblow()
{
	static afterimage_timer = 5;
	
	move = key_right + key_left;
	hsp = movespeed;
	
	if sprite_animation_end()
	{
		state = States.normal;
		movespeed = abs(movespeed);
		if (sprite_index == spr_swingDingEnd && key_attack)
		{
			state = States.mach2;
			movespeed = max(movespeed, 6);
		}
	}
	
	var throw_frame = 6;
	if (sprite_index == spr_swingDingEnd)
		throw_frame = 0;
	if (floor(image_index) < throw_frame && sprite_index != spr_swingDingEnd)
		movespeed = approach(movespeed, 0, 1);
	else
		movespeed = approach(movespeed, -xscale * 4, 0.5);
	if (animation_end_old(undefined, throw_frame) && instance_exists(baddieGrabbedID))
	{
		vsp = -5;
		event_play_oneshot("event:/SFX/player/punch", x, y);
		event_play_oneshot("event:/SFX/enemies/killingblow", x, y);
		camera_shake_add(5, 20);
		scr_finishingBlow(baddieGrabbedID, id);
		baddieGrabbedID = -4;
		if !instance_exists(obj_instakillHitbox)
		{
			with instance_create(x, y, obj_instakillHitbox)
			{
				playerID = other.id;
				targetState = States.finishingblow;
			}
		}
	}
	
	afterimage_timer = max(afterimage_timer - 1, 0);
	if (afterimage_timer <= 0)
	{
		with (create_afterimage(choose(AfterImageType.mach3effect1, AfterImageType.mach3effect2), xscale, true))
			basicAfterimage = false;
		afterimage_timer = 5;
	}
	image_speed = 0.4;
	landAnim = false;
}
