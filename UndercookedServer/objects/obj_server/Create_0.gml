/// @desc Init variables

#macro PORT 3000
#macro MAX_CLIENTS 8
#macro SOCKET_TYPE network_socket_tcp
#macro BUFFER_SIZE 1024

client_count = 0;
server = network_create_server(SOCKET_TYPE, PORT, MAX_CLIENTS);
server_buffer = buffer_create(BUFFER_SIZE, buffer_grow, 1);

if (server < 0) 
{
	show_error("Can't create server", 1);
}

clients = [];

event_user(15);

game_active = false;

window_set_position(2336, 165);