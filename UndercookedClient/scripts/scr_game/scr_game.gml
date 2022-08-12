
function draw_item(x, y, index) {
	if (index == -1) return;
	draw_sprite(spr_item, index, x, y);
}

function Item(chopped_=-1) constructor {
	chopped = chopped_;
	progress = 0;
}

global.items = [
new Item(1),
new Item(),
new Item(),
]

function clone_struct(s) {
	var new_s = {};
	var names = variable_struct_get_names(s);
	for (var i = 0; i < array_length(names); i ++) {
		var n = names[i];
		new_s[$ n] = s[$ n];
	}
	return new_s;
}