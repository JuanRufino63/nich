if (follow != noone) {
    var left = x - (deadZoneWidth / 2);
    var right = x + (deadZoneWidth / 2);
    var top = y - (deadZoneHeight / 2);
    var bottom = y + (deadZoneHeight / 2);

    // Verifica se o player saiu da zona morta e ajusta a posição da câmera
    if (follow.x < left) {
        x = follow.x + (deadZoneWidth / 2);
    }
    else if (follow.x > right) {
        x = follow.x - (deadZoneWidth / 2);
    }

    if (follow.y < top) {
        y = follow.y + (deadZoneHeight / 2);
    }
    else if (follow.y > bottom) {
        y = follow.y - (deadZoneHeight / 2);
    }

    // Centraliza a view na posição da câmera
    camera_set_view_pos(view_camera[0], x - camWidth / 2, y - camHeight / 2);
}
