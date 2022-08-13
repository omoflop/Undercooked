
randomize();

function Item(name_, chopped_=-1, pan_cooked_=-1, pot_cooked_=-1) constructor {
	chopped = chopped_;
	pan_cooked = pan_cooked_;
	pot_cooked = pot_cooked_;
	
	rand = random(10);
	
	can_chop = (chopped_ != -1);
	can_cook_pan = (pan_cooked_ != -1);
	can_cook_pot = (pot_cooked_ != -1);
	
	progress = 0;
	is_container = false;
	index = 0;
	name = name_;
	
	combinations = [];
	
	empty = false;
	
	function toString() {
		return name;
	}
	
	function draw(x, y) {
		draw_sprite(spr_items, index, x, y);
	}
	
	function can_combine(item) {
		var item_index = item.index;
		for (var i = 0; i < array_length(combinations); i ++) {
			var c = combinations[i];
			if (c[0] == item_index) return true;
		}
		return false;
	}
	
	function combine(item) {
		var item_index = item.index;
		for (var i = 0; i < array_length(combinations); i ++) {
			var c = combinations[i];
			if (c[0] == item_index) {
				return new_item(c[1]);
			}
		}
		return new_empty_item();
	}
}

function ItemContainer(name_, chopped_=-1, cooked_pan_=-1, cooked_pot_=-1) : Item(name_, chopped_=-1, cooked_pan_=-1, cooked_pot_=-1) constructor {
	is_container = true;
	progress = 0;
	index = 0;
	
	can_chop = 0;
	can_cook_pan = 0;
	can_cook_pot = 0;
	
	function toString() {
		if (item.empty) {
			return "Plate (empty)";
		} else {
			return "Plate (" + item.toString() + ")";
		}
	}
	
	item = -1;
	function add_item(i) {
		if (item.empty) {
			item = i;
		} else if (can_combine(i)) {
			item = item.combine(i);
		}
		
	}
	
	function can_combine(i) {
		if (item.empty && !i.empty && !i.is_container && i.index != find_item("Dirty Plate")) {
			return true;
		} else {
			return item.can_combine(i);
		}
	}
	
	function is_empty() {
		return item.empty;
	}
	
	function clear() {
		item = new_empty_item();
	}
	
	function draw(x, y) {
		draw_sprite(spr_items, index, x, y);
		item.draw(x, y);
	}
}

globalvar Plate;
Plate = new ItemContainer();
Plate.index = 0;



global.items = [
new Item("Empty", -1, -1, -1),
new ItemContainer("Plate"),
new ItemContainer("Pan"),
new ItemContainer("Pot"),
new Item("Dirty Plate"),
new Item("Egg",						-1, "Fried Egg", -1),
new Item("Fried Egg",				-1, -1, -1),
new Item("Lettuce",					"Chopped Lettuce", -1, -1),
new Item("Chopped Lettuce",			-1, -1, -1),
new Item("Tomato",					"Chopped Tomato", -1, -1),
new Item("Chopped Tomato",			-1, -1, -1),
new Item("Beef",					"Chopped Beef", "Cooked Beef", -1),
new Item("Chopped Beef",			-1, "Chopped Cooked Beef", -1),
new Item("Cooked Beef",				"Chopped Beef", -1, -1),
new Item("Chopped Cooked Beef",		-1, -1, -1),
new Item("Chicken",					"Chopped Beef", "Cooked Chicken", -1),
new Item("Chopped Chicken",			-1, "Chopped Cooked Chicken", -1),
new Item("Cooked Chicken",			"Chopped Chicken", -1, -1),
new Item("Chopped Cooked Chicken",	-1, -1, -1),
new Item("Pork",					"Chopped Beef", "Cooked Pork", -1),
new Item("Chopped Pork",			-1, "Chopped Cooked Pork", -1),
new Item("Cooked Pork",				"Chopped Pork", -1, -1),
new Item("Chopped Cooked Pork",		-1, -1, -1),
new Item("Green Eggs",				-1, -1, -1),
]

global.item_combinations = [
["Egg", "Lettuce", "Green Eggs"],
]

global.items[0].empty = true;

for (var i = 0; i < array_length(global.items); i ++) {
	var item = global.items[i];
	with (item) {
		index = i;
		chopped = find_item(chopped);
		pan_cooked = find_item(pan_cooked);
		pot_cooked = find_item(pot_cooked);
		
		if (is_container) {
			self.item = new_empty_item();
		}
	}
}
for (var i = 0; i < array_length(global.item_combinations); i ++) {
	var c = global.item_combinations[i];
	var i1 = find_item(c[0]);
	var i2 = find_item(c[1]);
	var result = find_item(c[2]);
	array_push(global.items[i1].combinations, [i2, result]);
	array_push(global.items[i2].combinations, [i1, result]);
}





function clone_struct(s) {
	var new_s = {};
	var names = variable_struct_get_names(s);
	for (var i = 0; i < array_length(names); i ++) {
		var n = names[i];

		if (is_method(s[$ n])) {
			new_s[$ n] = method(new_s, s[$ n]);
		} else {
			new_s[$ n] = clone_value(s[$ n]);
		}
	}
	return new_s;
}

function clone_value(v) {
	if (is_array(v)) {
		var a = [];
		for (var i = 0; i < array_length(v); i ++) {
			array_push(a, clone_value(v[i]));
		}
		return a;
	} else if (is_string(v) || is_real(v)) {
		return v;
	} else if (is_struct(v)) {
		return clone_struct(v);
	}
	
	return v;
}

function find_item(name) {
	for (var i = 0; i < array_length(global.items); i ++) {
		if (global.items[i].name == name) {
			return i;
		}
	}
	return 0;
}

function new_empty_item() {
	return new_item(0);
}

function new_item(item_type) {
	return clone_struct(global.items[item_type]);
}

function new_plate() {
	return clone_struct(global.items[find_item("Plate")]);
}

function new_plate_dirty() {
	return new_item(find_item("Dirty Plate"));
}

function add_score(s) {
	global.game_score += s;
	global.game_score = max(global.game_score, 0);
	
	if (instance_exists(obj_score_controller)) {
		with (obj_score_controller) {
			if (s < 0) {
				set_score_color(c_red);
			} else if (s > 0) {
				set_score_color(c_lime);
			}
		}
	}
}

function game_level_end() {
	global.player_frozen = true;
	instance_create_depth(0, 0, -9999, obj_game_end);
}
