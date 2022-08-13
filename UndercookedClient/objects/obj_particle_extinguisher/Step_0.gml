/// @desc

direction = angle;

if (size_delay == 0) {
	size = approach(size, 0, size_step);
} else {
	size_delay = approach(size_delay, 0, 1);
}

if (size == 0) {
	instance_destroy();
}

