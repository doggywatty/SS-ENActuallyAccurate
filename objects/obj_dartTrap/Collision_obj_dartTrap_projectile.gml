if other.parried
{
    instance_destroy(other);
    instance_destroy(self);
    instance_create(x, y, obj_bombExplosionPlayer);
}
