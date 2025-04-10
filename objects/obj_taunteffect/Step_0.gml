with obj_parent_player
{
	other.x = x;
	other.y = y;
	
	var supertaunt_sprites = [spr_taunt, spr_supertaunt1, spr_supertaunt2, spr_supertaunt3, spr_supertaunt4];
	if !array_contains(supertaunt_sprites, sprite_index)
		instance_destroy(other.id);
}
