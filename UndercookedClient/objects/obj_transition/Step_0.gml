/// @desc

if (state == 0) {
	alpha = approach(alpha, 1, alpha_step);
	if (alpha == 1) {
		state = 1;
	}
} else if (state == 1) {
	if (alarm[0] == -1) {
		alarm_set(0, 3);
		finished();
		room_goto(room_to);
	}
} else if (state == 2) {
	alpha = approach(alpha, 0, alpha_step);
	if (alpha == 0) {
		instance_destroy();
	}
}

