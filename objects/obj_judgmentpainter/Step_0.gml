if !active
	exit;

input_speed = input_check("jump") || input_check("up");
input_advance = input_check_pressed("jump") || input_check_pressed("up");
var painter_sprites = ds_map_find_value(painterExpressionMap, painterMood);
if is_struct(painter_sprites)
{
	if chatty
	{
		sprite_index = painter_sprites.talkspr;
		image_speed = 0.15;
	}
	else
	{
		sprite_index = painter_sprites.idlespr;
		if (sprite_index != spr_brainpainteridle)
		{
			image_speed = 0;
			image_index = 0;
		}
		else
			image_speed = 0.15;
	}
}

switch progression
{
	case 0:
		targetpos.x = xstart;
		targetpos.y = ((camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])) - sprite_height) + 4;
		
		if (point_distance(x, y, targetpos.x, targetpos.y) <= 0)
		{
			progression = 1;
			chatty = true;
		}
		break;
	case 1:
		typist.in(1, 0);
		targetpos.x = xstart + (60 * sin(global.CurrentTime / 1000));
		targetpos.y = ((camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])) - sprite_height) + 4;
		var _end_of_text = typist.get_state() >= 1;
		if (input_advance && _end_of_text)
			event_user(0);
		else if (!_end_of_text && input_speed)
			typist.in(4, 0);
		chatty = !_end_of_text;
		break;
	case 2:
		sprite_index = spr_brainpainteridle;
		if !flickspr.visible
		{
			flickspr.setPosition(targetPlayer.bbox_right, camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 32);
			flickspr.visible = true;
		}
		else if (flickspr.y > (targetPlayer.y - 32))
			flickspr.y -= 3;
		else if (flickpwr < 10)
		{
			if !sounded
			{
				event_play_oneshot("event:/SFX/general/painterflick");
				sounded = 1;
			}
			flickpwr += 0.5;
			flickspr.x = lerp(flickspr.x, targetPlayer.bbox_right - 55, 0.3) + random_range(-flickpwr, flickpwr);
			flickspr.y = (targetPlayer.y - 32) + random_range(-flickpwr, flickpwr);
		}
		else
		{
			event_play_oneshot("event:/SFX/player/punch", targetPlayer.x, targetPlayer.y);
			event_play_oneshot("event:/SFX/general/painterflickflying");
			instance_create(targetPlayer.x, targetPlayer.y, obj_bangEffect);
			flickspr.sprite_index = spr_brainpainterhandflick;
			finished = true;
			targetPlayer.ystart = targetPlayer.y;
			progression = 3;
			scr_task_notify("palette_PZ_exhibitionbrain");
			scr_task_notify("palette_PZ_exhibitionbraingold");
			with obj_music
			{
				if !is_undefined(global.RoomMusic)
				{
					fmod_studio_event_instance_stop(global.RoomMusic.musicInst, true);
					fmod_studio_event_instance_stop(global.RoomMusic.secretMusicInst, true);
				}
			}
		}
		break;
}

if progression == 0
{
	var dir = point_direction(x, y, targetpos.x, targetpos.y);
	x += ceil(lengthdir_x(movespeed, dir));
	y += ceil(lengthdir_y(movespeed, dir));
}
else
{
	x = approach(x, targetpos.x, movespeed);
	y = approach(y, targetpos.y, movespeed);
}
