var progress = life / life_max;
var size = 3 + round((1 - progress) * 7);

draw_set_alpha(progress);

// Centro blanco
draw_set_color(c_white);

draw_rectangle(
    x - 2,
    y - 2,
    x + 2,
    y + 2,
    false
);

// Destello amarillo
draw_set_color(c_yellow);

draw_rectangle(x - 1, y - size, x + 1, y - 3, false);
draw_rectangle(x - 1, y + 3, x + 1, y + size, false);
draw_rectangle(x - size, y - 1, x - 3, y + 1, false);
draw_rectangle(x + 3, y - 1, x + size, y + 1, false);

// Chispas diagonales
draw_set_color(c_orange);

draw_line(x - 3, y - 3, x - size, y - size);
draw_line(x + 3, y - 3, x + size, y - size);
draw_line(x - 3, y + 3, x - size, y + size);
draw_line(x + 3, y + 3, x + size, y + size);

// Restaurar dibujo
draw_set_alpha(1);
draw_set_color(c_white);