/// @desc

if (room == rm_game) {
	for (var i = 0; i < array_length(global.other_clients); i ++) {
		var inst = instance_create_depth(0, 0, 0, obj_other_client);
		inst.index = i;
	}
}

