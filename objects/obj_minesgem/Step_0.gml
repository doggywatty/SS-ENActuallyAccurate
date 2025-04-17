if (playerID == -4)
{
    instance_destroy();
    exit;
}

x = playerID.x;
y = playerID.y - 100;
if refined
{
    x += random_range(-2, 2);
    y += random_range(-2, 2);
}

image_xscale = approach(image_xscale, 1, 0.05);
image_yscale = approach(image_yscale, 1, 0.05);
if (gemCount < 4)
{
    image_index = gemCount;
    sprite_index = spr_minesgem;
}
else
{
    sprite_index = spr_minesgemfull;
    image_speed = 0.35;
}

if collected
{
    while (gemCount > 0)
    {
        with (instance_create(x + random_range(-5, 5), y + random_range(-5, 5), obj_minesgempiece))
        {
            isCollect = true;
            count = other.gemCount;
            instance_create(x, y, obj_poofeffect);
            ystart = y;
            hsp += other.playerID.hsp;
        }
        gemCount--;
    }
    collected = false;
    xstart = x;
    ystart = y;
}

if ((instance_exists(obj_minesgempiece) || collected) && playerID.state != States.actor)
{
    leaveTimer = 60;
    leaving = false;
}
else
{
    if idleGem
    {
        idleGem = false;
        leaveTimer = 0;
        leaving = true;
    }
    
    leaveTimer = approach(leaveTimer, 0, 1);
    if (leaveTimer <= 0)
        leaving = true;
}

if (image_alpha < 1 && !leaving)
    image_alpha += 0.1;
if leaving
    image_alpha -= 0.1;
if (image_alpha <= 0 && leaving)
    instance_destroy();

