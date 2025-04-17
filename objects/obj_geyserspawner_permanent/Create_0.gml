event_inherited();
if !instance_exists(SpoutID)
{
    with instance_create(x, y, obj_geyservertical)
    {
        image_xscale = other.image_xscale;
        geysertimer = 300;
        geyserPredeploy = true;
        other.SpoutID = id;
    }
}
