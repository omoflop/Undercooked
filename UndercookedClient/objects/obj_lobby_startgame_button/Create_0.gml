/// @desc

// Inherit the parent event
event_inherited();

setup_text("Start Game");

x -= width/2;

press = function() {
	send_info("start_game", {});	
}