function instance_create(_x, _y, obj, init_data = {})
{
    return instance_create_depth(_x, _y, 0, obj, init_data);
}
