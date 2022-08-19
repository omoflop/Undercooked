/// @desc

window_frame_update();

if (window_frame_get_visible()) {
	if (!init) {
		init = true;
	
		window_command_set_active(window_command_maximize, false);
		window_command_set_active(window_command_resize, false);
	
		room_goto(room_to);
	}
} else {
	init = false;
	if (keyboard_check(vk_control)) {
		var xaxis = keyboard_check(vk_right) - keyboard_check(vk_left);
		var yaxis = keyboard_check(vk_down) - keyboard_check(vk_up);
		var spd = 10;
		
		window_set_position(window_get_x() + xaxis * spd, window_get_y() + yaxis * spd);
	}
}