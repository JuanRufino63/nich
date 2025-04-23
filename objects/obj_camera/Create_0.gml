follow = obj_player;

camWidth = camera_get_view_width(view_camera[0]);
camHeight = camera_get_view_height(view_camera[0]);

// Define o tamanho da zona morta (por exemplo: 100x60 no centro da tela)
deadZoneWidth = 100;
deadZoneHeight = 60;

// Inicializa a posição da câmera centralizada no player
x = follow.x;
y = follow.y;