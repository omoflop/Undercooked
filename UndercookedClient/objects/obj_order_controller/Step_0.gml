/// @desc

if (global.player_frozen) return;

for (var i = 0; i < array_length(current_orders); i ++) {
	var c = current_orders[i];
	c.step();
}

if (array_length(current_orders) < 3 && alarm[0] == -1) {
	alarm_set(0, 60 * irandom_range(5, 15));
}