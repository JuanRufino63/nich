#region Movimentação
// Movimento horizontal
if (keyboard_check(ord("A")) && !keyboard_check(ord("D"))) {
    speed_x -= acceleration_x;
	direction_moviment = -1;
}
else if (keyboard_check(ord("D")) && !keyboard_check(ord("A"))) {
    speed_x += acceleration_x;
	direction_moviment = 1;
}
else {
    speed_x *= 0.9;
}

// LIMITE DE VELOCIDADE
speed_x = clamp(speed_x, -4, 4);
speed_y = clamp(speed_y, -4, 4);

//Troca de sprite durante movimentação
if(speed_x <= 0.1 && speed_x >= -0.1){
	if (direction_moviment == 1){
		sprite_index = spr_player_parado_direita;
	}
	else{
		sprite_index = spr_player_parado_esquerda;
	}
}
else{
	if(speed_x > 0){
		sprite_index = spr_direita_player;
	}
	else if(speed_x < 0){
		sprite_index = spr_esquerda_player;
	}
}
//Pulo
// Quando a tecla de espaço for liberada, inicia o pulo
if (keyboard_check_released(vk_space) && !jump) {
    jump_timer = room_speed; // 1 segundo de pulo
    jump = true;
    speed_y = -100; // Velocidade inicial para cima (negativa)
}

// Se estiver pulando
if (jump) {
    jump_timer -= 1;

    // Desacelera suavemente (exemplo simples, pode ser ajustado)
    speed_y += 1.0; // Gravidade puxando pra baixo

    y += speed_y;

    // Quando acabar o tempo do pulo ou atingir o chão (por segurança)
    if (jump_timer <= 0 || y >= room_height - sprite_height/2) {
        jump = false;
        speed_y = 0;
        y = min(y, room_height - sprite_height/2); // Previne passar do chão
    }
}
// Aplica movimento
x += speed_x;
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
    dash_direction = (direction_moviment == 1) ? 1 : -1;
    dash_speed = carregamento_dash / 5; // ajusta isso pra calibrar a força
    carregamento_dash = 0;
}

// Executa o dash suavemente
if (is_dashing) {
    if (dash_direction == 1) {
        sprite_index = sprite_peidando_direita;
    } else {
        sprite_index = sprite_peidando_esquerda;
    }

    x += dash_speed * dash_direction;

    // Suave desaceleração
    dash_speed -= 0.5;

    if (dash_speed <= 0) {
        dash_speed = 0;
        is_dashing = false;
    }
}
//Habilidade n2 fechar jogo
if (keyboard_check(ord("P"))){
	game_end();
}

#endregion
