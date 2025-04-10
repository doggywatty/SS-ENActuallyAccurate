depth = 110;
image_speed = 1;
scr_collision_init();
movespeed = 0;
verticalMovespeed = 0;
grav = 0.5;
state = States.frozen;
scr_taunt_storeVariables();
randomBufferMin = 80;
randomBufferMax = 50;
randomBuffer = randomBufferMin + irandom(randomBufferMax);

switch character
{
    case BuilderBears.ted:
        idleSprite = spr_builderBear_ted_idle;
        walkSprite = spr_builderBear_ted_walk;
        panicSprite = spr_builderBear_ted_panic;
        tauntSprite = spr_builderBear_ted_taunt;
        break;
    case BuilderBears.tedAlt:
        idleSprite = spr_builderBear_tedAlt_idle;
        walkSprite = spr_builderBear_tedAlt_walk;
        panicSprite = spr_builderBear_ted_panic;
        tauntSprite = spr_builderBear_tedAlt_taunt;
        break;
    case BuilderBears.sarah:
        idleSprite = spr_builderBear_sarah_idle;
        walkSprite = spr_builderBear_sarah_walk;
        panicSprite = spr_builderBear_sarah_panic;
        tauntSprite = spr_builderBear_sarah_taunt;
        break;
    case BuilderBears.jack:
        idleSprite = spr_builderBear_jack;
        walkSprite = spr_builderBear_jack;
        panicSprite = spr_builderBear_jack;
        tauntSprite = spr_builderBear_jack;
        break;
    case BuilderBears.karen:
        idleSprite = spr_builderBear_karen_idle;
        walkSprite = spr_builderBear_karen_idle;
        panicSprite = spr_builderBear_karen_panic;
        tauntSprite = spr_builderBear_karen_taunt;
        break;
}

