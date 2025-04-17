fadealpha = 2;
fadein = 0;
depth = -600;
scr_escapebgs();
with obj_collectEscape
{
    image_alpha = 1;
    instance_create(x, y, obj_poofeffect);
}
with obj_bigcollectEscape
{
    image_alpha = 1;
    instance_create(x, y, obj_poofeffect);
}
