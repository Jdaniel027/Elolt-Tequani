// ==================================================
// MOVIMIENTO DE LA GRANADA
// ==================================================

if (!exploded) {

    if (!landed) {

        // Gravedad
        vertical_speed += gravity_force;

        // ------------------------------------------
        // Movimiento horizontal
        // ------------------------------------------

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

        // ------------------------------------------
        // Movimiento vertical
        // ------------------------------------------

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

                vertical_speed = -abs(vertical_speed) * 0.55;
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

    // ----------------------------------------------
    // CUENTA REGRESIVA
    // ----------------------------------------------

    fuse_timer -= 1;

    if (fuse_timer <= 0) {

        exploded = true;
        explosion_timer = explosion_duration;

        horizontal_speed = 0;
        vertical_speed = 0;

        // ------------------------------------------
        // BUSCAR ENEMIGOS DENTRO DE LA EXPLOSIÓN
        // ------------------------------------------

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
            var enemy = ds_list_find_value(enemy_list, i);

            enemy.hp -= damage;
            enemy.hit_flash_timer = 8;

            var push_direction = sign(enemy.x - x);

            if (push_direction == 0) {
                push_direction = 1;
            }

            enemy.knockback_speed = push_direction * 5;
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