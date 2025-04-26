if is_undefined(Event)
	exit;
if is_array(Event)
	script_execute_ext(Event[0], Event, 1);
else
	Event();