/// @desc

if (!level_active) return;

for (var i = 0; i < array_length(global.active_orders); i ++) {
	var o = global.active_orders[i];
	o.step();
}

