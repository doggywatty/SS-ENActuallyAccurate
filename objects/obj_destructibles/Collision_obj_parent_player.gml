if (other.state == PlayerState.crouch)
{
	DestroyedBy = other.id;
	event_user(0);
}
