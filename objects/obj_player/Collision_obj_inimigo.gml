var dx = x - other.x;
var dy = y - other.y;
var dist = point_distance(x, y, other.x, other.y);

if (dist != 0) {
    x += (dx / dist) * 5;
    y += (dy / dist) * 5;
}
