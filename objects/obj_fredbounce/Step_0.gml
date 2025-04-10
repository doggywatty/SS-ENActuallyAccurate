var _bottom = (y + sprite_height) - peek;
if !playerTarget
	_bottom = y + sprite_height;
var _p = get_nearestPlayer();
if cutscene
{
	if (fred_y < y && holdingPlayer && vsp <= 0)
	{
		sprite_index = spr_fred_bounce;
		image_index = 0;
		holdingPlayer = false;
		vsp = 10;
		event_play_oneshot("event:/SFX/general/fredbounce", x, y);
		with _p
		{
			y = other.y;
			x = other.x;
			vsp = 0;
			hsp = 0;
			sprite_index = spr_player_PZ_minecart_jump;
			image_index = 0;
			vsp = -25;
			state = States.minecart_launched;
			movespeed = 0;
			with obj_achievementTracker
				bouncedOnFred++;
		}
	}
	else if holdingPlayer
	{
		sprite_index = spr_fred_bouncehold;
		vsp -= 2;
		fred_y += vsp;
		with _p
		{
			y = other.fred_y + 40;
			x = other.x;
			state = States.actor;
			vsp = 0;
			hsp = 0;
		}
	}
	else
	{
		fred_y += vsp;
		if sprite_animation_end()
		{
			sprite_index = spr_fred_wave;
			image_index = 0;
			cutscene = false;
			holdingPlayer = false;
		}
	}
	exit;
}

if (playerTarget && instance_exists(_p) && distance_to_object(_p) <= 350
&& scr_transformationCheck(_p.state) == "Minecart")
{
	var _pseeky = obj_parent_player.y;
	if (obj_parent_player.grounded || player_y < _pseeky)
		player_y = _pseeky;
	
	var _fy = fred_y;
	fred_y = lerp(fred_y, y, 0.02);
	vsp = fred_y - _fy;
	
	if (vsp < -2)
		sprite_index = spr_fred_up;
	else
		sprite_index = spr_fred;
}
else
{
	var _tgt = clamp((_bottom - fred_y) / 100, 0, 1);
	vsp = approach(vsp, 5 * _tgt, 0.5);
	if (sprite_index != spr_fred_wave)
		sprite_index = spr_fred;
}

if !cutscene
	fred_y = clamp(fred_y + vsp, y, y + sprite_height);
