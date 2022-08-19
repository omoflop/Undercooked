/// @desc Init variables

#macro PORT 3000
#macro SOCKET_TYPE network_socket_tcp
#macro IP global.server_ip
#macro BUFFER_SIZE 1024

client = network_create_socket(SOCKET_TYPE);
connected = network_connect(client, IP, PORT);

client_buffer = -1;

if (connected < 0) 
{
	room_goto(rm_login_fail);
	instance_destroy();
	return;
}

client_buffer = buffer_create(BUFFER_SIZE, buffer_grow, 1);


