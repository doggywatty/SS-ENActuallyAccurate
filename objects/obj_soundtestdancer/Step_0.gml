var do_dance = instance_exists(obj_soundTest) && obj_soundTest.pauseStatus && (obj_soundTest.musicPlaying || dancespr == spr_marble_soundtestdance);
sprite_index = do_dance ? dancespr : idlespr;
