
randomize();

globalvar game_active;
globalvar level_active;

global.level_data = [
	{
		time: 120,
		orders: [0]
	}
]
global.level_index = 0;
global.active_orders = [];

function get_level() {
	return global.level_data[global.level_index];
}

function activate_game() {
	game_active = true;
}

function activate_level() {
	level_active = true;
	var t = time_source_create(time_source_game, 1, time_source_units_seconds, function() {
		repeat (3) {
			add_order();
		}
	});
	time_source_start(t);
	
	set_timer();
}

function start_level() {
	activate_level();
	send_info_everyone("start_level");
}

function deactivate_game() {
	game_active = false;
	
}

function deactivate_level() {
	
	level_ready = [];
	level_active = false;
	global.active_orders = [];
	if (instance_exists(timer_controller)) {
		with (timer_controller) {
			deactivate();
		}
	}
}

function set_timer() {
	var l = get_level();
	send_info_everyone("set_timer", {time: l.time});
	
	if (instance_exists(timer_controller)) {
		with (timer_controller) {
			setup(l.time);
		}
	}
}

function level_timeout() {
	send_info_everyone("level_timeout", {});
	deactivate_level();
}


function add_order() {
	if (!level_active) return;
	
	var l = get_level();
	var o = l.orders[irandom(array_length(l.orders)-1)];
	var o_id = make_unique_id();
	send_info_everyone("add_order", {order: o, id: o_id});
	
	order_controller.add_order(o, o_id);
}

function finish_order(order_id) {
	trigger_plate_return();
	order_controller.finish_order(order_id);
}

function trigger_plate_return() {
	var t = time_source_create(time_source_game, 3, time_source_units_seconds, function() {
		send_info_everyone("add_plate_return_stack");
	});
	time_source_start(t);
}
