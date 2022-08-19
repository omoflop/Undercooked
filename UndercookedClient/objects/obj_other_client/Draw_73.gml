/// @desc

var item = data.item;

if (!item.empty) {
	var xx = x + 10 * cos(data.dir);
	var yy = y + 10 * sin(data.dir);
	item.draw(xx, yy);
}

