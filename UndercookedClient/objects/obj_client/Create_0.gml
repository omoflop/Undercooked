/// @desc Init variables

#macro PORT 3000
#macro SOCKET_TYPE network_socket_tcp
#macro IP "127.0.0.1"
#macro BUFFER_SIZE 1024

client = network_create_socket(SOCKET_TYPE);
connected = network_connect(client, IP, PORT);

if (connected < 0) 
{
	show_error("Can't connect to " + IP + ":" + string(PORT), 1);
}

client_buffer = buffer_create(BUFFER_SIZE, buffer_grow, 1);


