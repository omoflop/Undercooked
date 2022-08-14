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

item = new_empty_item();
reach = 20;

extinguisher_index = get_item_id("Extinguisher");

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
			
			if (global.key_hold_action && target.item.empty) {
				hold_interact();
			}
		}
	}
}

function process_extinguisher() {
	if (item.index == extinguisher_index && global.key_hold_action) {
		var xx = x + 14 * cos(axis_angle);
		var yy = y + 14 * sin(axis_angle);
		
		
		var a = point_direction(x, y, xx, yy);
		
		with (instance_create_depth(xx, yy, -yy, obj_particle_extinguisher)) {
			angle = a + choose(-1, 1) * random(35);
		}
	}
}