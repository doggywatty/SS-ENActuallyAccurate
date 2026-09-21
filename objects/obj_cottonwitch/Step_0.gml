baddieCollisionBoxEnabled = !((sprite_index == spr_cottonwitch_vanish && floor(image_index) >= 16) || sprite_index == spr_cottonwitch_invis || (sprite_index == spr_cottonwitch_appear && floor(image_index) < 14));
canGetScared = !(enemyAttackTimer <= 0 || state == PlayerState.titlescreen);

if (sprite_index == spr_cottonwitch_beam)
	doRedAfterImage = true;

event_inherited();
enemyAttack_TriggerEvent();
