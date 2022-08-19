/// @desc

draw_self();

var outline_color = c_black;

if (hover) outline_color = c_red;

draw_set_text(fnt_score, fa_center, fa_top);
draw_text_outline(x, y+sprite_height, text, outline_color);
draw_reset_text();

