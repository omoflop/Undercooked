/// @desc

// Inherit the parent event
event_inherited();

image_speed = 0;

progress_speed = 1/120;

function interact() {
	swap();
	
	if (item != -1) {
		image_index = 1;
	} else {
		image_index = 0;
	}
}

function hold_interact() {
	if (item != -1 && item.chopped != -1) {
		item.progress = approach(item.progress, 1, progress_speed);
	}
}

function progress_finished() {
	if (item != -1 && item.chopped != -1) {
		item = item.chopped;
	}
}