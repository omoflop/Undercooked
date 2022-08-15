/// @desc


margin = 40;
size = 20;
x = 30;
y = room_height/2;

var xx = x;
instance_create_depth(xx, y-size/2-margin/2, depth, obj_lobby_button_test_up);
instance_create_depth(xx, y+size/2+margin/2, depth, obj_lobby_button_test_down);

if (global.client.host) {
	instance_create_depth(room_width/2, room_height * 2/3, -999, obj_lobby_startgame_button);
}


