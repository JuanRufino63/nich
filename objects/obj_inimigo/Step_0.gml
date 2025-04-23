#region Colisão inimigo
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
if (y >   room_height - metade_altura) {
    y = room_height - metade_altura;
}
#endregion
#region Estados
x = clamp(x, metade_largura, room_width - metade_largura);
y = clamp(y, metade_altura, room_height - metade_altura);

// Detectar distância até o jogador
var dist = point_distance(x, y, target.x, target.y);
show_debug_message(dist)
// Troca para estado de alerta se estiver perto
if(global.inv <= 0){
	global.inv = 0;
	global.dano_player = true;
}
else{
	global.inv -= 1;
}
if (dist < alert_range) {
    state = "alerta";
}
else if (state == "alerta" && dist >= alert_range + 20) { // pequena tolerância
    state = "patrulha";
}
if (state == "alerta" && dist < 210){
	state = "atacar";
}
else{
	state = "alerta";
}

switch (state){
	//estado de patrulha
	case "patrulha":
		x += speed_x * dir;
		
		//Inverte o sentido
		if(x <= patrol_x1) dir = 1;
		if (x >= patrol_x2) dir = -1;
		break;
	// Perseguir jogador
	case "alerta":
        if (x < target.x) x += speed_x;
        else if (x > target.x) x -= speed_x;
		// DASH BACK TIMER
		if (!is_dashing_back) {
		    dash_cooldown--;

		    if (dash_cooldown <= 0) {
		        is_dashing_back = true;
		        dash_progress = 0;
		        dash_start_x = x;
		        dash_end_x = x + dash_distance * -dir; // Vai pra direção oposta
		        dash_cooldown = dash_timer; // reinicia o timer
		    }
		} else {
		    // Movimento suave com lerp
		    dash_progress++;
		    var t = dash_progress / dash_duration;
		    x = lerp(dash_start_x, dash_end_x, t);

		    if (dash_progress >= dash_duration) {
		        is_dashing_back = false;
		    }

		    // Evita sobrepor comportamento de patrulha/alerta enquanto dasha
		    exit;
}
		break;
	case "atacar":
		speed_x = 0
		if (global.dano_player = true){
			global.hp_player -= 1;
			global.inv = room_speed * 1;
			global.dano_player = false;
		}
		break;
}

#endregion
