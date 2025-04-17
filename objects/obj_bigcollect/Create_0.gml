collectvanish = false;
collectboxid = -4;
use_palette = false;
in_the_void = false;
col = 0;
depth = 2;
global.collected = 0;
random_set_seed(global.RandomSeed + x + y);
image_index = irandom_range(0, image_number - 1);
switch global.playerCharacter
{
	case Characters.Pizzelle:
		sprite_index = choose(
			spr_bigcollect1P, spr_bigcollect2P, spr_bigcollect3P, spr_bigcollect4P,
			spr_bigcollect5P, spr_bigcollect6P);
		break;
}
random_set_seed(global.RandomSeed);
image_speed = 0.35;
gotowardsPlayer = false;
