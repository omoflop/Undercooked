/// @desc

event_inherited();

selected = false;

function press() {
	selected = true;
}
function press_outside() {
	selected = false;
}

function reset_blink() {
	blink = true;
	alarm[0] = -1;
}

blink = false;

width = 10;
height = 10;
padding = 5;

delete_timer = 0;
text = "";

max_length = 15;

placeholder = "";