hsp = random_range(minSpd, maxSpd);
vsp = random_range(minSpd, maxSpd);
dir_h = choose(1, -1);
dir_v = choose(1, -1);
if canRotate
	image_angle = random_range(0, 360);
depth = -1;
alarm[0] = lifeTime;
