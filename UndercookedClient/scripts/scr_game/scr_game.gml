randomize();

#region Items

enum RecipeType {
	chopping,
	pan_cooked,
	pot_cooked,
	combo
}

function Item(name_) constructor {
	progress = 0;
	is_container = false;
	index = 0;
	name = name_;
	
	empty = false;
	special = false;
	
	function toString() {
		return name;
	}
	
	function make_packet() {
		return {
			index: index,
			progress: progress,
		}
	}
	
	function load_packet(packet) {
		progress = packet.progress;
	}
	
	
	function draw(x, y) {
		draw_sprite(spr_items, index, x, y);
	}
	
	function can_combine(item) {
		
		var r = find_recipe(RecipeType.combo, [index, item.index]);
		return r != undefined;
		
		//var item_index = item.index;
		//for (var i = 0; i < array_length(combinations); i ++) {
		//	var c = combinations[i];
		//	if (c[0] == item_index) return true;
		//}
		//return false;
	}
	
	function combine(item) {
		//var ingredients = get_base_ingredients(index);
		//array_push_all(ingredients, get_base_ingredients(item.index));
		var r = find_recipe(RecipeType.combo, [index, item.index]);
		if (r != undefined) return new_item(r.output);
		return new_empty_item();
		
		//var item_index = item.index;
		//for (var i = 0; i < array_length(combinations); i ++) {
		//	var c = combinations[i];
		//	if (c[0] == item_index) {
		//		return new_item(c[1]);
		//	}
		//}
		//return new_empty_item();
	}
	
	function is_applicable_to(recipe_type) {
		return in_recipe_type(index, recipe_type);	
	}
}

function SpecialItem(name_) : Item(name_) constructor {
	name = name_;	
	special = true;
}
	
function ItemContainer(name_) : Item(name_) constructor {
	is_container = true;
	progress = 0;
	index = 0;
	
	special = false;
	
	function toString() {
		if (item.empty) {
			return "Plate (empty)";
		} else {
			return "Plate (" + item.toString() + ")";
		}
	}
	
	function make_packet() {
		return {
			index: index,
			item: item.make_packet(),
		}
	}
	
	function load_packet(packet) {
		item = load_item(packet.item);
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
		if (item.empty && !i.empty && !i.is_container && !i.special) {
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

function Recipe(inputs_, output_, type_) constructor {
	inputs = [];
	for(var i = 0; i < array_length(inputs_); i++) {
		inputs[i] = get_item_id(inputs_[i]);
	}
	output = get_item_id(output_);
	type = type_;
}

function SingleInputRecipe(input_, output_, type_) : Recipe(undefined, output_, type_) constructor {
	inputs = [get_item_id(input_)];
}

function ChoppingRecipe(input_, output_) : SingleInputRecipe(input_, output_, RecipeType.chopping) constructor {}
function PanRecipe(input_, output_) : SingleInputRecipe(input_, output_, RecipeType.pan_cooked) constructor {}
function PotRecipe(input_, output_) : SingleInputRecipe(input_, output_, RecipeType.pot_cooked) constructor {}

// Happens when putting items together on a plate
function ComboRecipe(inputs_, output_) : Recipe(inputs_, output_, RecipeType.combo) constructor {}

// Finds a recipe of a certain type that needs specified inputs (array)
function find_recipe(recipe_type, inputs_) {
	for(var i = 0; i < array_length(global.recipes); i++) {
		var cur_recipe = global.recipes[i];
		log("%, %", cur_recipe.inputs, inputs_);
		if (cur_recipe.type == recipe_type && array_contents_equal(cur_recipe.inputs, inputs_)) return cur_recipe;
	}
	
	return undefined;
}


function make_recipe(recipe_type, inputs) {
	log("Looking up recipe for: %", item_array_to_string(inputs));
	log("Exists? %", find_recipe(recipe_type, inputs) != undefined);
	var out = find_recipe(recipe_type, inputs).output;
	return out;
}

function item_array_to_string(array) {
	var arr = [];
	for(var i = 0; i < array_length(array); i++) {
		arr[i] = global.items[array[i]];	
	}
	return string(arr);
}

// Gets the basic items a combo recipe is made from
// (ex: item = Green Eggs, returns ["Egg", "Lettuce"])
// Returns undefined if nothing is found.
// Used for combo recipes that require 3+ items and the first 2 might already have a recipe.
function get_base_ingredients(item) {
	for(var i = 0; i < array_length(global.recipes); i++) {
		var cur_recipe = global.recipes[i];
		if (cur_recipe.type == RecipeType.combo && cur_recipe.output == item) {
			return cur_recipe.inputs;	
		}
	}
	
	return undefined;
}

function in_recipe_type(item_id, recipe_type) {
	for(var i = 0; i < array_length(global.recipes); i++) {
		if (global.recipes[i].type == recipe_type) {
			var inputs = global.recipes[i].inputs;
			for(var j = 0; j < array_length(inputs); j++) {
				if (inputs[j] == item_id) {
					
					
					return true;
				}
			}
		}
	}
	
	return false;
}

global.items = [
	new Item("Empty"),
	new ItemContainer("Plate"),
	new ItemContainer("Pan"),
	new ItemContainer("Pot"),
	new SpecialItem("Dirty Plate"),
	new SpecialItem("Extinguisher"),
	new Item("Egg"),
	new Item("Fried Egg"),
	new Item("Lettuce"),
	new Item("Chopped Lettuce"),
	new Item("Tomato"),
	new Item("Chopped Tomato"),
	new Item("Beef"),
	new Item("Chopped Beef"),
	new Item("Cooked Beef"),
	new Item("Chopped Cooked Beef"),
	new Item("Chicken"),
	new Item("Chopped Chicken"),
	new Item("Cooked Chicken"),
	new Item("Chopped Cooked Chicken"),
	new Item("Pork"),
	new Item("Chopped Pork"),
	new Item("Cooked Pork"),
	new Item("Chopped Cooked Pork"),	
	new Item("Green Eggs"),
	new Item("Flour"),
	new Item("Sugar"),
	new Item("Tortilla"),
	new Item("Tomato Salad"),
	new Item("Lettuce Wrap"),
	new Item("Lettuce Tomato Wrap"),
];

global.recipes = [
	new ChoppingRecipe("Lettuce", "Chopped Lettuce"),
	new ChoppingRecipe("Tomato",  "Chopped Tomato"),
	new ChoppingRecipe("Beef",    "Chopped Beef"),
	new ChoppingRecipe("Chicken", "Chopped Chicken"),
	new ChoppingRecipe("Pork",    "Chopped Pork"),
	new ChoppingRecipe("Cooked Beef",    "Chopped Cooked Beef"),
	new ChoppingRecipe("Cooked Chicken", "Chopped Cooked Chicken"),
	new ChoppingRecipe("Cooked Pork",    "Chopped Cooked Pork"),
	
	new ComboRecipe(["Egg", "Lettuce"], "Green Eggs"),
	new ComboRecipe(["Tortilla", "Chopped Lettuce"], "Lettuce Wrap"),
	new ComboRecipe(["Chopped Tomato", "Lettuce Wrap"], "Lettuce Tomato Wrap"),
	new ComboRecipe(["Chopped Lettuce", "Chopped Tomato"], "Tomato Salad"),
];

global.items[0].empty = true;

for (var i = 0; i < array_length(global.items); i ++) {
	var item = global.items[i];
	with (item) {
		index = i;
		
		if (is_container) {
			self.item = new_empty_item();
		}
	}
}


function load_item(packet) {
	var item = new_item(packet.index);
	item.load_packet(packet);
	return item;
}

function get_item_id(name) {
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

function new_item(item_id) {
	return clone_struct(global.items[item_id]);
}

function new_plate() {
	return clone_struct(global.items[get_item_id("Plate")]);
}

function new_plate_dirty() {
	return new_item(get_item_id("Dirty Plate"));
}

#endregion

#region Level data

global.orders = [{
	item: get_item_id("Green Eggs"),
	item_sprite_index: 0,
	ingredients: [get_item_id("Egg"), get_item_id("Lettuce")],
}]

global.level_data = [
{
	room: rm_game,
	score_steps: [100, 200, 300],
}
]

global.level_completion_data = [];

for (var i = 0; i < array_length(global.level_data); i ++) {
	array_push(global.level_completion_data, {
		completed: false,
		score: 0,
		stars: 0,
	});
}

function cur_level() {
	return global.level_data[global.level_index];
}

function room_transition(rm) {
	if (!instance_exists(obj_transition)) {
		var t = instance_create_depth(0,0,0,obj_transition);
		t.room_to = rm;
		return t;
	}
	return noone;
}

#endregion

#region Other

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


function make_extinguisher_particle(xx, yy, dir) {
	with (instance_create_depth(xx, yy, -yy, obj_particle_extinguisher)) {
		angle = dir * 180/pi + choose(-1, 1) * random(35);
	}
}


#endregion