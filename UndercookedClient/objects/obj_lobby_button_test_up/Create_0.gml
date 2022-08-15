/// @desc

// Inherit the parent event
event_inherited();

press = function() {
	send_info("change_color", {id: global.client.client_id, new_index: global.client.color_index + 1});
}

x -= sprite_width/4;
y -= sprite_height/2;