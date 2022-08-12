/// @desc

event_inherited();

item_type = 0;

function interact() {
	if (item != -1) {
		swap();
	} else if (target.item == -1) {
		target.item = clone_struct(global.items[item_type]);
	} else {
		swap();	
	}
}
