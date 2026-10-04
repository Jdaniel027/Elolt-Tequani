if (!exploded) {

    // Sombra oscura del grano
    draw_set_color(make_color_rgb(130, 70, 10));

    draw_rectangle(
        x - 4,
        y - 5,
        x + 4,
        y + 5,
        false
    );

    // Grano de maíz
    draw_set_color(c_yellow);

    draw_rectangle(
        x - 3,
        y - 4,
        x + 3,
        y + 3,
        false
    );

    // Brillo
    draw_set_color(c_white);

    draw_rectangle(
        x - 2,
        y - 3,
        x,
        y - 1,
        false
    );

}
else {

    // Progreso de la explosión
    var progress = explosion_timer / explosion_duration;
    var radius = explosion_radius * (1 - progress);

    draw_set_alpha(progress);

    // Parte exterior
    draw_set_color(c_red);
    draw_circle(x, y, radius, false);

    // Parte intermedia
    draw_set_color(c_orange);
    draw_circle(x, y, radius * 0.70, false);

    // Centro
    draw_set_color(c_yellow);
    draw_circle(x, y, radius * 0.35, false);

    draw_set_alpha(1);
}

draw_set_color(c_white);
draw_set_alpha(1);