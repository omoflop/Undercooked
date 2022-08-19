/// @desc

t = instance_create_depth(room_width/2, room_height/2, 0, obj_text_field);
with (t) {
	width = string_width("W") * max_length + padding*2;
	height = string_height("W") + padding*2;
	text = global.server_ip;
	placeholder = "Server IP";
	x -= width/2;
}

b = instance_create_depth(room_width/2, room_height/2 + t.height + 10, 0, obj_button);
with (b) {
	setup_text("Connect");
	controller = other;
	
	press = function() {
		global.server_ip = controller.t.text;
		instance_create_depth(0,0,0,obj_load_warning);
		room_goto(rm_server_connect);
	}
	
	x -= width/2;
}