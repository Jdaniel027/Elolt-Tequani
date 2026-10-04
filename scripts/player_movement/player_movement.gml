function player_check_ground() {

    on_ground = place_meeting(
        x,
        y + 1,
        obj_solid
    );

    if (on_ground) {
        air_dash_available = true;
    }
}


function player_update_movement() {

    // Bloquear desplazamiento durante acciones
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

    // Colisión horizontal
    if (
        horizontal_speed != 0
        && place_meeting(
            x + horizontal_speed,
            y,
            obj_solid
        )
    ) {
        while (!place_meeting(
            x + sign(horizontal_speed),
            y,
            obj_solid
        )) {
            x += sign(horizontal_speed);
        }

        horizontal_speed = 0;

        if (dash_active) {
            dash_active = false;
            dash_timer = 0;
        }
    }

    x += horizontal_speed;

    // Actualizar dash y estela
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

    // Salto
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

    // Gravedad
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

    // Colisión vertical
    if (
        vertical_speed != 0
        && place_meeting(
            x,
            y + vertical_speed,
            obj_solid
        )
    ) {
        while (!place_meeting(
            x,
            y + sign(vertical_speed),
            obj_solid
        )) {
            y += sign(vertical_speed);
        }

        vertical_speed = 0;
    }

    y += vertical_speed;

    on_ground = place_meeting(
        x,
        y + 1,
        obj_solid
    );
}