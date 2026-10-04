// ==================================================
// VIDA
// ==================================================

draw_set_alpha(1);
draw_set_color(c_white);

draw_text(
    16,
    16,
    "VIDA: "
    + string(hp)
    + " / "
    + string(max_hp)
);


// ==================================================
// ESCUDO
// ==================================================

draw_text(
    16,
    36,
    "ESCUDO: "
    + string(floor(shield_durability))
    + " / "
    + string(shield_max)
);

// Fondo de la barra
draw_set_color(c_dkgray);
draw_rectangle(16, 56, 116, 64, false);

// Relleno entre 0 y 100 píxeles
var shield_width = clamp(
    100 * (shield_durability / shield_max),
    0,
    100
);

if (shield_broken) {
    draw_set_color(c_red);
}
else {
    draw_set_color(c_aqua);
}

draw_rectangle(
    16,
    56,
    16 + shield_width,
    64,
    false
);

// Restaurar estado de dibujo
draw_set_alpha(1);
draw_set_color(c_white);