// ==================================================
// COLISIONES: OBJ_SOLID + TILEMAP "Hitbox"
// ==================================================

function player_meets_wall(_x, _y) {

    // Mantener las colisiones con los bloques originales.
    if (place_meeting(_x, _y, obj_solid)) {
        return true;
    }

    // Buscar la capa de colisiones en la room actual.
    if (layer_exists("Hitbox")) {

        var _tilemap = layer_tilemap_get_id("Hitbox");

        // Comprobar únicamente si existe un tilemap válido.
        if (_tilemap != -1) {
            return place_meeting(_x, _y, _tilemap);
        }
    }

    return false;
}


// ==================================================
// COMPROBAR SUELO
// ==================================================

function player_check_ground() {

    // Si está dentro de un sólido, buscar espacio hacia arriba.
    if (player_meets_wall(x, y)) {

        var _max_up = 256;
        var _found_space = false;

        for (var _offset = 1; _offset <= _max_up; _offset++) {

            if (!player_meets_wall(x, y - _offset)) {

                // Mover únicamente cuando encontramos un sitio libre.
                y -= _offset;

                vertical_speed = 0;

                dash_active = false;
                dash_timer = 0;

                _found_space = true;
                break;
            }
        }

        // Avisar si no se encontró una salida.
        if (!_found_space) {
            show_debug_message(
                "Jugador atrapado: no hay espacio libre "
                + "en los 256 pixeles superiores."
            );
        }
    }

    // Comprobar el suelo después de corregir la posición.
    on_ground = player_meets_wall(x, y + 1);

    if (on_ground) {
        air_dash_available = true;
    }
}


// ==================================================
// MOVIMIENTO, SALTO, DASH Y COLISIONES
// ==================================================

function player_update_movement() {

    // Bloquear desplazamiento durante acciones.
    if (
        attacking
        || casting_fireball
        || throwing_grenade
        || shield_active
        || player_locked
    ) {
        move = 0;
    }

    if (keyboard_check(vk_down) && on_ground) {
        move = 0;
    }

    var horizontal_speed;

    if (dash_active) {
        horizontal_speed = dash_direction * dash_speed;
    }
    else {
        horizontal_speed = move * move_speed;
    }

    // ==================================================
    // COLISIÓN HORIZONTAL
    // ==================================================

    if (
        horizontal_speed != 0
        && player_meets_wall(x + horizontal_speed, y)
    ) {
        while (
            !player_meets_wall(
                x + sign(horizontal_speed),
                y
            )
        ) {
            x += sign(horizontal_speed);
        }

        horizontal_speed = 0;

        if (dash_active) {
            dash_active = false;
            dash_timer = 0;
        }
    }

    x += horizontal_speed;

    // ==================================================
    // ACTUALIZAR DASH Y ESTELA
    // ==================================================

    if (dash_active) {
        dash_timer -= 1;
        vertical_speed = 0;
        dash_trail_timer -= 1;

        if (dash_trail_timer <= 0) {

            var trail = instance_create_depth(
                x,
                y,
                depth + 1,
                obj_dash_trail
            );

            trail.trail_sprite = sprite_index;
            trail.trail_image = image_index;
            trail.trail_xscale = image_xscale;
            trail.trail_yscale = image_yscale;
            trail.trail_angle = image_angle;

            dash_trail_timer = dash_trail_interval;
        }

        if (dash_timer <= 0) {
            dash_active = false;
        }
    }

    // ==================================================
    // SALTO
    // ==================================================

    if (
        !attacking
        && !casting_fireball
        && !throwing_grenade
        && !shield_active
        && !player_locked
        && !dash_active
        && on_ground
        && keyboard_check_pressed(vk_space)
    ) {
        vertical_speed = jump_speed;
    }

    // ==================================================
    // GRAVEDAD
    // ==================================================

    if (!dash_active) {

        if (!on_ground) {
            vertical_speed += gravity_force;

            vertical_speed = min(
                vertical_speed,
                max_fall_speed
            );
        }
        else if (vertical_speed > 0) {
            vertical_speed = 0;
        }
    }
    else {
        vertical_speed = 0;
    }

    // ==================================================
    // COLISIÓN VERTICAL
    // ==================================================

    if (
        vertical_speed != 0
        && player_meets_wall(x, y + vertical_speed)
    ) {
        while (
            !player_meets_wall(
                x,
                y + sign(vertical_speed)
            )
        ) {
            y += sign(vertical_speed);
        }

        vertical_speed = 0;
    }

    y += vertical_speed;

    // Actualizar suelo después de moverse.
    on_ground = player_meets_wall(x, y + 1);
}