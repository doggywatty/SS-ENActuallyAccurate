if (player_complete_invulnerability())
    exit;
obj_parent_player.image_index = 0;
obj_parent_player.image_speed = 0.35;
obj_parent_player.sprite_index = spr_player_PZ_slipSlide_intro;
obj_parent_player.state = States.puddle;
obj_parent_player.vsp = -11;
obj_parent_player.grounded = 0;
with obj_achievementTracker
    constructHasSlipped = true;

event_play_oneshot("event:/SFX/player/slip", x, y);
slipped = 1;
with instance_create(x, y, obj_baddieDead)
{
    vsp = random_range(-7, -10);
    hsp = random_range(5, 10) * obj_parent_player.image_xscale;
    canrotate = false;
    sprite_index = spr_iceblock_puddle;
    image_speed = 0;
}
if !perma
{
    image_xscale = obj_parent_player.image_xscale;
    instance_destroy();
}
else
    alarm[0] = 60;
	