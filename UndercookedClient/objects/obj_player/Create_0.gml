/// @desc

xaxis = 0;
yaxis = 0;

xdir = 1;
ydir = 1;
axis_angle = 0;

spd = 2;
hsp = 0;
vsp = 0;

fric = 0.4;
acc = 0.4;

item = -1;
reach = 20;

function find_reach() {
	var xx = x + reach * cos(axis_angle);
	var yy = y + reach * sin(axis_angle);
	
	var c = collision_line(x, y, xx, yy, obj_countertop, 0, 1);
	
	if (instance_exists(c)) {
		with (c) {
			player_hover = true;
			
			if (global.key_action) {
				interact();
			}
			
			if (global.key_hold_action) {
				hold_interact();
			}
		}
	}
}