function scr_enemy_throw()
{
    sprite_index = spr_throw;
    if (object_index == obj_fizzCloud || object_index == obj_cottonblimp)
        vsp = 0;
    if !grounded
        hsp = approach(hsp, 0, 0.1);
    else
        hsp = 0;
    
    scr_conveyorBeltKinematics();
    if (sprite_animation_end())
    {
        switch object_index
        {
            case obj_fizzCloud:
            case obj_frothCloud:
            case obj_cottonblimp:
                state = EnemyStates.float;
                sprite_index = baddieSpriteWalk;
                break;
            default:
                state = States.frozen;
                sprite_index = baddieSpriteWalk;
                break;
        }
    }
    
    if (enemyAttackTimer <= 0 && floor(image_index) >= throw_frame)
    {
        enemyAttackTimer = 100;
        sprite_index = spr_throw;
        switch object_index
        {
            default:
                event_play_oneshot("event:/SFX/enemies/projectile", x, y);
                break;
            case obj_fizzCloud:
                event_play_oneshot("event:/SFX/enemies/thunderspawn", x, y);
                break;
        }
        switch object_index
        {
            case obj_gumslime:
                enemyAttackTimer = 200;
                break;
            case obj_googlyjuice:
                enemyAttackTimer = 400;
                with instance_create(x, y, obj_puddle)
                {
                    image_xscale = sign(other.image_xscale);
                    vsp -= 12;
                    hsp = 2;
                    grounded = 0;
                }
                with instance_create(x, y, obj_puddle)
                {
                    image_xscale = -sign(other.image_xscale);
                    vsp -= 12;
                    hsp = -2;
                    grounded = 0;
                }
                break;
            case obj_cottonwitch:
                enemyAttackTimer = 400;
                if !painter
                {
                    with instance_create(x, y, obj_cottonwitchprojectile)
                        image_xscale = other.image_xscale;
                }
                break;
            case obj_mintsplosion:
                enemyAttackTimer = 200;
                with (instance_create(x + (image_xscale * 65), y + 10, obj_mintsplosion_bomb))
                {
                    image_xscale = other.image_xscale;
                    movespeed = 12;
                }
                break;
            case obj_snowMint:
                enemyAttackTimer = 400;
                with instance_create(x, y, obj_snowMintProjectile)
                    image_xscale = other.image_xscale;
                break;
            case obj_fizzCloud:
                enemyAttackTimer = 300;
                with instance_create(x, y, obj_thundercloudprojectile)
                    image_xscale = other.image_xscale;
                break;
            case obj_popice:
                enemyAttackTimer = 200;
                with instance_create(x, y - 8, obj_popice_sneezeparticle)
                    image_xscale = other.image_xscale;
                break;
            case obj_cottonblimp:
                enemyAttackTimer = 300;
                
                with (instance_create(x, y, obj_blimp_proj, 
                {
                    image_xscale: image_xscale,
                    image_angle: image_angle,
                    baddieID: id
                }))
                    baddieID = other.id;
                break;
            
            case obj_crackerkicker:
                instance_create(x + (image_xscale * 50), y, obj_crackerkicker_kickhitbox, 
                {
                    image_xscale: image_xscale,
                    baddieID: id
                });
                movespeed = -1;
                enemyAttackTimer = 200;
                break;
        }
    }
}

