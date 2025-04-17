if object_exists(content)
{
    with instance_create(x, y - 20, content)
    {
        other.baddieid = id;
        image_xscale = sign(other.image_xscale);
        
        if (object_get_parent(object_index) == obj_parent_enemy)
        {
            state = States.charge;
            hasSquashedX = true;
            squashValueX = 0;
            baddieStunTimer = 50;
            vsp = -5;
            importantEnemy = true;
        }
    }
}
refresh = 100;
