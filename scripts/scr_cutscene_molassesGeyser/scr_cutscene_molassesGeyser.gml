function cutscene_geyser_start()
{
	var geyser = cutscene_get_actor("GEYSER");
	var finished = false;
	global.ComboFreeze = 15;
	obj_camera.chargeCameraX = 0;
	with obj_parent_player
	{
		state = States.actor;
		visible = false;
		hsp = 0;
		vsp = 0;
		image_speed = 0.35;
		if instance_exists(geyser)
		{
			geyser.t = 0;
			geyser.cutsceneTimer = 60;
			geyser.shakeX = 2;
			finished = true;
		}
	}
	with obj_parent_follower
		visible = false;
	if finished
		cutscene_event_end();
}

function cutscene_geyser_middle()
{
	var geyser = cutscene_get_actor("GEYSER");
	var finished = false;
	global.ComboFreeze = 15;
	with obj_parent_player
	{
		state = States.actor;
		visible = false;
		hsp = 0;
		vsp = 0;
		image_speed = 0.35;
		if instance_exists(geyser)
		{
			with geyser
			{
				t = (t + 1) % 65535;
				if ((t % 6) == 0)
				{
					camera_shake_add(irandom(2), 1);
					event_play_multiple("event:/SFX/general/breakblock", x, y);
				}
				if (sprite_animation_end(2) && sprite_index == spr_geyserCutscene_Activated)
					finished = true;
			}
		}
	}
	if finished
		cutscene_event_end();
}

function cutscene_geyser_end()
{
	var geyser = cutscene_get_actor("GEYSER");
	var finished = false;
	global.ComboFreeze = 15;
	with obj_parent_player
	{
		sprite_index = spr_player_PZ_geyser;
		state = States.jump;
		jumpStop = true;
		visible = true;
		hsp = 0;
		vsp = -18;
		image_speed = 0.35;
		wetTimer = wetTimerMax;
		if instance_exists(geyser)
		{
			finished = true;
			with geyser
			{
				sprite_index = spr_geyserCutscene_Active;
				image_index = 0;
				fmod_studio_event_instance_start(sound);
			}
		}
	}
	with obj_parent_follower
	{
		visible = true;
		wetTimer = wetTimerMax;
	}
	if finished
		cutscene_event_end();
}
