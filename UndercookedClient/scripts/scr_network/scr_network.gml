

global.player_count = 1;
global.other_clients = [];

global.client = {};


function received_packet(buffer) 
{
	var msg_id = buffer_read(buffer, buffer_string);
	var json = buffer_read(buffer, buffer_string);
	var packet = json_parse(json);
	
	if (instance_exists(obj_debug_log)) {
		with (obj_debug_log) {
			setup(msg_id + " " + string(packet));
		}
	}
	
	switch (msg_id) 
	{
		case "client_setup":
			global.client = packet;
			room_goto(rm_lobby);
			break;
		
		case "client_connect":
			array_push(global.other_clients, packet);
			
			global.player_count ++;
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
			room_goto(rm_game);
			break;
		
		case "set_item":
			var inst = get_client(packet.id);
			if (inst != -1) {
				if (inst.client_id == global.client.client_id) {
					if (instance_exists(obj_player)) {
						with (obj_player) {
							item = construct_item(packet.item);
						}
					}
				}
				inst.item = packet.item;
			} else if (instance_exists(obj_countertop)) {
				with (obj_countertop) {
					if (unique_id == packet.id) {
						item = construct_item(packet.item);
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