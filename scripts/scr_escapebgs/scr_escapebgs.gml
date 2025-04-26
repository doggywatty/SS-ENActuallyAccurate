function scr_escapebgs()
{
    if (global.panic == 1 || (instance_exists(obj_sucroseTimer) && obj_sucroseTimer.time_til_timed == 0))
    {
        layer_change_background(bg_entryway1_fgBuildings, bg_entryway1_fgBuildings_escape);
        layer_change_background(bg_entryway1_bgBuildings, bg_entryway1_bgBuildings_escape);
        layer_change_background(bg_entryway1_clouds, bg_entryway1_clouds_escape);
        layer_change_background(bg_entryway1_sky, bg_entryway1_sky_escape);
        layer_change_background(bg_entryway2_sky, bg_entrywaynightsky);
        layer_change_background(bg_entryway2_clouds, bg_entrywayescapeclouds);
        layer_change_background(bg_entryway2_buildings, bg_escapebuildingsentryway);
        layer_change_background(bg_entryway2_buildings2, bg_escapebuildingsentryway2);
        layer_change_background(entryway_endroombg1, entryway_endroomescape1);
        layer_change_background(entryway_endroombg2, entryway_endroomescape2);
        layer_change_background(entryway_endroombg3, entryway_endroomescape3);
        layer_change_background(entryway_endroombg4, entryway_endroomescape4);
        layer_change_background(entryway_endroombg5, entryway_endroomescape5);
        layer_change_background(bg_cottontown1_4, bg_cottontown1_4_vandalized);
        layer_change_background(bg_steamypark, bg_steamyparkescape);
        layer_change_background(bg_clockend_1, bg_clockend_1escape);
        layer_change_background(bg_mines1, bg_mines1_escape);
        layer_change_background(bg_minesC, bg_minesC_escape);
        layer_change_background(bg_minesWood, bg_minesWood_escape);
        layer_change_background(bg_minesWall, bg_minesWall_escape);
        layer_change_background(bg_minecaverns1, bg_minecaverns1_escape);
        layer_change_background(bg_minecaverns2, bg_minecaverns2_escape);
        layer_change_background(bg_minecaverns3, bg_minecaverns3_escape);
        layer_change_background(bg_minecaverns4, bg_minecaverns4_escape);
        layer_change_background(bg_minecavernsFG, bg_minecavernsFG_escape);
        layer_change_background(fg_molasses_rain, fg_molasses_rain_escape);
		layer_change_background(bg_molassesforestsky, bg_molassesforestsky_Escape);		
        layer_change_background(bg_molassesTemple_sky, bg_molassesTemple_sky_escape);
        layer_change_tileset(ts_mountain1_night, ts_mountain1_day);
        layer_change_background(bg_fudgetop2_foreground, bg_fudgetop2_foreground_escape);
        layer_change_background(bg_fudgetop2_1, bg_fudgetop2_1_escape);
        layer_change_background(bg_fudgetop2_2, bg_fudgetop2_2_escape);
        layer_change_background(bg_fudgetop2_3, bg_fudgetop2_3_escape);
        layer_change_background(bg_fudgetop2_4, bg_fudgetop2_4_escape);
        layer_change_background(bg_fudgetop3_1, bg_fudgetop3_1escape);
        layer_change_background(bg_fudgetop3_2, bg_fudgetop3_2escape);
        layer_change_background(bg_fudgetop3_flyingDude, bg_fudgetop3_flyingDudeescape);
        layer_change_background(bg_fudgetop3_3, bg_fudgetop3_3escape);
        layer_change_background(bg_fudgetop3_4, bg_fudgetop3_4escape);
        layer_change_background(bg_fudgetop3_5, bg_fudgetop3_5escape);
        layer_change_background(bg_sucrose_skySleep, bg_sucrose_skyActive);
        layer_change_background(bg_sucrosebgDebrisSleep, bg_sucrosebgDebris);
        layer_change_background(bg_sucrose_skyWakingUp, bg_sucrose_skyActive);
        layer_change_background(bg_estate1back1, bg_estate1back1E);
        layer_change_background(bg_estate1back2, bg_estate1back2E);
        layer_change_background(bg_estate1clouds, bg_estate1cloudsE);
        layer_change_background(bg_estate1ground1, bg_estate1ground1E);
        layer_change_background(bg_estate1ground2, bg_estate1ground2E);
        layer_change_background(bg_estate1sky, bg_estate1skyE);
        layer_change_background(bg_estate1sun, bg_estate1sunE);
    }
}
