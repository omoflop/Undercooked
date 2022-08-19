
function received_packet(buffer, socket) 
{
	var msg_id = buffer_read(buffer, buffer_string);
	var __in_data = buffer_read(buffer, buffer_string);

	var packet = json_parse(__in_data);	
	
	//log(msg_id + ": " + string(packet));
	
	switch (msg_id) {
		case "client_connect":
			send_info_everyone("client_connect", packet, socket);
			break;
		
		case "change_color":
			get_client(packet.id).color_index = packet.new_index;
			send_info_everyone("change_color", packet);
			break;
		
		case "start_game":
			activate_game();
			send_info_everyone("start_game", packet);
			break;
		
		case "assign_objects_id":
			var ids_ = packet.ids;
			var a = [];
			for (var i = 0; i < array_length(ids_); i ++) {
				array_push(a, {id: ids_[i], unique_id: make_unique_id()});
			}
			send_info_everyone(assign_objects_id, {list: a});
			break;
		
		case "set_item":
			send_info_everyone(msg_id, packet);
			break;
		
		case "player_movement":
			var c = get_client(packet.id);
			c.x = packet.x;
			c.y = packet.y;
			c.dir = packet.dir;
			
			send_info_everyone(msg_id, packet, socket);
			break;
		
		case "finish_order":
			finish_order(packet.id);
			send_info_everyone(msg_id, packet);
			break;
		
		case "update_stack_count":
			send_info_everyone(msg_id, packet);
			break;
		
		case "make_extinguisher_particle":
			send_info_everyone(msg_id, packet, socket);
			break;
		
		case "map_movement":
			send_info_everyone(msg_id, packet, socket);
			break;
		
		case "select_level":
			global.level_index = packet.level_index;
			send_info_everyone("goto_level", packet);
			break;
		
		case "level_ready":
			var found = false;
			for (var i = 0; i < array_length(level_ready); i ++) {
				var l = level_ready[i];
				if (l == packet.id) {
					found = true;
				}
			}
			if (!found) {
				array_push(level_ready, packet.id);
			}
			if (array_length(level_ready) >= client_count) {
				start_level();
			}
			break;
		
		case "endscreen_done":
			send_info_everyone(msg_id, packet);
			break;
	}
}

function get_host() {
	for (var i = 0; i < array_length(clients); i ++) {
		if (clients[i].host) {
			return clients[i];
		}
	}
	return noone;
}

function get_client(id) {
	for (var i = 0; i < array_length(clients); i ++) {
		if (clients[i].client_id == id) {
			return clients[i];
		}
	}
	return noone;
}

function send_info(msg_id, packet={}, destination) 
{
	var json = "";
	if (variable_struct_names_count(packet) == 0) {
		json = "{}";
	} else {
		json = json_stringify(packet);
	}
	
	if (instance_exists(obj_server)) {
		with (obj_server) {
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_string, msg_id);
			buffer_write(server_buffer, buffer_string, json);
			network_send_packet(destination, server_buffer, buffer_tell(server_buffer));
		}
	}
}

function send_info_everyone(msg_id, packet={}, exception=-1) 
{
	if (instance_exists(obj_server)) {
		with (obj_server) {
			for (var i = 0; i < array_length(clients); i ++) 
			{
				var cur_client = clients[i];
			
				if (cur_client != -1) 
				{
					if (exception == -1) 
					{
						send_info(msg_id, packet, cur_client.socket);
					} 
					else if (cur_client.socket != exception) 
					{
						send_info(msg_id, packet, cur_client.socket);
					}
				}
			}
		}
	}
}

global.unique_id_counter = 0;
function make_unique_id() {
	return global.unique_id_counter++;
}