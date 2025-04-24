#region Colisão inimigo
// Metade do sprite
var metade_largura = sprite_width / 2;
var metade_altura = sprite_height / 2;

// Impede sair da sala
x = clamp(x, metade_largura, room_width - metade_largura);
y = clamp(y, metade_altura, room_height - metade_altura);
#endregion

#region Controle de estado
// Distância até o jogador
var dist = point_distance(x, y, target.x, target.y);
show_debug_message(dist);

// Invulnerabilidade
if (global.inv <= 0) {
    global.inv = 0;
    global.dano_player = true;
} else {
    global.inv -= 1;
}

// Definição do estado
if (dist < 210) {
    state = "atacar";
}
else if (dist < alert_range) {
    state = "alerta";
}
else if (state == "alerta" && dist >= alert_range + 20) {
    state = "patrulha";
}
#endregion

#region Execução do estado
switch (state) {
    case "patrulha":
        speed_x = 2; // define aqui se necessário
        x += speed_x * dir;

        // Inverte a direção nas extremidades da patrulha
        if (x <= patrol_x1) dir = 1;
        if (x >= patrol_x2) dir = -1;
        break;

    case "alerta":
        speed_x = 2; // define aqui se necessário

        // Movimento em direção ao jogador
        if (x < target.x) x += speed_x;
        else if (x > target.x) x -= speed_x;

        // DASH para trás
        if (!is_dashing_back) {
            dash_cooldown--;
            if (dash_cooldown <= 0) {
                is_dashing_back = true;
                dash_progress = 0;
                dash_start_x = x;
                dash_end_x = x + dash_distance * -dir; // Vai pra direção oposta
                dash_cooldown = dash_timer;
            }
        } else {
            // Movimento com lerp
            dash_progress++;
            var t = dash_progress / dash_duration;
            x = lerp(dash_start_x, dash_end_x, t);

            if (dash_progress >= dash_duration) {
                is_dashing_back = false;
            }

            exit; // Sai para não interferir no movimento
        }
        break;

    case "atacar":
        speed_x = 0;
		
        if (global.dano_player) {
            global.hp_player -= 1;
            global.inv = 60 * 1; // 1 segundo de invulnerabilidade
            global.dano_player = false;
			global.hits += 1;		
        }
        break;
}
#endregion
