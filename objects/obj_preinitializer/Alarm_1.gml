if !instance_exists(obj_fadeoutTransition)
{
    pal_swap_init_system(shd_pal_swapper, shd_pal_html_sprite, shd_pal_html_surface);
    instance_create(x, y, obj_fadeoutTransition);
}
