if (other.image_index > 9)
    exit;
instance_create(x, y, obj_bombExplosionPlayer);
instance_destroy(id, false);
