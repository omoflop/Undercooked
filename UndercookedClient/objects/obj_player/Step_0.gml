/// @desc

if (global.player_frozen) return;


//xaxis = global.key_right - global.key_left;
//yaxis = global.key_down - global.key_up;
xaxis = global.input_xaxis;
yaxis = global.input_yaxis;

var xinput_active = abs(xaxis) > GP_DEADZONE;
var yinput_active = abs(yaxis) > GP_DEADZONE;

if (xinput_active) {
	hsp = approach(hsp, xaxis*spd, acc);
	xdir = xaxis;
	ydir *= abs(yinput_active);
} else {
	hsp = approach(hsp, 0, fric);
}

if (yinput_active) {
	vsp = approach(vsp, yaxis*spd, acc);
	ydir = yaxis;
	xdir *= abs(xinput_active);
} else {
	vsp = approach(vsp, 0, fric);
}

axis_angle = arctan2(ydir, xdir);//round_to_multiple(arctan2(ydir, xdir), 3.14/6)

if (place_meeting(x+hsp, y, obj_solid)) {
	while (!place_meeting(x+sign(hsp), y, obj_solid)) {
		x += sign(hsp);
	}
	hsp = 0;
}
x += hsp;


if (place_meeting(x, y+vsp, obj_solid)) {
	while (!place_meeting(x, y+sign(vsp), obj_solid)) {
		y += sign(vsp);
	}
	vsp = 0;
}
y += vsp;

depth = -bbox_bottom;

find_reach();

process_extinguisher();

process_network();