//Estados
state = "patrulha"
//Variaeis comuns
hp_mob = 20;
dano_comum = 2;
dir = 1;
alert_range = 500;
speed_x = 2;
speed_y = 2;
patrol_x1 = x - 100;
patrol_x2 = x + 100;
target = obj_player;
// DASH BACK TIMER
dash_timer = 5 * 60; // 5 segundos em frames
dash_cooldown = dash_timer;  // contador
dash_duration = 10; // duração do dash em frames
dash_progress = 0; // contador do dash
is_dashing_back = false;
dash_distance = -200; // distância pra trás (em X)
dash_start_x = 0;
dash_end_x = 0;