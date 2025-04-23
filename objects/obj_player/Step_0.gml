#region Movimentação
// Movimento vertical
if (keyboard_check(ord("W")) && !keyboard_check(ord("S"))) {
    speed_y -= acceleration_y;
}
else if (keyboard_check(ord("S")) && !keyboard_check(ord("W"))) {
    speed_y += acceleration_y;
}
else {
    speed_y *= 0.9;
}

// Movimento horizontal
if (keyboard_check(ord("A")) && !keyboard_check(ord("D"))) {
    speed_x -= acceleration_x;
}
else if (keyboard_check(ord("D")) && !keyboard_check(ord("A"))) {
    speed_x += acceleration_x;
}
else {
    speed_x *= 0.9;
}

// LIMITE DE VELOCIDADE
speed_x = clamp(speed_x, -4, 4);
speed_y = clamp(speed_y, -4, 4);

// Aplica movimento
x += speed_x;
y += speed_y;

//Troca de sprite durante movimentação
if(speed_x == 0 and speed_y ==0){
	sprite_index = spr_player_parado;
}
else{
	if(speed_x > 0 || speed_y < 0){
		sprite_index = spr_direita_player;
	}
	else if(speed_x < 0 || speed_y > 0){
		sprite_index = spr_esquerda_player;
	}
}
#endregion

#region Colisão player
// Metade do sprite
var metade_largura = sprite_width / 2;
var metade_altura = sprite_height / 2;

// Colisão com a borda esquerda
if (x < metade_largura) {
    x = metade_largura;
}

// Colisão com a borda direita
if (x > room_width - metade_largura) {
    x = room_width - metade_largura;
}

// Colisão com o topo
if (y < metade_altura) {
    y = metade_altura;
}

// Colisão com a base
if (y > room_height - metade_altura) {
    y = room_height - metade_altura;
}
#endregion

#region Habilidades
///Habilidade n1
// Carregando dash
if (keyboard_check(vk_down) && !is_dashing) {
    carregamento_dash += 1;
    if (carregamento_dash >= 100) {
        carregamento_dash = 100;
    }
}

// Inicia o dash
if (keyboard_check_pressed(vk_up) && !is_dashing) {
    is_dashing = true;
    dash_direction = (speed_x >= 0) ? 1 : -1;
    dash_speed = carregamento_dash / 5; // ajusta isso pra calibrar a força
    carregamento_dash = 0;
}

// Executa o dash suavemente
if (is_dashing) {
    obj_player.x += dash_speed * dash_direction;

    // Suave desaceleração
    dash_speed -= 0.5;

    if (dash_speed <= 0) {
        dash_speed = 0;
        is_dashing = false;
    }
}
#endregion

show_debug_message(speed_x)
show_debug_message(speed_y)
