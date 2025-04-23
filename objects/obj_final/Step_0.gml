if (point_in_rectangle(mouse_x, mouse_y, x - sprite_width / 2,
	y - sprite_height / 2, x + sprite_width / 2, y + sprite_height / 2)) {
    
	image_xscale = 1.2;
	image_yscale = 1.2;
	
	global.mouse_hovering = true; // ← Sinaliza pro controlador
} else {
	image_xscale = 1.0;
	image_yscale = 1.0;
}
