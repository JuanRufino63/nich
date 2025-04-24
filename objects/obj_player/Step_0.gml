#region Estados

// Morte
if (state != "morte" && global.hp_player <= 0) {
    state = "morte";
}

// Controle de tempo de ataque
if (state == "atacar") {
    attack_time -= 1;
    if (attack_time <= 0) {
        state = "normal";
    }
}

// Reset de attack_time quando voltar ao normal
if (state == "normal" && attack_time <= 0) {
    attack_time = 20;
}

// Hit stun
if (global.hits >= 2 && global.hits <= 30) {
    obj_player.x -= 10 * direction_moviment;
    global.hits += 1;
    state = "parado";
    if (global.hits >= 30) {
        global.hits = 0;
        state = "normal";
		parado_ = false;
    }
}

switch (state) {

    case "normal":
        #region Movimentação
        if (keyboard_check(ord("A")) && !keyboard_check(ord("D")) && parado_ == false) {
            speed_x -= acceleration_x;
            direction_moviment = -1;
        } else if (keyboard_check(ord("D")) && !keyboard_check(ord("A")) && parado_ == false){
            speed_x += acceleration_x;
            direction_moviment = 1;
        } else {
            speed_x *= 0.9;
        }

        speed_x = clamp(speed_x, -4, 4);
        speed_y = clamp(speed_y, -4, 4);

        // Sprite movimentação
        if (abs(speed_x) < 0.1) {
            sprite_index = (direction_moviment == 1) ? spr_direita_parado : spr_esquerda_parado;
        } else {
            sprite_index = (speed_x > 0) ? spr_player_direita : spr_player_esquerda;
        }

        // PULO
        if (keyboard_check_released(vk_space) && !jump) {
            jump_timer = 60;
            jump = true;
            speed_y = -10;
        }

        if (jump) {
            jump_timer -= 1;
            speed_y += 1.0;
            y += speed_y;

            if (jump_timer <= 0 || y >= room_height - sprite_height / 2) {
                jump = false;
                speed_y = 0;
                y = min(y, room_height - sprite_height / 2);
            }
        }

        x += speed_x;
        #endregion

        #region Colisão
        var metade_largura = sprite_width / 2;
        var metade_altura = sprite_height / 2;
        x = clamp(x, metade_largura, room_width - metade_largura);
        y = clamp(y, metade_altura, room_height - metade_altura);
        #endregion

        #region Habilidades
        // Dash (carregamento)
        if (keyboard_check(vk_down) && !is_dashing) {
            carregamento_dash = min(carregamento_dash + 1, 100);
        }

        // Dash (execução)
        if (keyboard_check_pressed(vk_up) && !is_dashing) {
            is_dashing = true;
            dash_direction = direction_moviment;
            dash_speed = carregamento_dash / 5;
            carregamento_dash = 0;
        }

        if (is_dashing) {
            sprite_index = (dash_direction == 1) ? sprite_peidando_direita : sprite_peidando_esquerda;
            x += dash_speed * dash_direction;
            dash_speed -= 0.5;
            if (dash_speed <= 0) {
                dash_speed = 0;
                is_dashing = false;
            }
        }

        // Reset do jogo
        if (keyboard_check(ord("P"))) {
            game_restart();
        }
        #endregion

        // Ataque
        if (global.dano_player && keyboard_check_pressed(vk_control)) {
            state = "atacar";
        }

        break;

    case "atacar":
        sprite_index = sprite_peidando_direita;
        break;

    case "parado":
        parado_ = true;
		sprite_index = spr_player_direita;
        break;

    case "morte":
        show_message("Você morreu");
        game_restart();
        break;
}
#endregion
