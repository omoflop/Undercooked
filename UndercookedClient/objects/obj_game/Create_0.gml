/// @desc

global.score = 0;
global.player_frozen = false;


#macro DEVICE_INDEX 0
#macro GP_DEADZONE 0.2
gamepad_set_axis_deadzone(DEVICE_INDEX, GP_DEADZONE);

function get_input() {
	
	//global.key_left	 = keyboard_check(vk_left)  || keyboard_check(ord("A"));
	//global.key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
	//global.key_up	 = keyboard_check(vk_up)    || keyboard_check(ord("W"));
	//global.key_down	 = keyboard_check(vk_down)  || keyboard_check(ord("S"));
	
	if (gamepad_is_connected(DEVICE_INDEX)) {
		
		var dz = gamepad_get_axis_deadzone(DEVICE_INDEX);
		
		global.key_left  = gamepad_button_check(DEVICE_INDEX, gp_padl) || gamepad_axis_value(DEVICE_INDEX, gp_axislh) < -dz;
		global.key_right = gamepad_button_check(DEVICE_INDEX, gp_padr) || gamepad_axis_value(DEVICE_INDEX, gp_axislh) >  dz;
		global.key_up    = gamepad_button_check(DEVICE_INDEX, gp_padu) || gamepad_axis_value(DEVICE_INDEX, gp_axislv) < -dz;
		global.key_down  = gamepad_button_check(DEVICE_INDEX, gp_padd) || gamepad_axis_value(DEVICE_INDEX, gp_axislv) >  dz;
		
		global.key_action = gamepad_button_check_pressed(DEVICE_INDEX, gp_face1);
		global.key_hold_action = gamepad_button_check(DEVICE_INDEX, gp_face3);
	}
}