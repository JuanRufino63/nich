if (global.mouse_hovering) {
	cursor_sprite = spr_cursor_positivo;
} else {
	cursor_sprite = spr_cursor;
}
global.mouse_hovering = false; // Reseta pro próximo frame
