/// @desc

xaxis = 0;
yaxis = 0;

xdir = 1;
ydir = 1;
axis_angle = 0;

spd = 2;
hsp = 0;
vsp = 0;

fric = 0.4;
acc = 0.4;

item = new_empty_item();
reach = 20;

extinguisher_index = get_item_id("Extinguisher");

function set_item(i) {
	send_info("set_item", {id: global.client.client_id, item: i.make_packet()});
}

function update_item() {
	send_info("set_item", {id: global.client.client_id, item: item.make_packet()});
}

update_item();

function find_reach() {
	var xx = x + reach * cos(axis_angle);
	var yy = y + reach * sin(axis_angle);
	
	var list = ds_list_create();
	var c = collision_line_list(x, y, xx, yy, obj_countertop, 0, 1, list, 1);
	
	if (c > 0 && instance_exists(list[| 0])) {
		with (list[| 0]) {
			player_hover = true;
			
			if (global.key_action) {
				interact();
			}
			
			if (global.key_hold_action && target.item.empty) {
				hold_interact();
			}
		}
	}
	ds_list_destroy(list);
}

function process_extinguisher() {
	if (item.index == extinguisher_index && global.key_hold_action) {
		var xx = x + 14 * cos(axis_angle);
		var yy = y + 14 * sin(axis_angle);
		
		make_extinguisher_particle(xx, yy, axis_angle)
		send_info("make_extinguisher_particle", {x: xx, y: yy, dir: axis_angle})
		
	}
}

function process_network() {
	if (x != xprevious || y != yprevious) {
		send_info("player_movement", {id: global.client.client_id, x: x, y: y, dir: axis_angle});
	}
}

send_info("player_movement", {id: global.client.client_id, x: x, y: y, dir: axis_angle});