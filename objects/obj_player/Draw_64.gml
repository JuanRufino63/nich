// Draw GUI Event
draw_set_color(c_white);

var msg = "Habilidade carregando: " + string(carregamento_dash) + " / " + string(100);
draw_text(32, 32, msg);
var msg_1 = "HP " + string(global.hp_player) + " / " + string(10);
draw_text(32, 64, msg_1);
