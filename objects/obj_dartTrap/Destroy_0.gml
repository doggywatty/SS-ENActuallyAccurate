if (ds_list_find_index(global.BaddieRoom, id) != -1)
    exit;
enemyDeath_SpawnDeathFX();
enemyDeath_awardPoints();
ds_list_add(global.BaddieRoom, id);
