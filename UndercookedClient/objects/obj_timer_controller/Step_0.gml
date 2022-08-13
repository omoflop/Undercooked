/// @desc



if (alarm[0] == -1) {
	alarm_set(0, 60);
	global.game_timer = approach(global.game_timer, 0, 1);
	
	if (global.game_timer == 0 && !finished) {
		finished = true;
		game_level_end();
	}
}