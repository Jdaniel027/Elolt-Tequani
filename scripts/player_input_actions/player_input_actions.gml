function player_read_input() {

    move = keyboard_check(vk_right)
         - keyboard_check(vk_left);

    if (
        !attacking
        && !casting_fireball
        && !throwing_grenade
        && !shield_active
        && !player_locked
        && !dash_active
    ) {
        if (move > 0) {
            facing = 1;
        }

        if (move < 0) {
            facing = -1;
        }
    }
}


function player_start_actions() {

    // Ataque cuerpo a cuerpo: X
    if (
        !attacking
        && !shield_active
        && !dash_active
        && !casting_fireball
        && !throwing_grenade
        && !player_locked
        && keyboard_check_pressed(ord("X"))
    ) {
        attacking = true;
        attack_sequence += 1;

        if (keyboard_check(vk_up)) {
            attack_direction = 0;
        }
        else {
            attack_direction = facing;
        }
    }

    // Bola de fuego: Z
    if (
        !attacking
        && !casting_fireball
        && !shield_active
        && !dash_active
        && !throwing_grenade
        && !player_locked
        && fireball_cooldown <= 0
        && keyboard_check_pressed(ord("Z"))
    ) {
        casting_fireball = true;
        fireball_spawned = false;
        fireball_cooldown = fireball_cooldown_max;
    }

    // Granada: V
    if (
        !attacking
        && !casting_fireball
        && !throwing_grenade
        && !shield_active
        && !dash_active
        && !player_locked
        && grenade_cooldown <= 0
        && keyboard_check_pressed(ord("V"))
    ) {
        throwing_grenade = true;
        grenade_spawned = false;
        grenade_cooldown = grenade_cooldown_max;
    }

    // Dash: C
    if (
        !dash_active
        && !attacking
        && !shield_active
        && !casting_fireball
        && !throwing_grenade
        && !player_locked
        && dash_cooldown <= 0
        && (on_ground || air_dash_available)
        && keyboard_check_pressed(ord("C"))
    ) {
        dash_active = true;
        dash_direction = facing;
        dash_timer = dash_duration;
        dash_trail_timer = 0;
        dash_cooldown = dash_cooldown_max;

        vertical_speed = 0;

        if (!on_ground) {
            air_dash_available = false;
        }
    }
}