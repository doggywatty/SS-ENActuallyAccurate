x = xstart;
x += random_range(shakeX, -shakeX);
shakeX = approach(shakeX, 0, 0.15);
if event_instance_isplaying(sound)
    fmod_quick3D(sound, x, bbox_bottom - 128);
