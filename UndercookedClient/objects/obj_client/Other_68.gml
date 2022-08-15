/// @desc Reveive info from server

type_event = ds_map_find_value(async_load, "type");

switch (type_event) 
{
	
	// Info has been sent to us from server
	case network_type_data:
	
		// Get buffer to write on
		buffer = ds_map_find_value(async_load, "buffer");
		
		// Start writing
		buffer_seek(buffer, buffer_seek_start, 0);
		
		// Receive and process info
		received_packet(buffer);
		break;
}
