/// @desc


item = -1;

player_hover = false;

target = obj_player;

offset = 4;

progress_speed = 0;
function progress_finished() {}

function interact() {
	swap();
}
function hold_interact() {}

function swap() {
	var temp = item;
	item = target.item;
	target.item = temp;
}

