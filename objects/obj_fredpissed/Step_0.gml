image_speed = (sprite_index == spr_fred_pissedhit) ? 0.5 : 0.35;
var _bottom = (y + sprite_height) - peek;
if !playerTarget
	_bottom = y + sprite_height;

var _p = get_nearestPlayer();
if cutscene
{
	var _tgt_x = x + (image_xscale * 100);
	fred_y = y;
	if (actor_buffer > 0)
	{
		actor_buffer--;
		if (actor_buffer < 0)
			actor_buffer = 0;
	}
	with _p
	{
		if (sprite_animation_end())
		{
			if (sprite_index == spr_player_PZ_minecart_fredBump)
			{
				sprite_index = spr_player_PZ_minecart_fredNervous;
				image_index = 0;
			}
			else if (sprite_index == spr_player_PZ_minecart_fredScreamTrans)
			{
				sprite_index = spr_player_PZ_minecart_fredScream;
				image_index = 0;
			}
		}
	}
	if (actor_buffer == 0 && instance_exists(_p) && _p.grounded && sprite_index != spr_fred_pissedhit)
	{
		sprite_index = spr_fred_pissedhit;
		image_index = 0;
		with _p
		{
			sprite_index = spr_player_PZ_minecart_fredScreamTrans;
			event_play_oneshot("event:/SFX/general/fredcutscenepunch");
			image_index = 0;
		}
		actor_buffer = -1;
	}
	
	if (actor_buffer && sprite_index == spr_fred_pissedhit)
	{
		image_speed = 0;
		image_index = approach(image_index, 12, 0.35);
		with _p
		{
			if (floor(other.image_index) == 10)
				y = other.py - 80;
			else
				y = other.py - 90;
			obj_camera.cameraYOffset = other.py - y;
			sprite_index = spr_player_PZ_fredHit;
			image_index = 0;
			vsp = 0;
			hsp = 0;
		}
	}
	
	if (actor_buffer == 0 && sprite_index == spr_fred_pissedhit)
	{
		with _p
		{
			state = States.Sjump;
			sprite_index = spr_superspring;
			vsp = -16;
			verticalMovespeed = vsp;
			freeFallSmash = 0;
		}
		actor_buffer = -2;
	}
	if (sprite_index == spr_fred_pissedhit && sprite_animation_end())
	{
		cutscene = false;
		sprite_index = spr_fred_pissedwave;
	}
	with _p
	{
		if (state == States.actor)
		{
			if (sprite_index == spr_player_PZ_minecart_fredBump && sprite_animation_end())
				sprite_index = spr_player_PZ_minecart;
			
			x = lerp(x, _tgt_x, 0.07);
			if (floor(other.image_index) >= 10 && other.sprite_index == spr_fred_pissedhit && other.actor_buffer == -1)
			{
				sprite_index = spr_player_PZ_fredHit;
				other.actor_buffer = 4;
				instance_create(x, y, obj_minecartCutscene);
				create_particle(x, y - 45, spr_parryeffect);
				event_play_oneshot("event:/SFX/player/punch");
				other.py = y;
				y -= 80;
				camera_shake_add(3, 5);
			}
		}
	}
	vsp = 0;
	exit;
}

if (playerTarget && instance_exists(_p) && scr_transformationCheck(_p.state) == "Minecart")
{
	var _fy = fred_y;
	fred_y = lerp(fred_y, y, 0.07);
	vsp = fred_y - _fy;
}
else
{
	var _tgt = clamp((_bottom - fred_y) / 100, 0, 1);
	vsp = approach(vsp, 5 * _tgt, 0.5);
}
fred_y = clamp(fred_y + vsp, y, y + sprite_height);
