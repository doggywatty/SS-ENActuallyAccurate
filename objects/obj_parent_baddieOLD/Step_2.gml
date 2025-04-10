if hasSquashedX
{
    squashValueX = approach(squashValueX, 0.4, 0.15);
    if (squashValueX >= 0.4)
        hasSquashedX = false;
}
else
    squashValueX = approach(squashValueX, 0, 0.05);

if hasSquashedY
{
    squashValueY = approach(squashValueY, 0.4, 0.15);
    if (squashValueY >= 0.4)
        hasSquashedY = false;
}
else
    squashValueY = approach(squashValueY, 0, 0.05);

if (state == EnemyStates.grabbbed)
{
    vsp = 0;
    hsp = 0;
    grounded = false;
}

if (jumpedFromBlock && vsp >= 0 && grounded && invincibleBaddie)
{
    invincibleBaddie = false;
    jumpedFromBlock = false;
}

scr_enemySounds_update();

