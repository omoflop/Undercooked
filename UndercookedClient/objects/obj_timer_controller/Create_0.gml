/// @desc

is_setup = true;

function get_timer_string() {
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
	
	return m_str + ":" + s_str;
}