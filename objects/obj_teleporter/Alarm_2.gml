spitting = true;
sprite_index = spr_teleporterexit_spit;
image_index = 0;
prepparticle = true;
event_play_oneshot("event:/SFX/general/teleporterend", x, y);
create_particle(x, y, spr_teleportEffect);