/// @desc

window_frame_update();

if (window_frame_get_visible() && !init) {
	init = true;
	
	window_command_set_active(window_command_maximize, false);
	window_command_set_active(window_command_resize, false);
}
