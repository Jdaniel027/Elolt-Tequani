// ==================================================
// PARPADEO POR INVULNERABILIDAD
// ==================================================

if (
    invincibility_timer > 0
    && (invincibility_timer div 4) mod 2 == 0
) {
    draw_set_alpha(0.35);
}
else {
    draw_set_alpha(1);
}


// ==================================================
// POSICIÓN VISUAL Y VIBRACIÓN DE IMPACTO
// ==================================================

var draw_x = x;
var draw_y = y;

if (damage_freeze_timer > 0) {
    draw_x += irandom_range(-1, 1);
    draw_y += irandom_range(-1, 1);
}

draw_sprite_ext(
    sprite_index,
    image_index,
    draw_x,
    draw_y,
    image_xscale,
    image_yscale,
    image_angle,
    image_blend,
    image_alpha
);

draw_set_alpha(1);


// ==================================================
// HITBOX DE DEPURACIÓN
// ==================================================

if (
    show_attack_hitbox
    && attack_hitbox_active
) {
    // Interior transparente
    draw_set_alpha(0.25);
    draw_set_color(c_red);

    draw_rectangle(
        attack_hitbox_left,
        attack_hitbox_top,
        attack_hitbox_right,
        attack_hitbox_bottom,
        false
    );

    // Contorno sólido
    draw_set_alpha(1);

    draw_rectangle(
        attack_hitbox_left,
        attack_hitbox_top,
        attack_hitbox_right,
        attack_hitbox_bottom,
        true
    );
}

// Restaurar estado de dibujo
draw_set_alpha(1);
draw_set_color(c_white);