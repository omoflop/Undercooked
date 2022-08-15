
/// #########################################################
/// # @desc Config Functions
/// #########################################################

function client_connect(socket) 
{
	// Create client object storage
	var c = add_client(socket);
	
	if (client_count == 0) {
		c.host = true;
	}
		
	// Send client info about itself
	send_info("client_setup", c, socket);
		
	// Send connected client info about every other client
	for (var i = 0; i < array_length(clients); i ++) 
	{
		var cur_client = clients[i];
			
		if (cur_client != -1 && clients[i].socket != socket) 
		{
			send_info("client_connect", clients[i], socket);
		}
	}
		
	// Send every other client info about new client
	send_info_everyone("client_connect", c, socket);
}

function client_disconnect(socket) 
{
	// Determine which client disconnected
	var client_id = get_client_from_socket(socket);
	
	// Tell all other clients about the disconnect
	if (client_id != -1) {
		send_info_everyone("client_disconnect", 
			{
				id: client_id
			}, socket);
	}
		
	// Remove client object storage
	for (var i = 0; i < array_length(clients); i ++) {
		var cur_client = clients[i];
		
		if (cur_client.socket == socket) {
			array_delete(clients, i, 1);
			break;
		}
	}
}

function add_client(socket_) 
{
	array_push(clients, 
	{
		socket: socket_,
		client_id: make_unique_id(),
		color_index: client_count,
		player_index: client_count,
		host: false,
		item: 0,
		x: 0,
		y: 0,
		dir: 0,
	});
	
	return clients[array_length(clients)-1];
}

function get_client_from_socket(socket)
{
	for (var i = 0; i < array_length(clients); i ++) {
		var cur_client = clients[i];
		
		if (cur_client.socket == socket) {
			return cur_client.client_id;
		}
	}
	
	return -1;
}