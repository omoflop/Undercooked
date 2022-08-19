/// @desc

global.server_ip = "127.0.0.1";

global.game_score = 0;
global.player_frozen = true;

global.level_index = -1;

global.game_timer = 0;

global.controller_index = 0;
global.controlled_connected = false;

#macro GP_DEADZONE 0.2
gamepad_set_axis_deadzone(global.controller_index, GP_DEADZONE);

function try_reconnect() {
	for(var i = 0; i < gamepad_get_device_count(); i++) {
		if (gamepad_is_connected(i)) {
			global.controller_index = i;
			global.controlled_connected = true;
			log("Reconnected gamepad %", i);
			return;
		}	
	}
}

function get_input() {
	
	//global.key_left	 = keyboard_check(vk_left)  || keyboard_check(ord("A"));
	//global.key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
	//global.key_up	 = keyboard_check(vk_up)    || keyboard_check(ord("W"));
	//global.key_down	 = keyboard_check(vk_down)  || keyboard_check(ord("S"));
	
	if (!gamepad_is_connected(global.controller_index)) {
		if (global.controlled_connected) {
			log("Gamepad % disconnected.", global.controller_index);
			global.controlled_connected = false;
		}
		try_reconnect();
	}
	
	if (gamepad_is_connected(global.controller_index)) {
		var dz = gamepad_get_axis_deadzone(global.controller_index);
		
		global.key_left  = gamepad_button_check(global.controller_index, gp_padl) || gamepad_axis_value(global.controller_index, gp_axislh) < -dz;
		global.key_right = gamepad_button_check(global.controller_index, gp_padr) || gamepad_axis_value(global.controller_index, gp_axislh) >  dz;
		global.key_up    = gamepad_button_check(global.controller_index, gp_padu) || gamepad_axis_value(global.controller_index, gp_axislv) < -dz;
		global.key_down  = gamepad_button_check(global.controller_index, gp_padd) || gamepad_axis_value(global.controller_index, gp_axislv) >  dz;
		
		global.key_action = gamepad_button_check_pressed(global.controller_index, gp_face1);
		global.key_hold_action = gamepad_button_check(global.controller_index, gp_face3);
		
		global.input_xaxis = gamepad_axis_value(global.controller_index, gp_axislh) 
		global.input_yaxis = gamepad_axis_value(global.controller_index, gp_axislv);
	} else {
		global.key_left  = keyboard_check(vk_left);	
		global.key_right = keyboard_check(vk_right);	
		global.key_up    = keyboard_check(vk_up);	
		global.key_down  = keyboard_check(vk_down);
		
		global.key_action = keyboard_check_pressed(ord("Z"));
		global.key_hold_action = keyboard_check(ord("X"));
		
		global.input_xaxis = global.key_right - global.key_left;
		global.input_yaxis = global.key_down - global.key_up;
	}
}