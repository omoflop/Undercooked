/// @desc

if (global.player_frozen) return;

for (var i = 0; i < array_length(current_orders); i ++) {
	var c = current_orders[i];
	c.step();
}
