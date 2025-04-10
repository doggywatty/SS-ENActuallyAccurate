if (surface_exists(displaySurface))
    surface_free(displaySurface);
if (!is_undefined(screenCapture) && sprite_exists(screenCapture))
    sprite_delete(screenCapture);
