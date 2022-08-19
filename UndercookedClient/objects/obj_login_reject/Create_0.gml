/// @desc


b = instance_create_depth(room_width/2, room_height/2 + 25, 0, obj_button);
with (b) {
	setup_text("Back");

	press = function() {
		room_goto(rm_login);
	}
	
	x -= width/2;
}
