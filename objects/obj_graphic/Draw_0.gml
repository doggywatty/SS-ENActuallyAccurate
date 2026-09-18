if (!draw_manually)
	draw_self();

if (is_undefined(onDraw))
	exit;

onDraw();
