// Cola de la bola
draw_set_color(c_red);

if (move_direction == 1) {

    draw_rectangle(
        x - 9,
        y - 2,
        x - 4,
        y + 2,
        false
    );

}
else {

    draw_rectangle(
        x + 4,
        y - 2,
        x + 9,
        y + 2,
        false
    );
}

// Parte exterior
draw_set_color(c_orange);

draw_rectangle(
    x - 5,
    y - 5,
    x + 5,
    y + 5,
    false
);

// Centro
draw_set_color(c_yellow);

draw_rectangle(
    x - 3,
    y - 3,
    x + 3,
    y + 3,
    false
);

draw_set_color(c_white);