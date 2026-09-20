if (other.state == PlayerState.climbwall)
{
	DestroyedBy = other.id;
	event_user(0);
}
