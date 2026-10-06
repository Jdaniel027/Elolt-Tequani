// ==================================================
// GRANADA SIN EXPLOTAR
// ==================================================

if (!exploded) {

    // Guardar posición anterior para detectar impactos
    var previous_x = x;
    var previous_y = y;

    // ==================================================
    // MOVIMIENTO
    // ==================================================

    if (!landed) {

        // Gravedad
        vertical_speed += gravity_force;


        // ----------------------------------------------
        // MOVIMIENTO HORIZONTAL
        // ----------------------------------------------

        var next_x = x + horizontal_speed;

        var horizontal_wall = collision_rectangle(
            next_x - 4,
            y - 4,
            next_x + 4,
            y + 4,
            obj_solid,
            false,
            true
        );

        if (horizontal_wall == noone) {

            x = next_x;

        }
        else {

            // Pequeño rebote contra paredes
            horizontal_speed *= -0.5;
        }


        // ----------------------------------------------
        // MOVIMIENTO VERTICAL
        // ----------------------------------------------

        var next_y = y + vertical_speed;

        var vertical_wall = collision_rectangle(
            x - 4,
            next_y - 4,
            x + 4,
            next_y + 4,
            obj_solid,
            false,
            true
        );

        if (vertical_wall == noone) {

            y = next_y;

        }
        else if (vertical_speed > 0) {

            // Acercarse al suelo sin atravesarlo
            while (
                collision_rectangle(
                    x - 4,
                    y - 3,
                    x + 4,
                    y + 5,
                    obj_solid,
                    false,
                    true
                ) == noone
            ) {
                y += 1;
            }

            bounce_count += 1;

            if (bounce_count <= max_bounces) {

                vertical_speed =
                    -abs(vertical_speed) * 0.55;

                horizontal_speed *= 0.80;

            }
            else {

                vertical_speed = 0;
                horizontal_speed = 0;
                landed = true;
            }

        }
        else {

            vertical_speed = 0;
        }
    }


    // ==================================================
    // DETECTAR IMPACTO CON ENEMIGO
    // ==================================================

    var impact_enemy = collision_line(
        previous_x,
        previous_y,
        x,
        y,
        par_enemy,
        false,
        true
    );

    // Comprobar también el área actual por si está detenida
    if (impact_enemy == noone) {

        impact_enemy = collision_circle(
            x,
            y,
            6,
            par_enemy,
            false,
            true
        );
    }


    // ==================================================
    // CUENTA REGRESIVA
    // ==================================================

    fuse_timer -= 1;

    var explode_by_impact =
        impact_enemy != noone;

    var explode_by_time =
        fuse_timer <= 0;


    // ==================================================
    // INICIAR EXPLOSIÓN
    // ==================================================

    if (explode_by_impact || explode_by_time) {

        exploded = true;
        explosion_timer = explosion_duration;

        horizontal_speed = 0;
        vertical_speed = 0;
        landed = true;


        // ----------------------------------------------
        // BUSCAR ENEMIGOS EN EL RADIO
        // ----------------------------------------------

        var enemy_list = ds_list_create();

        collision_circle_list(
            x,
            y,
            explosion_radius,
            par_enemy,
            false,
            true,
            enemy_list,
            false
        );

        for (
            var i = 0;
            i < ds_list_size(enemy_list);
            i++
        ) {
            var enemy =
                ds_list_find_value(enemy_list, i);

            // Cada enemigo recibe daño una sola vez
            enemy.hp -= damage;
            enemy.hit_flash_timer = 8;

            var push_direction =
                sign(enemy.x - x);

            if (push_direction == 0) {
                push_direction = 1;
            }

            enemy.knockback_speed =
                push_direction * 5;
        }

        ds_list_destroy(enemy_list);
    }
}


// ==================================================
// DURACIÓN VISUAL DE LA EXPLOSIÓN
// ==================================================

if (exploded) {

    explosion_timer -= 1;

    if (explosion_timer <= 0) {
        instance_destroy();
    }
}