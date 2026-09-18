if (scr_enemy_playerisnear(300, 200))
	sprite_index = spr_harryScared;
else
	sprite_index = spr_harryNEW;

ShakeBuffer = approach(ShakeBuffer, 0, 0.5);
