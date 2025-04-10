if dunk
{
    alarm[0] = -1;
    drawy = approach(drawy, 1000, 5);
    drawbigy = approach(drawbigy, 1000, 5);
    drawtexty = approach(drawtexty, 1000, 5);
    
    if (drawy == 1000 && drawbigy == 1000 && drawtexty == 1000)
        instance_destroy();
}
else
{
    if (drawy != 540)
        drawy = approach(drawy, 540, 5);
    
    if (drawbigy != 590)
        drawbigy = approach(drawbigy, 590, 5);
    
    if (drawtexty != 698)
        drawtexty = approach(drawtexty, 698, 5);
}
