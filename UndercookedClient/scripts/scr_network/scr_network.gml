

global.player_count = 1;
global.other_clients = [];

global.client = {};


function received_packet(buffer) 
{
	var msg_id = buffer_read(buffer, buffer_string);
	var json = buffer_read(buffer, buffer_string);
	var packet = json_parse(json);
	
	if (msg_id != "player_movement") {
		debug_log(msg_id + " " + string(packet), c_gray);
	}
	
	switch (msg_id) 
	{
		case "client_setup":
			global.client = packet;
			room_goto(rm_lobby);
			break;
		
		case "client_connect":
			if (packet.item == 0) {
				packet.item = new_empty_item();
			}
			array_push(global.other_clients, packet);
			
			global.player_count ++;
			break;
		
		case "connection_reject":
			room_goto(rm_login_reject);
			break;
		
		case "client_disconnect":
			if (instance_exists(obj_other_client)) {
				with (obj_other_client) {
					if (data.client_id == packet.id) {
						instance_destroy();
					}
				}
			}
			
			for (var i = 0; i < array_length(global.other_clients); i ++) {
				var c = global.other_clients[i];
				
				if (c.client_id == packet.id) {
					global.player_count --;
					
					array_delete(global.other_clients, i, 1);
					break;
				}
			}
			
			
			break;
		
		case "change_color":
			get_client(packet.id).color_index = packet.new_index;
			break;
		
		case "start_game":
			room_goto(rm_map);
			break;
		
		case "set_item":
			var inst = get_client(packet.id);
			if (inst != -1) {
				if (inst.client_id == global.client.client_id) {
					if (instance_exists(obj_player)) {
						with (obj_player) {
							item = load_item(packet.item);
						}
					}
				}
				inst.item = load_item(packet.item);
			} else if (instance_exists(obj_countertop)) {
				with (obj_countertop) {
					if (unique_id == packet.id) {
						item = load_item(packet.item);
					}
				}
			}
			break;
		
		case "player_movement":
			var c = get_client(packet.id);
			c.x = packet.x;
			c.y = packet.y;
			c.dir = packet.dir;
			break;
		
		case "set_timer":
			global.game_timer = packet.time;
			if (instance_exists(obj_timer_controller)) {
				with (obj_timer_controller) {
					alarm[0] = -1;
				}
			}
			break;
		
		case "level_timeout":
			game_level_end();
			break;
		
		case "add_order":
			if (instance_exists(obj_order_controller)) {
				with (obj_order_controller) {
					add_order(global.orders[packet.order], packet.id);
				}
			}
			break;
		
		case "finish_order":
			if (instance_exists(obj_order_controller)) {
				with (obj_order_controller) {
					accept_order(packet.id);
				}
			}
			break;
		
		case "timeout_order":
			if (instance_exists(obj_order_controller)) {
				with (obj_order_controller) {
					timeout_order(packet.id);
				}
			}
			break;
		
		case "update_stack_count":
			if (instance_exists(obj_countertop)) {
				with (obj_countertop) {
					if (unique_id == packet.id) {
						count += packet.count;
					}
				}
			}
			break;
		
		case "add_plate_return_stack":
			if (instance_exists(obj_plate_return)) {
				with (obj_plate_return) {
					add_plate();
				}
			}
			break;
		
		case "make_extinguisher_particle":
			var xx = packet.x;
			var yy = packet.y;
			var dir = packet.dir;
		
			make_extinguisher_particle(xx, yy, dir);
			break;
		
		case "map_movement":
			if (instance_exists(obj_map_player)) {
				with (obj_map_player) {
					x_goal = packet.x;
					y_goal = packet.y;
					image_index = packet.subimg;
				}
			}
			break;
		
		case "goto_level":	
			global.level_index = packet.level_index;
			with (instance_create_depth(0,0,0,obj_transition)) {
				finished = function() {
					send_info("level_ready", {id: global.client.client_id});
				}
				room_to = cur_level().room;
			}
			break;
		
		case "start_level":
			global.player_frozen = false;
			break;
		
		case "endscreen_done":
			if (room == rm_level_endscreen) {
				room_transition(rm_map);
			}
			break;
	}
}

function get_client(id) {
	if (id == global.client.client_id) {
		return global.client;
	}
	for (var i = 0; i < array_length(global.other_clients); i ++) {
		var c = global.other_clients[i];
				
		if (c.client_id == id) {
			return c;
		}
	}
	return -1;
}

// #####################################################
// # * Network send packet functions
// #####################################################
function net_ping() 
{
	global.ping_timer = round(get_timer()/1000);
	send_info("ping");
}



function send_info(msg_id, packet={}) 
{
	var json = "";
	if (variable_struct_names_count(packet) == 0) {
		json = "{}";
	} else {
		json = json_stringify(packet);
	}
	
	if (instance_exists(obj_client)) 
	{
		with (obj_client) 
		{
			buffer_seek(client_buffer, buffer_seek_start, 0);
			buffer_write(client_buffer, buffer_string, msg_id);
			buffer_write(client_buffer, buffer_string, json);
			network_send_packet(client, client_buffer, buffer_tell(client_buffer));
		}
	}
}