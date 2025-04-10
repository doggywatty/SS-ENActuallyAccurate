if !variable_instance_exists(self, "chefUnlockQueue")
	chefUnlockQueue = ds_queue_create();

activeChefTasks = [];
if !variable_instance_exists(self, "persistentTasks")
	persistentTasks = [];
else
	activeChefTasks = array_concat(activeChefTasks, persistentTasks);

activeExhibitionNightSecretTasks = [];
constructionBreakablesRooms = [
	entryway_1, entryway_2, entryway_3, entryway_4, entryway_5, entryway_6,
	entryway_6b, entryway_7, entryway_8, entryway_9, entryway_10, entryway_11
];
constructHasSlipped = false;
constructionClutterCleared = array_concat(constructionBreakablesRooms, [entryway_portal]);
cottonBlocksUsed = 0;
cottonMarkedBlocks = [];
cottonWitchRooms = [steamy_2, steamy_3, steamy_5, steamy_6, steamy_8, steamy_9, steamy_9B, steamy_14];
gnomeMinerRooms = [mineshaft_2, mineshaft_5, mineshaft_7, mineshaft_9, mineshaft_9b];
gnomeMinersSatisfied = [];
hitInMinecart = false;
slugsWhacked = 0;
guardianSupertaunted = 0;
geyserSpawnerRooms = [molasses_5, molasses_9, molasses_11, molasses_12, molasses_3b];
geyserSpawnerSpawned = [];
flingFrogSequence = [];
cottonBlockTime = 0;
drownedEnemies = 0;
bouncedOnFred = 0;
