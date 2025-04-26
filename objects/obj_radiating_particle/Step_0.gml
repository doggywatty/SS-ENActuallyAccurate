x += (hsp * dir_h);
y += (vsp * dir_v);
hsp = approach(hsp, 0.2, 0.3);
vsp = approach(vsp, 0.2, 0.3);
shake = random_range(-1, 1);
if canRotate
	image_angle += dir_h;
x += shake;
y += shake;
