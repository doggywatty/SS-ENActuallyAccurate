if (!place_meeting(x, y - 1, obj_destructibles) && !place_meeting(x, y - 1, obj_metalblock))
{
    if !array_contains(obj_achievementTracker.geyserSpawnerSpawned, id)
        obj_achievementTracker.geyserSpawnerSpawned[array_length(obj_achievementTracker.geyserSpawnerSpawned)] = id;
    
    if !instance_exists(SpoutID)
    {
        with instance_create(x, y, obj_geyservertical)
        {
            image_xscale = other.image_xscale / 3;
            if (ds_list_find_index(global.SaveRoom, other.id) != -1)
                geyserPredeploy = true;
            else
                fmod_studio_event_instance_start(sound);
            geysertimer = 300;
            other.SpoutID = id;
        }
        if (ds_list_find_index(global.SaveRoom, id) == -1)
            ds_list_add(global.SaveRoom, id);
    }
}

if instance_exists(SpoutID)
    imageIndex += 0.35;
