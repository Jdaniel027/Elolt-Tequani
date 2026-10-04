// ==================================================
// CALCULAR SIGUIENTE POSICIÓN
// ==================================================

var next_x = x + move_speed * move_direction;


// ==================================================
// COLISIÓN CON PAREDES
// ==================================================

var wall = collision_rectangle(
    next_x - hit_radius,
    y - hit_radius,
    next_x + hit_radius,
    y + hit_radius,
    obj_solid,
    false,
    true
);

if (wall != noone) {

    instance_create_depth(
        x,
        y,
        depth - 1,
        obj_melee_impact
    );

    instance_destroy();
    exit;
}


// ==================================================
// MOVIMIENTO
// ==================================================

x = next_x;


// ==================================================
// COLISIÓN CON ENEMIGOS
// ==================================================

var enemy = collision_circle(
    x,
    y,
    hit_radius,
    par_enemy,
    false,
    true
);

if (enemy != noone) {

    enemy.hp -= damage;
    enemy.hit_flash_timer = 6;
  enemy.knockback_speed = move_direction * 2;

    instance_create_depth(
        x,
        y,
        depth - 1,
        obj_melee_impact
    );

    instance_destroy();
    exit;
}


// ==================================================
// TIEMPO DE VIDA
// ==================================================

life -= 1;

if (life <= 0) {
    instance_destroy();
}