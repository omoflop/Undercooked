/// @desc

if (global.game_timer % 10 == 0) {
	send_info_everyone("set_timer", {time: global.game_timer})
}

