/// @desc

if (!init) {
	init = true;
	if (global.level_index != -1) {
		if (instance_exists(obj_map_level)) {
			with (obj_map_level) {
				if (level_index == global.level_index) {
					other.x = x;
					other.y = y;
				}
			}
		}
	}
	x_goal = x;
	y_goal = y;
}

depth = -bbox_bottom;

if (!global.client.host) {
	
	x = lerp(x, x_goal, 0.05);
	y = lerp(y, y_goal, 0.05);
	
	return;
}
if (instance_exists(obj_transition)) return;

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

dir = wrap(darctan2(vsp, hsp), 360);
image_index = round_to_multiple(dir, 45)/45;

if (current_time % 3 == 0 && (x != xprevious || y != yprevious)) {
	send_info("map_movement", {x: x, y: y, subimg: image_index});
}