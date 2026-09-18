draw_self();

if (tauntBuffer)
{
	angerEffect.draw(x - (15 * image_xscale), y, 1, 1, 90 * image_xscale, 16777215, 1);
	angerEffect.update();
}
