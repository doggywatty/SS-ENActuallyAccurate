repeat (3)
	randomize();

alt = chance(15);
random_set_seed(global.RandomSeed);

if (alt)
{
	fallspr = spr_painterpointer_fall;
	pointspr = spr_painterpointer;
}
