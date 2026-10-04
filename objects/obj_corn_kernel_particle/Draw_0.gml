// Contorno oscuro
draw_set_color(make_color_rgb(105, 42, 12));

draw_rectangle(
    x - 2,
    y - 3,
    x + 2,
    y + 3,
    false
);

// Interior amarillo
draw_set_color(make_color_rgb(255, 174, 25));

draw_rectangle(
    x - 1,
    y - 2,
    x + 1,
    y + 2,
    false
);

// Brillo
draw_set_color(make_color_rgb(255, 226, 92));

draw_point(x - 1, y - 2);

draw_set_color(c_white);