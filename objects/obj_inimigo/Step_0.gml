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
