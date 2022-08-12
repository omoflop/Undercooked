/// @desc



//xaxis = global.key_right - global.key_left;
//yaxis = global.key_down - global.key_up;
xaxis = gamepad_axis_value(DEVICE_INDEX, gp_axislh);
yaxis = gamepad_axis_value(DEVICE_INDEX, gp_axislv);


if (xaxis != 0) {
	hsp = approach(hsp, xaxis*spd, acc);
	xdir = xaxis;
} else {
	hsp = approach(hsp, 0, fric);
}

if (yaxis != 0) {
	vsp = approach(vsp, yaxis*spd, acc);
	ydir = yaxis
} else {
	vsp = approach(vsp, 0, fric);
}

axis_angle = arctan2(ydir, xdir);

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

find_reach()
