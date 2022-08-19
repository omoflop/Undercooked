/// @desc

if (obj_window_controller.init) {
	window_frame_set_fullscreen(!window_frame_get_fullscreen());
} else {
	window_set_fullscreen(!window_get_fullscreen());
}