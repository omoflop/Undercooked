/// @desc


current_orders = [];

function Order(o, id) constructor {
	order_data = o;
	progress = 0;
	progress_speed = 1/1800;
	max_tip_score = 30;
	
	unique_id = id;
	
	controller = other;
	index = -1;
	
	x = 0;
	y = 0;
	x_goal = 0;
	y_goal = 0;
	size = 32;
	
	move_pause = 0;
	move_pause_max = 10;
	
	death_timer = 0;
	death_timer_max = 10;
	dead = false;
	color = c_white;
	
	function toString() {
		return "Order[" + string(index) + "] (" + global.items[order_data.item].name + ")";
	}
	
	function set_index(i) {
		var margin = 5;
		
		x_goal = margin + (margin + size) * i;
		y_goal = 0;
		
		if (index == -1) {
			x = x_goal;
			y = -size;
		}
		
		move_pause = move_pause_max;
		
		index = i;
	}
	
	function draw() {
		var c = color;
		var a = 1;
		if (dead) {
			a = (death_timer/death_timer_max)
		}
		draw_sprite_ext(spr_order_bg, 0, x, y, 1, 1, 0, c, a);
		
		draw_sprite_ext(spr_order_items, order_data.item_sprite_index, x, y, 1, 1, 0, c, a);
		
		draw_progress_bar(a);
	}
	
	function draw_progress_bar(a) {
		var xx = x;
		var yy = y;
		var w = size * (1 - progress);
		var h = 5;
		var c = merge_color(c_green, c_red, progress);
		
		draw_set_color(c);
		draw_set_alpha(a);
		draw_rectangle(xx, yy, xx+w-1, yy+h-1, 0);
		draw_set_color(c_white);
		draw_set_alpha(1);
	}
	
	function step() {
		progress = approach(progress, 1, progress_speed);
		
		if (move_pause == 0) {
			x = lerp(x, x_goal, 0.1);
			y = lerp(y, y_goal, 0.1);
		}
		
		move_pause = approach(move_pause, 0, 1);
		
		death_timer = approach(death_timer, 0, 1);
		if (dead && death_timer == 0) {
			order_end();
		}
		
		if (progress == 1 && !dead) {
			abort();
		}
	}
	
	function abort() {
		add_score(-30);
		set_death(c_red);
	}
	
	function finish() {
		var tips = floor(max_tip_score * (1 - progress));
		add_score(50 + tips);
		
		set_death(c_lime);
	}
	
	function set_death(c) {
		color = c;
		death_timer = death_timer_max;
		dead = true;
	}
	
	function order_end() {
		with (controller) {
			delete_order(other.index);
		}
	}
}



function add_order(order_data, order_id) {
	var o = new Order(order_data, order_id);
	o.set_index(array_length(current_orders));
	array_push(current_orders, o);
}

function delete_order(index) {
	array_delete(current_orders, index, 1);
	
	for (var i = index; i < array_length(current_orders); i ++) {
		current_orders[i].set_index(i);
	}
}

function accept_order(order_id) {
	get_order(order_id).finish();
}

function timeout_order(order_id) {
	
}

function get_order(unique_id) {
	for (var i = 0; i < array_length(current_orders); i ++) {
		var c = current_orders[i];
		if (c.unique_id == unique_id) {
			return c;
		}
	}
	return -1;
}

function check_item_accept(item_index) {
	for (var i = 0; i < array_length(current_orders); i ++) {
		var c = current_orders[i];
		if (c.order_data.item == item_index) {
			return c.unique_id;
		}
	}
	return -1;
}
