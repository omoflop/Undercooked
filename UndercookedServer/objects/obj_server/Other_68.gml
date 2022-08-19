type_event = ds_map_find_value(async_load, "type");

switch (type_event) 
{
	
	case network_type_data:
		var buffer = ds_map_find_value(async_load, "buffer");
		var socket = ds_map_find_value(async_load, "id");
		
		buffer_seek(buffer, buffer_seek_start, 0);
		
		received_packet(buffer, socket);
		break;
		
	case network_type_connect:
		var socket = ds_map_find_value(async_load, "socket");
		
		if (game_active) {
			send_info("connection_reject");
		} else {
			
			client_connect(socket);
			
			// Increase client count
			client_count ++;
		}
		break;
		
	case network_type_disconnect:
		var socket = ds_map_find_value(async_load, "socket");
		
		client_disconnect(socket);
		
		// Decrease client count
		client_count --;
		
		if (client_count <= 0) {
			deactivate_game();
			deactivate_level();
		}
		break;
}