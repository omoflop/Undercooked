/// @desc

if (!is_setup || !level_active) return;

if (alarm[0] == -1) {
	alarm_set(0, 60);
	global.game_timer = approach(global.game_timer, 0, 1);
	
	if (!finished && global.game_timer == 0) {
		finished = true;
		level_timeout();
	}
}

if (alarm[1] == -1 && array_length(global.active_orders) <= 4) {
	alarm_set(1, 60 * irandom_range(10, 25));
}