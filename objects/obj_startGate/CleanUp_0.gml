if surface_exists(surf)
    surface_free(surf);
if !is_undefined(savedPaintSprite)
{
    if sprite_exists(savedPaintSprite)
        sprite_delete(savedPaintSprite);
}
