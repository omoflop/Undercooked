/// @desc

function Order(d, i) constructor {
	order_data = d;
	unique_id = i;
	progress = 0;
	progress_speed = 1/1800;
	
	controller = other;
	
	finished = false;
	
	function step() {
		progress = approach(progress, 1, progress_speed);
		
		if (progress == 1 && !finished) {
			finished = true;
			send_info_everyone("timeout_order", {id: unique_id})
			controller.finish_order(unique_id);
		}
	}
}

function draw(x, y) {
	var h = 0;
	for (var i = 0; i < array_length(global.active_orders); i ++) {
		var o = global.active_orders[i];
		draw_text(x, y+h, "Order[" + string(o.unique_id) + "] = " + string_format(o.progress, 1, 2));
		h += 20;
	}
	
	return h;
}

function add_order(order_data, unique_id) {
	array_push(global.active_orders, new Order(order_data, unique_id));
}

function finish_order(unique_id) {
	for (var i = 0; i < array_length(global.active_orders); i ++) {
		var o = global.active_orders[i];
		if (o.unique_id == unique_id) {
			array_delete(global.active_orders, i, 1);
			return;
		}
	}
}