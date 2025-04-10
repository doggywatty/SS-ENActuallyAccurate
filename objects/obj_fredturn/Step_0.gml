var _bottom = (y + sprite_height) - peek;
if !playerTarget
	_bottom = y + sprite_height;
var _p = get_nearestPlayer();
if (sprite_index == spr_fred_turn)
{
	with _p
	{
		if (sprite_index == spr_player_PZ_minecart_turn || sprite_index == spr_player_PZ_minecart_turnidle)
		{
			var _pos = 78;
			switch (floor(other.image_index))
			{
				case 0:
					_pos = 100;
					break;
				case 1:
				case 2:
					_pos = 78;
					break;
				case 3:
				case 4:
				case 5:
				case 6:
					_pos = 70;
					break;
				default:
					_pos = 110;
					break;
			}
			
			x = other.x - (other.image_xscale * _pos);
			if (floor(other.image_index) >= 8)
			{
				event_play_oneshot("event:/SFX/general/fredbounce", x, y);
				sprite_index = spr_player_PZ_minecart_turnend;
				image_index = 0;
				movespeed = 12;
				xscale = -xscale;
				x = other.x - (other.image_xscale * 130);
			}
		}
	}
	
	if sprite_animation_end()
		sprite_index = spr_fred_turnwave;
		
	fred_y = lerp(fred_y, y, 0.3);
	vsp = 0;
	exit;
}

if (playerTarget && instance_exists(_p) && distance_to_object(_p) <= 350 && scr_transformationCheck(_p.state) == "Minecart")
{
	var _fy = fred_y;
	fred_y = lerp(fred_y, y, 0.07);
	vsp = fred_y - _fy;
	sprite_index = spr_fred_turnidle;
}
else
{
	var _tgt = clamp((_bottom - fred_y) / 100, 0, 1);
	vsp = approach(vsp, 5 * _tgt, 0.5);
	if (sprite_index != spr_fred_turnwave || fred_y == (y + sprite_height))
		sprite_index = spr_fred_turnidle;
}
fred_y = clamp(fred_y + vsp, y, y + sprite_height);
