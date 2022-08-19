/// @desc

global.game_timer = 0;

is_setup = false;
finished = false;

function setup(t) {
	global.game_timer = t;
	is_setup = true;
}

function deactivate() {
	finished = false;
	is_setup = false;
	alarm[0] = -1;
	alarm[1] = -1;
	global.game_timer = 0;
}

function get_timer_string() {
	if (!is_setup) return "-----";
	
	var v = global.game_timer;
	var m = floor(v / 60);
	var s = v % 60;
	
	var m_str, s_str;
	
	if (m < 10) {
		m_str = "0" + string(m);
	} else {
		m_str = string(m);
	}
	
	if (s < 10) {
		s_str = "0" + string(s);
	} else {
		s_str = string(s);
	}
	
	var str = m_str + ":" + s_str;
	return str;
}