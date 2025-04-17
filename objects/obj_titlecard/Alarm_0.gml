if !instance_exists(obj_fadeoutTransition)
{
    with instance_create(x, y, obj_fadeoutTransition)
    {
        levelStart = true;
        titleCard = true;
    }
}
